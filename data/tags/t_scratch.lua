--TODO: booster pack thang
function Balatrostuck.INIT.Tags.t_scratch()
    SMODS.Tag{
        key = "scratch",
        config = {type = "eval"},
        loc_txt = {
            ['name'] = 'Scratch Tag',
            ['text'] = {
                [1] = 'Restart current Ante,',
                [2] = 'convert all your {C:attention}Jokers{} ',
                [3] = 'into {C:attention}random Jokers{} with',
                [4] = 'the same rarity'            
            }
        },
        pos = {
            x = 2,
            y = 0
        },
        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            -- PUT RELEVENT LOC VARS HERE WHEN YOU GET TO REWORDING THIS!!!!!!! - Delirium
            return {true}
        end,
        apply = function(self, tag, context)
            tag:yep("Ify!",G.C.Green,
            function()

                
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        if G.blind_select then
                            G.blind_select:remove()
                            G.blind_prompt_box:remove()
                            G.blind_select = nil
                            delay(0.2)
                        end
                        return true
                    end
                }))
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.GAME.round_resets.blind_states.Small = 'Current'
                        G.GAME.round_resets.blind_states.Big = 'Upcoming'
                        G.GAME.round_resets.blind_states.Boss = 'Upcoming'
                        G.GAME.round_resets.blind_tags.Small = get_next_tag_key()
                        G.GAME.round_resets.blind_tags.Big = get_next_tag_key(nil,true)
                        return true
                    end
                }))         

                
                local dumb = {0,0.9,1,1}

                for j=1, #G.jokers.cards do 
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if type(card.config.center.rarity) ~= 'number' then
                                card.config.center.rarity = 3
                            end
                            local _pool, _pool_key = get_current_pool('Joker', dumb[card.config.center.rarity], nil, nil)
                            center = pseudorandom_element(_pool, pseudoseed(_pool_key))
                            local it = 1
                            while center == 'UNAVAILABLE' do
                                it = it + 1
                                center = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
                            end

                            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true end }))
                            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                                card:remove_from_deck()
                                card.config.center = G.P_CENTERS[center]
                                card:set_ability(card.config.center,true)
                                card:add_to_deck()
                                return true 
                            end}))
                            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() card:flip();play_sound('tarot2', percent);card:juice_up(0.3, 0.3);return true end }))
                            return true
                        end
                    }))
                end


                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'immediate',
                            func = function()
                                play_sound('cancel')
                                G.blind_select = UIBox {
                                    definition = create_UIBox_blind_select(),
                                    config = { align = "bmi", offset = { x = 0, y = G.ROOM.T.y + 29 }, major = G.hand, bond = 'Weak' }
                                }
                                G.blind_select.alignment.offset.y = 0.8 - (G.hand.T.y - G.jokers.T.y) +
                                    G.blind_select.T.h
                                G.ROOM.jiggle = G.ROOM.jiggle + 3
                                G.blind_select.alignment.offset.x = 0
                                G.CONTROLLER.lock_input = false
                                for i = 1, #G.GAME.tags do
                                    G.GAME.tags[i]:apply_to_run({ type = 'immediate' })
                                end
                                for i = 1, #G.GAME.tags do
                                    if G.GAME.tags[i]:apply_to_run({ type = 'new_blind_choice' }) then break end
                                end
                                return true
                            end
                        })); return true
                    end
                }))
                return true
            end)
            tag.triggered = true
        end
    }
end