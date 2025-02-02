function Balatrostuck.INIT.Aspects.c_aspect_rage()
    Balatrostuck.Aspect{
        key = "rage",
        name = "Rage",
        loc_txt = {
            ['name'] = "Rage",
            ['text'] = {
                [1] = 'Scoring cards give',
                [2] = '{C:white,X:mult}X#1#{} Mult times',
                [3] = 'the {C:attention}difference{}',
                [4] = 'between {C:attention}hands{}',
                [5] = 'and {C:attention}discards{} left'
            }
        },
        pos = {
            x = 2,
            y = 0
        },
        soul_pos = {
            x = 2,
            y = 2
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        loc_vars = function(self, info_queue)
            return {
                vars = {
                    (G.GAME.BALATROSTUCK.aspect_levels[self.name] or 0)*0.25
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
        key = 'rage',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 3,
            y = 0
        },
        config = {},
        name = 'Aspect of Rage',
        apply = function(self,slab,context)
            if context.individual and context.cardarea == G.play then
                if math.abs(G.GAME.current_round.hands_left - G.GAME.current_round.discards_left) ~= 0 then
                    return {
                        x_mult = (slab:level() / 2) * math.abs(G.GAME.current_round.hands_left - G.GAME.current_round.discards_left),
                        card = context.other_card
                    }
                end
            end
        end
    }

end