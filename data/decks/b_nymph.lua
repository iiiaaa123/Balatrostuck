function Balatrostuck.INIT.Decks.b_nymph()
    SMODS.Back {
        key = 'nymph',
        loc_txt = {
            name = "Nymph Deck",
            text = {
                'THE effect',
            }
        },
        atlas = 'HomestuckDecks',
        pos = {x = 0,y = 1},
        unlocked = true,
        calculate = function(self,back,context)
            if context.skip_blind then
                        if (true) then
                            if G.round_eval then 
                                G.round_eval:remove()
                                G.round_eval = nil
                            end
                            if G.blind_select then
                                G.blind_select:remove()
                                G.blind_prompt_box:remove()
                                G.blind_select = nil
                            end
                            G.GAME.current_round.discards_left = math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards)
                            G.GAME.current_round.hands_left = (math.max(1, G.GAME.round_resets.hands + G.GAME.round_bonus.next_hands))
                            G.GAME.current_round.hands_played = 0
                            G.GAME.current_round.discards_used = 0
                            G.GAME.current_round.any_hand_drawn = nil
                            G.GAME.current_round.reroll_cost_increase = 0
                            G.GAME.current_round.used_packs = {}

                            for k, v in pairs(G.GAME.hands) do 
                                v.played_this_round = 0
                            end

                            for k, v in pairs(G.playing_cards) do
                                v.ability.wheel_flipped = nil
                            end

                            G.GAME.current_round.free_rerolls = G.GAME.round_resets.free_rerolls
                            calculate_reroll_cost(true)

                            G.GAME.round_bonus.next_hands = 0
                            G.GAME.round_bonus.discards = 0
                            G.GAME.current_round.jokers_purchased = 0
                            G.GAME.current_round.discards_left = math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards)
                            G.GAME.current_round.hands_left = (math.max(1, G.GAME.round_resets.hands + G.GAME.round_bonus.next_hands))
                            G.STATE = G.STATES.SHOP
                            G.GAME.shop_free = nil
                            G.GAME.shop_d6ed = nil
                            G.STATE_COMPLETE = false
                            G:update_shop()
                            if G.STAGE == G.STAGES.RUN then  ease_round(1) end
                        end
                        
                    end
            end
    }
end
