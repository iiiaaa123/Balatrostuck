function Balatrostuck.INIT.Aspects.c_aspect_light()
    Balatrostuck.Aspect{
        key = "light",
        name = "Light",
        loc_txt = {
            ['name'] = "Light",
            ['text'] = {
                [1] = 'Held consumables',
                [2] = 'give {C:white,X:mult}X#1#{} Mult each'
            }
        },
        pos = {
            x = 0,
            y = 0
        },
        soul_pos = {
            x = 0,
            y = 2
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        loc_def = function(self, info_queue)
            return {1+(G.GAME.BALATROSTUCK.aspect_levels[self.name]*0.5)}
        end
    }:register()
end