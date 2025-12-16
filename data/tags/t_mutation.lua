
function Balatrostuck.INIT.Tags.t_mutation()
    SMODS.Tag{
        key = "mutation",
        config = {type = "immediate", extra = {round_triggered = -1}},
        loc_txt = {
            ['name'] = 'Mutation Tag',
            ['text'] = {
                        'For each joker',
                        'create a paradox clone',
                        '{C:inactive}only triggers once a round'
                
            }
        },
        pos = {
            x = 2,
            y = 1
        },
        
        in_pool = function(self)
            return (G.GAME.round_resets.ante > 1)
        end,

        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            art_credit('penny', info_queue)

            return {true}
        end,
         apply = function(self, tag, context) -- failsafe for doomquarius added o7
            if context.type == self.config.type and G.GAME.round ~= tag.ability.extra.round_triggered then
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
                tag.ability.extra.round_triggered = G.GAME.round

                end)
                tag.triggered = true
            end
        end,
    }
end