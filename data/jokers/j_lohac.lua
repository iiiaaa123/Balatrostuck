-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_lohac()
    SMODS.Joker{
        name = "Heat and Clockwork",
        key = "lohac",
        config = {
            extra = {
                mult_gain = 1,
                mult_total = 1
            }
        },
        loc_txt = {
            ['name'] = 'Heat and Clockwork',
            ['text'] = {
                [1] = "Gain {C:blue}+2{} Hands when {C:attention}Blind{} is",
                [2] = "selected if previous round's",
                [3] = "score was {C:attention,E:2,S:1.1}set on fire"

            }
        },
        pos = {
            x = 1,
            y = 8
        },
        cost = 8,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_vars = function (self, info_queue, card)
            return {vars = {card.ability.extra.mult_gain, card.ability.extra.mult_total}}
        end,
        calculate = function (self, card, context)
            if context.end_of_round and not (context.individual or context.repetition) and G.GAME.current_round.hands_played == 1 then
                card.ability.extra.mult_total = card.ability.extra.mult_total + card.ability.extra.mult_gain
                return {
                    message = localize {
                        type = 'variable', 
                        key = 'a_xmult', 
                        vars = { card.ability.extra.mult_total }
                    },
                    colour = G.C.FILTER
                }
                
            elseif context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_played > 0 and card.ability.extra.mult_total > 1 then
                card.ability.extra.mult_total = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.FILTER
                }

            elseif context.joker_main and context.cardarea == G.jokers and card.ability.extra.mult_total > 1 then
                return {
                    message = localize{
                        type = 'variable', 
                        key = 'a_xmult', 
                        vars = { card.ability.extra.mult_total }
                    },
                    colour = G.C.FILTER,
                    Xmult_mod = card.ability.extra.mult_total
                }
            end
        end
    }
end 