function Balatrostuck.INIT.Seals.seal_felt()
    SMODS.Seal{
        key = 'felt',
        config = {extra = {drawn = true}},
        loc_txt = {
            name = 'Felt Seal',
            label = 'Felt Seal',
            text = {
                'When drawn create a {C:paradox}Paradox',
                'copy of this card without this seal'
            }
        },
        badge_colour = HEX('70E05F'),
        atlas = 'HomestuckSeals',
        pos = {x=0,y=0},
        calculate = function(self,card,context)
            if context.hand_drawn and context.cardarea == G.hand then
                if card.ability.seal.extra.drawn == false then
                    card.ability.seal.extra.drawn = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local _card = copy_card(card, nil, nil, G.playing_card)
                            _card:set_edition('e_bstuck_paradox',true,true)
                            _card:add_to_deck()
                            _card:set_seal(nil,true,true)
                            table.insert(G.playing_cards, _card)
                            G.hand:emplace(_card)
                            _card:start_materialize(nil, false)
                            playing_card_joker_effects({_card})
                            return true
                        end
                    }))
                end
            end

            if context.setting_blind then
                card.ability.seal.extra.drawn = false
            end
        end
    }
end