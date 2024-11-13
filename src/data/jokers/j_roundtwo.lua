function Balatrostuck.INIT.Jokers.j_roundtwo() 
    SMODS.Joker{
        name = "Round 2",
        key = "roundtwo",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Round 2',
            ['text'] = {
            }
        },
        pos = {
            x = 6,
            y = 7
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }:register()
end