function Balatrostuck.INIT.Jokers.j_vodkamutini()
    SMODS.Joker{
        name = "Vodka Mutini",
        key = "vodkamutini",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Vodka Mutini',
            ['text'] = {
                [1] = "When a paradox card is created",
                [2] = "create a non-paradox copy of it."
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calculate = function(self,card,context)
            -- not finished until meow sound is added
            if context.paradox_created then
                local _card = G.GAME.BALATROSTUCK.last_paradox_created
                local pCard = {}

                if _card.config.center.consumeable then 
                    if G.consumeables.config.card_limit - #G.consumeables.cards > 0 then
                        pCard = copy_card(_card, nil, nil, nil, true)
                        pCard:add_to_deck()    
                        G.consumeables:emplace(pCard) 
                        pCard:juice_up(0.3, 0.5)
                    end
                elseif _card.config.center.set == "Joker" then 
                    if G.jokers.config.card_limit - #G.jokers.cards > 0 then
                        if _card.config.center.key ~= "j_bstuck_vodkamutini" then
                            pCard = copy_card(_card, nil, nil, true, true)
                            pCard:add_to_deck()
                            G.jokers:emplace(pCard)
                            pCard:juice_up(0.3, 0.5)
                        end
                    end
                else 
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
                    pCard = copy_card(_card, nil, nil, G.playing_card, true)
                    pCard:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, pCard)
                    G.hand:emplace(pCard)
                    --[[
                    if G.STATE == 999 then --this is stupid, if something is breaking here this is the first thing you should change
                        G.deck:emplace(pCard)
                    else
                        G.hand:emplace(pCard)
                    end
                    ]]
                    pCard:juice_up(0.3, 0.5)
                    return true end }))
                end

            end
        end
    }
end 