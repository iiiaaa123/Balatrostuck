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
            x = 9,
            y = 6
         },
        cost = 5,
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
                
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(raised_card)
                        _card:start_materialize({G.C.PARADOX},firstmat)
                        local firstmat = true
                        _card:set_edition('e_bstuck_paradox',true,true)
                        G.hand:emplace(_card)
                        G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
                        -- G.deck.config.card_limit = G.deck.config.card_limit + 1
                        delay(0.1)
                        return true
                    end}))
                playing_card_joker_effects({_card})
            end
        end
    }
end 