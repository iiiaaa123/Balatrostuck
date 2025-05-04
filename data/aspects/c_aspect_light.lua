function Balatrostuck.INIT.Aspects.c_aspect_light()
    Balatrostuck.Aspect{
        key = "light",
        name = "Light",
        loc_txt = {
            ['name'] = "Light",
            ['text'] = {
                [1] = "", -- "{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
                [2] = 'Cards in your {C:attention}consumable',
                [3] = 'area give {X:mult,C:white}X#2#{} Mult',
                [4] = '{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)'
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
        loc_vars = function(self, info_queue)
            art_credit2('akai', 'yokcos', info_queue)
            return {
                vars = {
                    1+(G.GAME.BALATROSTUCK.aspect_levels[self.name] or 0)*0.5
                }
            }
        end,
        use = function(self, context)
            self:switch_slab()
        end,
        can_use = function(self)
            return true
        end
    }



    Balatrostuck.Slab{
        key = 'light',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 0,
            y = 0
        },
        config = {},
        name = 'Aspect of Light',
        apply = function(self, slab, context) 
            if context.other_consumeable then
                return {
                    Xmult_mod = 1 + slab:level() / 2,
                    message = localize{type = 'variable', key = 'a_xmult', vars = {1 + slab:level() / 2}},
                    card = context.other_consumeable              
                }
            end
        end
    }
end