function Balatrostuck.INIT.Zodiacs.c_zodiac_taurus()
    Balatrostuck.Zodiac{
        name = "Taurus",
        key = "taurus",
        config = {},
        pos = {
            x = 0,
            y = 0
        },
        loc_txt = {
            ['name'] = "Taurus", --value is 0.95^lvl
            ['text'] = {
                "{S:0.8}({S:0.8}lvl.#1#{S:0.8}){} Level up", --needs color var
                "Discarded {C:attention}3s{} multiply the current",
                "{C:attention}Blind requirement{} by {C:red}X0.95", --next level value 
                "{C:inactive}(Currently {C:red}X1{C:inactive})" --current level value
            }
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }
end