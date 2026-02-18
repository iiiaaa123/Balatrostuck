function Balatrostuck.INIT.Jokers.j_hopesplosion()
    SMODS.Joker{
        name = "Hopesplosion",
        key = "hopesplosion",
        config = {
            extra = { 
            }
        },
        loc_txt = {
            ['name'] = "Hopesplosion",
            ['text'] = {
                [1] = "may god have mercy on us, campfire"
            }
        },
        pos = {
            x = 19,
            y = 0
        },

        
        cost = 8,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = false,
        unlocked = true,


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
        
        end,
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {G.GAME.probabilities.normal}}
        end,
    }
end 