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
        discovered = true,
        atlas = "HomestuckAspects",
        loc_vars = function(self, info_queue)
            art_credit2('akai', 'yokcos', info_queue)
            return {
                vars = {
                    summation(self:level()+1)
                },
                main_start = {BSUI.Modules.GameText.LevelUp(G.C.UI.TEXT_DARK, self:level()+1)},
                main_end = (self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Format('+'..self:level(), G.C.IMPORTANT),
                    BSUI.Modules.GameText.Inactive(' hand size')
                })} or {})
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
            y = 2
        },
        config = {},
        name = 'Aspect of Space',
        apply = function(self, slab, context) 
            local peepee = summation(slab:level())
            local poopoo = summation(slab:level() - 1)

            if context.activated and context.after_level_up then
                if context.returning then
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