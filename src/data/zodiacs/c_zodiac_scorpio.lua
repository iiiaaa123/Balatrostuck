function Balatrostuck.INIT.Zodiacs.c_zodiac_scorpio()
    Balatrostuck.Zodiac{
        name = "Scorpio",
        key = "scorpio",
        config = {},
        pos = {
            x = 6,
            y = 0
        },
        loc_txt = {
            ['name'] = "Scorpio",
            ['text'] = {
                '{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up',
                'Played {C:attention}8s{} double all {C:green,E:1,S:1.1}probabilities{}',
                'when scored, up to ',
                '{C:attention}1{} time#3# per hand, and',
                'resets when next hand is played', --next level amount
                '{C:inactive}(Currently up to {C:attention}#2# {C:inactive}times)', --current level amount
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
            G.GAME.BALATROSTUCK.zodiac_levels[card.ability.name] = G.GAME.BALATROSTUCK.zodiac_levels[card.ability.name] + 1
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = level
            return {
                vars = {
                    level,
                    formula,
                    (level~=1 and 's' or ''),
                    colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])}
                }
            }
        end,
    }
end