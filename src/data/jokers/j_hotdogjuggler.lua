function Balatrostuck.INIT.Jokers.j_hotdogjuggler()
    SMODS.Joker{
        name = "Hotdog Juggler",
        key = "hotdogjuggler",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Hotdog Juggler',
            ['text'] = {
                [1] = "Every 25 cards discarded",
                [2] = "create a Zodiac card"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 5,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 