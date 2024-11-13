function Balatrostuck.INIT.Aspects.c_aspect_blood()
    Balatrostuck.Aspect{
        key = 'blood',
        name = "Blood",
        loc_txt = {
            ['name'] = "Blood",
            ['text'] = {
                [1] = 'Up to #1# {C:red}discarded',
                [2] = 'cards per blind',
                [3] = 'gets a random',
                [4] = '{C:purple}enhancement'
            }
        },
        pos = {
            x = 4,
            y = 1
        },
        soul_pos = {
            x = 4,
            y = 3
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        loc_def = function(self, info_queue)
            return {G.GAME.BALATROSTUCK.aspect_levels[self.name]+1}
        end
    }:register()

    --Balatrostuck.Slab{key='blood', atlas='HomestuckAspectSlabs', pos={x=2,y=2}}:register()
end