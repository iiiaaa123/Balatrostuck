--TODO: fix nil mult in tooltip 
function Balatrostuck.INIT.Jokers.j_conditionalimmortality()
    SMODS.Joker{
        name = "Conditional Immortality",
        key = "conditionalimmortality",
        config = {
            extra = {
                mult_mod = 3,
                mult = 0
            }
        },
        loc_txt = {
            ['name'] = 'Conditional Immortality',
            ['text'] = {
                [1] = "This Joker gains {C:mult}+#1#{} Mult",
                [2] = "for every {C:attention}Jimbo{} sold,",
                [3] = "Jimbo appears {C:attention}10X{} more",
                [4] = "frequently in the shop",
                [5] = "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
            },
            unlock = {'Unlocked by',
            'finishing Act 6'}
        },
        pos = {
            x = 1,
            y = 1
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.BSTUCK_joker_destroyed then
                if context.other_card.config.center.key == 'j_joker' then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}})
                elseif context.other_card.config.center.key == 'j_bstuck_joker' then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}})
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            delay(0.5)
                            ease_background_colour{new_colour = HEX('FFAD56')}
                            play_sound('bstuck_HomestuckHeroicDeath', 1, 1)
                            attention_text({
                                scale = 2, text = 'HEROIC', hold = 4, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                            })
                            delay(5)
                            return true
                        end,
                        blocking = false,
                        blockable = false
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 5, 
                        func = function() 
                            ease_background_colour_blind(G.STATE)
                            return true
                        end,
                        blocking = false,
                        blockable = false
                    }))
                -- shhhhhhhhhhhhhhhhhhh
                elseif context.other_card.config.center.key == 'j_bstuck_jocker' then
                    card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_mod
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}})
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            delay(0.5)
                            ease_background_colour{new_colour = HEX('B544FF')}
                            play_sound('bstuck_HomestuckJustDeath', 1, 5)
                            attention_text({
                                scale = 2, text = 'JUST', hold = 4, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                            })
                            delay(5)
                            return true
                        end,
                        blocking = false,
                        blockable = false
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 5, 
                        func = function() 
                            ease_background_colour_blind(G.STATE)
                            return true
                        end,
                        blocking = false,
                        blockable = false
                    }))
                end
            end
            
            if context.store_joker_replace then
                if context.shop_card and context.shop_card.config.center.set == 'Joker' and pseudorandom('cond') < 1/2 then
                    --sendInfoMessage(context.shop_card.config.center.key)
                    
                    context.shop_card.config.center = G.P_CENTERS['j_joker']
                    context.shop_card:set_ability(G.P_CENTERS['j_joker'])
                    context.shop_card:set_sprites(G.P_CENTERS['j_joker'])
                    context.shop_card:set_cost()
                end
            end

            if context.joker_main then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end,
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            info_queue[#info_queue+1] = G.P_CENTERS['j_joker'] or nil
            return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult}}
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_collide' then
                unlock_card(self)
            end
        end
    }
end 
