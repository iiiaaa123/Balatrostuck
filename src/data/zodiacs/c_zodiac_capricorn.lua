function Balatrostuck.INIT.Zodiacs.c_zodiac_capricorn()
    Balatrostuck.Zodiac{
        name = "Capricorn",
        key = "capricorn",
        config = {},
        pos = {
            x = 1,
            y = 1
        },
        loc_txt = {
            ['name'] = "Capricorn",
            ['text'] = {
                [1] = 'test'
            }
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }:register()
end