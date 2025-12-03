function Balatrostuck.INIT.Aspects.c_aspect_breath()
    Balatrostuck.Aspect{
        key = "breath",
        name = "Breath",
        loc_txt = {
            name = "Breath",
            text = {
                '{C:attention}#1#{} free {C:green}Reroll#2#{} in each shop', --dynamic plural needed
            }
        },
        pos = {
            x = 4,
            y = 0
        },
        soul_pos = {
            x = 4,
            y = 2
        },
        cost = 4,
        discovered = false,
        atlas = "HomestuckAspects",
        use = function(self, context)
            self:switch_slab()
        end,
        can_use = function(self)
            return true
        end
    }

    Balatrostuck.Slab{
        key = 'breath',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 2,
            y = 1
        },
        config = {},
        name = 'Aspect of Breath',
        apply = function(self, slab, context)
            local peepee 
            local poopoo
            
            if context.activated or context.deactivated then     
                peepee = slab:level()
                poopoo = slab:level() - 1
            end

            if context.activated and context.after_level_up then
                if context.returning then
                    SMODS.change_free_rerolls(peepee)
                    --removed the returns here because they dont seem to be needed and were making it so it doesnt level down
                    --return {true}
                else
                    SMODS.change_free_rerolls(peepee-poopoo)
                    --return {true}
                end
            end
            
            if context.deactivated and context.before_level_down then
                SMODS.change_free_rerolls(-peepee)
                --return {true}
            end
        end
    }
end
