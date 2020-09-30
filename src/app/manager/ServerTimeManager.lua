-- 服务器时间类
local ServerTimeManager = class("ServerTimeManager")

--计算本地时区比UTC0快了多少秒
local function get_timezone(t)
    -- local now = os.time()
    --i18n 夏令时计算应根据服务器时间
    local now = t or G_ServerTime:getTime()
    local timeDiff = os.difftime(now, os.time(os.date("!*t", now)))
    local date = os.date("*t", now)
    if date.isdst then 
        timeDiff = timeDiff + 3600      --夏令时会快一个小时
    end
    return timeDiff
end

function ServerTimeManager:ctor(t, zone)
    self._zone = 8 -- 默认服务器时区,北京时区
    self._diff = 0 -- 客户端时区比服务器时区快了多少秒
    self._t = os.time() -- 时间戳
    self._lastSetTime = timer:getms() --os.time() -- 最后一次setTime时, 本地时间点
end



function ServerTimeManager:setTime(t, zone)
    self._t = t  --- 1 --同步服务器时间减一秒
    self._zone = zone
    self._lastSetTime = timer:getms() -- os.time()
    self._diff = get_timezone() - zone*3600
    -- print("1112233 aa = ", self._diff)
    --print("currrendate:" .. self:getTimeString())
end

--获取当前的服务器时间戳
function ServerTimeManager:getTime()
    local elapsed = timer:getms() - self._lastSetTime
    local elapsedTemp = math.floor( elapsed * 0.001 )

    return self._t + elapsedTemp, self._t + elapsed* 0.001
end

function ServerTimeManager:getMSTime()
    local elapsed = timer:getms() - self._lastSetTime
    return self._t * 1000 + elapsed
end

--指定时间的格林时间
function ServerTimeManager:isOldEnough(year, month, day)
    local time = self:getTime()
    local openYear = time - math.floor( 18*365.25*24*3600 )
    local opendate = self:getDateObject(openYear)
    if year < opendate.year then 
        return true
    elseif year == opendate.year and month < opendate.month then 
        return true
    elseif year == opendate.year and month == opendate.month and day <= opendate.day then 
        return true
    end
    return false
end

function ServerTimeManager:getDateObject(t,zeroTime)
    if t == nil then
        t = self:getTime()
    end
    zeroTime = zeroTime or 0
    --需要根据时区计算
    -- i18n 如果不是当前时间，diff应重新计算，因为夏令时会变
    local diff = self._diff
    if t ~= self:getTime() then
        diff = get_timezone(t) - self._zone*3600
    end
    local localdate = os.date('*t', math.max(0,t - diff - zeroTime))
    -- dump(localdate)

    return localdate
end

--获取当前时间对应的服务器日期
function ServerTimeManager:getDate(t)
    local localdate = self:getDateObject(t)
    return string.format("%04d-%02d-%02d", localdate.year, localdate.month, localdate.day)
end

function ServerTimeManager:getDateAndHour(t)
    local localdate = self:getDateObject(t)
    return string.format("%04d-%02d-%02d-%02d", localdate.year, localdate.month, localdate.day, localdate.hour)
end

function ServerTimeManager:getWeekdayAndHour(t)
    local time = t or self:getTime()
    local localdate = self:getDateObject(t)
    local nowSecond = localdate.hour*3600 + localdate.min*60 + localdate.sec             --今天已经过去了多少秒
    return localdate.wday - 1, nowSecond
end


--获取时间戳t对应的服务器时间的字符串
function ServerTimeManager:getTimeString(t)

    local localdate = self:getDateObject(t)

    return string.format("%04d-%02d-%02d %02d:%02d:%02d", localdate.year, localdate.month, localdate.day,localdate.hour, localdate.min, localdate.sec)
end

--获得过去多长时间hhmm
function ServerTimeManager:getPassTimeHHMM(timestamp)
    local sec = self:getTime() - timestamp
    local hh, mm  = self:getCurrentHHMMSS(sec)
    return hh, mm
