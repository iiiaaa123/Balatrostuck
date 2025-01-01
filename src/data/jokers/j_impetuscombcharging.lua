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
                [1] = "First played Three of a Kind gives a D6 tag. Resets every ante.",
                [2] = "Unleash sepulcritude after 20 rerolls. [Currently: 0/20]"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 7,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 