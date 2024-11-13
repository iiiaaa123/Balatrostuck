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
                [1] = 'test'
            }
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }:register()
end