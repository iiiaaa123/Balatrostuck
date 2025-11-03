function Balatrostuck.INIT.Jokers.j_pawnrevolution()
    SMODS.Joker{
        name = "Pawn Revolution",
        key = "pawnrevolution",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Pawn Revolution',
            ['text'] = {
                [1] = "On {C:attention}first hand{} of round,",
                [2] = "create a {C:paradox}Paradox{} copy of",
                [3] = "{C:attention}lowest{} ranked card held in hand"
            }
        },
        pos = {
            x = 4,
            y = 11
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function (self, info_queue, card) 
            art_credit('cejai', info_queue)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
        end,
        calculate = function(self,card,context)
            if context.setting_blind then
                local eval = function() return G.GAME.current_round.hands_played == 0 end
                juice_card_until(card, eval, true)
            end
            
            
            if context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_played == 0 then
                local temp_ID = 15
                local raised_card = nil
                for i=1, #G.hand.cards do
                    if temp_ID >= G.hand.cards[i].base.id and not SMODS.has_no_rank(G.hand.cards[i]) then 
                        temp_ID = G.hand.cards[i].base.id; 
                        raised_card = G.hand.cards[i] 
                    end
                end
                
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local _card = copy_card(raised_card, nil, nil, G.playing_card)
                _card:add_to_deck()
                _card:set_edition('e_bstuck_paradox')
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
                playing_card_joker_effects({_card})
            end
        end
    }
end 