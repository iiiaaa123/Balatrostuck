function Balatrostuck.INIT.Jokers.j_smallerbutterflies()
    SMODS.Joker{
        name = "Smaller Butterflies",
        key = "smallerbutterflies",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Smaller Butterflies',
            ['text'] = {
                [1] = "1 in 3 chance for +3$",
                [2] = "+33 chips"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 