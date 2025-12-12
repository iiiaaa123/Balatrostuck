
function Balatrostuck.INIT.Tags.t_mutation()
    SMODS.Tag{
        key = "mutation",
        config = {type = "new_blind_choice"},
        loc_txt = {
            ['name'] = 'Mutation Tag',
            ['text'] = {
                [1] = 'For each joker',
                [2] = 'Create a paradox clone'            
            }
        },
        pos = {
            x = 2,
            y = 1
        },
        atlas = 'HomestuckTags',
        
        in_pool = function(self)
            return (G.GAME.round_resets.ante > 1)
        end,

        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['p_bstuck_aspect_booster']
            art_credit('penny', info_queue)

            return {true}
        end,
         apply = function(self, tag, context) -- DO NOT LET THIS SHIP WITHOUT A FAILSAFE FOR DOOMQUARIUS
                local lock = tag.ID
                tag:yep("MEOW!",G.C.Green, 
                function()

                     for j = 1, #G.jokers.cards do 
                    if G.jokers.cards[j] ~= card then
                        G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = function()
                            local _card = copy_card(G.jokers.cards[j], nil, nil, nil)
                            _card:start_materialize()
                            _card:set_edition('e_bstuck_paradox')
                            _card:add_to_deck()
                            G.jokers:emplace(_card)
                            G.GAME.joker_buffer = 0
                            play_sound('bstuck_HomestuckMeow', 1 + math.random()*0.5, 0.4)
                        return true
                        end
                    }))
                    end
                end
                    

                return true
                end)
                tag.triggered = true
        end,
    }
end