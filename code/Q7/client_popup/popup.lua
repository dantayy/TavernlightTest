
popupWindow = nil -- window reference
popupButton = nil -- button reference
popupMargin = 20 -- space from edge of window at which button will autmatically jump
moveAmmount = 10 -- space to move button horizontally every time move is called
moveTimer = 100 -- time between calls to the move function

-- called by onLoad from popup.otmod
function init()
  create()
end

-- called by onUnload from popup.otmod
function terminate()
  destroy()
end

-- reposition the button instantly
function jump()
  -- set button X to the right side of the window
  buttonX = popupWindow:getX() + popupWindow:getWidth() - popupMargin - popupButton:getWidth()
  -- set button Y to a random vertical value within the bounds of the predefined margin
  buttonY = math.random(popupWindow:getPosition().y + popupMargin + popupButton:getHeight(), popupWindow:getPosition().y + popupWindow:getHeight() - popupMargin - popupButton:getHeight())
  -- set the position values of the button
  popupButton:setPosition({x = buttonX, y = buttonY})
end

-- move the button horizontally on its own
function move()
    -- get button's horizontal position
    buttonX = popupButton:getX()
    -- check if close enough to left side of window to jump back to right side
    if buttonX < popupWindow:getX() + popupMargin then
      jump()
    end
    -- move button to the left
    buttonX = buttonX - moveAmmount
    popupButton:setPosition({x = buttonX, y = popupButton:getY()})
    -- schedule another move
    scheduleEvent(move, moveTimer)
  end

-- initialize variables
function create()
  -- grab the window
  popupWindow = g_ui.displayUI('popup')
  -- grab the button
  popupButton = popupWindow:recursiveGetChildById('jumpButton')
  -- force the window to show and take focus immediately
  popupWindow:show()
  popupWindow:raise()
  popupWindow:focus()
  -- start button off with a jump to the right side
  jump()
  -- start moving button momentarily
  scheduleEvent(move, moveTimer)
end

-- release/destroy variables
function destroy()
  if popupWindow then
      popupButton = nil
      popupWindow:destroy()
      popupWindow = nil
  end
end