-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_descend()
    SMODS.Joker{
        name = "Descend",
        key = "descend",
        config = {
            extra = {
                rounds_loc = 3,
                rounds_left = 3,
                mult_gain = 0.5,
                mult_total = 0
            }
        },
        loc_txt = {
            ['name'] = 'Descend',
            ['text'] = {
                [1] = 'After 3 rounds remove',
                [2] = 'every {C:planet}Planet{} level',
                [3] = 'and gain {C:white,X:mult}X0.5{} Mult',
                [4] = 'per level removed'
            }
        },
        pos = {
            x = 2,
            y = 7
         },
        cost = 4,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }:register()
end