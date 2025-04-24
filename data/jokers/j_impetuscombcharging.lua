function Balatrostuck.INIT.Jokers.j_impetuscombcharging()
    SMODS.Joker{
        name = "Impetus Comb Charging",
        key = "impetuscombcharging",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Impetus Comb Charging',
            ['text'] = {
                [1] = "First played {C:attention}Three of a Kind{}",
                [2] = "each ante gives a {C:attention}D6 tag{}.",
                [3] = "{C:green}Unleash sepulcritude{} after {C:attention}20{} rerolls",
                [4] = "{C:inactive}(Currently {C:attention}0{C:inactive}/20 rerolls)"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 7,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 