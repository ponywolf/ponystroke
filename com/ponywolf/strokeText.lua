-- stroke module com.ponywolf.strokeText

-- define module
local M = {}
local useContainer = false

function M.new(options)

  -- default options for instance
  options = options or {}
  local x = options.x or 0
  local y = options.y or 0
  options.x = 0
  options.y = 0

  -- new options 
  local color = options.color or {1,1,1,1}
  local strokeColor = options.strokeColor or {0.25,0.25,0.25,1}
  local strokeWidth = options.strokeWidth or 2

  -- create the main text
  local text = display.newText(options)
  text:setFillColor(unpack(color))

  -- make a bounding box based on the default text
  local width = math.max(text.contentWidth, options.width or 0)
  local height = math.max(text.contentHeight * 2, options.height or 0)

  --  create snapshot to hold text/strokes
  local stroked

  if useContainer then 
    stroked = display.newSnapshot(width + (2 * strokeWidth), height + (2 * strokeWidth))
  else 
    stroked = display.newGroup()
  end

  stroked.strokes = {}
  stroked.unstroked = text

  -- draw the strokes
  for i = -strokeWidth, strokeWidth, 1 do
    for j = -strokeWidth, strokeWidth, 1 do
      if not (i == 0 and j == 0) then --skip middle
        options.x,options.y = i,j
        local stroke = display.newText(options)
        stroke:setFillColor(unpack(strokeColor))
        if useContainer then
          stroked.group:insert(stroke)
        else
          stroked:insert(stroke)
        end
        --stroked:insert(stroke)        
        stroked.strokes[#stroked.strokes+1] = stroke
      end
    end
  end

  -- call this function to update the text and invalidate the canvas
  function stroked:update(text)
    self.unstroked.text = text
    self.text = text
    for i=1, #self.strokes do
      self.strokes[i].text = text
    end
    if self.invalidate then self:invalidate() end
  end

  if useContainer then
    stroked.group:insert(text)  
  else
    stroked:insert(text) 
    function stroked:setFillColor(r,g,b,a)
      stroked.unstroked:setFillColor(r,g,b,a)
    end
  end

  stroked:translate(x,y) 
  options.x = x
  options.y = y 
  stroked.text = options.text

  -- return insantance
  return stroked
end

-- return module
return M