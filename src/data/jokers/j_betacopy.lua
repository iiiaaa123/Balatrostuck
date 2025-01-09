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
                [1] = "{C:red}X2{} Base Blind size",
                [2] = "Gain a {C:attention}Sburb Tag",
                [3] = "at the end of round",
                [4] = "{S:1.1,C:red,E:2}self destructs"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 25,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 