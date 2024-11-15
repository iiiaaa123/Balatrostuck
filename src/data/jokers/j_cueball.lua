function Balatrostuck.INIT.Jokers.j_cueball()
    SMODS.Joker{
        name = "Magic Cue Ball",
        key = "cueball",
        config = {
            extra = {
                card1 = "Nothing",
                card2 = "Nothing",
                card3 = "Nothing",
            }
        },
        loc_txt = {
            ['name'] = 'Magic Cue Ball',
            ['text'] = {
                [1] = 'Next cards are',
                [2] = '{C:attention}#1#{},',
                [3] = '{C:attention}#2#{}, and',
                [4] = '{C:attention}#3#{}',
                [5] = '{C:white}(suckers.){C:green}1 in 1000{}{C:white}chance to',
                [6] = '{C:white}destroy all jokers'
            }
        },
        pos = {
            x = 1,
            y = 6
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            local get_card_name = function(card)
                if card then
                    local rank = card.base.value
                    local suit = card.base.suit
        
                    if card.ability.effect ~= 'Stone Card' then
                        return localize(rank, 'ranks') .. " of " .. localize(suit, "suits_plural")
                    else
                        return "Stone"
                    end
                end
            end
    
                if G.deck and G.deck.cards then
                    local index, cards
                    cards = {}
                    index = #G.deck.cards
                    for k, card in ipairs(G.deck.cards) do
                        if k == index then
                            cards[1] = card
                        end
                        if k == index - 1 then
                            cards[2] = card
                        end
                        if k == index - 2 then
                            cards[3] = card
                        end
                    end
                    
                    if #cards > 0 then
                        card.ability.extra.card1 = get_card_name(cards[1])
                    else
                        card.ability.extra.card1 = "Nothing"
                    end
                    
                    if #cards > 1 then
                        card.ability.extra.card2 = get_card_name(cards[2])
                    else
                        card.ability.extra.card2 = "Nothing"
                    end
                    
                    if #cards > 2 then
                        card.ability.extra.card3 = get_card_name(cards[3])
                    else
                        card.ability.extra.card3 = "Nothing"
                    end
                end
    
            --card.calculate_joker({generate_ui = true})
            return {vars = {card.ability.extra.card1, card.ability.extra.card2, card.ability.extra.card3}}
        end
    }:register()
end