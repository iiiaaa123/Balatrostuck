function Balatrostuck.INIT.Jokers.j_coloursmayhem()
    SMODS.Joker{
        name = "ColoUrs and Mayhem",
        key = "coloursmayhem",
        config = {
            extra = { 
            }
        },
        loc_txt = {
            ['name'] = "ColoUrs and Mayhem",
            ['text'] = {
                [1] = "When round begins, create {C:green}#1#",
                [2] = "{C:attention}Lucky {C:paradox}Paradox {C:clubs}4 of Clubs{} in hand"
            }
        },
        pos = {
            x = 0,
            y = 4
        },

        
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = true,

        atlas = 'HomestuckJokersAnimated',
        animated = true,
        frames = 8,
        animation_speed = 20,

        calculate = function (self, card, context)
        
        end,
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {G.GAME.probabilities.normal}}
        end,
    }
end 