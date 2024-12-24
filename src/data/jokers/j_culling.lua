function Balatrostuck.INIT.Jokers.j_culling()
    SMODS.Joker{
        name = "Culling",
        key = "culling",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Culling',
            ['text'] = {
                [1] = "Scored clubs and diamonds have a 1 in 4 chance to be destroyed",
                [2] = "+20 mult if a card has been destroyed this round"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 5,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 