end

--后去 已过去多长时间
function ServerTimeManager:getPassTime(timestamp)
    local sec= self:getTime() - timestamp
    local day=math.floor(sec/3600/24)
    local h=math.floor(sec/3600)
    local m=math.floor(sec/60)
    local str=""
    if day > 0 then
        str = Lang.get("someday",{day =day })
        -- day.."天前"
    elseif h > 0 then
        str =  Lang.get("somehour",{hour =h})
        -- hour.."小时前"
    elseif m > 0 then
        str =   Lang.get("somemin",{min =m})
        --min.."分钟前"
    else
        str = Lang.get("somemin",{min = 1})
    end
    return str
end

--计算时间戳t还有多少秒
--如果t已经过去了,那么返回负数
function ServerTimeManager:getLeftSeconds(t)
    local nowTime = self:getTime()
    return t - nowTime
end

--计算时间戳t还有多少秒, 并返回一个时间字符串
--如果t已经过去了,那么返回 "-"
function ServerTimeManager:getLeftSecondsString(t, customStr)
    local timeLeft = self:getLeftSeconds(t)
    if timeLeft < 0 then
        if customStr then
            return customStr
        end
        return "-"
    else
        local hour = (timeLeft-timeLeft%3600)/3600
        local minute = (timeLeft-hour*3600 -timeLeft%60)/60
        local second = timeLeft%60
        local text = ""
        if hour <10 then
            text = text .. "0".. hour .. ":"
        else
            text = text .. hour .. ":"
        end

        if minute <10 then
            text = text .. "0".. minute .. ":"
        else
            text = text .. minute .. ":"
        end

        if second <10 then
            text = text .. "0".. second
        else
            text = text .. second
        end

        return  text
    end
end

function ServerTimeManager:getLeftMinSecStr(t, customStr)
    local timeLeft = self:getLeftSeconds(t)
    if timeLeft < 0 then
        if customStr then
            return customStr
        end
        return "-"
    else
        local hour = (timeLeft-timeLeft%3600)/3600
        local minute = (timeLeft-hour*3600 -timeLeft%60)/60
        local second = timeLeft%60
        local text = ""

        if minute <10 then
            text = text .. "0".. minute .. ":"
        else
            text = text .. minute .. ":"
        end

        if second <10 then
            text = text .. "0".. second
        else
            text = text .. second
        end

        return  text
    end
end


--倒计时 toString ,不含天数
function ServerTimeManager:_secondToString(t)
    local hour = (t-t%3600)/3600
    local minute = (t-hour*3600 -t%60)/60
    local second = t%60

    local text = ""

    if hour <10 then
        text = text .. "0".. hour .. ":"
    else
        text = text .. hour .. ":"
    end

    if minute <10 then
        text = text .. "0".. minute .. ":"
    else
        text = text .. minute .. ":"
    end

    if second <10 then
        text = text .. "0".. second
    else
        text = text .. second
    end
    return  text
end

-- i18n 新增方法 :倒计时 toString ,不含天数,h or min
function ServerTimeManager:secondToHourOrMinuteString(t)
    local hour = (t-t%3600)/3600
    local minute = (t-hour*3600 -t%60)/60
    local second = t%60
    local text = ""
    if hour > 0 then
        text = Lang.get("lang_common_format_hour_unit", {hour = hour})
    elseif minute > 0  then
        text =  Lang.get("lang_common_format_min_unit", {min = minute})
    else
        text = Lang.get("lang_common_format_min_unit", {min = 1})
    end
    return  text
end

--到分钟的string
function ServerTimeManager:minToString(t)
    local hour = (t-t%3600)/3600
    local minute = (t-hour*3600 -t%60)/60
    local second = t%60

    local text = ""

    if hour <10 then
        text = text .. "0".. hour .. ":"
    else
        text = text .. hour .. ":"
    end

    if minute <10 then
        text = text .. "0".. minute
    else
        text = text .. minute
    end

    return  text
