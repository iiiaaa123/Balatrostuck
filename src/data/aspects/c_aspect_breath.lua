function Balatrostuck.INIT.Aspects.c_aspect_breath()
    Balatrostuck.Aspect{
        key = "breath",
        name = "Breath",
        loc_txt = {
            ['name'] = "Breath",
            ['text'] = {
                [1] = 'All {C:blue}seals{} get',
                [2] = 'retriggered',
                [3] = '#1# times',
            }
        },
        pos = {
            x = 4,
            y = 0
        },
        soul_pos = {
            x = 4,
            y = 2
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        loc_def = function(self, info_queue)
            return {G.GAME.BALATROSTUCK.aspect_levels[self.name]}
        end
    }:register()
end
