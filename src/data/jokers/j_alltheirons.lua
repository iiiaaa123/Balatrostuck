function Balatrostuck.INIT.Jokers.j_alltheirons()
    SMODS.Joker{
        name = "All the Irons",
        key = "alltheirons",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'All the Irons',
            ['text'] = {
            }
        },
        pos = {
            x = 7,
            y = 1
        },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calculate = function(self, context)
        end
    }:register()
end