
function Balatrostuck.INIT.Jokers.j_consortconcierge()
    SMODS.Joker{
        name = "Consort Concierge",
        key = "consortconcierge",
        config = {
            extra = {
                h_size = 0
            }
        },
        loc_txt = {
            ['name'] = 'Consort Concierge',
            ['text'] = {
                [1] = '{C:attention}+1 hand size{} each ',
                [2] = 'hand played, up to {C:attention}4',
                [3] = 'Resets at end of round',
                [4] = '{C:inactive}(Currently: {C:attention}+#1#{}{C:inactive})'
            }
        },
        pos = {
            x = 0,
            y = 10
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.h_size}}
        end,

        remove_from_deck = function(self, card, from_debuff)
            G.hand:change_size(-card.ability.extra.h_size)
        end,

        calculate = function(self, card, context)
            if context.joker_main and context.cardarea == G.jokers and context.scoring_hand and card.ability.extra.h_size < 4 then
                card.ability.extra.h_size = card.ability.extra.h_size + 1,
                G.hand:change_size(1)
                    
            elseif context.end_of_round and not (context.repetition or context.individual or context.blueprint) then
                G.hand:change_size(-card.ability.extra.h_size)
                card.ability.extra.h_size = 0
        end  
        
    end
    }
end