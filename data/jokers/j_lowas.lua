-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_lowas()
    SMODS.Joker{
        name = "Wind and Shade",
        key = "lowas",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Wind and Shade',
            ['text'] = {
                [1] = "When {C:attention}Blind{} is selected,",
                [2] = "shuffle {C:attention}3 {C:green}Paradox{} {C:attention}Gold{}",
                [3] = "cards into deck"
            }
        },
        pos = {
            x = 0,
            y = 8
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 