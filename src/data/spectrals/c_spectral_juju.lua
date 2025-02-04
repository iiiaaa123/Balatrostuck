function Balatrostuck.INIT.Spectrals.c_spectral_thetreasure()
    SMODS.Consumable {
        key = 'thetreasure',
        name = 'The Treasure',
        set = 'Spectral',
        loc_txt = {
            name = 'The Treasure',
            text = {
                [1] = 'All Aspects gain 1 permanent level',
                [2] = '-1 joker slot',
                [3] = 'Art by Lyman'
            }
        },
        pos = {
            x = 0,
            y = 0
        },
        atlas = 'HomestuckSpectrals',
        can_use = function(self,card)
            -- checks if you have at least 1 joker slot to remove
            if G.jokers.config.card_limit > 0 then return true end
        end,
        use = function(self, card, area, copier)
            local deletable_jokers = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
            end
            if #deletable_jokers > 0 then
                local chosen_joker = pseudorandom_element(deletable_jokers, pseudoseed('ankh_choice'))
                chosen_joker:start_dissolve(nil,true)
            end
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1

            local thisbetterfuckingwork = {'Time','Space','Heart','Hope','Rage','Light','Void','Mind','Doom','Life','Blood','Breath','Piss'}
            for k,v in pairs(thisbetterfuckingwork) do
                G.GAME.BALATROSTUCK.aspect_levels[v] = G.GAME.BALATROSTUCK.aspect_levels[v] + 1
            end
        end
    }
end