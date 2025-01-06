function Balatrostuck.INIT.Jokers.j_crowbarsfelt()
    SMODS.Joker{
        name = "Crowbars Felt",
        key = "crowbarsfelt",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Crowbars Felt',
            ['text'] = {
                [1] = "Gains {C:mult}+#2#{} Mult",
                [2] = "if played hand",
                [3] = "contains a {C:attention}Straight{}",
                [4] = "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 99,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 