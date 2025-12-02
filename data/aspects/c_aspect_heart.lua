function Balatrostuck.INIT.Aspects.c_aspect_heart()
    Balatrostuck.Aspect{
        key = "heart",
        name = "Heart",
        loc_txt = {
            ['name'] = "Heart",
            ['text'] = {
                'When a poker hand is',
                '{C:attention}leveled up{}, it gains',
                '{C:attention}#1#{} additional level#2#',
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
                --sendInfoMessage("Intersected level up")
                return {
                    amount = context.amount + slab:level()
                }
            end
        end
    }

end
