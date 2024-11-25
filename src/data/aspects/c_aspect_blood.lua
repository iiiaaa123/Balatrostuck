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
        loc_vars = function(self, info_queue)
            return {
                vars = {
                    (G.GAME.BALATROSTUCK.aspect_levels[self.name] or 0)+1
                }
            }
        end,
        use = function(self, card, area, copier)
            sendInfoMessage("Setting slab")
            add_slab(Slab('slab_bstuck_blood'))
            -- do more slab logic
            G.GAME.BALATROSTUCK.aspect_levels[self.name] = (G.GAME.BALATROSTUCK.aspect_levels[self.name] or 0) + 1
            sendInfoMessage(self.name..": "..G.GAME.BALATROSTUCK.aspect_levels[self.name])
        end,
        can_use = function(self)
            return true
        end
    }

    Balatrostuck.Slab{
        key = 'blood',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 2,
            y = 2
        },
        config = { discards_used = 0 },
        name = 'Aspect of Blood',
        apply = function(self, slab, context)
            if context.pre_discard then
                local to_discard = math.min(#context.full_hand, G.GAME.BALATROSTUCK.aspect_levels['Blood'] - slab.ability.discards_used)
                for i = 1, to_discard do
                    local enhancement = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed('slab_bstuck_blood'))
                    if enhancement.key and G.P_CENTERS[enhancement.key] then
                        context.full_hand[i]:set_ability(G.P_CENTERS[enhancement.key])
                        slab.ability.discards_used = slab.ability.discards_used + 1
                    end
                end
            end

            if context.end_of_round then
                slab.ability.discards_used = 0
            end
        end
    }

    --Balatrostuck.Slab{key='blood', atlas='HomestuckAspectSlabs', pos={x=2,y=2}}
end