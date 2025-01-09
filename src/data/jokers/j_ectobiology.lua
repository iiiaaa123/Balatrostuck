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
                [1] = "When {C:attention}Blind{} is selected, create a",
                [2] = "{C:green}Paradox{} copy of {C:attention}Joker{} to the right"
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