function Balatrostuck.INIT.Jokers.j_captchacard()
    SMODS.Joker{
        name = "Captchalogue Card",
        key = "captchacard",
        config = {
            extra = {
                rank = 10,
                displayed_rank = 10,
                suit = "Hearts"
            }
        },
        loc_txt = {
            ['name'] = 'Captchalogue Card',
            ['text'] = {
                [1] = "Create a random {C:attention}consumable",
                [2] = "for each scoring {C:attention}#1#{} of {V:1}#2#",
                [3] = "in played hand"
            }
        },
        loc_vars = function(self,info_queue,card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.displayed_rank, card.ability.extra.suit, colours = {G.C.SUITS[card.ability.extra.suit]}}}
        end,
        pos = {
            x = 5,
            y = 0
        },
        cost = 3,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.end_of_round then
                local suits = {'Hearts','Diamonds','Clubs','Spades'}
                card.ability.extra.rank = pseudorandom('Captcha',2,14)
                card.ability.extra.suit = pseudorandom_element(suits,pseudoseed('Captcha'))
                if card.ability.extra.rank == 11 then
                    card.ability.extra.displayed_rank = 'Jack'
                elseif card.ability.extra.rank == 12 then
                    card.ability.extra.displayed_rank = 'Queen'
                elseif card.ability.extra.rank == 13 then
                    card.ability.extra.displayed_rank = 'King'
                elseif card.ability.extra.rank == 14 then
                    card.ability.extra.displayed_rank = 'Ace'
                else
                    card.ability.extra.displayed_rank = card.ability.extra.rank
                end
            end

            if context.individual and context.cardarea == G.play then
                if context.other_card:get_id() == card.ability.extra.rank and context.other_card:is_suit(card.ability.extra.suit) and
                #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    return {
                        extra = {focus = card, message = '+1 Consumable!', func = function()
                            local chosen_set = 'Planet'
                            local rando = pseudorandom('Captcha',1,100)

                            if rando >= 90 then
                                chosen_set = 'Spectral'
                            elseif rando >= 60 then 
                                chosen_set = 'Zodiac'
                            elseif rando >= 30 then
                                chosen_set = 'Tarot'
                            else
                                chosen_set = 'Planet'
                            end

                            G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.0,
                                func = (function()
                                        local edible = SMODS.create_card({set = chosen_set})
                                        edible:add_to_deck()
                                        G.consumeables:emplace(edible)
                                        G.GAME.consumeable_buffer = 0
                                    return true
                                end)}))
                        end},
                        colour = G.C.SECONDARY_SET.Tarot,
                        card = card
                    }
                end  
            end
        end
    }
end