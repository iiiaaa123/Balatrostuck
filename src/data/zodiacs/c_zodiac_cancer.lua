function Balatrostuck.INIT.Zodiacs.c_zodiac_cancer()
    Balatrostuck.Zodiac{
        name = "Cancer",
        key = "cancer",
        config = {},
        pos = {
            x = 2,
            y = 0
        },
        loc_txt = {
            ['name'] = "Cancer",
            ['text'] = {
                "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                'future {C:attention}held 4s',
                'to give {C:mult}+#2# Mult{}'
            }
        },
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
            local formula = 3 + level
            return {
                level,
                formula,
                colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])}
            }
        end,
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }:register()
end