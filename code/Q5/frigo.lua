-- frigo code for question 5 of the Tavernlight test, executed when any player says "frigo"
function onSay(player, words, param)
    -- get player's position as a reference point to place effects around
    local playerPosition = player:getPosition()
    -- create an effect position to move around the player
    local effectPosition = player:getPosition()
    local effectMaxX = effectPosition.x + 4
    local effectMinX = effectPosition.x - 4
    local effectMaxY = effectPosition.y + 2
    local effectMinY = effectPosition.y - 2
    -- create a flurry of ice tornadoes in rapid succession
    -- originally tried to implement this with an os.time()-based while loop
    -- couldn't get tornadoes to reliably appear when spawned on time intervals though...
    for i = 1, 100, 1 do
        -- give tornado a random position
        effectPosition.x = math.random(effectMinX,effectMaxX)
        effectPosition.y = math.random(effectMinY,effectMaxY)
        -- ignore tornadoes placed directly on the player's vertical line and on the corners of the area
        if effectPosition.x ~= playerPosition.x
        and not(effectPosition.x == effectMaxX and effectPosition.y == effectMaxY)
        and not(effectPosition.x == effectMaxX and effectPosition.y == effectMinY)
        and not(effectPosition.x == effectMinX and effectPosition.y == effectMaxY)
        and not(effectPosition.x == effectMinX and effectPosition.y == effectMinY)
        then
            -- do the magic effect
            doSendMagicEffect(effectPosition, CONST_ME_ICETORNADO)
        end
    end
    -- send text to screen
    return true
end