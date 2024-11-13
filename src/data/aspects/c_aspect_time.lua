function Balatrostuck.INIT.Aspects.c_aspect_time()
    Balatrostuck.Aspect{
        key = "time",
        name = "Time",
        loc_txt = {
            ['name'] = "Time",
            ['text'] = {
                [1] = '{E:1,S:1.2}(lvl. #2#){} Get {C:blue}+#1# Hand#3#{}'
            }
        },
        pos = {
            x = 3,
            y = 0
        },
        soul_pos = {
            x = 3,
            y = 2
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        loc_def = function(self, info_queue)
            return {summation(G.GAME.BALATROSTUCK.aspect_levels[self.name])}
        end
    }:register()
end