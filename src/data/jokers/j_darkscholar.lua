function Balatrostuck.INIT.Jokers.j_darkscholar()
    SMODS.Joker{
        name = "Dark Scholar",
        key = "darkscholar",
        config = {
            extra = {

                h_size = 0,
                h_max = 10,

                Xmult_up = 2,
                Xmult_down = 0.5,

                grimdark = false,
                scholar_text = {
                    [1] = "{C:attention}+1{} hand size every time",
                    [2] = "a {C:tarot}Tarot{} card is used,",
                    [3] = "goes {C:dark_edition}grimdark{} at {C:attention}+10"
                },
                grim_text = {
                    [1] = "{X:mult,C:white}X2{} Mult if a {C:tarot}Tarot{} card",
                    [2] = "has been used this round",
                    [3] = "otherwise {X:mult,C:white}X0.5{} Mult"
                },

            }
        },
        loc_txt = {
            ['name'] = 'Dark Scholar', --variables don't apply the formatting correctly. sad! figure it out later
            ['text'] = {
                [1] = "#1#",
                [2] = "#2#",
                [3] = "#3#"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 10,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.scholar_text[1], card.ability.extra.scholar_text[2], card.ability.extra.scholar_text[3]}}
        end,
    }
end 