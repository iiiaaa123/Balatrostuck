function Balatrostuck.INIT.Aspects.c_aspect_life()
    Balatrostuck.Aspect{
        key = "life",
        name = "Life",
        loc_txt = {
            ['name'] = "Life",
            ['text'] = {
                [1] = "", -- "{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
                [2] = "Add {C:attention}#2#{} random {C:green}Paradox{} cards",
                [3] = "to hand when round begins,",
                [4] = "every {C:green}Paradox{} card anywhere",
                [5] = "gives {C:money}$#3#{} at end of round",
                [6] = "{C:inactive}(Currently {C:green}+#4#}{C:inactive} and {C:money}$#5#{C:inactive})"
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
        end
    }



    Balatrostuck.Slab{
        key = 'life',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 0,
            y = 0
        },
        config = {payout = 0},
        name = 'Aspect of Life',
        apply = function(self, slab, context) 
            if context.setting_blind then
                for i=1, slab:level()+1 do
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
