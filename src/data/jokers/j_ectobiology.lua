function Balatrostuck.INIT.Jokers.j_ectobiology()
    SMODS.Joker{
        name = "Ectobiology",
        key = "ectobiology",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Ectobiology',
            ['text'] = {
                [1] = "Start of blind create a paradox",
                [2] = "copy of joker to the right of this."
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 10,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 