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
                'Played {C:attentions}6s{} give {C:chips}+#2# {C:attention}permanent{} Chips', --next level value
                'to all {C:attention}other{} scoring cards when scored',
                '{C:inactive}(Currently {C:chips}+#3#{C:inactive} permanent chips)' --current level value
            }
        },
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true end
            }))
            G.GAME.BALATROSTUCK.zodiac_levels[card.ability.name] = G.GAME.BALATROSTUCK.zodiac_levels[card.ability.name] + 1
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = card.config.extra.chips * level
            return {
                vars = {
                    level,
                    formula,
                    colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])}
                }
            }
        end,
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }
end