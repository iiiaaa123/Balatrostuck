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
                [1] = "Turn a random consumable paradox at end of round.",
                [2] = "Paradox consumables cannot be destroyed."
            }
        },
        pos = {
            x = 2,
            y = 0
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