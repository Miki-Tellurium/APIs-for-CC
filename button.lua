--Button making API by Miki_Tellurium
--Version 1.0
--To do: documentation

local dTextColor = colors.black         --default button text color
local dActBackColor = colors.green      --default background color when active
local dInactBAckColor = colors.red      --default background color when inactive
local dDisBackColor = colors.lightGrey  --default background color when disabled
local dBlinkColor = colors.yellow       --default blink color
active = "active"
inactive = "inactive"
disabled = "disabled"

---@class button
button = {
    label = "button",               --text displayed on the button
    width = 0,                      --width of the button (can't be smaller then the button)
    x = 1,                          --x coordinate
    y = 1,                          --y coordinate
    actTColor = dTextColor,         --text color when active
    inactTColor = dTextColor,       --text color when inactive
    disTColor = dTextColor,         --text color when disabled
    actBColor = dActBackColor,      --background color when active
    inactBColor = dInactBAckColor,  --background color when inactive
    disBColor = dDisBackColor,      --background color when disabled
    blinkColor = dBlinkColor,       --background color when button blink
    state = active,                 --possible states: active, inactive, disabled
    isBlink = false                 --if the button blink when clicked
}

--Class setup, allow to create new button objects
function button:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function button:delete()
    local background = term.getBackgroundColor()
    self:setBackgroundColor(background)
    self:setTextColor(background)
    self:paint()
    self = {}
end

function button:setLabel(text)
    self.label = tostring(text)
end

function button:getLabel()
    return self.label
end

function button:setWidth(int)
    if int < #self.label then
        error("Width must be equal or superior to number of characters in label")
    end
    self.width = int
end

function button:getWidth()
    return self.width
end

function button:setLocation(x, y)
    self.x = x
    self.y = y
end

function button:getLocation()
    return self.x, self.y
end

--Set same text color for all states
function button:setTextColor(color)
    self.actTColor = color
    self.inactTColor = color
    self.disTColor = color
end

function button:setActiveTextColor(color)
    self.actTColor = color
end

function button:getActiveTextColor()
    return self.actTColor
end

function button:setInactiveTextColor(color)
    self.inactTColor = color
end

function button:getInactiveTextColor(color)
    return self.inactTColor
end

function button:setDisabledTextColor(color)
    self.disTColor = color
end

function button:getDisabledTextColor()
    return self.disTColor
end

--Set same background color for all states
function button:setBackgroundColor(color)
    self.actBColor = color
    self.inactBColor = color
    self.disBColor = color
end

function button:setActiveBackgroundColor(color)
    self.actBColor = color
end

function button:getActiveBackgroundColor()
    return self.actBColor
end

function button:setInactiveBackgroundColor(color)
    self.inactBColor = color
end

function button:getInactiveBackgroundColor()
    return self.inactBColor
end

function button:setDisabledBackgroundColor(color)
    self.disBColor = color
end

function button:getDisabledBackgroundColor()
    return self.disBColor
end

function button:setState(string, repaint)
    if string == active then
        self.state = active
    elseif string == inactive then
        self.state = inactive
    elseif string == disabled then
        self.state = disabled
    else
        error("Incorrect state value. Possible states are active, inactive, disabled")
    end

    if repaint then
        self:paint()
    end
end

function button:getState()
    return self.state
end

function button:setBlinking(boolean)
    self.isBlink = boolean
end

function button:isBlinking()
    return self.isBlink
end

function button:setBlinkColor(color)
    self.blinkColor = color
end

function button:getBlinkColor()
    return self.blinkColor
end

function button:paint()
    --Store current text and background color for later
    local cText = term.getTextColor()
    local cBack = term.getBackgroundColor()
    --Store current cursor position for later
    local cX, cY = term.getCursorPos()

    if self.width < #self.label or self.width <= 0 then
        self.width = #self.label
    end
    --set text and background color based on current state
    if self.state == active then
        term.setBackgroundColor(self.actBColor)
        term.setTextColor(self.actTColor)
    elseif self.state == inactive then
        term.setBackgroundColor(self.inactBColor)
        term.setTextColor(self.inactTColor)
    elseif self.state == disabled then
        term.setBackgroundColor(self.disBColor)
        term.setTextColor(self.disTColor)
    end
    --Draw the button
    term.setCursorPos(self.x, self.y)
    if self.width > #self.label then
        local difference = self.width - #self.label
        for i = 1,math.floor(difference/2) do
            term.write(" ")
        end
        term.write(self.label)
        for k = 1,math.ceil(difference/2) do
            term.write(" ")
        end
    else
        term.write(self.label)
    end
    --Restore the previous terminal status
    term.setTextColor(cText)
    term.setBackgroundColor(cBack)
    term.setCursorPos(cX, cY)
end

function button:blink()
    local blinkColor = self.blinkColor
    local cBack = nil
    if self:isBlinking() then
        if self.state == active then
            cBack = self.actBColor
        elseif self.state == inactive then
            cBack = self.inactBColor
        elseif self.state == disabled then
            cBack = self.disBColor
        end

        if self.state == active then
            self:setActiveBackgroundColor(blinkColor)
        elseif self.state == inactive then
            self:setInactiveBackgroundColor(blinkColor)
        elseif self.state == disabled then
            self:setDisabledBackgroundColor(blinkColor)
        end

        self:paint()
        sleep(0.15)

        if self.state == active then
            self:setActiveBackgroundColor(cBack)
        elseif self.state == inactive then
            self:setInactiveBackgroundColor(cBack)
        elseif self.state == disabled then
            self:setDisabledBackgroundColor(cBack)
        end

        self:paint()
    end
end

function button:clear()
    local background = term.getBackgroundColor()
    local cText = nil
    local cBack = nil
    if self.state == active then
        cText = self.actTColor
        cBack = self.actBColor
    elseif self.state == inactive then
        cText = self.inactTColor
        cBack = self.inactBColor
    elseif self.state == disabled then
        cText = self.disTColor
        cBack = self.disBColor
    end

    if self.state == active then
        self:setActiveTextColor(background)
        self:setActiveBackgroundColor(background)
    elseif self.state == inactive then
        self:setInactiveTextColor(background)
        self:setInactiveBackgroundColor(background)
    elseif self.state == disabled then
        self:setDisabledTextColor(background)
        self:setDisabledBackgroundColor(background)
    end

    self:paint()

    if self.state == active then
        self:setActiveTextColor(cText)
        self:setActiveBackgroundColor(cBack)
    elseif self.state == inactive then
        self:setInactiveTextColor(cText)
        self:setInactiveBackgroundColor(cBack)
    elseif self.state == disabled then
        self:setDisabledTextColor(cText)
        self:setDisabledBackgroundColor(cBack)
    end
end

function button:waitForClick(event)
    if event[1] == "mouse_click" and event[2] == 1 then
        px, py = event[3], event[4]
        if px >= self.x and px < self.x+self.width and py == self.y then
            self:blink()
            return true
        else
            return false
        end
    elseif event[1] == "monitor_touch" then
        px, py = event[3], event[4]
        if px >= self.x and px < self.x+self.width and py == self.y then
            self:blink()
            return true
        else
            return false
        end
    else
        return false
    end
end