end

--到秒钟的string
function ServerTimeManager:secToString(t)
    -- local hour = (t-t%3600)/3600
    -- local minute = (t-hour*3600 -t%60)/60
    -- local second = t%60
    local second = t

    return string.format("%02d",second)
end

-- 到分秒的string
function ServerTimeManager:secCountToString(t)
    -- local hour = (t-t%3600)/3600
    -- local minute = (t-hour*3600 -t%60)/60
    -- local second = t%60
    local minute = t / 60
    local second = t % 60

    return string.format("%02d:%02d", minute, second)
end

function ServerTimeManager:getCurrentHHMMSS(t)
    local localdate = self:getDateObject(t)
    return localdate.hour, localdate.min,localdate.sec
end


function ServerTimeManager:isTimeExpired( t,fixedHour)
    -- body
    local tNow = self:getTime()
    return self:secondsFromToday(t) < fixedHour*3600 and self:secondsFromToday(tNow) >= fixedHour*3600 or tNow - t >= 24*3600
end

function ServerTimeManager:getLeftDHMFormat(t)
    local leftTime = t - self:getTime()
    if leftTime > 0 then
        local d = math.floor(leftTime / (24 * 3600))
        leftTime = leftTime % (24 * 3600)
        local h = math.floor(leftTime / 3600)
        leftTime = leftTime % 3600
        local m = math.floor(leftTime / 60)

        return Lang.get("common_time_DHM", {day = d,hour = h, minute = m})
    else
        return Lang.get("common_time_DHM", {day = 0,hour = 0, minute = 0})
    end
end

function ServerTimeManager:getTimeStringDHMS(t)
    local day,hour,min,second = self:convertSecondToDayHourMinSecond(t)
    local time =  string.format(Lang.get("common_time_DHMS_NEW"), day, hour, min,second)
    return time
end

function ServerTimeManager:getTimeStringHMS(t)
    local day,hour,min,second = self:convertSecondToDayHourMinSecond(t)
    return string.format(Lang.get("common_time_DHM"), hour, min, second)
end

function ServerTimeManager:getTimeStringDHM(t)
    local leftTime = t - self:getTime()
    local day,hour,min,second = self:convertSecondToDayHourMinSecond(leftTime)
    return string.format(Lang.get("common_time_DHM_NEW"), day, hour, min, second)
end

function ServerTimeManager:convertSecondToDayHourMinSecond(sec)
    if sec <= 0 then
        return 0,0,0,0
    end
    local day= math.floor(sec/(3600*24))
    sec = sec-day*3600*24
    local h = math.floor(sec/3600)
    sec = sec - h*3600
    local m=math.floor(sec/60)
    sec = sec - m * 60
    return day,h,m,sec
end

function ServerTimeManager:getLeftDHMSFormat(t)
     local leftTime = t - self:getTime()
     local day,hour,min,second = self:convertSecondToDayHourMinSecond(leftTime)
     local time =  string.format(Lang.get("common_time_DHMS"), day, hour, min,second)
     return time
end

--
function ServerTimeManager:getLeftDHMSFormatEx(t)
    local leftTime = t - self:getTime()
    local day,hour,min,second = self:convertSecondToDayHourMinSecond(leftTime)
    if day >= 1 then
        return string.format(Lang.get("common_time_D"), day, hour)
    end
    local time = string.format(Lang.get("common_time_DHM"), hour, min,second)
    return time
end

function ServerTimeManager:getLeftDHMSFormatD(t)
    local leftTime = t - self:getTime()
    local day,hour,min,second = self:convertSecondToDayHourMinSecond(leftTime)
    if day > 0 then
        return true, string.format(Lang.get("common_time_DH"), day, hour)  -- xx天文本
    else
        return false, string.format(Lang.get("common_time_HMS"), hour, min, second)
    end
