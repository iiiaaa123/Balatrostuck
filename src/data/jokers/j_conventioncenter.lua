function Balatrostuck.INIT.Jokers.j_conventioncenter()
    SMODS.Joker{
        name = "Convention Center",
        key = "conventioncenter",
        config = {
            extra = { shop_size = 1}
        },
        loc_txt = {
            ['name'] = 'Convention Center',
            ['text'] = {
                [1] = "{C:attention}+1{} booster pack",
                [2] = "available in shop"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        add_to_deck = function(self,card,from_debuff)
            G.GAME.shop.booster_max = G.GAME.shop.booster_max + card.ability.extra.shop_size
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.GAME.shop.booster_max = G.GAME.shop.booster_max - card.ability.extra.shop_size
        end
    }
end 