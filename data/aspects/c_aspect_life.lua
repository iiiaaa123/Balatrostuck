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
    }



    Balatrostuck.Slab{
        key = 'life',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 0,
            y = 0
        },
        config = {payout = 0},
        name = 'Aspect of Life',
        apply = function(self, slab, context) 
            if context.end_of_round then

            end
        end
    }
end
