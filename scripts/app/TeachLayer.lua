--
-- Author: hzyuxiaohua@corp.netease.com
-- Date: 2014-04-18 17:18:44
--

local TeachLayer = class("TeachLayer", function(rect) return display.newLayer() end)

function TeachLayer:ctor(param,args)
    self:setTouchEnabled(true)
    self:addTouchEventListener(function(event, x, y)
        if event == "began" then
            local rect = CCRectMake(args["x"] - 60, args["y"] - 60, 120, 120)
            local touchposition = CCPoint(x,y)

            if rect:containsPoint(touchposition) then
                print("Yes")
                return true
            else
                print("NO")
                return false
            end
        end
    end, false, -128, false)

    -- 裁剪图层
    local pClip = CCClippingNode:create()
    -- 反向
    pClip:setInverted(true)

    -- 蒙板
    local colorlayer = CCLayerColor:create(ccc4(0, 0, 0, 100))
    pClip:addChild(colorlayer)

    -- 模板初始化
    local node = CCDrawNode:create()

    -- 绘制8边形
    -- local pointarr1 = CCPointArray:create(8)
    -- pointarr1:add(ccp(display.cx-150, display.cy))
    -- pointarr1:add(ccp(display.cx-100, display.cy + 100))
    -- pointarr1:add(ccp(display.cx, display.cy+150))
    -- pointarr1:add(ccp(display.cx+100, display.cy + 100))
    -- pointarr1:add(ccp(display.cx+150, display.cy))
    -- pointarr1:add(ccp(display.cx+100, display.cy - 100))
    -- pointarr1:add(ccp(display.cx, display.cy-150))
    -- pointarr1:add(ccp(display.cx-100, display.cy - 100))

    -- node:drawPolygon(pointarr1:fetchPoints(), 8, ccc4f(1.0, 1.0, 0, 0.5), 4, ccc4f(0.1, 1, 0.1, 1))
    -- node:drawDot(CCPoint(display.cx, display.cy),100,ccc4f(0,1,0,1))
    -- node:drawSegment(CCPoint(display.cx - 100, display.cy), CCPoint(display.cx + 100, display.cy), 40, ccc4f(0,1,0,1))

    -- 绘制圆形
    local green     = ccc4f(0.1, 1, 0.1, 1)             -- 顶点颜色,这里我们没有实质上没有绘制,所以看不出颜色
    local Radius    = 55                                -- 圆的半径
    local vertCount = 64                                -- 圆形其实可以看做正多边形,我们这里用正64边型来模拟园
    local coef      = 2.0 * math.pi/vertCount           -- 计算每两个相邻顶点与中心的夹角
    local verts     = CCPointArray:create(vertCount)    -- 顶点数组

    for i = 1, vertCount do
        local rads = i * coef                           -- 弧度
        local x = Radius * math.cos(rads)               -- 对应顶点的x
        local y = Radius * math.sin(rads)               -- 对应顶点的y
        verts:add(ccp(x,y))
    end

    -- 绘制多边形
    node:drawPolygon(verts:fetchPoints(),vertCount,green,4,green)
    node:runAction(CCRepeatForever:create(CCSequence:createWithTwoActions(CCScaleBy:create(0.3,0.8), CCScaleTo:create(0.3,1))))
	pClip:setStencil(node)
	self:addChild(pClip)

    -- 自定义位置，该实例使用屏幕中心位置
    if type(args) == "table" then
    	node:setPosition(args["x"], args["y"])
    else
    	node:setPosition(display.cx, display.cy)
    end

    -- 添加其它组件
    -- 圆圈
    self.circle = display.newSprite("Circle.png", args["x"], args["y"]):addTo(self)
    -- 小手
    self.hand   = display.newSprite("Hand.png", self.circle:getContentSize().width/2 + 30, self.circle:getContentSize().height/2 - 40):addTo(self.circle)
	self.circle:runAction(CCRepeatForever:create(CCSequence:createWithTwoActions(CCScaleBy:create(0.3,0.8), CCScaleTo:create(0.3,1))))
end


return TeachLayer