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
        discovered = true,
        atlas = "HomestuckAspects",
        loc_vars = function(self, info_queue)
            art_credit2('akai', 'yokcos', info_queue)
            return {
                vars = {
                    self:level()+1,
                    ((self:level()+1) ~= 1 and 'ies' or 'y')
                },
                main_start = {BSUI.Modules.GameText.LevelUp(G.C.UI.TEXT_DARK, self:level()+1)},
                main_end = (self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Format(self:level(), G.C.IMPORTANT),
                    BSUI.Modules.GameText.Inactive(' cop'..(self:level() ~= 1 and 'ies' or 'y'))
                })} or {})
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