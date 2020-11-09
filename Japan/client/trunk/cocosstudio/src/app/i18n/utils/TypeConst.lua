local TypeConst = {}

TypeConst.__index = 0

function TypeConst._indexIncreasing()
    TypeConst.__index = TypeConst.__index + 1
    return TypeConst.__index
end

-- 文本
TypeConst.TEXT = TypeConst._indexIncreasing() 
-- 特效
TypeConst.EFFECT = TypeConst._indexIncreasing() 
-- 编辑器
TypeConst.EDITOR = TypeConst._indexIncreasing() 


-- 常规字体
TypeConst.FONT_NORMAL = TypeConst._indexIncreasing() 
-- 标题字体
TypeConst.FONT_TITLE = TypeConst._indexIncreasing() 


return readOnly(TypeConst)
