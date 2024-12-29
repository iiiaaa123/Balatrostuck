function Balatrostuck.INIT.Jokers.j_balletslippers()
    SMODS.Joker{
        name = "Ballet Slippers",
        key = "balletslippers",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Ballet Slippers',
            ['text'] = {
                [1] = "Gains +5 Mult if played hand is [played hand]",
                [2] = "hand changes every hand. Resets if a different hand is played."
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 