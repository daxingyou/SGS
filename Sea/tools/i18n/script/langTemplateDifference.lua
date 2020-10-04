local compareFunction = function( resultPath,langPathOld,langPathNew )
    local oldPackagePath = package.path..";"..langPathOld
    local newPackagePath = package.path..";"..langPathNew
    package.path = oldPackagePath
    local tab = require("LangTemplate")
    package.loaded["LangTemplate"] = nil
    package.path = newPackagePath
    local tabNew = require("LangTemplate")
    local result = {}
    local count = 0
    local function insertResult( k,v )
        local key = '"'..k..'"'
        if type( v ) == "table" then
            result[key] = TableToStr(v)
        else
            local decodeStr = EscDecode( v )
            --特殊处理，删除冗余空白符
            local str = string.gsub(decodeStr,"\\n%s*{","\\n{")
            result[key] = '"'..str..'"'
        end
    end
    for k,v in pairs(tabNew) do
        if tab[k] == nil then
            insertResult(k,v)
            count = count + 1
        else
            local newValue = v
            local oldValue = tab[k]
            if type( newValue ) == "table" then
                newValue = TableToStr(newValue)
            end
            if type( oldValue ) == "table" then
                oldValue = TableToStr(oldValue)
            end
            if newValue ~= oldValue then
                insertResult(k,v)
                count = count + 1
            end
        end
    end
    print("resultCount=",count)
    -- LuaTableToJsonFile(result,resultPath)
    return result
end








-- module( "json_to_lua", package.seeall )

--##############################################################################
--#                                  模块接口
--##############################################################################

-- json字符串转lua table
function JsonStrToLuaTable( szJsonStr )
    local tWords = SplitWord( szJsonStr )
    -- 此处应该加一个语法检查的
    -- CheckSyntax( tWords )
    local ResultObj = CreateObjectByWords( tWords )

    return ResultObj
end

-- lua table转json
function LuaTableToJsonStr( tTable, nTabCnt )
    nTabCnt = nTabCnt or 0
    local szJsonStr = "\n"

    assert( type( tTable ) == "table", "tTable is not a table." )

    local szTab = ""
    for i = 1, nTabCnt do
        szTab = szTab .. '\t'
    end

    local szKeyType = nil
    for key, value in pairs( tTable ) do
        if szKeyType == nil then
            szKeyType = type( key )
            if szKeyType ~= "string" and szKeyType ~= "number" then
                -- 处理不了其他类型的key
                return nil
            end
        end

        -- 处理key，key类型不一致，转换失败
        if type( key ) ~= szKeyType then
            return nil
        end

        szJsonStr = szJsonStr .. '\t' .. szTab
        if szKeyType == "string" then
            szJsonStr = szJsonStr .. string.format( "\"%s\" : ", EscDecode( key ) )
        end

        -- 处理value
        if type( value ) == "table" then
            szJsonStr = szJsonStr..TableToStr(value).. ",\n"
            -- szJsonStr = szJsonStr .. LuaTableToJsonStr( value, nTabCnt + 1 ) .. ",\n"
        else
            if type( value ) == 'string' then
                value = '"' .. EscDecode( value ) .. '"'
                -- value = '"' ..  value  .. '"'
            end
            szJsonStr = szJsonStr .. string.format( "%s,\n", value )
        end
        --特殊处理，删除冗余空白符
        szJsonStr = string.gsub(szJsonStr,"\\n%s*{","\\n{")
    end
    if szJsonStr == '\n' then szTab = ''; szJsonStr = '' end
    if szKeyType == "string" then
        return "{" .. szJsonStr .. szTab .. '}'
    else
        return "[" .. szJsonStr .. szTab .. ']'
    end
end

-- 文件中读json文件并转成Lua table
function JsonFileToLuaTable( szJsonFileName )
    local JsonFileObj = io.open( szJsonFileName, 'r' )
    if JsonFileObj == nil then
        return nil
    end

    local szJsonStr = JsonFileObj:read( "*a" )
    io.close( JsonFileObj )
    return JsonStrToLuaTable( szJsonStr )
end

