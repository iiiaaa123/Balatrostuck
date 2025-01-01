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
                [1] = "Gains +7 mult when",
                [2] = "you score a straight"
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