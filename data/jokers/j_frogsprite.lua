function Balatrostuck.INIT.Jokers.j_frogsprite()
    SMODS.Joker{
        name = "fr0gsprite",
        key = "frogsprite",
        config = {
            extra = { 
                depth = 15
            }
        },
        loc_txt = {
            ['name'] = 'fr0gsprite',
            ['text'] = {
                [1] = "When round begins, shuffle 2",
                [2] = "{C:attention}Steel {C:paradox}Paradox Aces{}",
                [3] = "in the bottom #1# cards of your deck"
            }
        },
        pos = {
            x = 9,
            y = 12
        },

        
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
        if context.first_hand_drawn then
                local firstmat = nil
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                        for i=1,2 do 
                            local _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('fr0g'..i))
                            local _card = create_playing_card({front = G.P_CARDS[_suit..'_A'], center = G.P_CENTERS.m_steel}, nil, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                            local _valid_positions = {}
                            for i=1,math.min(self.config.extra.depth,G.deck.config.card_limit) do
                                table.insert(_valid_positions,i)
                            end
                            local _pos = pseudorandom_element(_valid_positions, pseudoseed('fr0g'..i))
                            _card:set_edition('e_bstuck_paradox',true,true)
                            table.insert(G.deck.cards, _pos, _card)
                            G.deck.config.card_limit = #G.deck.cards
                            _card:set_card_area(G.deck)
                            G.deck:set_ranks()
                            G.deck:align_cards()
                            _card:add_to_deck()
                            playing_card_joker_effects({_card})
                        end
                        if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
                            -- G.deck.config.card_limit = G.deck.config.card_limit + 1
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "ribbit", colour = G.C.PARADOX})
                        delay(0.1)
                        return true
                    end}))
                    
            end
        end,
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {self.config.extra.depth}}
        end,
    }
end 