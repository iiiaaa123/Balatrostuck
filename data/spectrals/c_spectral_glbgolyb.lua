function Balatrostuck.INIT.Spectrals.c_spectral_glbgolyb()
    SMODS.Consumable {
        key = 'glbgolyb',
        name = "Gl'bgolyb",
        set = 'Spectral',
        loc_txt = {
            name = "Gl'bgolyb",
            text = {
                'Add a {C:dark_edition}Lusus Seal{}',
                'to {C:attention}1{} selected',
                'card in your hand'
            }
        },
        pos = {
            x = 1,
            y = 1
        },
        loc_vars = function (self, info_queue, card) 
            art_credit('akai', info_queue)
        end,
        atlas = 'HomestuckSpectrals',
        can_use = function(self,card)
            return #G.hand.cards > 1
        end,
        use = function(self, card, area, copier)
            local conv_card = G.hand.highlighted[1]
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                conv_card:set_seal('bstuck_lusus', nil, true)
                return true end }))
            
            delay(0.5)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        end
    }
end