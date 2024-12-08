function Balatrostuck.INIT.Aspects.c_aspect_mind()
    Balatrostuck.Aspect{
        key = "mind",
        name = "Mind",
        loc_txt = {
            ['name'] = "Mind",
            ['text'] = {
                [1] = 'When you gain a {C:attention}tag{}',
                [2] = 'create #1# copies of it.',
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
            return {
                vars = {
                    self:level()
                }
            }
        end
    }

end

 Balatrostuck.Slab{
    key = 'mind',
    atlas = 'HomestuckAspectSlabs',
    pos = {
        x = 2,
        y = 1
    },
    config = {},
    name = 'Aspect of Mind',
    apply = function(self, slab, context)
        if _context.type == 'tag_add' and _context.tag.key ~= 'tag_double'then
             for slab:level()=1,1
                add_tag(Tag(_context.tag.key))


        end
    end
}
end
