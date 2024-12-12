-- DONE
function Balatrostuck.INIT.Jokers.j_ringoflife() 
    SMODS.Joker{
        name = "Ring of Life",
        key = "ringoflife",
        config = {
        },
        loc_txt = {
            ['name'] = 'Ring of Life',
            ['text'] = {
                [1] = "Adjacent {C:attention}Jokers{}",
                [2] = "count as {C:tarot}Eternal{}",
            }
        },
        pos = {
            x = 4,
            y = 6
        },
        cost = 6,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calculate = function(self, context)
        end
    }
end