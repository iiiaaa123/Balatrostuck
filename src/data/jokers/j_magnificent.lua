-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_magnificent() 
    SMODS.Joker{
        name = "Magnificent Joker",
        key = "magnificent",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'MAGNIFICENT JOKER.',
            ['text'] = {
            }
        },
        pos = {
            x = 5,
            y = 6
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calculate = function (self, context)
        end
    }:register()
end