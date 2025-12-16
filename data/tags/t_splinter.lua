
function Balatrostuck.INIT.Tags.t_splinter()
    SMODS.Tag{
        key = "splinter",
        config = {type = "new_blind_choice"},
        loc_txt = {
            ['name'] = 'Splinter Tag',
            ['text'] = {
                [1] = 'Gives a free',
                [2] = '{C:aspect}Aspect Pack'            
            }
        },
        pos = {
            x = 3,
            y = 1
        },
        atlas = 'HomestuckTags',
        
        in_pool = function(self)
            return (G.GAME.round_resets.ante > 1)
        end,

        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['p_bstuck_aspect_booster']
            art_credit('akai', info_queue)

            return {true}
        end,
        apply = function(self, tag, context)
            if context.type == self.config.type then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                tag:yep('+', G.C.SECONDARY_SET.Aspect,function() 
                        
                        return true
                    end)
                tag.triggered = true
            end
        end,
    }
end