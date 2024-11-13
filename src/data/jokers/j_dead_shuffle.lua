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
                [1] = 'Gains {X:mult,C:white}X#1#{} Mult per',
                [2] = 'scoring {C:attention}Ace of #2#{}',
                [3] = '{C:inactive}Suit changes every round{}',
                [4] = '{C:inactive}Resets every round{}',
                [5] = '{C:inactive}(Currently: {X:mult,C:white}X#3#{} Mult{C:inactive}){}{}'
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
        loc_def = function(card)
            return {card.ability.extra.xmult, card.ability.extra.suit, card.ability.extra.total}
        end,
        calculate = function(self, context)
            if context.cardarea == G.jokers and context.joker_main then
                 return {
                     message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.total } },
                     Xmult_mod = self.ability.extra.total,
                     colour = G.C.RED
                 }
            
            elseif context.cardarea == G.play and context.individual and not context.repetition then
                if context.other_card:is_suit(self.ability.extra.suit) and context.other_card:get_id() == 14 then
                    self.ability.extra.total = self.ability.extra.total + self.ability.extra.xmult
                    return {
                        extra = {
                            focus = self,
                            message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.total } },
                            colour = G.C.RED
                        }
                    }
                end
            
            elseif context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
                self.ability.extra.total = 1
                self.ability.extra.suit = pseudorandom_element({'Spades','Hearts','Diamonds','Clubs'}, pseudoseed('deadshuffle'))
    
                return {
                    message = localize('k_reset'),
                    colour = G.C.FILTER
                }
            end
        end
    }:register()
end