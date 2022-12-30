--Button making API by Miki_Tellurium
--Version: 1.0.0
local expect = require("cc.expect")
local expect = expect.expect

local defaultTextColor = colors.black
local defaultActiveBackgroundColor = colors.green
local defaultInactiveBackgroundColor = colors.red
local defaultDisabledBackgroundColor = colors.lightGray
local defaultBlinkColor = colors.yellow
active = "active"
inactive = "inactive"
disabled = "disabled"

--- This API provide tools to draw and add functions to buttons.
--- Buttons can have different state and change look based on the
--- current state. The background and text color of the button is
--- customizable using the ComputerCraft [colors] API. You can also
--- use [button:waitForClick] to check when a button is clicked and
--- add functions to it.
---@class button
button = {
    label = "button",  --text displayed on the button
    width = 0,         --can't be smaller then label
    x = 1,
    y = 1,
    activeTextColor = defaultTextColor,
    inactiveTextColor = defaultTextColor,
    disabledTextColor = defaultTextColor,
    activeBackgroundColor = defaultActiveBackgroundColor,
    inactiveBackgroundColor = defaultInactiveBackgroundColor,
    disabledBackgroundColor = defaultDisabledBackgroundColor,
    blinkColor = defaultBlinkColor,  --background color when button blink
    state = active,                  --possible states: active, inactive, disabled
    isBlink = false                  --if the button blink when clicked
}

