function Balatrostuck.INIT.Aspects.c_aspect_candy()
    Balatrostuck.Aspect{
        key = "candy",
        name = "Candy",
        loc_txt = {
            name = "Candy",
            text = {
                'guagua #1#'
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
        discovered = false,
        atlas = "HomestuckAspects",
        use = function(self, context)
            self:switch_slab()
        end,
        can_use = function(self)
            return true
        end
    }

    Balatrostuck.Slab{
        key = 'candy',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 1,
            y = 1
        },
        config = {},
        name = 'Aspect of Candy',
        apply = function(self, slab, context) 
            if context.after then
                G.E_MANAGER:add_event(Event({
                    func = function ()


                        return true
                    end
                }))
            end
        end
    }
end
