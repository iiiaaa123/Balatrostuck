function Balatrostuck.INIT.Jokers.j_vasterror()
    SMODS.Joker{
        name = "Twelve by Twelve",
        key = "vasterror",
        config = {
            extra = {
                rolls_needed = 7,
                rolls = 0
            }
        },
        loc_txt = {
            ['name'] = 'Twelve by Twelve',
            ['text'] = {
                [1] = "Every {C:green}#1# rerolls{}, a random",
                [2] = "card in {C:attention}deck{} gains a {C:attention}Blue Seal",
                [3] = "and becomes {C:green}Paradox",
                [4] = "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 6,
        rarity = 2,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.rolls_needed, card.ability.extra.rolls}}
        end,

        calculate = function(self, card, context)
            if context.reroll_shop and not context.blueprint then

                if card.ability.extra.rolls >= card.ability.extra.rolls_needed then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Paradox-ify!',colour = G.C.GREEN, card = card})
                    if not context.blueprint then
                        card.ability.extra.rolls = 0
                    end
                    local _card = pseudorandom_element(G.deck.cards,pseudoseed("arcjetted"))
                    _card:set_edition("e_bstuck_paradox",true)
                    _card:set_seal("Blue")
                end
            end
        end
    }
end 