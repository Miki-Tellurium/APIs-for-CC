--API for writing text by Miki_Tellurium
--v1.0

--- Simple API to write fast monochromatic text
---@class text
text={}

--- Print a line and then move cursor to next line
---@param text string The text to write
---@param xPos number The x coordinate of the text
---@param yPos number The y coordinate of the text
---@param textColor number What color the text will be
---@param backgroundColor number What color the background will be
function text.println(text, xPos, yPos, textColor, backgroundColor)

 local dText = term.getTextColor()               --Store the current text color
 local dBack = term.getBackgroundColor()         --Store the current background color
 local currentX, currentY = term.getCursorPos()  --Store the current cursor position
 
 if xPos == nil then
  xPos = currentX
 end
 
 if yPos == nil then
  yPos = currentY
 end
 
 if backgroundColor ~= nil then
  term.setBackgroundColor(backgroundColor)
 else
  term.setBackgroundColor(dBack)
 end
 
 if textColor ~= nil then
  term.setTextColor(textColor)
 else
  term.setTextColor(dText)
 end
 
 term.setCursorPos(xPos, yPos)
 print(text)
 
 term.setTextColor(dText)
 term.setBackgroundColor(dBack)
end

--- Print a line and move the cursor at the wnd of the written text
---@param text string The text to write
---@param xPos number The x coordinate of the text
---@param yPos number The y coordinate of the text
---@param textColor number What color the text will be
---@param backgroundColor number What color the background will be
function text.print(text, xPos, yPos, textColor, backgroundColor)

 local dText = term.getTextColor()               --Store the current text color
 local dBack = term.getBackgroundColor()         --Store the current background color
 local currentX, currentY = term.getCursorPos()  --Store the current cursor position

 if xPos == nil then
  xPos = currentX
 end
 
 if yPos == nil then
  yPos = currentY
 end
 
 if backgroundColor ~= nil then
  term.setBackgroundColor(backgroundColor)
 else
  term.setBackgroundColor(dBack)
 end
 
 if textColor ~= nil then
  term.setTextColor(textColor)
 else
  term.setTextColor(dText)
 end
 
 term.setCursorPos(xPos, yPos)
 term.write(text)
 
 term.setTextColor(dText)
 term.setBackgroundColor(dBack)
end
