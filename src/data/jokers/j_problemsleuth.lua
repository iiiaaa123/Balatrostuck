function Balatrostuck.INIT.Jokers.j_problemsleuth()
    SMODS.Joker{
        name = "Problem Sleuth",
        key = "problemsleuth",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Problem Sleuth',
            ['text'] = {
                [1] = "Scored face cards give 2$ if played",
                [2] = "hand contrains a 3-Of-A-Kind"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 5,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 