function Balatrostuck.INIT.Spectrals.c_spectral_13ofstars()
    SMODS.Consumable {
        key = '13ofstars',
        name = '13 of Stars',
        set = 'Spectral',
        loc_txt = {
            name = '13 of Stars',
            text = {
                [1] = 'Summons Biscuits',
                [2] = '[Must have room]'
            }
        },
        pos = {
            x = 0,
            y = 1
        },
        atlas = 'HomestuckSpectrals',
        hidden = true,
        soul_set = 'Enhanced',
        soul_rate = 0.003,
        can_repeat_soul = false,
        loc_vars = function(self, info_queue, card) 
            info_queue[#info_queue + 1] = G.P_CENTERS['j_bstuck_biscuits']
        end,
        can_use = function(self,card)
            return #G.jokers.cards < G.jokers.config.card_limit
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
            return true end }))
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('timpani')
                    SMODS.add_card({set = 'Joker',no_edition = true, key = 'j_bstuck_biscuits'})
                    return true
            end}))
        end
    }
end