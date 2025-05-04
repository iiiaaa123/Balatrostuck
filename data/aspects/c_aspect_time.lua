function Balatrostuck.INIT.Aspects.c_aspect_time()
    Balatrostuck.Aspect{
        key = "time",
        name = "Time",
        loc_txt = {
            ['name'] = "Time",
            ['text'] = {
                [1] = "", -- "{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
                [2] = "{C:blue}+#1#{} hand#3# each round",
                [3] = "{C:inactive}(Currently {C:blue}+#4#{C:inactive} hands)"
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
            local mariobros = ""
            if self:level() ~= 0 then
                mariobros = "s"
            end
            return {
                vars = {
                    summation(self:level() + 1),
                    self:level(),
                    mariobros
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