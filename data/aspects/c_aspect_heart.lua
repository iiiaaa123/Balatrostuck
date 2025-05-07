function Balatrostuck.INIT.Aspects.c_aspect_heart()
    Balatrostuck.Aspect{
        key = "heart",
        name = "Heart",
        loc_txt = {
            ['name'] = "Heart",
            ['text'] = {
                'When a poker hand is',
                '{C:attention}leveled up{}, it gains',
                '{C:attention}#1#{} additional levels',
            }
        },
        pos = {
            x = 1,
            y = 1
        },
        soul_pos = {
            x = 1,
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
                    BSUI.Modules.GameText.Format(summation(self:level())..' ', G.C.IMPORTANT),
                    BSUI.Modules.GameText.Format(
                    'level'..(summation(self:level()) ~= 1 and 's' or ''), G.C.UI.TEXT_INACTIVE
                    )
                })} or {})
            }
        end,
        use = function(self, card, area, copier)
            self:switch_slab()
        end,
        can_use = function(self)
            return true
        end
    }

    Balatrostuck.Slab{
        key = 'heart',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 0,
            y = 1
        },
        config = {},
        name = 'Aspect of Heart',
        apply = function(self, slab, context)
            if context.level_up_hand then
                sendInfoMessage("Intersected level up")
                return {
                    amount = context.amount + summation(slab:level())
                }
            end
        end
    }

end
