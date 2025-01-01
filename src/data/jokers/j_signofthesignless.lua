function Balatrostuck.INIT.Jokers.j_signofthesignless()
    SMODS.Joker{
        name = "Sign of the Signless",
        key = "signofthesignless",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Sign of the Signless',
            ['text'] = {
                [1] = "1 in 60 to be destroyed and reset all Zodiac levels. ",
                [2] = "If a played card is just a wild card destroy it and level up the Zodiac of the same rank"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 9,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 