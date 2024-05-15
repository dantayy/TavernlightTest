// adds item with passed ID to a player with the passed name string
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    // grab player
    // NOTE: Player pointer retrieved from elsewhere, not allocated here (assuming based on naming convention)
    Player* player = g_game.getPlayerByName(recipient);
    // handle missing player with passed name
    if (!player) {
        // create new Player object
        // NOTE: NEW Player memory allocated here
        player = new Player(nullptr);
        // attempt to load in Player data with the passed name from the I/O system
        // NOTE: assuming this action adds player to external storage so that it's memory will be managed/freed elsewhere if successful
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            // CHANGE: memory would leak here if Player not deleted before return
            delete player;
            return;
        }
    }

    // create new Item object with the given item
    // NOTE: NEW Item memory allocated here (assuming based on naming convention)
    Item* item = Item::CreateItem(itemId);
    // handle faulty item creation
    if (!item) {
        // NOTE: item would have to be a nullptr to get here, no risk of memory leak by returning now
        return;
    }

    // add item to player
    // NOTE: Item added to Player inbox; assuming Player frees its items, no extra memory management needed
    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    // save the player data in the I/O system if they're currently offline
    if(player->isOffline()){
        IOLoginData::savePlayer(player);
    }
}