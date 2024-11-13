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
            ['name'] = "Taurus",
            ['text'] = {
                [1] = 'test'
            }
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }:register()
end