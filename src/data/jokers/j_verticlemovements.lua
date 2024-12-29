function Balatrostuck.INIT.Jokers.j_verticlemovements()
    SMODS.Joker{
        name = "VERTICLEMOVEMENTS",
        key = "verticlemovements",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'VERTICLEMOVEMENTS',
            ['text'] = {
                [1] = "Jokers in the shop are paradox",
                [2] = "All paradox cards give 1.2x mult"
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