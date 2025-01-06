function Balatrostuck.INIT.Jokers.j_clover()
    SMODS.Joker{
        name = "Clover",
        key = "clover",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Clover',
            ['text'] = {
                [1] = "When round begins, create {C:green}#1#",
                [2] = "{C:attention}Lucky {C:green}Paradox {C:clubs}4 of Clubs{} in hand"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function (self, info_queue, card)
            return {vars = {G.GAME.probabilities.normal}}
        end,
    }
end 