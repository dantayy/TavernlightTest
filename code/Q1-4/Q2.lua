function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    -- define the search query 
    -- (grab the rows of the "guilds" table that have a "max_members" value less than the passed number (memberCount), and return only the "name" column data)
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    -- query our database with the passed memberCount inserted into the formatted string
    -- NOTE: assuming we are using a TFS database as defined in https://github.com/otland/forgottenserver/blob/master/src/database.h
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    -- CHANGE: added a check to verify that result contains any data
    if resultId then
        -- CHANGE: loop through each row in the result
        repeat
            -- print the name value from this row of the result
            local guildName = result.getString("name")
            print(guildName)            
        until not result.next(resultId)
    else
        print(string.format("No guilds with size less than %d found!", memberCount))
    end
    -- CHANGE: free the database query result
    result.free(resultId)
    
end