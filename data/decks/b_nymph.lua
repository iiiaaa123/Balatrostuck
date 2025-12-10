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
                G.E_MANAGER:add_event(Event({
                      trigger = 'immediate',
                      func = function()
                        if G.round_eval then 
                            G.round_eval:remove()
                            G.round_eval = nil
                        end
                        if G.blind_select then
                            G.blind_select:remove()
                            G.blind_prompt_box:remove()
                            G.blind_select = nil
                        end
                        G.GAME.current_round.jokers_purchased = 0
                        G.GAME.current_round.discards_left = math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards)
                        G.GAME.current_round.hands_left = (math.max(1, G.GAME.round_resets.hands + G.GAME.round_bonus.next_hands))
                        G.STATE = G.STATES.SHOP
                        G.GAME.shop_free = nil
                        G.GAME.shop_d6ed = nil
                        G.STATE_COMPLETE = false
                        return true
                      end
        }))
            end
        end
    }
end
