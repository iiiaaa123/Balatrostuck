function Balatrostuck.INIT.Jokers.j_nepetajoker()
    SMODS.Joker{
        name = "nepetajoker",
        key = "nepetajoker",
        config = {
            extra = {mult = 2, mult_gain = 0, suit_a = 'Spades', suit_b = 'Hearts'}
        },
        loc_txt = {
            ['name'] = 'Rogue Matchmaker',
            ['text'] = {
                "This Joker gains {C:mult}+#1#{} Mult if",
                "played hand contains a scoring",
                "{V:1}#3#{} and {V:2}#4#{} card",
                "{s:0.8}Suits change every round{}",
                "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
            }
        },
        pos = {
            x = 7,
            y = 2
         },
        loc_vars = function(self,info_queue,card)
            art_credit('lyman', info_queue)
            return {vars = {card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.suit_a, card.ability.extra.suit_b, 
                    colours = {G.C.SUITS[card.ability.extra.suit_a],G.C.SUITS[card.ability.extra.suit_b]}}}
        end,
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.before then
                local bucketOfSlop = {false,false}
                for c = 1, #context.scoring_hand do
                    if context.scoring_hand[c]:is_suit(card.ability.extra.suit_a) then
                        bucketOfSlop[1] = true
                    elseif context.scoring_hand[c]:is_suit(card.ability.extra.suit_b) then
                        bucketOfSlop[2] = true
                    end
                end
                if bucketOfSlop[1] and bucketOfSlop[2] then
                    card.ability.extra.mult_gain = card.ability.extra.mult_gain + card.ability.extra.mult
                    return {
                        message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                        colour = G.C.MULT,
                        card = card 
                    }
                end
            end

            if context.end_of_round then
                local suits = {'Spades','Hearts','Diamonds','Clubs'}
                local chosen_suits = {}
                chosen_suits[1] = pseudorandom_element(suits,pseudoseed(':33'))
                for i=1, #suits do
                    if suits[i] == chosen_suits[1] then
                        table.remove(suits,i)
                        break
                    end
                end
                chosen_suits[2] = pseudorandom_element(suits,pseudoseed(':33'))

                card.ability.extra.suit_a = chosen_suits[1]
                card.ability.extra.suit_b = chosen_suits[2]
            end

            if context.joker_main then
                return {
                    mult = card.ability.extra.mult_gain,
                    card = card
                }
            end
        end
    }
end 
