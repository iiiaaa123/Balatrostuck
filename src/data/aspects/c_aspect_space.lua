function Balatrostuck.INIT.Aspects.c_aspect_space()
    Balatrostuck.Aspect{
        key = "space",
        name = "Space",
        loc_txt = {
            ['name'] = "Space",
            ['text'] = {
                [1] = '{C:attention}+#1# hand size{}'
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
        discovered = true,
        atlas = "HomestuckAspects",
        loc_vars = function(self, info_queue)
            return {
                vars = {
                    summation(G.GAME.BALATROSTUCK.aspect_levels[self.name] or 0)
                }
            }
        end,
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
            y = 0
        },
        config = {},
        name = 'Aspect of Space',
        apply = function(self, slab, context) 
            if context.start_of_round then
                G.hand:change_size(summation(slab:level()))
            end
        end
    }
end