end

--获取今天某个时间点时间戳
function ServerTimeManager:getTimestampByHMS(_hour, _min, _second)
    local localdate = self:getDateObject()
    local hour = _hour or 0
    local minute = _min or 0
    local second = _second or 0

    local stamp = os.time({year=localdate.year,month=localdate.month, day=localdate.day,
        hour = hour, min = minute, sec = second})
    return stamp or 0
end

--获取今天时间戳
--参数为秒数
function ServerTimeManager:getTimestampBySeconds(seconds)
    -- local localdate = self:getDateObject()
    -- local hour = (seconds-seconds%3600)/3600
    -- local minute = (seconds-hour*3600 -seconds%60)/60
    -- local second = seconds%60

    -- local stamp = os.time({year=localdate.year,month=localdate.month, day=localdate.day,
    --     hour = hour, min = minute, sec = second})

    -- return stamp or 0
    
    --i18n os.time会受本地时区影响导致计算出的时间戳不准确
    local stamp = self:getTime() - self:secondsFromToday() + seconds
    return stamp
end


--[[
    step 单位小时 表示几小时更新一次
    lastRefreshStamp 时间戳 上次更新时间 如果等于nil 则视为当前时间点
    返回值 下一个更新时间戳
]]
function ServerTimeManager:getAutoRefreshTargetStamp(step,lastRefreshStamp)
    local nowTime = self:getTime()
    local lastTime = lastRefreshStamp or nowTime
    local lastDate = self:getDateObject(lastTime)
    local secFromLast = lastDate.hour*3600 + lastDate.min*60 + lastDate.sec
    local lastStep = math.floor(secFromLast/(step))
    local targetTime = (lastTime - secFromLast) + (lastStep+1)*step
    return targetTime
end


--[[
    secList 刷新时间点 {3*3600,15*3600,...}
    lastRefreshStamp 根据一个时间点算出与其对应的下一个刷新时间点、如果等于nil 则视为当前时间点
    返回值 下一个更新时间戳
]]
function ServerTimeManager:getNextFixRefreshStamp(secList,lastRefreshStamp)
    --时间点刷新
    local isFinded = false
    local realNowTime = self:getTime()
    local nowTime = lastRefreshStamp or realNowTime
    local targetTime = nowTime
    if secList == nil or #secList < 1 then
        assert(nil,"secList must be a not nil or empty Array")
    end

    local secFromToday = self:secondsFromToday(nowTime)
    table.sort(secList,function(a,b)
        return a < b
    end)

    for i=1,#secList do
        if secFromToday < secList[i] then
            targetTime = secList[i] + (nowTime - secFromToday)
            isFinded = true
            break
        end
    end

    if isFinded == false then
        --找不到就是下一天
        targetTime = (nowTime - secFromToday) + 24*3600 + secList[1]
    end

    return targetTime
end

--[===================[
    比较t跟今天零点相差的秒数, 如果是今天之前的t,那么返回负数
]===================]
function ServerTimeManager:secondsFromToday(t)
    --首选需要知道今天的零点的那个t1
    local now = self:getTime()
    local date = self:getDateObject(now)
    local t1 = now - date.hour*3600 - date.min*60 - date.sec
    t = t or now
    return t - t1
end

function ServerTimeManager:getTodaySeconds(t)
    t = t or self:getTime()
    local date = self:getDateObject(t)
    return  date.hour*3600 + date.min*60 + date.sec
end

function ServerTimeManager:secondsFromZero(t,zeroSeconds)
    t = t or self:getTime()
    zeroSeconds = zeroSeconds or 0
    local date = self:getDateObject(t)
    local t1 = t - date.hour*3600 - date.min*60 - date.sec

    if t - t1 >= zeroSeconds then
       t1 = t1 + zeroSeconds
    else
       t1 = t1 - (3600*24 - zeroSeconds)
    end
    return t1
end

