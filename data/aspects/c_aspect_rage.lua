function Balatrostuck.INIT.Aspects.c_aspect_rage()
    Balatrostuck.Aspect{
        key = "rage",
        name = "Rage",
        loc_txt = {
            name = "Rage",
            text = {
                'First played card gives',
                '{C:white,X:mult}X#1#{} Mult to the power',
                'of {C:red}discards{} left {E:2,C:red}minus{} ',
                '{C:blue}hands{} left when scored',
                '{C:inactive}Currently {C:white,X:mult}X#3#{C:inactive} Mult',
                '{C:inactive}Between {C:white,X:mult}X#4#{C:inactive} and {C:white,X:mult}X#2#{C:inactive} Mult',
                
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
        discovered = false,
        atlas = "HomestuckAspects",
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
            x = 2,
            y = 0
        },
        config = {hands_left_to_evaluate = 0, discards_left_to_evaluate = 0, setup = false, debug_total_xmult_given = 1},
        ability = {extra={repetitions=0}},
        name = 'Aspect of Rage',
        apply = function(self,slab,context)
            if context.before then 
                if not self.config.setup then
                    self.config.discards_left_to_evaluate = G.GAME.current_round.discards_left
                    self.config.hands_left_to_evaluate = G.GAME.current_round.hands_left
                    self.config.setup = true
                    self.ability.extra.repetitions = G.GAME.current_round.hands_left + G.GAME.current_round.discards_left - 1
                end
            end
            if context.individual and context.cardarea == G.play then
                if context.other_card == context.scoring_hand[1] then
                    print("Triggered!")
                    if self.config.discards_left_to_evaluate > 0 then
                        self.config.discards_left_to_evaluate = self.config.discards_left_to_evaluate - 1
                        self.config.debug_total_xmult_given = self.config.debug_total_xmult_given * (1 + (slab:level() / 2))
                        local xmult = 1 * (1 + (slab:level() / 2))
                        return {
                            message = localize{type='variable',key='a_xmult',vars={xmult}},
                            x_mult = xmult,
                            card = context.other_card
                        }
                    end
                    if self.config.hands_left_to_evaluate > 0 then
                        self.config.hands_left_to_evaluate = self.config.hands_left_to_evaluate - 1
                        self.config.debug_total_xmult_given = self.config.debug_total_xmult_given / (1 + (slab:level() / 2))
                        local xmult = 1 / (1 + (slab:level() / 2))
                        return {
                            message = localize{type='variable',key='a_xmult',vars={xmult}},
                            x_mult = xmult,
                            card = context.other_card
                        }
                    end
                    return {}
                end
            end
            if context.after then
                self.config.setup = false
                self.ability.extra.repetitions = 0
            end
        end
    }

end