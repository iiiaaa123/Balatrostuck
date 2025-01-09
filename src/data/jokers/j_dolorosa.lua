function Balatrostuck.INIT.Jokers.j_dolorosa()
    SMODS.Joker{
        name = "Wardrobifier",
        key = "dolorosa",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Wardrobifier',
            ['text'] = {
                [1] = "{C:attention}Wild{} cards also count as {C:attention}#1#,",
                [2] = "enhancement changes each round"
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