function Balatrostuck.INIT.Aspects.c_aspect_space()
    Balatrostuck.Aspect{
        key = "space",
        name = "Space",
        loc_txt = {
            name = "Space",
            text = {
                '{C:attention}+#1#{} hand size'
            }
        },
        pos = {
            x = 3,
            y = 1
        },
        soul_pos = {
            x = 3,
            y = 3
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
        key = 'space',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 3,
            y = 2
        },
        config = {},
        name = 'Aspect of Space',
        apply = function(self, slab, context) 
            local peepee 
            local poopoo
            
            if context.activated or context.deactivated then     
                peepee = summation(slab:level())
                poopoo = summation(slab:level() - 1)
            end

            if context.activated and context.after_level_up then
                if context.returning or context.is_new then
                    G.hand:change_size(peepee)
                else
                    G.hand:change_size(peepee-poopoo)
                end
            end
            if context.deactivated and context.before_level_down then
                G.hand:change_size(-peepee)
            end
        end
    }
end