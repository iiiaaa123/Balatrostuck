function Balatrostuck.INIT.Jokers.j_culling()
    SMODS.Joker{
        name = "Culling",
        key = "culling",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Culling',
            ['text'] = {
                [1] = "{C:mult}+20{} Mult if a card has been {C:attention}destroyed{} this round,", 
                [2] = "played cards with {C:clubs}Clubs{} or {C:diamonds}Diamonds{} suit have a", 
                [3] = "{C:green}1 in 4{} chance to be {C:attention}destroyed{} when scored"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 5,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 