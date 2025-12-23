function Balatrostuck.INIT.Jokers.j_frogsprite()
    SMODS.Joker{
        name = "fr0gsprite",
        key = "frogsprite",
        config = {
            extra = { 
                hands = 5
            }
        },
        loc_txt = {
            ['name'] = 'fr0gsprite',
            ['text'] = {
                "{C:attention}+#1#{} {C:blue}hands{} each round",
                "reduces by {C:red}1{} every round"
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
        if context.setting_blind then
            ease_hands_played(card.ability.extra.hands)
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "ribbit"})
        end
        if context.end_of_round and not context.blueprint and not context.repetition and not context.blueprint and not context.individual  then
            if card.ability.extra.hands <= 1 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "0_0"})
                SMODS.destroy_cards(card, nil, nil, true)
            
            else
                card.ability.extra.hands = card.ability.extra.hands - 1
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "0_0"})
            end
        end
        end,
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.hands}}
        end,
    }
end 