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
        soul_rate = 0.0013,
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


-- PISS BLACKLIST FOR LATER
-- j_credit_card, j_ceremonial, j_marble, j_loyalty_card,j_chaos, j_egg, j_burglar, j_madness, j_red_card, j_riff_raff, j_cloud_9, j_rocket, j_gift, j_to_the_moon, j_hallucination, j_golden, j_merry_andy, j_invisible, j_satellite, j_cartomancer, j_astronomer, j_merry_andy, j_burglar, j_runner, j_constellation, j_green_joker, j_square, j_hologram, j_obelisk, j_lucky_cat, j_glass, j_wee, 