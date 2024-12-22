function Balatrostuck.INIT.Jokers.j_purrfectwarrior()
    SMODS.Joker{
        name = "Purrfect Warrior",
        key = "purrfectwarrior",
        config = {
            extra = {
                h_gain = 1,
                levels = 5,
                h_plays = 0
            }
        },
        loc_txt = {
            ['name'] = 'Purrfect Warrior',
            ['text'] = {
                [1] = 'Gain {C:blue}+#1#{} hand for each',
                [2] = '{C:attention}#2#{} Hand Levels you have',
                [3] = '{C:inactive}(Currently {C:blue}+#3#{C:inactive} Hands)'
            }
        },
        pos = {
            x = 5,
            y = 9
        },
        cost = 10,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.h_gain, card.ability.extra.levels, card.ability.extra.h_plays}}
        end,


        add_to_deck = function(self, card, from_debuff)
            card.ability.extra.h_plays = math.floor(math.max((sum_levels()-12)/5,0))
            if card.ability.extra.h_plays > 0 then
                ease_hands_played(card.ability.extra.h_plays)
            end
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.h_plays
        end,        
    
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.h_plays
        end,

        calculate = function(self, card, context)
            if context.bstuck_level_up_hand and not context.blueprint then
                print("mreow B33")
                if math.floor(math.max((sum_levels()-12)/5,0)) > card.ability.extra.h_plays then
                    local thunk = math.floor(math.max((sum_levels()-12)/5,0)) - card.ability.extra.h_plays
                    G.GAME.round_resets.hands = G.GAME.round_resets.hands + thunk
                    ease_hands_played(thunk)
                    card.ability.extra.h_plays = math.floor(math.max((sum_levels()-12)/5,0))
                end
            end
        end
    }
    
    
end