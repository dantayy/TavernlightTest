-- removes a member with the passed ID from the party of the player with the passed ID
-- CHANGE: improved name of function and member argument to reflect their uses
function removeMemberFromPlayerParty(playerId, memberId)
    -- get player with the passed ID
    -- NOTE: not super confident in this syntax, but I don't have a better frame of reference for how the Player class/system operates so I assume this is a valid method to acquire a Player object
    player = Player(playerId)
    -- get the party tied to the player
    local party = player:getParty()
    
    -- iterate through party's members
    for k,v in pairs(party:getMembers()) do
        -- if member key matches the passed member ID, remove them from the player's party
        -- CHANGE: assuming members are keyed by ID, checking for match with the ID is more straightforward
        if k == memberId then
            -- NOTE: again, without better understanding of Player management, I have to assume this is a valid way to get a Playey, and that the party class takes in an object to remove it from itself
            -- NOTE: potentially could simplify party management if it just worked with IDs rather than entire Player objects
            party:removeMember(Player(memberId))
            -- CHANGE: break loop when member is removed (should only be one member with the passed ID)
            break
        end
    end
end