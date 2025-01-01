function Balatrostuck.INIT.Jokers.j_sepulcritude()
    SMODS.Joker{
        name = "Sepulchritude",
        key = "sepulcritude",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Sepulchritude',
            ['text'] = {
                [1] = "4x mult if played hand",
                [2] = "is a three-of-a-kind with faces"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 20,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 