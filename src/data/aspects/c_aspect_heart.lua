function Balatrostuck.INIT.Aspects.c_aspect_heart()
    Balatrostuck.Aspect{
        key = "heart",
        name = "Heart",
        loc_txt = {
            ['name'] = "Heart",
            ['text'] = {
                [1] = 'Reduces amount',
                [2] = 'of {C:blue}hands{} to 1',
                [3] = '{C:attention}scoring cards',
                [4] = 'give {C:white,X:mult}X#1#{} Mult each'
            }
        },
        pos = {
            x = 1,
            y = 1
        },
        soul_pos = {
            x = 1,
            y = 3
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        loc_def = function(self, info_queue)
            return {G.GAME.BALATROSTUCK.aspect_levels[self.name]+2}
        end
    }:register()   
end
