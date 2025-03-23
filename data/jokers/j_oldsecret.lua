function Balatrostuck.INIT.Jokers.j_oldsecret()
    SMODS.Joker{
        name = "Old Secret",
        key = "oldsecret",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Old Secret',
            ['text'] = {
                [1] = "A random held {C:attention}consumeable{} becomes",
                [2] = "{C:green}Paradox{} at end of round, {C:green}Paradox",
                [3] = "consumeables cannot be destroyed"
            }
        },
        pos = {
            x = 9,
            y = 8
         },
        cost = 6,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 