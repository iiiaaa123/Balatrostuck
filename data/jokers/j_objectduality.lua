function Balatrostuck.INIT.Jokers.j_objectduality()
    SMODS.Joker{
        name = "Object Duality",
        key = "objectduality",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Object Duality',
            ['text'] = {
                [1] = "If first played {C:attention}poker hand{} of",
                [2] = "round is a {C:attention}High Card{}, create",
                [3] = "a {C:paradox}Paradox{} {E:2,C:dark_edition}innocuous double",
                [4] = "of each scoring card"
            },
            unlock = {'Unlocked by',
            'finishing Act 6'},
            check_for_unlock = function(self,args)
                if args.type == 'bstuck_collide' then
                    unlock_card(self)
                end
            end
        },
        pos = {
            x = 0,
            y = 12
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        calculate = function(self,card,context)
            if context.first_hand_drawn then
                local eval = function() return G.GAME.current_round.hands_played == 0 end
                juice_card_until(card, eval, true)
            end
            
            if context.before and context.scoring_name == 'High Card' and G.GAME.current_round.hands_played == 0 then
                for i=1, #context.scoring_hand do
            
                    local othercard = context.scoring_hand[i]
                
                
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('timpani')
                            othercard:juice_up(0.5, 0.5)
                            bstuck_add_paradox_card({set = 'Joker', key = get_innocuous(othercard,false)})
                            return true
                        end
                    }))
                    delay(0.4)
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_collide' then
                unlock_card(self)
            end
        end
    }
end 