function Balatrostuck.INIT.Jokers.j_theplotpoint()
    SMODS.Joker{
        name = "The Plot Point",
        key = "theplotpoint",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'The Plot Point',
            ['text'] = {
                [1] = "Sell this joker: Destroy all jokers except leftmost",
                [2] = "Gain a Black Hole and -1 ante. Once per game."
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 