function Balatrostuck.INIT.Jokers.j_vasterror()
    SMODS.Joker{
        name = "Twelve by Twelve",
        key = "vasterror",
        config = {
            extra = {
                rolls_needed = 6,
                rolls = 0,
                valid_cards = {}
            }
        },
        loc_txt = {
            ['name'] = 'Twelve by Twelve',
            ['text'] = {
                [1] = "Every {C:green}#1# rerolls{} in the shop, add",
                [2] = "{C:paradox}Paradox{} edition and a {C:blue}Blue Seal{} to",
                [3] = "two {C:attention}random{} playing cards in {C:attention}deck",
                [4] = "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1# rerolls)"
            }
        },
        pos = {
            x = 8,
            y = 2
         },
        cost = 6,
        rarity = 2,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            info_queue[#info_queue + 1] = {key = 'blue_seal', set = 'Other'}
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.rolls_needed, card.ability.extra.rolls}}
        end,

        calculate = function(self, card, context)
            if context.reroll_shop and not context.blueprint then
                card.ability.extra.rolls = card.ability.extra.rolls + 1
                if card.ability.extra.rolls >= card.ability.extra.rolls_needed then
                    -- First hit
                    card.ability.extra.valid_cards = {}
                    for k, v in pairs(G.deck.cards) do
                        if not v.edition then
                            card.ability.extra.valid_cards[#card.ability.extra.valid_cards+1] = v
                        end
                    end

                    if card.ability.extra.valid_cards[1] then
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Paradox-ify!',colour = G.C.GREEN, card = card})
                        card.ability.extra.rolls = 0
                        local _card = pseudorandom_element(card.ability.extra.valid_cards,pseudoseed("arcjetted"))
                        _card:set_edition("e_bstuck_paradox",true)
                        _card:set_seal("Blue")
                    else
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Miss!',colour = G.C.JOKER_GREY, card = card})
                        card.ability.extra.rolls = 0
                    end
                -- Second hit
                    card.ability.extra.valid_cards = {}
                    for k, v in pairs(G.deck.cards) do
                        if not v.edition then
                            card.ability.extra.valid_cards[#card.ability.extra.valid_cards+1] = v
                        end
                    end

                    if card.ability.extra.valid_cards[1] then
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Paradox-ify!',colour = G.C.GREEN, card = card})
                        card.ability.extra.rolls = 0
                        local _card = pseudorandom_element(card.ability.extra.valid_cards,pseudoseed("arcjetted"))
                        _card:set_edition("e_bstuck_paradox",true)
                        _card:set_seal("Blue")
                    else
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Miss!',colour = G.C.JOKER_GREY, card = card})
                        card.ability.extra.rolls = 0
                    end
                end
            end
        end
    }
end 