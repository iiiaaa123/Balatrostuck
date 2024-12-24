function Balatrostuck.INIT.Jokers.j_bigkahuna()
    SMODS.Joker{
        name = "Big Kahuna",
        key = "bigkahuna",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Big Kahuna',
            ['text'] = {
                [1] = "After beating a blind",
                [2] = "create a paradox lovers card"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 