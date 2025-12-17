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
                local _blacklist = {"tag_bstuck_scratch","tag_boss"}
                for i = 1, slab:level() do
                    for k,v in ipairs(_blacklist) do
                        if context.tag.key == v then return nil end
                    end
                    local _new_tag = Tag(context.tag.key)
                    if context.tag.key == 'tag_orbital' then
                        _new_tag.ability.orbital_hand = context.tag.ability.orbital_hand
                    end
                    add_tag(_new_tag,true)
                end
            end
        end
    }
end