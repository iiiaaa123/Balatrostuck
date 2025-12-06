function Balatrostuck.INIT.Aspects.c_aspect_hope()
    Balatrostuck.Aspect{
        key = "hope",
        name = "Hope",
        loc_txt = {
            name = "Hope",
            text = {
                "{C:attention}Booster Packs{} have",
                "{C:attention}+#1#{} card#2# to choose from",
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
        discovered = false,
        atlas = "HomestuckAspects",
        use = function(self, context)
            self:switch_slab()
        end,
        can_use = function(self)
            return true
        end,
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
            local peepee 
            local poopoo
            
            if context.activated or context.deactivated then     
                peepee = slab:level()
                poopoo = slab:level() - 1
            end

            if context.activated and context.after_level_up then
                if context.returning then
                    G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + peepee
                else
                    G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + (peepee - poopoo)
                end
            end
            if context.deactivated and context.before_level_down then
                G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) - peepee
            end
        end
    }
end
