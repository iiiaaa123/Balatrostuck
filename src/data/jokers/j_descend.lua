-- TODO: Localization and calculation logic, make sure to replace description with just the mult after rounds are up
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
            ['name'] = 'Descend', --would like to replace entire description with just "X1 Mult" for however much mult it has after the removal thangs
            ['text'] = {
                [1] = 'After 3 rounds, set level',
                [2] = 'of all poker hands to 1 and',
                [3] = 'this Joker gains {C:white,X:mult}X0.5{} Mult',
                [4] = 'per level removed',
                [5] = '(Currently 0/3)'
            }
        },
        pos = {
            x = 2,
            y = 7
         },
        cost = 9,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end