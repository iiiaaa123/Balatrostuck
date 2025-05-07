function Balatrostuck.INIT.Aspects.c_aspect_rage()
    Balatrostuck.Aspect{
        key = "rage",
        name = "Rage",
        loc_txt = {
            name = "Rage",
            text = {
                'First scoring card gives {C:white,X:mult}X#1#{} Mult',
                'times the {C:attention}difference{} between',
                '{C:blue}hands{} and {C:red}discards{} left',
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
            art_credit2('akai', 'yokcos', info_queue)
            return {
                vars = {
                    (self:level()+1)*0.25
                },
                main_start = {BSUI.Modules.GameText.LevelUp(G.C.UI.TEXT_DARK, self:level()+1)},
                main_end = (self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Format('X'..(self:level())*0.25, G.C.WHITE, G.C.RED),
                    BSUI.Modules.GameText.Format(' Mult', G.C.UI.TEXT_INACTIVE)
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
        key = 'rage',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 2,
            y = 0
        },
        config = {},
        name = 'Aspect of Rage',
        apply = function(self,slab,context)
            if context.individual and context.cardarea == G.play then
                if context.other_card == context.scoring_hand[1] then
                    return {
                        x_mult = (1 + (slab:level() / 2)) ^ (G.GAME.current_round.discards_left - G.GAME.current_round.hands_left),
                        card = context.other_card
                    }
                end
            end
        end
    }

end