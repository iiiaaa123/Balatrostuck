function Balatrostuck.INIT.Jokers.j_pairing_grid() 
    SMODS.Joker{
        name = "Pairing Grid",
        key = "pairing_grid",
        config = {
            extra = {
                mult = 4,
                big_mult = 20
            }
        },
        loc_txt = {
            ['name'] = "Pairing Grid",
            ['text'] = {
                [1] = '{C:mult}+#1#{} Mult for each {C:attention}unique',
                [2] = '{C:attention}suit{} in scoring hand, or',
                [3] = '{C:mult}+#2#{} Mult if {C:attention}all four suits'
            }
        },
        pos = {
            x = 9,
            y = 3
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.mult, card.ability.extra.big_mult}}
        end,

        calculate = function (self, card, context)
            if context.cardarea == G.jokers and context.joker_main then
                local suits = {
                    ['Hearts'] = 0,
                    ['Diamonds'] = 0,
                    ['Spades'] = 0,
                    ['Clubs'] = 0
                }
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i].ability.name ~= 'Wild Card' then
                        if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                        elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                        elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                        elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                    end
                end
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i].ability.name == 'Wild Card' then
                        if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                        elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                        elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                        elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                    end
                end
                local thunk = 0
                if suits["Hearts"] == 1 then
                    thunk = thunk + 1
                end
                if suits["Diamonds"] == 1 then
                    thunk = thunk + 1
                end
                if suits["Spades"] == 1 then
                    thunk = thunk + 1
                end
                if suits["Clubs"] == 1 then
                    thunk = thunk + 1
                end
                if thunk == 0 then
                
                elseif thunk >= 4 then
                    return{
                        message = localize{type='variable',key='a_mult',vars={card.ability.extra.big_mult}},
                        mult_mod = card.ability.extra.big_mult
                    }
                else 
                    return{
                        message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult*thunk}},
                        mult_mod = card.ability.extra.mult*thunk
                    }
                end
            end
        end
    }
end