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
            return true
        end,
        use = function(self, card, area, copier)

            -- flips cards
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true end }))
            for i=1, #G.hand.cards do
                local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('card1', percent);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
            end
            delay(0.2)

            -- does the actual scratching
            for i=1, #G.hand.cards do
                G.E_MANAGER:add_event(Event({func = function()
                    local _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('scratch'))
                    local _rank = pseudorandom_element({'2','3','4','5','6','7','8','9','T','J','Q','K','A'}, pseudoseed('scratch'))
                    local card = G.hand.cards[i]
                    card:set_base(G.P_CARDS[_suit..'_'.._rank])
                return true end }))
            end

            -- adds enhancements
            for i=1, #G.hand.cards do
                local FUCKINGWORKALREADY = SMODS.poll_enhancement({guaranteed = true})
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.cards[i]:set_ability(G.P_CENTERS[FUCKINGWORKALREADY]);return true end }))
            end 

            -- unflips cards
            for i=1, #G.hand.cards do
                local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
            end
            delay(0.5)
        end
    }
end