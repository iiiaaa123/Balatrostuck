function Balatrostuck.INIT.Aspects.c_aspect_mind()
    Balatrostuck.Aspect{
        key = "mind",
        name = "Mind",
        loc_txt = {
            name = "Mind",
            text = {
                'When a {C:attention}Tag{} is created,',
                'create {C:attention}#1#{} cop#2# of it',
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
                if context.tag.ability and context.tag.ability.orbital_hand and context.tag.ability.orbital_hand ~= "[poker hand]" then
                    G.orbital_hand = context.tag.ability.orbital_hand
                end
                for i = 1, slab:level() do
                    add_tag(Tag(context.tag.key),true)
                end
            end
        end
    }
end