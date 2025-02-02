function Balatrostuck.INIT.Zodiacs.c_zodiac_ophiuchus()
    Balatrostuck.Zodiac{
        name = "Ophiuchus",
        key = "ophiuchus",
        config = {},
        pos = {
            x = 5,
            y = 1
        },
        loc_txt = {
            ['name'] = "Ophiuchus",
            ['text'] = {
                "{S:0.8}({S:0.8}lvl.#1#{S:0.8}){} Level up", --needs color var
                "When played {C:attention}Kings{} are scored, a",
                "random card held in hand becomes",
                "{C:green}Paradox{} and gives {X:mult,C:white}X2{} Mult", --next level value
                "{C:inactive}(Currently {X:mult,C:white}X1{C:inactive})" --current level value
            }
        },
        cost = 4,
        discovered = false,
        atlas = "HomestuckZodiacs"
    }
end