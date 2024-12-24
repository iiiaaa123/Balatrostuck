function Balatrostuck.INIT.Jokers.j_misspaint()
    SMODS.Joker{
        name = "Miss Paint",
        key = "misspaint",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Miss Paint',
            ['text'] = {
                [1] = "Gains +1 mult when a card changes suits",
                [2] = "[Currently: +4 mult]"
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
    }
end 