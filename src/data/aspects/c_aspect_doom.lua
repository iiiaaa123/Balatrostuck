function Balatrostuck.INIT.Aspects.c_aspect_doom()
    Balatrostuck.Aspect{
        key = "doom",
        name = "Doom",
        loc_txt = {
            ['name'] = "Doom",
            ['text'] = {
                [1] = 'When a {C:green,E:1,S:1.1}probability',
                [2] = 'up to {C:green}1 in 3{} fails',
                [3] = 'gain a {C:dark_edition}Negative{} Fool'
            }
        },
        pos = {
            x = 5,
            y = 1
        },
        soul_pos = {
            x = 5,
            y = 3
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects"
    }:register()   
end
