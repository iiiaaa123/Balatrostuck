-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_lofaf()
    SMODS.Joker{
        name = "Frost and Frogs",
        key = "lofaf",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Frost and Frogs',
            ['text'] = {
            }
        },
        pos = {
            x = 3,
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