function Balatrostuck.INIT.Zodiacs.c_zodiac_leo()
    Balatrostuck.Zodiac{
        name = "Leo",
        key = "leo",
        config = {},
        pos = {
            x = 3,
            y = 0
        },
        loc_txt = {
            ['name'] = "Leo",
            ['text'] = {
                [1] = 'test'
            }
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }:register()
    end