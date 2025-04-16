function Balatrostuck.INIT.Jokers.j_ahabscrosshairs()
    SMODS.Joker{
        name = "Ahabs Crosshairs",
        key = "ahabscrosshairs",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Ahabs Crosshairs',
            ['text'] = {
                [1] = "Gives {X:red,C:white}X#1#{} Mult per {C:money}$#2#",
                [2] = "of total {C:attention}sell value",
                [3] = "on all current {C:attention}Jokers",
                [4] = "{C:inactive}(Currently {X:red,C:white}X#2#{C:inactive} Mult)."
            }
        },
        pos = {
            x = 9,
            y = 0
         },
        cost = 20,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 