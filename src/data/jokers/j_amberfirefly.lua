function Balatrostuck.INIT.Jokers.j_amberfirefly()
    SMODS.Joker{
        name = "Amber Firefly",
        key = "amberfirefly",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Amber Firefly',
            ['text'] = {
                [1] = "Shuffle a random {C:green}Paradox",
                [2] = "card with a {C:purple}Purple Seal{} into",
                [3] = "deck when {C:attention}Blind{} is selected",
                [4] = "{C:attention}-1{} hand size"
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