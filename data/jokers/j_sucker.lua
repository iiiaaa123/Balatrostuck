function Balatrostuck.INIT.Jokers.j_sucker()
    SMODS.Joker{

        name = "Sucker",
        key = "sucker",
        config = {
            extra = {
                base = 6,
                decrement = 1
            }
        },
        loc_txt = {
            ['name'] = 'Sucker',
            ['text'] = {
                '{C:green}#1# in #2#{} chance', 
                'for {}{C:white,X:mult}X#2#{} Mult,',
                'decreases by {C:suckers,E:2}1{}',
                'every round'
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 3,
            y = 4
        },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {G.GAME.probabilities.normal, card.ability.extra.base }}
        end,

        calculate = function(self, card, context)

            if context.joker_main and context.cardarea == G.jokers then
                if pseudorandom('suckers') < G.GAME.probabilities.normal / card.ability.extra.base then
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.base } },
                        Xmult_mod = card.ability.extra.base
                    }
                end

            elseif context.end_of_round and not context.individual and not context.blueprint and not context.repetition then
                if card.ability.extra.base - card.ability.extra.decrement <= 1 then 

                    card.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:start_dissolve({G.C.RED}, nil, 1.6)
                            return true;
                        end
                    }))

                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1

                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = function()
                        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sucker', 'suc')
                        card:set_edition(nil, nil, true)
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:start_materialize()
                        G.GAME.joker_buffer = 0
                        return true
                        end
                    }))

                    return {
                        message = localize('k_eaten_ex'),
                        colour = G.C.FILTER
                    }
                else
                    card.ability.extra.base = card.ability.extra.base - card.ability.extra.decrement
                    G.E_MANAGER:add_event(Event({
                        delay = 0.2,
                        message = '-'..card.ability.extra.decrement,
                        colour = G.C.GREEN,
                    }))
                    return {
                        trigger = 'after',
                        delay = 0.2,
                        message = localize{type='variable',key='a_xmult_minus',vars={card.ability.extra.decrement}},
                        colour = G.C.RED
                    }
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end