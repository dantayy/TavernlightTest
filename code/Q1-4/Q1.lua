-- release storage data of passed player
local function releaseStorage(player)
    -- CHANGE: swapped out constant player value for passed variable player
    -- CHANGE: then cut out unnecessary passing of self (player) to method called with : syntax
    player:setStorageValue(-1)
    -- NOTE: wrapping a single statement chunk in a function seems unnecessary...
    -- NOTE: if this is all releaseStorage will ever do, it could probably be cut and instances of it replaced with the direct call to setStorageValue on the player.
end

-- called whenever the passed player logs out
function onLogout(player)
    -- check for existing player storage data
    -- CHANGE: swapped out constant player value for passed variable player
    -- CHANGE: then cut out unnecessary passing of self to method called with : syntax
    -- CHANGE: modified the comparison to check for the null storage value (-1)
    -- CHANGE: inverted the player check so that it fires when a player *does* exist that needs its storage data released
    if player:getStorageValue() ~= -1 then
        -- in 1000 miliseconds, release the passed player by passing it to releaseStorage
        -- NOTE: If there is no reason for the system to maintain player storage data after this function ends, this could be turned into a direct call on releaseStorage/player:setStorageValue
        addEvent(releaseStorage, 1000, player)
        -- tell caller that passed player was set to be released successfully
        return true
    end
    -- tell the caller that something went wrong when trying to find/release the passed player
    return false
end