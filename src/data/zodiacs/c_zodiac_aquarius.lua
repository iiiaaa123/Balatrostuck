function Balatrostuck.INIT.Zodiacs.c_zodiac_aquarius()
    Balatrostuck.Zodiac{
        name = "Aquarius",
        key = "aquarius",
        config = {},
        pos = {
            x = 2,
            y = 1
        },
        loc_txt = {
            ['name'] = "Aquarius",
            ['text'] = {
                '{S:0.8}({S:0.8}lvl.#1#{S:0.8}){} Level up', --needs color var
                '{C:attention}Jacks{} create {C:attention}1{} random',
                '{C:attention}Tags{} when {C:attention}destroyed', --next level value + dynamic plural
                '{C:inactive}(Currently {C:attention}0{C:inactive} Tags)' --current level value + dynamic plural
            }
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }
end