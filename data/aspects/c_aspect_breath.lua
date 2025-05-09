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
        discovered = true,
        atlas = "HomestuckAspects",
        loc_vars = function(self, info_queue)
            art_credit2('akai', 'yokcos', info_queue)
            return {
                vars = {
                    self:level()+1,
                    ((self:level()+1) ~= 1 and 's' or '')
                },
                main_start = {BSUI.Modules.GameText.LevelUp(G.C.UI.TEXT_DARK, self:level()+1)},
                main_end = (self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Format(self:level(), G.C.IMPORTANT),
                    BSUI.Modules.GameText.Inactive(' reroll'..(self:level() ~= 1 and 's' or ''))
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
        key = 'breath',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 2,
            y = 1
        },
        config = {},
        name = 'Aspect of Breath',
        apply = function(self, slab, context)
            local peepee = slab:level()
            local poopoo = slab:level() - 1

            if context.activated and context.after_level_up then
                if context.returning then
                    SMODS.change_free_rerolls(peepee)
                else
                    SMODS.change_free_rerolls(peepee-poopoo)
                end
            end
            if context.deactivated and context.before_level_down then
                SMODS.change_free_rerolls(-peepee)
            end
        end
    }
end
