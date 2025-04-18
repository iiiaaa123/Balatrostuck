function Balatrostuck.INIT.Aspects.c_aspect_hope()
    Balatrostuck.Aspect{
        key = "hope",
        name = "Hope",
        loc_txt = {
            ['name'] = "Hope",
            ['text'] = {
                [1] = 'test'
            }
        },
        pos = {
            x = 2,
            y = 1
        },
        soul_pos = {
            x = 2,
            y = 3
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        use = function(self, context)
            self:switch_slab()
        end,
        can_use = function(self)
            return true
        end
    }

    Balatrostuck.Slab{
        key = 'hope',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 3,
            y = 1
        },
        config = {},
        name = 'Aspect of Hope',
        apply = function(self, slab, context) 
            local peepee = slab:level()
            local poopoo = slab:level() - 1

            if context.activated and context.after_level_up then
                if context.returning then
                    G.GAME.BALATROSTUCK.pack_size_bonus = G.GAME.BALATROSTUCK.pack_size_bonus + peepee
                else
                    G.GAME.BALATROSTUCK.pack_size_bonus = G.GAME.BALATROSTUCK.pack_size_bonus + (peepee - poopoo)
                end
            end
            if context.deactivated and context.before_level_down then
                G.GAME.BALATROSTUCK.pack_size_bonus = G.GAME.BALATROSTUCK.pack_size_bonus - peepee
            end
        end
    }
end
