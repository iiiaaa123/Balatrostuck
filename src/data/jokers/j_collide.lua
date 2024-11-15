-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_collide()
    SMODS.Joker{
        name = "Collide",
        key = "collide",
        config = {
        },
        loc_txt = {
            ['name'] = 'collide',
            ['text'] = {
            }
        },
        pos = {
            x = 4,
            y = 7
        },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
        end,
        calculate = function (self, context)
        end
    }:register()
end