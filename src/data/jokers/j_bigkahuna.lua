function Balatrostuck.INIT.Jokers.j_bigkahuna()
    SMODS.Joker{
        name = "Big Kahuna",
        key = "bigkahuna",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Big Kahuna',
            ['text'] = {
                [1] = "Create a {C:green}Paradox {C:attention}Lovers",
                [2] = "card at end of round"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 