-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Example of strokeText 

display.setDefault( "background", 0.333 )

local strokeText = require "com.ponywolf.strokeText"

local options = {
  text = "This is an example of strokeText in Corona SDK",
  x = display.contentCenterX,
  y = display.contentCenterY,
  width = display.contentWidth * 0.8,
  font = native.systemFontBold,
  fontSize = 42,
  align = "center",
  color = {1,1,1,1},
  strokeColor = {0,0,0,1},
  strokeWidth = 2
}

local text = strokeText.new(options)

-- use text:update() to change the text

local function onTimer()
  text:update("Use this to change the what the text says")
end

timer.performWithDelay(1500, onTimer)

-- since it's a snapshot, it fades like pre-rendered glyph fonts

transition.to(text, {alpha = 0, delay = 3000})
transition.to(text, {alpha = 1, delay = 4500})

-- That's about it, enjoy


