function Balatrostuck.INIT.Jokers.j_museofspace()
    SMODS.Joker{
        name = "Muse of Space",
        key = "museofspace",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Muse of Space',
            ['text'] = {
                [1] = "Gain +3 hand size",
                [2] = "End of blind this transforms into Lord of Time"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 