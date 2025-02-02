function Balatrostuck.INIT.Zodiacs.c_zodiac_sagittarius()
    Balatrostuck.Zodiac{
        name = "Sagittarius",
        key = "sagittarius",
        config = {},
        pos = {
            x = 0,
            y = 1
        },
        loc_txt = {
            ['name'] = "Sagittarius",
            ['text'] = {
                '{S:0.8}({S:0.8}lvl.#1#{S:0.8}){} Level up', --needs color var
                'Played cards give',
                '{C:chips}+25{} Chips if played hand ', --next level value
                'contains a {C:attention}non-scoring 9',
                '{C:inactive}(Currently {C:chips}+0{C:inactive} Chips)' --current level value
            }
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }
end