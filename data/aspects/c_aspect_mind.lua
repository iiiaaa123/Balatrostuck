function Balatrostuck.INIT.Aspects.c_aspect_mind()
    Balatrostuck.Aspect{
        key = "mind",
        name = "Mind",
        loc_txt = {
            ['name'] = "Mind",
            ['text'] = {
                [1] = "", -- "{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
                [2] = 'When a {C:attention}Tag{} is created,',
                [3] = 'create {C:attention}#2#{} copies of it',
                [4] = '{C:inactive}(Currently {C:attention}#3#{C:inactive} copies)'
            }
        },
        pos = {
            x = 1,
            y = 0
        },
        soul_pos = {
            x = 1,
            y = 2
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        loc_vars = function(self, info_queue)
            art_credit2('akai', 'yokcos', info_queue)
            return {
                vars = {
                    (G.GAME.BALATROSTUCK.aspect_levels[self.name] or 0)
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
        key = 'mind',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 1,
            y = 0
        },
        config = {},
        name = 'Aspect of Mind',
        apply = function(self, slab, context) 
            if context.tag then
                if context.tag.ability and context.tag.ability.orbital_hand then
                    G.orbital_hand = context.tag.ability.orbital_hand
                end
                for i = 1, slab:level() do
                    add_tag(Tag(context.tag.key),true)
                end
            end
        end
    }
end