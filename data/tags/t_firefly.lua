
function Balatrostuck.INIT.Tags.t_firefly()
    SMODS.Tag{
        key = "firefly",
        config = {type = "new_blind_choice"},
        loc_txt = {
            ['name'] = 'Firefly Tag',
            ['text'] = {
                [1] = 'Shuffle {C:attention}7 {C:paradox}Paradox {C:attention}Gold',
                [2] = 'cards into your deck'            
            }
        },
        pos = {
            x = 3,
            y = 2
        },
        atlas = 'HomestuckTags',
        
        

        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['p_bstuck_aspect_booster']
            art_credit('akai', info_queue)

            return {true}
        end,
        apply = function(self, tag, context)
                local lock = tag.ID
                if context.type == self.config.type then
                    tag:yep("Ify!",G.C.Green, 
                    function()
                        for i=1, 7 do
                            G.E_MANAGER:add_event(Event{
                                delay = 0.25, trigger = 'after', func = function()
                                local front = pseudorandom_element(G.P_CARDS, pseudoseed('cert_fr'))
                                local _card = create_playing_card({
                                        front = front, 
                                        center = G.P_CENTERS.m_gold}, nil, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                                    _card:set_edition('e_bstuck_paradox',true,true)
                                    G.deck:emplace(_card,pseudorandom('LOWAS',1,#G.deck.cards))
                            return true
                            end
                            })
                            
                        end

                    end)
                    tag.triggered = true
                end
        end,
    }
end