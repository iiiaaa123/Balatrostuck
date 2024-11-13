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
                [1] = 'test'
            }
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }:register()
end