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
                [1] = "This Joker gains {C:mult}+#1#{} Mult",
                [2] = "if {C:attention}poker hand{} is a {C:attention}#2#{},",
                [3] = "poker hand changes each hand,",
                [4] = "{C:attention}resets{} if a different hand is played",
                [5] = "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
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