--- Create a new button with default values and return it.
--- You can use it like this:
--- * buttonName = [button:new()]
---
--- buttonName will be the name of the new button object, you
--- can call it's functions like this:
--- * buttonName:function()
function button:new(obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

--- Deletes the button from the terminal and erases its data.
--- Once this function is called the button no longer exist.
--- If you want to delete the button from the terminal without
--- erasing its data use [button:clear].
function button:delete()
    local background = term.getBackgroundColor()
    self:setBackgroundColor(background)
    self:setTextColor(background)
    self:paint()
    self = {}
end

--- Set the text that will be displayed on the button.
---@param text string The text to be displayed on the button
function button:setLabel(text)
    expect(1, text, "string")
    self.label = tostring(text)
    if self.width < #self.label or self.width <= 0 then
        self.width = #self.label
    end
end

--- Returns the label of the button.
---@return string The current label of the button
function button:getLabel()
    return self.label
end

--- Set the width of the button. If the width is greater than
--- the number of characters on the label than the label on the
--- button will be centered. Throws if the width is lower than
--- the number of characters on the label.
---@param int number The width of the button
function button:setWidth(int)
    expect(1, int, "number")
    if int < #self.label then
        error("bad argument to setWidth (can't be lower than label size)", 2)
    end
    self.width = int
end

--- Returns the width of the button
---@return number The width of the button
function button:getWidth()
    return self.width
end

--- Set where the button will be displayed on the terminal.
---@param x number The x coordinate of the button
---@param y number The y coordinate of the button
function button:setLocation(x, y)
    expect(1, x, "number")
    expect(2, y, "number")
    self.x = x
    self.y = y
end

--- Returns the x and y coordinates of the button
---@return number The x and y coordinates of the button
function button:getLocation()
    return self.x, self.y
end

--- Set the current state of the button. Different states dictate
--- the label and background color of the button. If repaint is true
--- the button will be repainted on the terminal.
--- Possible states are: active, inactive and disabled.
--- Throws if the state is invalid.
---@param state string The state of the button
---@param repaint boolean If the button should be repainted on the terminal
function button:setState(state, repaint)
    expect(1, state, "string")
    expect(2, repaint, "boolean", "nil")
    if state == active then
        self.state = active
    elseif state == inactive then
        self.state = inactive
    elseif state == disabled then
        self.state = disabled
    else
        error("bad argument to setState (possible states: active, inactive, disabled)", 2)
    end

    if repaint then
        self:paint()
    end
end

--- Returns the current state of the button.
---@return string The state of the button
function button:getState()
    return self.state
end

--- Set the same text color for all states.
---@param color number The color to set the text to
function button:setTextColor(color)
    expect(1, color, "number")
    self.activeTextColor = color
    self.inactiveTextColor = color
    self.disabledTextColor = color
end

--- Set the text color for the active state.
---@param color number The color to set the text to
function button:setActiveTextColor(color)
    expect(1, color, "number")
    self.activeTextColor = color
end

--- Returns the current text color for the active state of the button.
---@return number The current text color for the active state
function button:getActiveTextColor()
    return self.activeTextColor
end

--- Set the text color for the inactive state.
---@param color number The color to set the text to
function button:setInactiveTextColor(color)
    expect(1, color, "number")
    self.inactiveTextColor = color
end

--- Returns the current text color for the inactive state of the button.
---@return number The current text color for the inactive state
function button:getInactiveTextColor()
    return self.inactiveTextColor
end

--- Set the text color for the disabled state.
---@param color number The color to set the text to
function button:setDisabledTextColor(color)
    expect(1, color, "number")
    self.disabledTextColor = color
end

--- Returns the current text color for the disabled state of the button.
---@return number The current text color for the disabled state
function button:getDisabledTextColor()
    return self.disabledTextColor
end

--- Set the same background color for all states.
---@param color number The color to set the background to
function button:setBackgroundColor(color)
    expect(1, color, "number")
    self.activeBackgroundColor = color
    self.inactiveBackgroundColor = color
    self.disabledBackgroundColor = color
end

--- Set the background color for the active state.
---@param color number The color to set the background to
function button:setActiveBackgroundColor(color)
    expect(1, color, "number")
    self.activeBackgroundColor = color
end

--- Returns the current background color for the active state of the button.
---@return number The current background color for the active state
function button:getActiveBackgroundColor()
    return self.activeBackgroundColor
end

--- Set the background color for the inactive state.
---@param color number The color to set the background to
function button:setInactiveBackgroundColor(color)
    expect(1, color, "number")
    self.inactiveBackgroundColor = color
end

--- Returns the current background color for the inactive state of the button.
---@return number The current background color for the inactive state
function button:getInactiveBackgroundColor()
    return self.inactiveBackgroundColor
end

--- Set the background color for the disabled state.
---@param color number The color to set the background to
function button:setDisabledBackgroundColor(color)
    expect(1, color, "number")
    self.disabledBackgroundColor = color
end

--- Returns the current background color for the disabled state of the button.
---@return number The current background color for the disabled state
function button:getDisabledBackgroundColor()
    return self.disabledBackgroundColor
end

--- Set if the button should blink when clicked.
---@param boolean boolean If the button should blink when clicked
function button:setBlinking(boolean)
    expect(1, boolean, "boolean")
    self.isBlink = boolean
end

--- Returns true if the button is set to blink when clicked.
---@return boolean If the button is set to blink when clikced
function button:doesBlink()
    return self.isBlink
end

--- Set the color the button should turn to when clicked.
---@param color number The color the button should turn to when blinking
function button:setBlinkColor(color)
    expect(1, color, "number")
    self.blinkColor = color
end

--- Returns the color the button is set to turn to when blinking.
---@return number The color the button turn to when blinking
function button:getBlinkColor()
    return self.blinkColor
end

--- Draw the button on the screen using the current button
--- properties. Note that after the function is called the
--- cursor return where it was before drawing the button.
function button:paint()
    --Store current text and background color for later
    local currentTextColor = term.getTextColor()
    local currentBackgroundColor = term.getBackgroundColor()
    --Store current cursor position for later
    local currentX, currentY = term.getCursorPos()

    if self.width < #self.label or self.width <= 0 then
        self.width = #self.label
    end
    --set text and background color based on current state
    if self.state == active then
        term.setBackgroundColor(self.activeBackgroundColor)
        term.setTextColor(self.activeTextColor)
    elseif self.state == inactive then
        term.setBackgroundColor(self.inactiveBackgroundColor)
        term.setTextColor(self.inactiveTextColor)
    elseif self.state == disabled then
        term.setBackgroundColor(self.disabledBackgroundColor)
        term.setTextColor(self.disabledTextColor)
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
    term.setTextColor(currentTextColor)
    term.setBackgroundColor(currentBackgroundColor)
    term.setCursorPos(currentX, currentY)
end

--- Make the button blink. This function is called by [button:waitForClick]
--- if [button:setBlinking] is set to true.
function button:blink()
    local blinkColor = self.blinkColor
    local currentBackgroundColor = nil
    if self:doesBlink() then
        if self.state == active then
            currentBackgroundColor = self.activeBackgroundColor
        elseif self.state == inactive then
            currentBackgroundColor = self.inactiveBackgroundColor
        elseif self.state == disabled then
            currentBackgroundColor = self.disabledBackgroundColor
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
            self:setActiveBackgroundColor(currentBackgroundColor)
        elseif self.state == inactive then
            self:setInactiveBackgroundColor(currentBackgroundColor)
        elseif self.state == disabled then
            self:setDisabledBackgroundColor(currentBackgroundColor)
        end

        self:paint()
    end
end

--- Delete the button from the terminal. It doesn't erase its data.
--- Note that this function use the current background color of the
--- terminal to delete the button.
function button:clear()
    local background = term.getBackgroundColor()
    local currentTextColor = nil
    local currentBackgroundColor = nil
    if self.state == active then
        currentTextColor = self.activeTextColor
        currentBackgroundColor = self.activeBackgroundColor
    elseif self.state == inactive then
        currentTextColor = self.inactiveTextColor
        currentBackgroundColor = self.inactiveBackgroundColor
    elseif self.state == disabled then
        currentTextColor = self.disabledTextColor
        currentBackgroundColor = self.disabledBackgroundColor
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
        self:setActiveTextColor(currentTextColor)
        self:setActiveBackgroundColor(currentBackgroundColor)
    elseif self.state == inactive then
        self:setInactiveTextColor(currentTextColor)
        self:setInactiveBackgroundColor(currentBackgroundColor)
    elseif self.state == disabled then
        self:setDisabledTextColor(currentTextColor)
        self:setDisabledBackgroundColor(currentBackgroundColor)
    end
end

--- Return true if the button was clicked. This function checks for
--- the [mouse_click] or [monitor_touch] events and returns true if
--- the button was clicked. You can pass an event to this function
--- by using [os.pullEvent] in a table:
--- - local event = {[os.pullEvent()]}
function button:waitForClick(event)
    expect(1, event, "table")
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
