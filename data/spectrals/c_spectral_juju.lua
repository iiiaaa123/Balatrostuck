function Balatrostuck.INIT.Spectrals.c_spectral_thetreasure()
    SMODS.Consumable {
        key = 'thetreasure',
        name = 'The Treasure',
        set = 'Spectral',
        loc_txt = {
            name = 'The Treasure',
            text = {
                [1] = 'Gain 1 {C:aspect}Aspects{} level',
                [2] = '{C:aspect}Aspects{} start with +1 level',
                [3] = 'Permanently {C:red}-1{} Joker slots',
                [4] = '{C:inactive}Does not grant you an',
                [5] = '{C:inactive}Aspect if you dont have one'

            }
        },
        pos = {
            x = 0,
            y = 0
        },

        loc_vars = function (self, info_queue, card) 
            art_credit('lyman', info_queue)
        end,
        atlas = 'HomestuckSpectrals',
        can_use = function(self,card)
            return #G.jokers.cards < G.jokers.config.card_limit
        end,
        use = function(self, card, area, copier)
            --G.jokers.config.card_limit = G.jokers.config.card_limit - 1
            G.jokers:change_size(-1)
            local thisbetterfuckingwork = {'Time','Space','Heart','Hope','Rage','Light','Void','Mind','Doom','Life','Blood','Breath','Piss'}
            for k,v in pairs(thisbetterfuckingwork) do
                G.GAME.BALATROSTUCK.aspect_levels[v] = G.GAME.BALATROSTUCK.aspect_levels[v] + 1
            end
            delay(1)
            G.E_MANAGER:add_event(Event({
                delay = 1, func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    if G.GAME.slab then
                        G.ui_slab:juice_up()
                        play_sound('chips1', math.random()*0.1 + 0.55, 0.42)
                        G.GAME.slab:calculate({ activated = true, old_slab = G.GAME.slab, after_level_up = true, returning = false},true)
                    end

                    play_sound('bstuck_HomestuckAscendAll',0.7,0.5)
                    return true
                end
            }))
            delay(1)
        end
    }
end