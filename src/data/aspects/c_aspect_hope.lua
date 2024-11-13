function Balatrostuck.INIT.Aspects.c_aspect_hope()
    Balatrostuck.Aspect{
        key = "hope",
        name = "Hope",
        loc_txt = {
            ['name'] = "Hope",
            ['text'] = {
                [1] = 'test'
            }
        },
        pos = {
            x = 2,
            y = 1
        },
        soul_pos = {
            x = 2,
            y = 3
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects"
    }:register()
end
