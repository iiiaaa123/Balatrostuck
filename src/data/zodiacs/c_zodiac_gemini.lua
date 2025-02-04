function Balatrostuck.INIT.Zodiacs.c_zodiac_gemini()
    Balatrostuck.Zodiac{
        name = "Gemini",
        key = "gemini",
        config = {},
        pos = {
            x = 1,
            y = 0
        },
        loc_txt = {
            ['name'] = "Gemini",
            ['text'] = {
                '{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up',
                '{C:attention}Retrigger{} played {C:attention}2s',
                '{C:attention}#2#{} additional time#3#', --1 should be next level value + times should be dynamically plural
                '{C:inactive}(Currently {C:attention}#4# {C:inactive}times)' --current level amount + dynamic plural
            }
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs",
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Gemini')
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local curr_level = G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0
            local level = curr_level + 1
            local formula = level
            return {
                vars = {
                    level,
                    formula,
                    (level~=1 and 's' or ''),
                    curr_level,
                    (curr_level~=1 and 's' or ''),
                    colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])}
                }
            }
        end,
    }

    Balatrostuck.Caste{
        key = 'Gemini',
        config = {},
        name = 'Gemini',
        rank = 2,
        apply = function(self,context)
            if context.repetition and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
				return {
					message = 'agaiin!',
					repetitions = self:level(),
					card = context.other_card
				}
            end
        end
    }






end 