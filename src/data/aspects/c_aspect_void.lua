function Balatrostuck.INIT.Aspects.c_aspect_void()
    Balatrostuck.Aspect{
        key = "void",
        name = "Void",
        loc_txt = {
            ['name'] = "Void",
            ['text'] = {
                [1] = 'Applies {C:dark_edition}Negative{} to',
                [2] = 'random consumable',
                [3] = 'each round {C:inactive}(max of #1#){}'
            }
        },
        pos = {
            x = 0,
            y = 1
        },
        soul_pos = {
            x = 0,
            y = 3
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects"
    }:register()
end