-- Lua table生成json并保存到文件
function LuaTableToJsonFile( tTable, szJsonFileName )
    local JsonFileObj = io.open( szJsonFileName, 'w' )
    szJsonStr = LuaTableToJsonStr( tTable )
    if szJsonStr == nil then
        return false
    else 
        JsonFileObj:write(szJsonStr)
        io.close( JsonFileObj )
        return true
    end
end

--##############################################################################
--#                                  主要函数
--##############################################################################

tJson2Lua = {
    ["true"] = { value = true },
    ["null"] = { value = nil },
    ["false"] = { value = false },
}

tStr2Esc = {
    ["\\\""] = '\"', ["\\f"] = '\f', ["\\b"] = '\b', ["\\/"] = '/',
    ["\\\\"] = '\\', ["\\n"] = '\n', ["\\r"] = '\r', ["\\t"] = '\t',
}

tEsc2Str = {
    ['\"'] = "\\\"", ['\f'] = "\\f", ['\b'] = "\\b", ['/'] = "/",
    ['\n'] = "\\n", ['\r'] = "\\r", ['\t'] = "\t"
}


-- 分词
function SplitWord( szJsonStr )
    local tWords = {}
    if szJsonStr == nil then
        return nil
    end

    szJsonStr = StringTrim( szJsonStr )
    local nIndex = 1
    while nIndex <= #szJsonStr do
        repeat          -- breake实现continue

            local szChar = szJsonStr:sub( nIndex, nIndex )

            -- 跳过空白字符
            if ( " \t\n\r" ):find( szChar, 1, true ) then
                break
            end

            -- 处理语法的字符和字符串
            if ( "{:}[,]\"" ):find( szChar, 1, true ) then
                tWords[#tWords + 1] = szChar
                if szChar == '"' then
                    local szTempStr = ""
                    nIndex = nIndex + 1
                    local szNextChar = szJsonStr:sub( nIndex, nIndex )
                    while szNextChar ~= szChar do
                        szTempStr = szTempStr .. szNextChar
                        if szNextChar == '\\' and nIndex + 1 <= #szJsonStr then
                            nIndex = nIndex + 1
                            szTempStr = szTempStr .. szJsonStr:sub( nIndex, nIndex )
                        end
                        nIndex = nIndex + 1
                        szNextChar = szJsonStr:sub( nIndex, nIndex )
                    end
                    tWords[#tWords + 1] = szTempStr
                    tWords[#tWords + 1] = szChar
                end

            -- 处理数字
            elseif CharIsDigit(szChar) or szChar == '-' or szChar == '.' then
                local szNumStr = szChar
                if szChar == '.' then szNumStr = '0.' end
                while nIndex + 1 <= #szJsonStr do
                    local szNextChar = szJsonStr:sub( nIndex + 1, nIndex + 1 )
                    if ( "AaBbCcDdEeFfXx. -+" ):find( szNextChar, 1, true ) or
                        CharIsDigit( szNextChar ) then
                        if szNextChar ~= ' ' then
                            szNumStr = szNumStr .. szNextChar
                        end
                        nIndex = nIndex + 1
                    else break end
                end
                tWords[#tWords + 1] = szNumStr

            elseif CharIsAlpha( szChar ) then
                local szTempStr = szChar
                while nIndex + 1 <= #szJsonStr do
                    local szNextChar = szJsonStr:sub( nIndex + 1, nIndex + 1 )
                    if CharIsAlpha( szNextChar ) then
                        szTempStr = szTempStr .. szNextChar
                        nIndex = nIndex + 1
                    else break end
                end
                tWords[#tWords + 1] = szTempStr
            end

        until ( true )  -- breake实现continue
        nIndex = nIndex + 1
    end

    return tWords
end

-- 根据分词创建对象
function CreateObjectByWords( tWords, tCur )
    tCur = tCur or { 1 }
    local nIndex = tCur[1]

    -- 处理字典
    if tWords[nIndex] == '{' then
        local ResultObj = {}
        nIndex = nIndex + 1
        while nIndex <= #tWords do
            if tWords[nIndex] == '}' then
                tCur[1] = nIndex
                return ResultObj
            elseif tWords[nIndex] == '"' then
                szKey = EscEncode( tWords[nIndex + 1] )
                tCur[1] = nIndex + 4
                ResultObj[szKey] = CreateObjectByWords( tWords, tCur )
                nIndex = tCur[1]
            end
            nIndex = nIndex + 1
        end

    -- 处理数组
    elseif tWords[nIndex] == '[' then
        local ResultObj = {}
        local nArrayLen = 0
        nIndex = nIndex + 1
        while nIndex <= #tWords do
            if tWords[nIndex] == ']' then
                tCur[1] = nIndex
                return ResultObj
            elseif tWords[nIndex] ~= ',' then
                tCur[1] = nIndex
                ResultObj[nArrayLen + 1] = CreateObjectByWords( tWords, tCur )
                nArrayLen = nArrayLen + 1
                nIndex = tCur[1]
            end
            nIndex = nIndex + 1
        end

    -- 处理字符串
    elseif tWords[nIndex] == '"' then
        tCur[1] = nIndex + 2
        return EscEncode( tWords[nIndex + 1] )

    -- 处理false, true, null
    elseif tJson2Lua[tWords[nIndex]] ~= nil then
        return tJson2Lua[tWords[nIndex]].value

    elseif tWords[nIndex] ~= ',' then
        return tonumber( tWords[nIndex] )
    end
end

-- 处理转义字符
function EscEncode( szString )
    for str, esc in pairs( tStr2Esc ) do
        szString = string.gsub( szString, str, esc)
    end
    return szString
end

function EscDecode( szString )
    szString = string.gsub( szString, '\\', "\\\\")
    for esc, str in pairs( tEsc2Str ) do
        szString = string.gsub( szString, esc, str)
    end
    return szString
end

-- 打印lua table
function PrintTable( tTable, szContext, nTabCnt )
    nTabCnt = nTabCnt or 0
    szContext = szContext or ""

    assert( type( tTable ) == "table", "tTable is not a table." )

    local szTab = ""
    for i = 1, nTabCnt do
        szTab = szTab .. '\t'
    end
    print( szContext .. '{' )
    for key, value in pairs( tTable ) do
        if type( key ) == 'string' then
            key = '"' .. EscDecode( key ) .. '"'
        end
        local szTemp = '\t' .. szTab .. string.format( "[%s] = ", key )
        if type( value ) == "table" then
            PrintTable( value, szTemp, nTabCnt + 1)
        else
            if type( value ) == 'string' then
                value = '"' .. EscDecode( value ) .. '"'
            end
            print( szTemp .. string.format( "%s,", value ) )
        end
    end
    print( szTab .. '}' )
end

--##############################################################################
--#                                 字符串辅助函数
--##############################################################################

-- 删除前后空白字符
function StringTrim( szString )
    if type( szString ) ~= "string" then
        return ""
    end
    return ( string.gsub( string.gsub( szString, "%s+$", "" ), "^%s+", "" ) )
end

-- 判断是数字
function CharIsDigit( szChar )
    assert( #szChar == 1, "szChar is not a char: " .. szChar )
    return ( '0' ):byte() <= szChar:byte() and szChar:byte() <= ( '9' ):byte()
end

-- 判断是字母
function CharIsAlpha( szChar )
    assert( #szChar == 1, "szChar is not a char: " .. szChar )
    return ( ( 'a' ):byte() <= szChar:byte() and szChar:byte() <= ( 'z' ):byte() ) or
            ( ( 'A' ):byte() <= szChar:byte() and szChar:byte() <= ( 'Z' ):byte() )
end





function ToStringEx(value)
    if type(value)=='table' then
       return TableToStr(value)
    elseif type(value)=='string' then
        return "\""..value.."\""
    else
       return tostring(value)
    end
end

function TableToStr(t)
    if t == nil then return "" end
    local retstr= "{"

    local i = 1
    for key,value in pairs(t) do
        local signal = ","
        if i==1 then
          signal = ""
        end

        if key == i then
            retstr = retstr..signal..ToStringEx(value)
        else
            if type(key)=='number' or type(key) == 'string' then
                retstr = retstr..signal..'['..ToStringEx(key).."]="..ToStringEx(value)
            else
                if type(key)=='userdata' then
                    retstr = retstr..signal.."*s"..TableToStr(getmetatable(key)).."*e".."="..ToStringEx(value)
                else
                    retstr = retstr..signal..key.."="..ToStringEx(value)
                end
            end
        end

        i = i+1
    end

     retstr = retstr.."}"
     return retstr
end

return compareFunction
