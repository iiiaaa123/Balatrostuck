function Balatrostuck.INIT.Jokers.j_redblood()
    SMODS.Joker{
        name = "Redblood",
        key = "redblood",
        config = {
            extra = {
            }
        },
        enhancement_gate = 'm_wild',
        loc_txt = {
            ['name'] = 'Redblood',
            ['text'] = {
                [1] = '{C:attention}Wild Cards{} can\'t be debuffed'
            }
        },
        pos = {
            x = 2,
            y = 10
         },
        cost = 2,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',


        
    }
end