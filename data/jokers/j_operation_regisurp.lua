function Balatrostuck.INIT.Jokers.j_operation_regisurp()
    SMODS.Joker{
        name = "Operation Regisurp",
        key = "operation_regisurp",
        config = {
            extra = {
                suit = "Spades",
                dollars = 12,
                trash_list = {}
            }
        },
        loc_txt = {
            ['name'] = 'Operation Regisurp',
            ['text'] = {
                [1] = "Played {C:attention}Queens of #1#{} give",
                [2] = "{C:money}$#2#{} when scored and are destroyed "
            }
        },
        pos = {
            x = 8,
            y = 3
        },
        cost = 5,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.suit, card.ability.extra.dollars}}
        end,

        calculate = function(self, card, context)
            if context.before and not context.blueprint then
                card.ability.extra.trash_list = {}
                for i=1, #context.scoring_hand do
                    if context.scoring_hand[i]:get_id() == 12 and context.scoring_hand[i]:is_suit(card.ability.extra.suit) then
                        card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                    end
                end

            elseif context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 and context.other_card:is_suit(card.ability.extra.suit) then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return {
                    dollars = card.ability.extra.dollars,
                    card = card
                }

            elseif context.destroying_card and not context.blueprint then
                for _, v in pairs(card.ability.extra.trash_list) do
                    if v == context.destroying_card then
                        return true
                    end
                end
                return nil                
            end
        end
    }
end