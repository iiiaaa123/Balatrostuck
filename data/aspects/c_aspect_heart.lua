function Balatrostuck.INIT.Aspects.c_aspect_heart()
    Balatrostuck.Aspect{
        key = "heart",
        name = "Heart",
        loc_txt = {
            ['name'] = "Heart",
            ['text'] = {
                [1] = "", -- "{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
                [2] = 'When a poker hand is',
                [3] = '{C:attention}leveled up{}, it gains',
                [4] = '{C:attention}#2#{} additional levels',
                [5] = '{C:inactive}(Currently {C:attention}#3#{C:inactive} levels)'
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
                    (G.GAME.BALATROSTUCK.aspect_levels[self.name] or 0)+2
                }
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
