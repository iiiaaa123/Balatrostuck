function Balatrostuck.INIT.Jokers.j_balletslippers()
    SMODS.Joker{
        name = "Ballet Slippers",
        key = "balletslippers",
        config = {
            extra = {
                to_do_poker_hand = {"High Card", "Pair", "Three of a Kind"},
                counter = 1, -- 1 : inactive | 2: high card played | 3: pair played
                mult_gain = 4,
                mult = 0
            }
        },
        loc_txt = {
            ['name'] = 'Ballet Slippers',
            ['text'] = {
                "This Joker gains {C:mult}+#1#{} Mult",
                'if next 3 {C:attention}poker hands{}',
                'are {C:attention}#2#{}, {C:attention}#3#{} and',
                '{C:attention}#4#{}',
                '{C:inactive}(Next {C:attention}#5#{C:inactive})',
                "{C:inactive}(Currently {C:mult}+#6#{C:inactive} Mult)"
            },
        unlock = {'Unlocked by',
                'finishing Act 1'}
        },
        pos = {
            x = 6, -- 6 for abated, 7 for active
            y = 10
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self,info_queue,card)
            art_credit('akai', info_queue)
            return {vars = {
                card.ability.extra.mult_gain, 
                card.ability.extra.to_do_poker_hand[1],
                card.ability.extra.to_do_poker_hand[2],
                card.ability.extra.to_do_poker_hand[3],
                card.ability.extra.to_do_poker_hand[card.ability.extra.counter],
                card.ability.extra.mult,
                colours = {
                    (card.ability.extra.counter == 0 and G.C.ATTENTION or G.C.INACTIVE),
                    (card.ability.extra.counter == 1 and G.C.ATTENTION or G.C.INACTIVE),
                    (card.ability.extra.counter == 2 and G.C.ATTENTION or G.C.INACTIVE),
                }
            }
            }
        end,

        calculate = function(self,card,context)
            if context.before then
                if context.scoring_name == card.ability.extra.to_do_poker_hand[card.ability.extra.counter] then
                    if card.ability.extra.counter == 3 then
                        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                        card.ability.extra.counter = 1
                        return {
                            card = card,
                            message = localize('k_upgrade_ex')
                        }
                    else
                        local thunk = card.ability.extra.counter
                        card.ability.extra.counter = card.ability.extra.counter + 1
                        return {
                            card = card,
                            message = thunk.."/3"
                        }
                    end
                elseif card.ability.extra.counter > 1 then
                    card.ability.extra.counter = 1
                    return {
                        card = card,
                        message = localize('k_reset')
                    }
                end
            end
                

            if context.joker_main and card.ability.extra.mult > 0 then
                return {
                  mult_mod = card.ability.extra.mult,
                  message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
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