function Balatrostuck.INIT.Jokers.j_vodkamutini()
    SMODS.Joker{
        name = "Vodka Mutini",
        key = "vodkamutini",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Vodka Mutini',
            ['text'] = {
                [1] = "When a paradox card is created",
                [2] = "create a non-paradox copy of it."
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 