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
            }
        },
        pos = {
            x = 0,
            y = 8
         },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }:register()
end 