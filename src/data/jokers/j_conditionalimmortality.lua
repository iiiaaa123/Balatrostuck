function Balatrostuck.INIT.Jokers.j_conditionalimmortality()
    SMODS.Joker{
        name = "Conditional Immortality",
        key = "conditionalimmortality",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Conditional Immortality',
            ['text'] = {
                [1] = "Gains +3 mult for every Jimbo sold",
                [2] = "Jimbo appears 10x more often in the shop"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 