function Balatrostuck.INIT.Jokers.j_yaldabaoth()
    SMODS.Joker{
        name = "Yaldabaoth",
        key = "yaldabaoth",
        config = {
            extra = {
                xmult = 1,
                xmult_mod = 0.5
            }
        },
        loc_txt = {
            ['name'] = 'Yaldabaoth',
            ['text'] = {
                [1] = 'Gains {C:white,X:mult}X#1#{} Mult per',
                [2] = 'unused {C:red}discard{} at',
                [3] = 'the end of round',
                [4] = '{C:inactive}Resets on discard',
                [5] = '{C:inactive}(Currently: {C:white,X:mult}X#2#{} {C:inactive}Mult)'
            }
        },
        pos = {
            x = 0,
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
            x = 5,
            y = 9
        },
    
        loc_vars = function(self, info_queue, card)
            return { vars = {card.ability.extra.xmult_mod, card.ability.extra.xmult}}
        end,

        calculate = function(self, card, context)
            if context.cardarea == G.jokers and not (context.repetition or context.individual or context.after or context.before) then
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }

            elseif context.end_of_round and not (context.repetition or context.individual or context.blueprint) then
                local xmod = card.ability.extra.xmult_mod
                local discards_left = G.GAME.current_round.discards_left
                card.ability.extra.xmult = card.ability.extra.xmult + (discards_left * xmod)
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    colour = G.C.FILTER
                }

            elseif context.pre_discard and not (context.repetition or context.individual or context.blueprint) and card.ability.extra.xmult > 1 then
                card.ability.extra.xmult = 1
                card_eval_status_text( card, 'extra', nil, nil, nil, {message = localize('k_reset'), colour = G.C.FILTER})
            end
        end
    }
end