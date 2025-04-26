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

        in_pool = function(self)
            return (G.GAME.round_resets.ante > 3) and not G.GAME.BALATROSTUCK.scratched
        end,

        loc_vars = function(self, info_queue, card)
            -- PUT RELEVENT LOC VARS HERE WHEN YOU GET TO REWORDING THIS!!!!!!! - Delirium
            return {true}
        end,
        
        apply = function(self, tag, context)
            G.GAME.BALATROSTUCK.scratchcolors = {G.C.RED, G.C.VRISKA, G.C.BLIND['Small']}
            G.GAME.BALATROSTUCK.scratched = G.GAME.BALATROSTUCK.scratched and (G.GAME.BALATROSTUCK.scratched + 1) or 1
            if G.GAME.BALATROSTUCK.scratched > #G.GAME.BALATROSTUCK.scratchcolors then G.GAME.BALATROSTUCK.scratched = 1 end
            play_sound('bstuck_HomestuckScratch')
            ease_background_colour_blind(G.GAME.BALATROSTUCK.scratchcolors[G.GAME.BALATROSTUCK.scratched])
            tag:yep("+",G.C.Green,
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

                if not next(SMODS.find_card("j_bstuck_echidna")) then
                for j=1, #G.jokers.cards do 
                    local rarity = G.jokers.cards[j].config.center.rarity
                    local legendary = nil
                    if rarity == 1 then
                      rarity = 0
                    elseif rarity == 2 then
                      rarity = 0.9
                    elseif rarity == 3 then
                      rarity = 0.99
                    elseif rarity == 4 then
                      rarity = nil
                      legendary = true
                    end
                    G.jokers.cards[j]:start_dissolve(nil, true)
                    G.E_MANAGER:add_event(Event({
                      trigger = "after",
                      delay = 0.4,
                      func = function()
                        local card = create_card("Joker", G.jokers, legendary, rarity, true, nil, nil, "IstoleThisCodeFromCryptid")
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        return true
                      end,
                    }))
                end
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