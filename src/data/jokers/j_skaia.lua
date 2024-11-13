-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_skaia()
    SMODS.Joker{
        name = "Skaia",
        key = "skaia",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Skaia',
            ['text'] = {
            }
        },
        pos = {
            x = 4,
            y = 8
        },
        cost = 6,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }:register()
end 