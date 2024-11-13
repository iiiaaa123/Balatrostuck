-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_lolar()
    SMODS.Joker{
        name = "Light and Rain",
        key = "lolar",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Light and Rain',
            ['text'] = {
            }
        },
        pos = {
            x = 2,
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