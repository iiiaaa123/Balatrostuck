function Balatrostuck.INIT.Aspects.c_aspect_void()
    Balatrostuck.Aspect{
        key = "void",
        name = "Void",
        loc_txt = {
            ['name'] = "Void",
            ['text'] = {
                [1] = 'Applies {C:dark_edition}Negative{} to',
                [2] = 'random joker',
                [3] = 'each round {C:inactive}(max of #1#){}'
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
        discovered = true,
        atlas = "HomestuckAspects",
        loc_vars = function(self, info_queue)
            return {
                vars = {
                    summation(1+(G.GAME.BALATROSTUCK.aspect_levels[self.name] or 0)),
                }
            }
        end
    }
end


Balatrostuck.Slab{
    key = 'void',
    atlas = 'HomestuckAspectSlabs',
    pos = {
        x = 2,
        y = 1
    },
    config = {},
    name = 'Aspect of Void',
    apply = function(self, slab, context)
        if context.start_of_round then
            local voidcount = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].edition.type == 'negative' then local voidcount = voidcount + 1 end,
            if voidcount =<  summation(1+(G.GAME.BALATROSTUCK.aspect_levels[self.name] or 0)) then -- Make the check for max cap negative jokers
                local temp_pool =  (self.eligible_editionless_jokers) or {}
                local eligible_card = pseudorandom_element(temp_pool, pseudoseed('what pumpkin'))
                eligible_card:set_edition(negative, true)
            end
        end
    end
}
end