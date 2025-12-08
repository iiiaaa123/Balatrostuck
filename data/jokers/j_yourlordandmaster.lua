function Balatrostuck.INIT.Jokers.j_yourlordandmaster()
    SMODS.Joker {
        name = "YOUR LORD AND MASTER",
        key = "yourlordandmaster",
        config = {
            extra = {
                banned_hands = {"High Card", "Pair", "Three of a Kind"},
                cali_jokers = {
                    "j_bstuck_jokermode", "j_bstuck_crowbarsfelt",
                    "j_bstuck_magnificent"
                },
                high_hands = {"Flush", "Straight", "Full House"},
                banned_high_hand = "Flush",
                shop_timer = 1
            }
        },
        loc_txt = {
            ['name'] = 'YOUR LORD AND MASTER',
            ['text'] = {
                -- "{C:caliborn}YOU DO NOT NEED TO KNOW MY WAYS.",
                -- "{C:caliborn}MY PUTRID SOUL WILL MAKE A MOCKERY",
                -- "{C:caliborn}OF THIS GLORIFIED GAME OF SOLITAIRE."
            },
            unlock = {'Unlocked by', 'finishing Act 6'}
        },
        pos = {x = 0, y = 0},
        cost = 1,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        atlas = 'TheCalibornJoker',

        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {
                vars = {},
                main_end = {
                    BSUI.Modules.GameText.HomestuckLog({
                        'YOU DO NOT NEED TO KNOW MY WAYS.',
                        'MY PUTRID SOUL WILL MAKE A MOCKERY',
                        'OF THIS GLORIFIED GAME OF SOLITAIRE.'
                    }, G.C.CALIBORN)
                }
            }
        end,
        animated = true,
        frames = 250,
        dimensions = {x = 15, y = 15},
        animation_speed = 50,
        photosensitive = false,
        in_pool = function(self) return Balatrostuck.peanut_gallery end,
        check_for_unlock = function(self, args)
            if args.type == 'bstuck_collide' then unlock_card(self) end
        end,
        add_to_deck = function(self, card)
            G.E_MANAGER:add_event(Event({
                trigger = "immediate",
                func = function()
                    card:add_dialogue("caliborn_bought1", "bm")
                    card:remove_dialogue(2)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 2,
                func = function()
                    card:add_dialogue("caliborn_bought2", "bm")
                    card:remove_dialogue(4)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 4,
                func = function()
                    card:add_dialogue("caliborn_bought3", "bm")
                    card:remove_dialogue(2)
                    return true
                end
            }))
        end,
        remove_from_deck = function(self, card, from_debuff)
            if not from_debuff then
                for k, v in pairs(G.jokers.cards) do
                    local cali_jokers = {
                        "j_bstuck_jokermode", "j_bstuck_crowbarsfelt",
                        "j_bstuck_magnificent"
                    }
                    for penis, cock in pairs(cali_jokers) do
                        if (v.config.center.key == cock) then
                            v:start_dissolve()
                            play_sound('timpani', 0.6, 0.8)
                        end
                    end
                end
            end
        end,
        calculate = function(self, card, context)
            if context.setting_blind then
                card.ability.extra.banned_high_hand =
                    pseudorandom_element(card.ability.extra.high_hands,
                                         pseudoseed('Clown'))
                if card.ability.extra.banned_high_hand == "Flush" then
                    if pseudorandom('flush') < 1 / 2 then
                        card:add_dialogue("caliborn_flush2", "bm")
                        card:remove_dialogue(6)
                    else
                        card:add_dialogue("caliborn_flush1", "bm")
                        card:remove_dialogue(6)
                    end
                end
                if card.ability.extra.banned_high_hand == "Straight" then
                    if pseudorandom('straight') < 1 / 2 then
                        card:add_dialogue("caliborn_straight2", "bm")
                        card:remove_dialogue(6)
                    else
                        card:add_dialogue("caliborn_straight1", "bm")
                        card:remove_dialogue(6)
                    end
                end
                if card.ability.extra.banned_high_hand == "Full House" then
                    if pseudorandom('house') < 1 / 2 then
                        card:add_dialogue("caliborn_fullhouse2", "bm")
                        card:remove_dialogue(6)
                    else
                        card:add_dialogue("caliborn_fullhouse1", "bm")
                        card:remove_dialogue(6)
                    end
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local cards = {}
                        for i = 1, #G.playing_cards do
                            G.playing_cards[i]:start_dissolve(nil, true)
                        end
                        local suits = {"H", "D", "S", "C"}
                        local ranks = {
                            "T", "2", "3", "4", "5", "6", "7", "8", "9", "A",
                            "J", "Q", "K"
                        }
                        for k, v in pairs(suits) do
                            for k2, v2 in pairs(ranks) do
                                local index = k2 + #ranks * (k - 1)
                                cards[index] =
                                    create_playing_card({
                                        front = G.P_CARDS[v .. '_' .. v2],
                                        center = G.P_CENTERS.c_base
                                    }, G.deck, nil, nil, {G.C.RED})
                            end
                        end
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        return true
                    end
                }))
            end

            if context.debuff_hand then
                for i = 1, #card.ability.extra.banned_hands do
                    if context.scoring_name ==
                        card.ability.extra.banned_hands[i] then
                        return {
                            debuff_text = 'TRUE MASTERY OVER THE HAND IS NECESSARY TO BE A TRUE MAN',
                            debuff = true
                        }
                    end
                    if context.scoring_name ==
                        card.ability.extra.banned_high_hand then
                        return {
                            debuff_text = 'I SAID YOU DO NOT PLAY THAT THIS ROUND',
                            debuff = true
                        }
                    end
                end
            end

            if context.end_of_round and not context.individual and
                not context.repetition then
                card.ability.extra.shop_timer =
                    card.ability.extra.shop_timer - 1
            end

            if context.store_joker_replace and card.ability.extra.shop_timer ==
                0 and card.ability.extra.cali_jokers[1] and
                context.shop_card.config.center.set == 'Joker' then
                card.ability.extra.shop_timer = 3
                local cali_key = pseudorandom_element(card.ability.extra
                                                          .cali_jokers,
                                                      pseudoseed('Clown'))
                context.shop_card:set_ability(G.P_CENTERS[cali_key])
                for k, v in pairs(card.ability.extra.cali_jokers) do
                    if v == cali_key then
                        card.ability.extra.cali_jokers[k] = nil
                    end
                end
                context.shop_card.states.visible = false
                context.shop_card:start_materialize({G.C.GREEN, G.C.RED}, nil,
                                                    1.3)
                context.shop_card:juice_up()
                play_sound('timpani', 0.9, 0.8)
            end
        end

    }
end
