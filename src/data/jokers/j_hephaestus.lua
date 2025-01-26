function Balatrostuck.INIT.Jokers.j_hephaestus()
    SMODS.Joker{
        name = "Hephaestus",
        key = "hephaestus",
        config = {
            extra = 2
        },
        loc_txt = {
            ['name'] = 'Hephaestus',
            ['text'] = {
                [1] = 'Retrigger held {C:attention}Steel{}',
                [2] = 'cards {C:attention}2{} additional times,',
                [3] = 'played {C:attention}Steel{} cards give',
                [4] = '{X:mult,C:white}X2{} Mult when scored' 
            }
        },
        pos = {
            x = 2,
            y = 9
        },
        cost = 20,
        rarity = 4,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        soul_pos = {
            x = 7,
            y = 9
        },
    
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = G.P_CENTERS.m_steel
            return {vars = {card.ability.extra}}
        end,

        calculate = function(self, card, context)
            if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
                if context.other_card.ability.name == 'Steel Card' then
                    if context.other_card.debuff then
                        return {
                            message = localize('k_debuffed'),
                            colour = G.C.RED,
                            card = card,
                        }
                    else
                        return {
                            x_mult = card.ability.extra,
                            card = card
                        }
                    end
                end
            end
        end
    }
end