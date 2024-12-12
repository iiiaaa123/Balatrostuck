function Balatrostuck.INIT.Jokers.j_typheus()
    SMODS.Joker{
        name = "Typheus",
        key = "typheus",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Typheus',
            ['text'] = {
                [1] = 'Debuffed cards act',
                [2] = 'as all enhancements,',
                [3] = 'debuffs all held ',
                [4] = 'cards {C:attention}each hand{}'
            }
        },
        pos = {
            x = 4,
            y = 9
        },
        cost = 20,
        rarity = 4,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        soul_pos = {
            x = 9,
            y = 9
        }
    }
end