--i18n ui4
function ServerTimeManager:getTimeOfZero(t,zeroSeconds)
    t = t or self:getTime()
    zeroSeconds = zeroSeconds or 0
    local date = self:getDateObject(t)
    local t1 = t - date.hour*3600 - date.min*60 - date.sec

    if t - t1 >= zeroSeconds then
       t1 = t1 + zeroSeconds
    else
       t1 = t1 - (3600*24 - zeroSeconds)
    end
    return t1
end

-- 获取一个 4点 时间
function ServerTimeManager:getNextCleanDataTime()
    local cleanClock = 4 * 60 *60
    if not Lang.checkLang(Lang.CN) then
        local TimeConst  = require("app.const.TimeConst")
        cleanClock = TimeConst.RESET_TIME * 60 *60
    end
    local oneDay = 24*60*60
    local curTime = self:getTime()
    local date = self:getDateObject(curTime)
    local t1 = date.hour*3600 + date.min*60 + date.sec
    local nextCleanDataClock = curTime - t1 + cleanClock
    if t1 > cleanClock then
        nextCleanDataClock = nextCleanDataClock + oneDay
    end
    return nextCleanDataClock
end
-- 获取 下一个0点时间
function ServerTimeManager:getNextZeroTime(time)
    local oneDay = 24*60*60
    local curTime = time or self:getTime()
    local date = self:getDateObject(curTime)
    local t1 = date.hour*3600 + date.min*60 + date.sec
    local nextZeroClock = curTime - t1 + oneDay
    return nextZeroClock
end



--[[
    将时间（秒数）转换成时间格式的字符串
    sec 需要转换的秒数
    返回转换后的时间文本
    时间小于1小时，显示“x分钟”，不满1分钟，按1分钟算
    时间小于24小时，显示“x小时”
    时间大于24小时，显示“x天”
]]
function ServerTimeManager:getDayOrHourOrMinFormat(sec)
    local day,hour,min,second = self:convertSecondToDayHourMinSecond(sec)
    if day > 0 then
        return Lang.get("lang_common_format_day_unit", {day = day})  -- xx天文本
    else
        if hour > 0 then
            return Lang.get("lang_common_format_hour_unit", {hour = hour})
        else
            min = min > 0 and min or 1
            return Lang.get("lang_common_format_min_unit", {min = min})
        end
    end
end

--根据时间戳返回年月日和时间
--返回有两个参数分别为：2015-10-23 ，15：39：00
function ServerTimeManager:getDateAndTime(time)
    local tab = self:getDateObject(time)

    local function check(date)
        if tonumber(date) < 10 then
            date = "0".. date
        end
        return date
    end

    return  string.format(Lang.get("common_time_month_day"), tab.month, tab.day) , check(tab.hour) .. ":" .. check(tab.min) .. ":" .. check(tab.sec)
end

--根据时间戳返回年月日和时间
--返回有两个参数分别为：2015-10-23 ，15：39：00
function ServerTimeManager:getDateAndTime2(time)
    local tab = self:getDateObject(time)

    local function check(date)
        if tonumber(date) < 10 then
            date = "0".. date
        end
        return date
    end

    return  string.format(Lang.get("common_time_month_day2"), tab.month, tab.day) , check(tab.hour) .. ":" .. check(tab.min) .. ":" .. check(tab.sec)
end

--返回某天的最晚时间，diffDay指的是那天和当天差的天数
function ServerTimeManager:getSomeDayMidNightTimeByDiffDay(diffDay,resetHour)
	local TimeConst  = require("app.const.TimeConst")
	local resetSeconds = resetHour  * 3600
	local currentTime = G_ServerTime:getTime()
	local todaySecond = G_ServerTime:secondsFromToday(currentTime)
	if todaySecond >= resetSeconds then
		diffDay = diffDay + 1
	end
	local endTime = currentTime - todaySecond + resetSeconds + TimeConst.SECONDS_ONE_DAY * diffDay
	return endTime
