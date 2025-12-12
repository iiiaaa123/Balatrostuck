
function Balatrostuck.INIT.Tags.t_carapacian()
    SMODS.Tag{
        key = "carapacian",
        config = {type = "new_blind_choice"},
        loc_txt = {
            ['name'] = 'Carapacian Tag',
            ['text'] = {
                [1] = 'Create two',
                [2] = 'random Tags'            
            }
        },
        pos = {
            x = 1,
            y = 1
        },
        atlas = 'HomestuckTags',
        

        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)

            return {true}
        end,

        apply = function(self, tag, context)
                local lock = tag.ID
                tag:yep("Tags!",G.C.Green, 
                function()
                    
                     G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        local tagkey = get_next_tag_key()
                        if tagkey == 'tag_bstuck_scratch' then tagkey = 'tag_handy' end --prevent this from spawning scratch tag
                        local tag = Tag(tagkey)
                        if tagkey == 'tag_bstuck_carapacian' then tagkey = 'tag_handy' end --prevent this from spawning itself
                        local tag = Tag(tagkey)
                        if tagkey == 'tag_orbital' then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then _poker_hands[#_poker_hands+1] = k end
                            end
                            
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed('orbital'))
                        end
                        play_sound('timpani')
                        add_tag(tag)
                        return true
                    end}))

                     G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        local tagkey = get_next_tag_key()
                        if tagkey == 'tag_bstuck_scratch' then tagkey = 'tag_handy' end --prevent this from spawning scratch tag
                        local tag = Tag(tagkey)
                        if tagkey == 'tag_bstuck_carapacian' then tagkey = 'tag_handy' end --prevent this from spawning itself
                        local tag = Tag(tagkey)
                        if tagkey == 'tag_orbital' then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then _poker_hands[#_poker_hands+1] = k end
                            end
                            
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed('orbital'))
                        end
                        play_sound('timpani')
                        add_tag(tag)
                        return true
                    end}))

                return true
                end)
                tag.triggered = true
        end,
    }
end