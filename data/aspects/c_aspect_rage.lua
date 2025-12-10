function Balatrostuck.INIT.Aspects.c_aspect_rage()
    Balatrostuck.Aspect{
        key = "rage",
        name = "Rage",
        loc_txt = {
            name = "Rage",
            text = {
                'First played card gives',
                '{C:white,X:mult}X#1#{} Mult for every {C:red}discard{} left',
                'and {C:white,X:mult}X#2#{} Mult for every {C:blue}hand{} left',
                'when scored',
                
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
        config = {},
        name = 'Aspect of Rage',
        apply = function(self,slab,context)
            if context.individual and context.cardarea == G.play then
                if context.other_card == context.scoring_hand[1] then
                    card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = "RAGE MODE!", colour = G.C.RAGE, instant = true})
                    delay(0.2)
                    for i=1, G.GAME.current_round.discards_left do
                        local _xmult = 1 * (1 + (slab:level() / 2))
                        card_eval_status_text(context.other_card,'x_mult_rage',_xmult,nil,nil,{message = localize { type = 'variable', key = 'a_xmult', vars = { _xmult } }})
                        context.other_card:juice_up(0.5,0.5)
                        SMODS.calculate_effect({xmult = _xmult, remove_default_message = true}, context.other_card)
                        delay(0.3)
                        
                        
                    end
                    for i=1, G.GAME.current_round.hands_left do
                        local _xmult = 1 / (1 + (slab:level() / 2))
                        card_eval_status_text(context.other_card,'x_mult_rage',_xmult,nil,nil,{message = localize { type = 'variable', key = 'a_xmult', vars = { _xmult } }})
                        context.other_card:juice_up(0.5,0.5)
                        SMODS.calculate_effect({xmult = _xmult, remove_default_message = true}, context.other_card)
                        delay(0.3)

                    end
                    return {

                    }

                end
            end
        end
    }

end