--
-- Author: hzyuxiaohua@corp.netease.com
-- Date: 2014-04-18 14:40:44
--

local teachlayer = import("..TeachLayer")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    display.newSprite("Background.jpg", display.cx, display.cy):addTo(self)

    local button_1 = ui.newImageMenuItem({
        image = "Box.png",
        x = display.cx - 200,
        y = display.cy,
        listener = function(tag)
            print("Button_1 Clicked.")
        end
        })

    local button_2 = ui.newImageMenuItem({
        image = "Box.png",
        x = display.cx,
        y = display.cy,
        listener = function(tag)
            print("Button_2 Clicked.")
        end
        })

    local button_3 = ui.newImageMenuItem({
        image = "Box.png",
        x = display.cx + 200,
        y = display.cy,
        listener = function(tag)
            print("Button_3 Clicked.")
        end
        })

    local menu = ui.newMenu({button_1, button_2, button_3}):addTo(self)
    -- menu:setTouchPriority(kCCMenuHandlerPriority + 20)
    
    local myteachlayer = teachlayer:new({x = display.cx - 200, y = display.cy}):addTo(self)
    local label = ui.newTTFLabel({
        text = "提示:请点击小手提示的按钮！",
        color = ccc3(255, 255, 255),
        x = display.cx,
        y = display.cy + 200,
        align = ui.TEXT_ALIGN_CENTER,
        })
    myteachlayer:addChild(label)
end

function MainScene:onEnter()

end

function MainScene:onExit()
end

return MainScene
