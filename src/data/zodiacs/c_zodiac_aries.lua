function Balatrostuck.INIT.Zodiacs.c_zodiac_aries()
    Balatrostuck.Zodiac{
        name = "Aries",
        key = "aries",
        config = {
            extra = {
                mult_mod = 2
            }
        },
        pos = {
            x = 4,
            y = 1
        },
        loc_txt = {
            ['name'] = "Aries",
            ['text'] = {
                '{{S:0.8}({S:0.8, V:1}lvl.#1#{}{S:0.8}){} Level up',
                'future {C:attention}scoring Aces',
                'to give {C:mult}+#2# Mult{} per',
                'Ace {C:attention}discarded{} or',
                '{C:attention}left in deck'
            }
        },
        loc_def = function(card)
            local level = G.GAME.BALATROSTUCK.zodiac_levels[card.name] + 1
            local formula = card.config.extra.mult_mod * level
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