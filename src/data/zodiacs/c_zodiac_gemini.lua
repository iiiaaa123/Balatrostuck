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
                "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                '{C:attention}all{} future {C:attention}2s{} to',
                'be {C:attention}retriggered',
                '#2# time#3#'
            }
        },
        cost = 4,
        discovered = false,
        atlas = "HomestuckZodiacs",
        use = function(self, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                self:juice_up(0.8, 0.5)
                return true end
            }))
            G.GAME.BALATROSTUCK.zodiac_levels[self.ability.name] = G.GAME.BALATROSTUCK.zodiac_levels[self.ability.name] + 1
        end,
        can_use = function() return true end,
        loc_def = function(card)
            local level = G.GAME.BALATROSTUCK.zodiac_levels[card.name] + 1
            local formula = level
            return {
                level,
                formula,
                (level~=1 and 's' or ''),
                colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])}
            }
        end,
    }:register()
end 