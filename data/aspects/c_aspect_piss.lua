function Balatrostuck.INIT.Aspects.c_aspect_piss()
    Balatrostuck.Aspect{
        key = 'piss',
        name = "Piss",
        loc_txt = {
            name = "Piss",
            text = {
                "When {C:attention}Blind{} is selected,",
                "create {C:attention}#1# {C:paradox}Paradox{C:attention} Jokers",
            }
        },
        pos = {
            x = 6,
            y = 0
        },
        soul_pos = {
            x = 6,
            y = 3
        },
        cost = 4,
        no_collection = true,
        hidden = true,
        soul_set = 'Aspect',  
        soul_rate = 0.013,
        can_repeat_soul = false,
        atlas = "HomestuckAspects",
        use = function(self, card, area, copier)
            self:switch_slab()
        end,
        can_use = function(self)
            return true
        end
    }

    Balatrostuck.Slab{
        key = 'piss',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 0,
            y = 3
        },
        config = { discards_used = 0 },
        name = 'Aspect of Piss',
        apply = function(self, slab, context)
            if context.setting_blind then
                for i=1,  summation(slab:level()+1) do
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = function()
                        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'who')
                        card:set_edition("e_bstuck_paradox", nil)
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:start_materialize()
                        G.GAME.joker_buffer = 0
                        return true
                        end
                    }))
                end
            end
        end
    }

    --Balatrostuck.Slab{key='blood', atlas='HomestuckAspectSlabs', pos={x=2,y=2}}
end




