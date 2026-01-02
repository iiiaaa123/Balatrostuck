function Balatrostuck.INIT.Zodiacs.c_zodiac_gemini()
    Balatrostuck.Zodiac{
        name = "Gemini",
        key = "gemini",
        config = {
        },
        pos = {
            x = 1,
            y = 0
        },
        loc_txt = {
            ['name'] = "Gemini",
            ['text'] = {
                '{C:attention}Retrigger{} each played {C:attention}2',
                '{C:attention}#1#{} additional time#2#', --1 should be next level value + times should be dynamically plural
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
            self:add_caste('Gemini')
        end,
        can_use = function() return true end,
    }

    Balatrostuck.Caste{
        key = 'Gemini',
        config = {},
        name = 'Gemini',
        rank = 2,
        apply = function(self,context)
            if context.repetition and self:level(context.other_card) < 1 then return end

            if context.repetition and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                SMODS.calculate_context({zodiac_triggered = true, zodiac = self})
				return {
					message = 'agaiin!',
                    colour = G.C.MONEY,
					repetitions = self:level(context.other_card),
					card = context.other_card
				}
            end
        end
    }






end 