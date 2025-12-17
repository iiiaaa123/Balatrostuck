function Balatrostuck.INIT.Jokers.j_wake()
    SMODS.Joker{
        name = "Wake",
        key = "wake",
        config = {
            extra = {
                xmult_mod = 0.2,
                hands = 1
            }
        },
        loc_txt = {
            ['name'] = 'Wake',
            ['text'] = {
                'Gives {C:white,X:mult}X#1#{} Mult',
                'for each remaining',
                '{C:attention}hand{}, discarded',
                '{C:attention}Jacks{} give {C:blue}+1{} hands',
                '{C:inactive}(Currently {C:white,X:mult}X#2# {C:inactive} Mult)'

                -- 'Discarded Jacks',
                -- 'give {C:blue}+2{} hands,',
                -- 'this Joker gives',
                -- '{C:white,X:mult}X0.2{} Mult for each',
                -- 'hand remaining',
                -- '{C:inactive}(Currently {C:white,X:mult}X0 {C:inactive} Mult)'
                -- [1] = "Played Jacks give +1 hand when scored and are destroyed",
                -- [2] = "If this card is sold during a blind create paradox copies of jacks destroyed by it"
            },
            unlock = {'Unlocked by',
                    'finishing Act 4'}
            
        },
        loc_vars = function (self, info_queue, card) 
            art_credit('akai', info_queue)
            return {
                vars = {
                    card.ability.extra.xmult_mod,
                    1 + (card.ability.extra.xmult_mod * G.GAME.current_round.hands_left),
                    card.ability.extra.hands

                }
            }
        end,
        pos = {
            x = 8,
            y = 10
         },
        cost = 9,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                    xmult = 1 + (card.ability.extra.xmult_mod * G.GAME.current_round.hands_left),
                    card = card
                }
            end

            if context.discard and context.other_card:get_id() == 11 then
                ease_hands_played(card.ability.extra.hands)
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_hands', vars = {card.ability.extra.hands}}})
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_descend' then
                unlock_card(self)
            end
        end
    }
end 