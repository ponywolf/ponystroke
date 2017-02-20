-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Example of strokeText 

display.setDefault( "background", 0.333 )

local ponystroke = require "com.ponywolf.ponystroke"

local options = {
  text = "This is an example of strokeText in Corona SDK",
  x = display.contentCenterX,
  y = display.contentCenterY,
  width = display.contentWidth * 0.8,
  font = native.systemFontBold,
  fontSize = 24,
  align = "center",
  color = {1,1,1,1},
  strokeColor = {0,0,0,1},
  strokeWidth = 2
}

local strokedText = ponystroke.newText(options)

local function onTimer()
  strokedText.text = "Use this to change the what the text says"
end

timer.performWithDelay(1500, onTimer)

-- since it's a snapshot, it fades like pre-rendered glyph fonts

transition.to(strokedText, {alpha = 0, delay = 3000})
transition.to(strokedText, {alpha = 1, delay = 4500})

-- That's about it, enjoy


