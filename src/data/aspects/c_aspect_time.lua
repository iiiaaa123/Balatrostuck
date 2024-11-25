function Balatrostuck.INIT.Aspects.c_aspect_time()
    Balatrostuck.Aspect{
        key = "time",
        name = "Time",
        loc_txt = {
            ['name'] = "Time",
            ['text'] = {
                [1] = '{E:1,S:1.2}(lvl. #2#){} Get {C:blue}+#1# Hand#3#{}'
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
            return {
                vars = {
                    summation(self:level()),
                    self:level()
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
            if context.activated and context.after_level_up then
                if context.old_slab and context.old_slab.key == self.key then
                    local hands_played_before = summation(slab:level() - 1)
                    local hands_played_after = summation(slab:level())
                    local delta = hands_played_after - hands_played_before
                    ease_hands_played(delta)
                elseif context.old_slab and context.old_slab.key ~= self.key then
                    ease_hands_played(summation(slab:level()))
                elseif context.is_new then
                    ease_hands_played(summation(slab:level()))
                end
            elseif context.deactivated and context.before_level_down then
                ease_hands_played(-summation(slab:level()))
            elseif context.start_of_round then
                ease_hands_played(summation(slab:level()))
            end
        end
    }
end