function Balatrostuck.INIT.Jokers.j_whatpumpkin()
    SMODS.Joker{
        name = "What Pumpkin",
        key = "whatpumpkin",
        config = {
            extra = {
                odds = 3,
                remaining = 20
            }
        },
        loc_txt = {
            ['name'] = 'What Pumpkin?',
            ['text'] = {
                [1] = 'Played cards have a',
                [2] = '{C:green}#1# in #2#{} chance to create a',
                [3] = '{C:green}paradox copy{} of itself when scored',
                [4] = '{C:inactive}({C:attention}#3#{C:inactive} copies remaining)'
            }
        },
        pos = {
            x = 1,
            y = 4
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.remaining}}
        end,
    
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.individual and card.ability.extra.remaining > 0 then
                if pseudorandom('what?') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(context.other_card, nil, nil, G.playing_card, true)
                        _card:set_edition("e_bstuck_paradox", false)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.hand:emplace(_card)
                        _card.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card:start_materialize()
                                return true
                            end
                        })) 
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Appear-ify!",colour = G.C.GREEN})
                    if not context.blueprint then
                        card.ability.extra.remaining = card.ability.extra.remaining - 1
                        if card.ability.extra.remaining <= 0 then
                            delay(0.3)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound('tarot1')
                                    card.T.r = -0.2
                                    card:juice_up(0.3, 0.4)
                                    card.states.drag.is = true
                                    card.children.center.pinch.x = true
                                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                        func = function()
                                                G.jokers:remove_card(self)
                                                card:remove()
                                                card = nil
                                            return true; end})) 
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint or card, 'extra', nil, nil, nil, {message = "-ify!",colour = G.C.GREEN})
                        end
                    end
                end
            end
        end
    }
end