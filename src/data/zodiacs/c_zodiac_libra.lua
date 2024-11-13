function Balatrostuck.INIT.Zodiacs.c_zodiac_libra()
    Balatrostuck.Zodiac{
        name = "Libra",
        key = "libra",
        config = {},
        pos = {
            x = 5,
            y = 0
        },
        loc_txt = {
            ['name'] = "Libra",
            ['text'] = {
                "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                'future {C:attention}scoring 7s',
                'to give {X:mult,C:white}X#2#{} Mult'
            }
        },
        cost = 4,
        discovered = true,
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
            local formula = 1 + level/10
            return {
                level,
                formula,
                colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])}
            }
        end,
    }:register()
end

--[1] = 'All scoring 7s',
--[2] = 'give {X:mult,C:white}X1.1{} Mult']