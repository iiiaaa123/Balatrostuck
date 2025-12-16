
function Balatrostuck.INIT.Tags.t_denizen()
    SMODS.Tag{
        key = "denizen",
        config = {type = "new_blind_choice"},
        loc_txt = {
            ['name'] = 'Denizen Tag',
            ['text'] = {
                [1] = 'Create a negative',
                [2] = 'eternal rare joker'            
            }
        },
        pos = {
            x = 1,
            y = 1
        },
        atlas = 'HomestuckTags',
        
        in_pool = function(self)
            return (G.GAME.round_resets.ante > 1)
        end,

        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)

            return {true}
        end,
        apply = function(self, tag, context)
            if context.type == self.config.type then
                local lock = tag.ID
                local _times = tag.ability.extra.stack_count
                for i=1,_times or 1 do
                    tag:yep("+",G.C.Red, 
                    function()

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local _card = SMODS.add_card({set = 'Joker', rarity = 3,edition = 'e_negative'})
                                _card:start_materialize()
                                _card:set_eternal(true)
                                return true
                        end}))
                        

                    return true
                    end)
                    tag.ability.extra.stack_count = tag.ability.extra.stack_count -1
                end
                tag.triggered = true 
                tag.ability.extra.stack_count = 0
            end
            
        end,
    }
end