function Balatrostuck.INIT.Spectrals.c_spectral_lotuscapsule()
    SMODS.Consumable {
        key = 'lotuscapsule',
        name = 'Lotus Capsule',
        set = 'Spectral',
        loc_txt = {
            name = 'Lotus Capsule',
            text = {
                [1] = 'Add a Felt Seal to',
                [2] = '1 selected card'
            }
        },
        pos = {
            x = 1,
            y = 0
        },
        atlas = 'HomestuckSpectrals',
        can_use = function(self,card)
            return #G.hand.highlighted == 1
        end,
        loc_vars = function(self, info_queue, card) 
            info_queue[#info_queue + 1] = G.P_SEALS['bstuck_felt']
        end,
        use = function(self, card, area, copier)
            local conv_card = G.hand.highlighted[1]
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                conv_card:set_seal('bstuck_felt', nil, true)
                return true end }))
            
            delay(0.5)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        end
    }
end