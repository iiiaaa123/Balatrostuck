function Balatrostuck.INIT.Aspects.c_aspect_space()
    Balatrostuck.Aspect{
        key = "space",
        name = "Space",
        loc_txt = {
            ['name'] = "Space",
            ['text'] = {
                [1] = '{C:attention}+#1# hand size{}'
            }
        },
        pos = {
            x = 3,
            y = 1
        },
        soul_pos = {
            x = 3,
            y = 3
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        loc_def = function(self, info_queue)
            return {summation(G.GAME.BALATROSTUCK.aspect_levels[self.name])}
        end
    }:register()
end