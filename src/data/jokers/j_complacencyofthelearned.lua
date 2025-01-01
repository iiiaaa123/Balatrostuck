function Balatrostuck.INIT.Jokers.j_complacencyofthelearned()
    SMODS.Joker{
        name = "Complacency of the Learned",
        key = "complacencyofthelearned",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Complacency of the Learned',
            ['text'] = {
                [1] = "If a Lucky Card succeeds, gives xmult",
                [2] = "equal to 6 times the number of successes divided by how many cards scored"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 8,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 