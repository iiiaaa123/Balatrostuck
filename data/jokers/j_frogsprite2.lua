function Balatrostuck.INIT.Jokers.j_frogsprite2()
    SMODS.Joker{
        name = "fr0gsprite2",
        key = "frogsprite2",
        config = {
            extra = { 
                depth = 1,
                procced = false
            }
        },
        loc_txt = {
            ['name'] = 'fr0gsprite2',
            ['text'] = {
                [1] = "If first hand of the round ",
                [2] = "has only 1 card,",
                [3] = "transform it into a {C:paradox}Paradox Ace{} before scoring",
                [4] = "and put it into the bottom of your deck"
            }
        },
        pos = {
            x = 9,
            y = 12
        },

        
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.first_hand_drawn then
                if not context.blueprint then
                    local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
                    juice_card_until(card, eval, true)
                end
            end
            if context.before and #context.full_hand == 1 and G.GAME.current_round.hands_played == 0 then
                context.other_card = context.full_hand[1]
                card.ability.extra.procced = true
                G.E_MANAGER:add_event(Event({func = function()
                    play_sound('tarot1')
                    context.other_card:juice_up(0.3,0.4)
                    return true end }))

                local _card_base = string.sub(context.other_card.base.suit, 1, 1)..'_A'
                context.other_card:set_base(G.P_CARDS[_card_base])
                context.other_card:set_edition('e_bstuck_paradox',true,true)
                delay(0.1)
                

                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,
                    func = function() 
                    playing_card_joker_effects({context.other_card})
                    card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = "ribbit", colour = G.C.PARADOX})
                    
                    return true
                end}))

            end
        end,
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {self.config.extra.depth}}
        end,
    }
end 