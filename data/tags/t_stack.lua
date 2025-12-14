
function Balatrostuck.INIT.Tags.t_stack()
    SMODS.Tag{
        key = "stack",
        config = {type = "eval"},
        loc_txt = {
            ['name'] = 'Stack Tag',
            ['text'] = {
                "If you're seeing this",
                "something went really wrong"
            }
        },
        pos = {
            x = 1,
            y = 1
        },
        
        
        ability = {
            contained_tag = nil,
            stack_count = 0,
        },

        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)

            return {true}
        end,

        apply = function(self, tag, context)
                local lock = tag.ID
                print("Called stack tag, contents:")
                print(inspect(tag.ability.contained_tag))
                print("Context: "..inspect(context))
                tag:yep("Tags!",G.C.Green, 
                function()
                    if not tag.ability.contained_tag then return true end
                    if tag.ability.stack_count <= 0 then 
                        return true --exit early if we are empty
                    else
                        
                        tag.ability.contained_tag.is_in_stack = true
                        
                        local _ret = tag.ability.contained_tag:apply_to_run(context)
                        print("Contained tag return value: "..tostring(_ret))
                        if _ret then tag.ability.stack_count = tag.ability.stack_count - 1 end
                        local _done = (tag.ability.stack_count <= 0)
                        tag.triggered = _done
                        tag.ability.contained_tag.triggered = _done
                        if _done then 
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.7,
                                func = (function()
                                    tag:remove()
                                    G.CONTROLLER.locks[lock] = nil
                                    return true
                                    
                                end)
                            }))
                        end
                        G.CONTROLLER.locks[lock] = nil
                        return true
                    end 

                    
                end)
                
                
        end,
    }
end