function Balatrostuck.INIT.Jokers.j_dolorosa()
    SMODS.Joker{
        name = "The Dolorosa",
        key = "dolorosa",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'The Dolorosa',
            ['text'] = {
                [1] = "Wild Cards also count as [enhancement]",
                [2] = "Enhancement changes each round"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 6,
        rarity = 2,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 