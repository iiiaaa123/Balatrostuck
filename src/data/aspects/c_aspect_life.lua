function Balatrostuck.INIT.Aspects.c_aspect_life()
    Balatrostuck.Aspect{
        key = "life",
        name = "Life",
        loc_txt = {
            ['name'] = "Life",
            ['text'] = {
                [1] = 'test'
            }
        },
        pos = {
            x = 5,
            y = 0
        },
        soul_pos = {
            x = 5,
            y = 2
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects"
    }:register()
end
