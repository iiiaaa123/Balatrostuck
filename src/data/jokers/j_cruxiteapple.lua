function Balatrostuck.INIT.Jokers.j_cruxiteapple()
    SMODS.Joker{
        name = "Cruxite Apple",
        key = "cruxiteapple",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Cruxite Apple',
            ['text'] = {
                [1] = "If you win the blind with 0 hands",
                [2] = "remaining your first reroll next shop is free then destroy this"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 1,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 