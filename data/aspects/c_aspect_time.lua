function Balatrostuck.INIT.Aspects.c_aspect_time()
    Balatrostuck.Aspect{
        key = "time",
        name = "Time",
        loc_txt = {
            name = "Time",
            text = {
                "{C:blue}+#1#{} hand#2# each round",
            }
        },
        pos = {
            x = 3,
            y = 0
        },
        soul_pos = {
            x = 3,
            y = 2
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        loc_vars = function(self, info_queue)
            art_credit2('akai', 'yokcos', info_queue)
            return {
                vars = {
                    summation(self:level()+1),
                    (self:level()+1 ~= 1 and 's' or '')
                },
                main_start = {BSUI.Modules.GameText.LevelUp(G.C.UI.TEXT_DARK, self:level()+1)},
                main_end = (self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Format('+'..self:level(), G.C.BLUE),
                    BSUI.Modules.GameText.Format(' hand'..(self:level() ~= 1 and 's' or '')..' each round', G.C.UI.TEXT_INACTIVE)
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
        key = 'time',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 3,
            y = 0
        },
        config = {},
        name = 'Aspect of Time',
        apply = function(self, slab, context) 
            if context.setting_blind then
                ease_hands_played(summation(slab:level()))
            end
        end
    }
end