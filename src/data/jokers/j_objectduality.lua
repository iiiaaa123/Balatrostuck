function Balatrostuck.INIT.Jokers.j_objectduality()
    SMODS.Joker{
        name = "Object Duality",
        key = "objectduality",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Object Duality',
            ['text'] = {
                [1] = "If first played hand of round is a high card then create",
                [2] = "the paradox joker corresponding to each scored card"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 