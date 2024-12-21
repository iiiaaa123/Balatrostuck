function Balatrostuck.INIT.Jokers.j_fluoriteoctet() 

    local locs = {
        mult     = 'give +8 Mult per scoring card',
        xmult    = 'give X2 Mult',
        seal     = 'add seal to a scoring card',
        dollars  = 'give $8',
        tarot    = 'create a Tarot card',
        spectral = 'create a Spectral card',
        chips    = 'give +800 Chips'
    }

    SMODS.Joker{
        name = "Fluorite Octet",
        key = "fluoriteoctet",
        config = {
            extra = {
                descs = get_table_values(locs),
                probs = get_table_keys(locs)
            }
        },
        loc_txt = {
            ['name'] = 'Fluorite Octet',
            ['text'] = {
                [1] = '{C:green}#1# in 64{} chance for {C:white,X:mult}X64{} Mult',
                [2] = '{C:inactive}otherwise'
            }
        },
        pos = {
            x = 5,
            y = 1
            },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            return {
                vars = {G.GAME.probabilities.normal},
                main_end = {
                    {
                        n = G.UIT.O,
                        config = {
                            object = DynaText(
                                {
                                    string = card.ability.extra.descs,
                                    colours = {G.C.VRISKA},
                                    pop_in_rate = 9999999,
                                    silent = true,
                                    random_element = false,
                                    pop_delay = 0.166,
                                    scale = 0.32,
                                    min_cycle_time = 0
                                }
                            )
                        }
                    }
                }
            }            
        end,
        calculate = function(self, card, context)
            if context.joker_main and context.cardarea == G.jokers then
                if pseudoseed("yeah!!!!!!!!") < G.GAME.probabilities.normal / 64 then
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { 64 } },
                        Xmult_mod = 64
                    }
                else
                    local payout = pseudorandom_element(card.ability.extra.probs, pseudoseed("yeah!!!!!!!!"))
                    if payout == 'mult' then
                        local mult = #context.scoring_hand * 8
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { mult }},
                            mult_mod = mult
                        }

                    elseif payout == 'xmult' then
                        return {
                            message = localize { type = 'variable', key = 'a_xmult', vars = { 2 } },
                            Xmult_mod = 2
                        }

                    elseif payout == 'chips' then
                        return { 
                            message = localize { type = 'variable', key = 'a_chips', vars = { 800 } },
                            chip_mod = 800
                        }

                    elseif payout == 'tarot' then
                        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.0,
                                func = (function()
                                        local card_vris = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'octet')
                                        card_vris:add_to_deck()
                                        G.consumeables:emplace(card_vris)
                                        G.GAME.consumeable_buffer = 0
                                    return true
                                end)}))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.SECONDARY_SET.Tarot})
                        end

                    elseif payout == 'seal' then
                        local _cards = {}
                        for i=1, #context.scoring_hand do
                            if not context.scoring_hand[i].seal then
                                _cards[#_cards+1] = context.scoring_hand[i]
                            end
                        end
                        if _cards[1] then
                            local _card = pseudorandom_element(_cards, pseudoseed("yeah!!!!!!!!"))
                            local seal_type = SMODS.poll_seal({guaranteed = true})
                            _card:set_seal(seal_type, true)
                            _card:juice_up(0.5,0.5)
                            
                        end

                    elseif payout == 'spectral' then
                        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.0,
                                func = (function()
                                        local card_vris = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'octet')
                                        card_vris:add_to_deck()
                                        G.consumeables:emplace(card_vris)
                                        G.GAME.consumeable_buffer = 0
                                    return true
                                end)}))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                        end
                        
                    elseif payout == 'dollars' then
                        ease_dollars(8)
                        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 8
                        G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                        return {
                            message = localize('$') .. 8,
                            dollars = 8,
                            colour = G.C.MONEY
                        }
                    end
                end
            end
        end
    }
end