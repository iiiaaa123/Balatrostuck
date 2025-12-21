function Balatrostuck.INIT.Aspects.c_aspect_mind()
    Balatrostuck.Aspect{
        key = "mind",
        name = "Mind",
        loc_txt = {
            name = "Mind",
            text = {
                'When a {C:attention}Tag{} is created,',
                'create {C:attention}#1#{} cop#2# of it',
            }
        },
        pos = {
            x = 1,
            y = 0
        },
        soul_pos = {
            x = 1,
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
        key = 'mind',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 1,
            y = 0
        },
        config = {},
        name = 'Aspect of Mind',
        apply = function(self, slab, context) 
            if context.modify_tag_stacks then --called from tag_heaven.lua
                return context.stacks * (slab:level() + 1) 
            end
        end
    }
end