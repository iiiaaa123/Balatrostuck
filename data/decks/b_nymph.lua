function Balatrostuck.INIT.Decks.b_nymph()
    SMODS.Back {
        key = 'nymph',
        loc_txt = {
            name = "Nymph Deck",
            text = {
                'THE effect',
            }
        },
        atlas = 'HomestuckDecks',
        pos = {x = 0,y = 1},
        unlocked = true,
        calculate = function(self,back,context)
            if context.skip_blind then
            Game:update_shop(dt)
            G.UIDEF.shop()
            G.STATE = G.STATES.SHOP
            G.GAME.shop_free = nil
            G.GAME.shop_d6ed = nil
            G.shop.alignmen.offset.y = -5.3
            end
        end
    }
end
