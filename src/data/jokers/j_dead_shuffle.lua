-- DONE: This joker doesn't need any more work unless something comes up
function Balatrostuck.INIT.Jokers.j_dead_shuffle()
    SMODS.Joker{
        name = "Dead Shuffle",
        key = "dead_shuffle",
        config = {
            extra = {
                xmult = 1.5,
                suit = "Spades",
                total = 1
            }
        },
        loc_txt = {
            ['name'] = 'Dead Shuffle',
            ['text'] = {
                [1] = 'This Joker gains {X:mult,C:white}X#1#{} Mult',
                [2] = 'when each played {C:attention}Ace of #2#{}',
                [3] = 'is scored this round,',
                [4] = 'suit changes every round',
                [5] = '{C:inactive}(Currently: {X:mult,C:white}X#3#{C:inactive} Mult)'
            }
        },
        pos = {
            x = 1,
            y = 2
        },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.xmult, card.ability.extra.suit, card.ability.extra.total}}
        end,
        calculate = function(self, card, context)
            if context.cardarea == G.jokers and context.joker_main then
                 return {
                     message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.total } },
                     Xmult_mod = card.ability.extra.total,
                     colour = G.C.RED
                 }
            
            elseif context.cardarea == G.play and context.individual and not context.repetition then
                if context.other_card:is_suit(card.ability.extra.suit) and context.other_card:get_id() == 14 then
                    card.ability.extra.total = card.ability.extra.total + card.ability.extra.xmult
                    return {
                        extra = {
                            focus = card,
                            message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.total } },
                            colour = G.C.RED
                        }
                    }
                end
            
            elseif context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
                card.ability.extra.total = 1
                card.ability.extra.suit = pseudorandom_element({'Spades','Hearts','Diamonds','Clubs'}, pseudoseed('deadshuffle'..G.GAME.round_resets.ante))
    
                return {
                    message = localize('k_reset'),
                    colour = G.C.FILTER
                }
            end
        end
    }
end