function Balatrostuck.INIT.Aspects.c_aspect_life()
    Balatrostuck.Aspect{
        key = "life",
        name = "Life",
        loc_txt = {
            name = "Life",
            text = {
                "Add {C:attention}#1#{} random {C:paradox}Paradox{} cards",
                "to hand when round begins,",
                "every {C:paradox}Paradox{} card anywhere",
                "gives {C:money}$#2#{} at end of round",
            }
        },
        pos = {
            x = 5,
            y = 0
        },
        soul_pos = {
            x = 5,
            y = 2
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        use = function(self, context)
            self:switch_slab()
        end,
        can_use = function(self)
            return true
        end,
    }



    Balatrostuck.Slab{
        key = 'life',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 0,
            y = 2
        },
        config = {payout = 0},
        name = 'Aspect of Life',
        apply = function(self, slab, context) 
            if context.setting_blind then
                for i=1, slab:level()*2 do
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local _card = SMODS.create_card({set = 'Base'})
                            _card:start_materialize({G.C.PARADOX},firstmat)
                            firstmat = true
                            _card:set_edition('e_bstuck_paradox',true,true)
                            G.hand:emplace(_card)
                            G.GAME.blind:debuff_card(_card)
                            G.hand:sort()
                            -- G.deck.config.card_limit = G.deck.config.card_limit + 1
                            delay(0.1)
                            return true
                        end}))
                    playing_card_joker_effects({_card})
                end
            end
        end
    }
end
