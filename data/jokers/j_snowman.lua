function Balatrostuck.INIT.Jokers.j_snowman()
    SMODS.Joker{
        name = "Snowman",
        key = "snowman",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Snowman',
            ['text'] = {
                [1] = "{C:attention}8{}s are considered {C:attention}face cards{}",
                [2] = "Each {C:attention}face{} card held in hand",
                [3] = "gives {C:mult}+1{} mult"
            }
        },
        pos = {
            x = 3,
            y = 5
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        calculate = function(self,card,context)
            if context.individual and context.cardarea == G.hand and not context.end_of_round then
                if context.other_card:is_face() and not context.other_card.debuff then
                    return {
                        h_mult = 1,
                        card = card
                    }
                elseif context.other_card:is_face() then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end
    }
end 