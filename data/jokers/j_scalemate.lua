function Balatrostuck.INIT.Jokers.j_scalemate()
    SMODS.Joker{
        name = "Scalemate",
        key = "scalemate",
        config = {
            extra = { 
            }
        },
        loc_txt = {
            ['name'] = 'Scalemate',
            ['text'] = {
                [1] = "When round begins, create {C:green}#1#",
                [2] = "{C:attention}Lucky {C:paradox}Paradox {C:clubs}4 of Clubs{} in hand"
            }
        },
        pos = {
            x = 9,
            y = 12
        },

        
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
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