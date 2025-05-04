function Balatrostuck.INIT.Aspects.c_aspect_blood()
    Balatrostuck.Aspect{
        key = 'blood',
        name = "Blood",
        loc_txt = {
            ['name'] = "Blood",
            ['text'] = {
                [1] = "", -- "{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
                [2] = 'First {C:attention}#1#{} cards discarded', 
                [3] = "each round get a random",
                [4] = '{C:purple}enhancement',
                [5] = '{C:inactive}(Currently {C:attention}#2#{C:inactive} cards)'
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
            art_credit2('akai', 'yokcos', info_queue)
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
                if G.GAME.BALATROSTUCK.blood_discards < slab:level() + 1 then
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
                        G.GAME.BALATROSTUCK.blood_discards = G.GAME.BALATROSTUCK.blood_discards + 1
                    end
                end
            end

            if context.end_of_round then
                G.GAME.BALATROSTUCK.blood_discards = 0
            end
        end
    }

    --Balatrostuck.Slab{key='blood', atlas='HomestuckAspectSlabs', pos={x=2,y=2}}
end