function Balatrostuck.INIT.Jokers.j_joker()
    SMODS.Joker{
        name = "Joker",
        key = "joker",
        config = {
            extra = {
                booster_repeat = 5,
                charity_money = 20
            }
        },
        loc_txt = {
            ['name'] = 'Joker',
            ['text'] = {
                [1] = '{C:mult}+4{} Mult',
            },
            unlock = {'Unlocked by',
            'finishing Act 6'}
        },
        pos = {
            x = 6,
            y = 4
        },
        cost = 2,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {key='warn_bstuck_wip', set='Other'}
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        soul_pos = {
            x = 5,
            y = 4
        },
        in_pool = function(self)
            return Balatrostuck.peanut_gallery
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_collide' then
                unlock_card(self)
            end
        end,
        add_to_deck = function(self, card)
            card:add_dialogue("john_bought", "bm")
            card:remove_dialogue(3)
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {mult = 4}
            end

            if not context.blueprint then
                if context.starting_shop or context.reroll_shop then
                    local activated = false
                    if G.shop_jokers.cards[1].config.center.set == 'Joker' and G.shop_jokers.cards[2].config.center.set == 'Joker' and G.shop_jokers.cards[1].config.center.rarity and G.shop_jokers.cards[1].config.center.rarity == 1 and 
                    G.shop_jokers.cards[2].config.center.rarity and G.shop_jokers.cards[2].config.center.rarity == 1 and
                        (not card.ability.UNCOMMON_ANTE) or card.ability.UNCOMMON_ANTE and (G.GAME.round_resets.ante >= card.ability.UNCOMMON_ANTE) then
                        card:add_dialogue("john_common", "bm")
                        card:remove_dialogue(7)
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        add_tag(Tag('tag_uncommon'))
                        card.ability.UNCOMMON_ANTE = G.GAME.round_resets.ante + 2
                    end

                    for k, v in pairs(G.shop_jokers.cards) do
                        if v.cost == G.GAME.dollars + 1 then
                            if not activated then
                                card:add_dialogue("john_cost", "bm")
                                card:remove_dialogue(7)

                                G.E_MANAGER:add_event(Event({trigger = "after", delay = 2, func = function()
                                v.cost = G.GAME.dollars
                                v:juice_up()
                                play_sound("coin1")
                                return true end}))
                                
                                G.E_MANAGER:add_event(Event({trigger = "after", delay = 2, func = function()
                                return true end}))
                            end
                            activated = true
                        end
                    end

                elseif context.cardarea == G.play and context.repetition then
                    if pseudorandom('john') < 1 / 8 then
                        return {
                            message = localize('k_again_ex'),
                            repetitions = 1,
                            card = card
                        }
                    end

                elseif context.store_joker_create then
                    if (not G.GAME.TIMETRAVEL_TIMER) and pseudorandom('john') < 1 / 10 then
                        G.GAME.TIMETRAVEL_TIMER = G.GAME.round_resets.ante + 3
                        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 1,
                        func = function()
                            _card = create_card('Joker', G.shop_jokers, nil, 1, nil, nil, nil, 'rta')
                            G.GAME.TIMETRAVEL_KEY = _card.config.center.key
                            create_shop_card_ui(_card, 'Joker', G.shop_jokers)
                            G.shop_jokers:emplace(_card)
                            _card.states.visible = false
                            _card:start_materialize({G.C.BLUE, G.C.WHITE}, nil, 1.6)
                            _card:set_cost()      
                            john_2 = SMODS.create_card({key = "j_bstuck_joker"}) 
                            john_2.states.visible = false
                            G.shop_jokers:emplace(john_2)
                            john_2:start_materialize({G.C.BLUE, G.C.WHITE}, nil, 1.3)
                            john_2:add_dialogue("john_future", "tm")
                            john_2.no_ui = true
                            john_2.states.drag.can = false
                            john_2.states.hover.can = false
                            john_2.states.collide.can = false
                            return true
                        end}))

                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 7, blocking = false,
                        func = function()
                            john_2:start_dissolve({G.C.BLUE, G.C.WHITE}, nil, 1.3)
                            return true
                    end}))

                    end

                elseif context.skipping_booster and not context.open_booster then
                    if pseudorandom('john') < 1 / card.ability.extra.booster_repeat then
                        card.ability.extra.booster_repeat = card.ability.extra.booster_repeat + 1
                        local thunk = pseudorandom_element({1,2,3}, pseudoseed('john'))
                        card:add_dialogue("john_pack_"..thunk, "bm")
                        card:remove_dialogue(3)
                        G.E_MANAGER:add_event(Event({
                        func = (function()
                            add_tag(Tag(pseudorandom_element({'tag_buffoon','tag_charm','tag_meteor','tag_standard','tag_ethereal','t_bstuck_matriorb','t_bstuck_spirograph'}, pseudoseed('john'))))
                            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                            return true
                        end)
                        }))
                    end

                elseif context.game_over and to_big(G.GAME.chips) / to_big(G.GAME.blind.chips) > to_big(0.25) and not card.ability.REVIVE_ACTIVATED then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')  
                        return true
                    end
                })) 
                card.ability.REVIVE_ACTIVATED = true
                card:add_dialogue("john_revive", "bm")
                card:remove_dialogue(7)
                return {
                    message = localize('k_saved_ex'),
                    saved = true,
                    colour = G.C.RED
                }

                elseif context.end_of_round and not context.individual and not context.repetition then
                    if G.GAME.blind.boss then

                    end
                    if (G.GAME.dollar_buffer and (G.GAME.dollars + G.GAME.dollar_buffer) or G.GAME.dollars) <= 0 and card.ability.extra.charity_money == 20 then
                        ease_dollars(card.ability.extra.charity_money)
                        card:add_dialogue("john_charity","bm")
                        card:remove_dialogue(4)
                        card.ability.extra.charity_money = 0
                    end

                    card.ability.extra.booster_repeat = 5
                end
            end
        end
    }
end