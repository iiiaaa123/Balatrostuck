--effect will be awkward with pack timings; needs lovely patch for pack tags (and also consider aquarius)
function Balatrostuck.INIT.Jokers.j_descendascend()
    SMODS.Joker{
        name = "Descendascend",
        key = "descendascend",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Descendascend', 
            ['text'] = {
                [1] = "Gain a {C:attention}Buffoon Tag{} at end of round,",
                [2] = "{C:attention}Jokers{} in {C:attention}Buffoon Packs{} are {C:green}Paradox"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 