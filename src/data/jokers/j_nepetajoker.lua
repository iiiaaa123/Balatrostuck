function Balatrostuck.INIT.Jokers.j_nepetajoker()
    SMODS.Joker{
        name = "nepetajoker",
        key = "nepetajoker",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'nepetajoker',
            ['text'] = {
                [1] = "Permanently gains +3 Mult when played hand has a scoring card of",
                [2] = "[suit] and [suit] (changes each round) [Currently: +0]"
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