function Balatrostuck.INIT.Zodiacs.c_zodiac_pisces()
    Balatrostuck.Zodiac{
        name = "Pisces",
        key = "pisces",
        config = {
        },
        pos = {
            x = 3,
            y = 1
        },
        loc_txt = {
            name = "Pisces",
            text = {
                'Played{C:attention} Queens{} give {C:money}$#1# {C:red,E:2}minus{} the', --next level value
                'amount of {C:attention}remaining hands{} when scored', 
            }
        },
        cost = 4,
        discovered = false,
        atlas = "HomestuckZodiacs",
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('timpani', 0.7)
                play_sound('bstuck_HomestuckBloodDrop', 1)
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Pisces')
        end,
        can_use = function() return true end,
    }
    

    Balatrostuck.Caste{
        key = 'Pisces',
        name = 'Pisces',
        rank = 12,
        apply = function(self,context)
            if context.individual and self:level(context.other_card) < 1 then return end
            
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                SMODS.calculate_context({zodiac_triggered = true, zodiac = self})
                return {
                    dollars = (3 * self:level(context.other_card)) - G.GAME.current_round.hands_left,
                    card = context.other_card
                }
            end
        end
    }




end
