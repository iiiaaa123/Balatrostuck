-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_betacopy()
    SMODS.Joker{
        name = "Beta Copy",
        key = "betacopy",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Beta Copy',
            ['text'] = {
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
    }:register()
end 