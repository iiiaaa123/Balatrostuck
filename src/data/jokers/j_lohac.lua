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
                [1] = "Gains {C:white,X:mult}X#1#{} Mult per blind",
                [2] = "won in a {C:attention}single{} hand",
                [3] = "{C:inactive}resets on {C:attention}second{} {C:inactive}hand",
                [4] = "{C:inactive}(Currently: {C:white,X:mult}X#2#{} Mult{C:inactive})"

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
        calculate = function (self, context)
            if context.end_of_round and not (context.individual or context.repetition) and G.GAME.current_round.hands_played == 1 then
                self.ability.extra.mult_total = self.ability.extra.mult_total + self.ability.extra.mult_gain
                return {
                    message = localize {
                        type = 'variable', 
                        key = 'a_xmult', 
                        vars = { self.ability.extra.mult_total }
                    },
                    colour = G.C.FILTER
                }
                
            elseif context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_played > 1 and self.ability.extra.mult_total > 1 then
                self.ability.extra.mult_total = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.FILTER
                }

            elseif context.joker_main and context.cardarea == G.jokers then
                return {
                    message = localize{
                        type = 'variable', 
                        key = 'a_xmult', 
                        vars = { self.ability.extra.mult_total }
                    },
                    colour = G.C.FILTER,
                    Xmult_mod = self.ability.extra.mult_total
                }
            end
        end
    }
end 