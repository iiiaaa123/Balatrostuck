function Balatrostuck.INIT.Aspects.c_aspect_blood()
    Balatrostuck.Aspect{
        key = 'blood',
        name = "Blood",
        loc_txt = {
            ['name'] = "Blood",
            ['text'] = {
                [1] = '{E:1,S:1.2}(lvl. #2#){} Up to #1# {C:red}discarded',
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
                    self:level() + 1,
                    self:level()
                }
            }
        end,
        use = function(self, card, area, copier)
            self:switch_slab()
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
            if context.discard then
                if slab.ability.discards_used < slab:level() + 1 then
                    local enhancement = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed('slab_bstuck_blood'))
                    if enhancement.key and G.P_CENTERS[enhancement.key] then
                        sendInfoMessage("Enhancing")
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.9375,
                            func = function()
                                card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = "Enhanced!", colour = G.C.SET.Enhanced, instant = true})
                                context.other_card:set_ability(G.P_CENTERS[enhancement.key])
                                return true
                        end}))
                        slab.ability.discards_used = slab.ability.discards_used + 1
                    end
                end
            end

            if context.end_of_round then
                slab.ability.discards_used = 0
            end
        end,
        generate_ui = function(self, slab, info_queue, card, desc_nodes, specific_vars, full_UI_table)
            
        end
    }

    --Balatrostuck.Slab{key='blood', atlas='HomestuckAspectSlabs', pos={x=2,y=2}}
end