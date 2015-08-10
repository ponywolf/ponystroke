-- stroke module com.ponywolf.strokeText

-- define module
local M = {}

function M.new(options)

  -- default options for instance
  options = options or {}
  local x = options.x or 0
  local y = options.y or 0
  options.x = 0
  options.y = 0

  -- new options 
  local color = options.color or {1,1,1,1}
  local strokeColor = options.strokeColor or {0,0,0,1}
  local strokeWidth = options.strokeWidth or 1

  -- create the main text
  local text = display.newText(options)
  text:setFillColor(color[1],color[2],color[3],color[4])

  -- make a bounding box based on the default text
  local width = math.max(text.contentWidth,options.width or 0)
  local height = math.max(text.contentHeight,options.height or 0)

  --  create snapshot to hold text/strokes
  local stroked = display.newSnapshot(width + (2 * strokeWidth), height + (2 * strokeWidth))
  stroked.strokes = {}
  stroked.unstroked = text

  -- draw the strokes
  for i = -strokeWidth, strokeWidth do
    for j = -strokeWidth, strokeWidth do
      if not (i == 0 and j == 0) then --skip middle
        options.x,options.y = i,j
        local stroke = display.newText(options)
        stroke:setFillColor(strokeColor[1],strokeColor[2],strokeColor[3],strokeColor[4])
        stroked.group:insert(stroke)
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
    self:invalidate()
  end

  stroked.group:insert(text)
  stroked:translate(x,y) 
  options.x = x
  options.y = y 
  stroked.text = options.text

  -- return insantance
  return stroked
end

-- return module
return M