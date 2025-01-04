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
                [1] = "Earn {C:money}$#1#{} if a Joker triggers",
                [2] = "{C:attention}thrice{} in a single round",
                [3] = "{C:inactive}(Once per Joker each round)"
            }
        },
        pos = {
            x = 7,
            y = 1
        },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calculate = function(self, card, context)
        end
    }
end