function Balatrostuck.INIT.Zodiacs.c_zodiac_virgo()
    Balatrostuck.Zodiac{
        name = "Virgo",
        key = "virgo",
        config = {
            extra = {
                chips = 12
            }
        },
        pos = {
            x = 4,
            y = 0
        },
        loc_txt = {
            ['name'] = "Virgo",
            ['text'] = {
                "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                'future scoring {C:attention}6{}s',
                'to {C:attention}distribute{}',
                'a total bonus of' ,
                '{C:chips}+#2# Chips{} among',
                'all cards {C:attention}scored{}',
                '{C:attention}permamently',
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
            local formula = card.config.extra.chips * level
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