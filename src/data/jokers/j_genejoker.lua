function Balatrostuck.INIT.Jokers.j_genejoker()
    SMODS.Joker{
        name = "Gene Joker",
        key = "genejoker",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Gene Joker',
            ['text'] = {
                [1] = "Gains +4 chips when a",
                [2] = "paradox card is created",
                [3] = "[Currently: +4 chips]"
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