end

function ServerTimeManager:getRefreshTimeString(t)
	local localdate = G_ServerTime:getDateObject(t)
    local time =  string.format(Lang.get("common_refresh_time_format"), localdate.year, localdate.month, localdate.day,localdate.hour)
    return time
end
--年月日
function ServerTimeManager:getRefreshTimeStringYMD(t, type)
	local localdate = G_ServerTime:getDateObject(t)
    local time =  string.format(Lang.get("common_refresh_time_format_YMD"), localdate.year, localdate.month, localdate.day)
    if type then
        time = string.format(Lang.get("common_refresh_time_format_YMD_"..type), localdate.year, localdate.month, localdate.day)
    end
    return time
end

--月日
function ServerTimeManager:getRefreshTimeStringMD(t)
	local localdate = G_ServerTime:getDateObject(t)
    local time =  string.format(Lang.get("common_refresh_time_format_MD"), localdate.month, localdate.day)
    return time
end

--计算每天重置的过期时间
function ServerTimeManager:getNextUpdateTime(lastUpdateTime,resetTime)
    local TimeConst  = require("app.const.TimeConst")
	-- 重置时间换算成秒数
    if resetTime == nil then
        resetTime = 4 --默认4点重置
    end
	local resetSeconds = resetTime * 3600

	-- 上一次更新距离今天0点的时间（秒数）
	local lastSeconds = G_ServerTime:secondsFromToday(lastUpdateTime)
	local nextUpdateTime = lastUpdateTime - lastSeconds + resetSeconds + (lastSeconds > resetSeconds and TimeConst.SECONDS_ONE_DAY or 0)

    local curTime = G_ServerTime:getTime()

	return nextUpdateTime, curTime >= nextUpdateTime
end

--计算指定下个wday和指定定小时的秒数
function ServerTimeManager:getTimeByWdayandSecond(wday, sec)
    local now = self:getTime()
    local date = self:getDateObject(now)
    local t0 = now -  date.wday*86400 - date.hour*3600 - date.min*60 - date.sec        --本周开始的时间
    return t0 + wday*86400 + sec
end


--计算下一个时间点的秒数
function ServerTimeManager:getNextHourCount(hour)
    local now = self:getTime()
    local date = self:getDateObject(now)
    local t = 0
    
    if date.hour < hour then 
        t = now - date.hour*3600 - date.min*60 - date.sec + hour*3600
    else 
        t = now - date.hour*3600 - date.min*60 - date.sec + hour*3600 + 86400
    end
    local time = t-now
    return self:getTimeStringHMS(time)
end

-- i18n 新增方法 :倒计时 toString ,00:00 小时:分钟
function ServerTimeManager:secondToHourAndMinuteString(t)
    local hour = (t-t%3600)/3600
    local minute = (t-hour*3600 -t%60)/60
    if hour == 0 and minute == 0 then
        minute = 1
    end
    local text = string.format("%02d:%02d",hour,minute)
    return  text
end

--i18n ja 获取banner图上的时间格式 05/22 22:00
function ServerTimeManager:getBannerTimeString(t)
    local localdate = self:getDateObject(t)
    return string.format("%02d/%02d %02d:%02d", localdate.month, localdate.day,localdate.hour, localdate.min)
end

--i18n ja 打印函数执行时间
function ServerTimeManager:millisecondNow(type, id)
    local socket = G_SocketManager --require "socket"

    id = (id == nil) and "" or id
    if type == 1 then
        self._start_time = G_ServerTime:getMSTime()
        release_print(id .. " start time: "..self._start_time  .."ms \n")
    elseif type == 2 then  
        self._end_time = G_ServerTime:getMSTime()
        local use_time = (self._end_time - self._start_time ) 
        release_print(id .. " used time: "..use_time .."ms --------------------------------------------------------------------------------- \n")
    end  
end  

return ServerTimeManager


 