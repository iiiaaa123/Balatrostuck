function Balatrostuck.INIT.Jokers.j_pairing_grid() 
    SMODS.Joker{
        name = "Pairing Grid",
        key = "pairing_grid",
        config = {
            extra = {}
        },
        loc_txt = {
            ['name'] = "Pairing Grid",
            ['text'] = {

            }
        },
        pos = {
            x = 9,
            y = 3
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calculate = function (self, context)
        end
    }:register()
end