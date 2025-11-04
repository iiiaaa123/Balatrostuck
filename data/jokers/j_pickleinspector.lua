function Balatrostuck.INIT.Jokers.j_pickleinspector()
    SMODS.Joker{
        name = "Pickle Inspector",
        key = "pickleinspector",
        config = {
            extra = {
                xmult_gain = 0.05,
                xmult = 1
            }
        },
        loc_txt = {
            ['name'] = 'Pickle Inspector',
            ['text'] = {
                [1] = "This Joker gains {X:red,C:white}X#1#{} Mult",
                [2] = "whenever {C:attention}a played or held card triggers,",
                [3] = "resets at end of round",
                [4] = "{C:inactive}(Currently {X:red,C:white}X#2#{C:inactive} Mult)"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 8,
            y = 0
         },
        cost = 5,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self,info_queue,card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.xmult_gain, card.ability.extra.xmult}}
        end,

        calculate = function(self,card,context)
            if context.individual and context.cardarea == G.play and not context.blueprint then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    card = card,
                    message = localize('k_upgrade_ex')
                }
            end

            if context.repetition and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
                if (next(context.card_effects[1]) or #context.card_effects > 1) then
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
                end
            end

            if context.end_of_round and context.main_eval and not context.blueprint then
                card.ability.extra.xmult = 1
                return {
                    card = card,
                    message = localize('k_reset')
                }
            end

            if context.joker_main and card.ability.extra.xmult > 1 then
                return {
                  Xmult_mod = card.ability.extra.xmult,
                  message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
                }
            end        
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 