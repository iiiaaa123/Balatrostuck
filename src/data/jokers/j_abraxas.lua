function Balatrostuck.INIT.Jokers.j_abraxas()
    SMODS.Joker{
        name = "Abraxas",
        key = "abraxas",
        config = {
            extra = {
                h_plays = 3,
                h_size = 3
            }
        },
        loc_txt = {
            ['name'] = 'Abraxas',
            ['text'] = {
                [1] = '{C:blue}+#1#{} hands',
                [2] = '{C:attention}+#2# hand size'
            }
        },
        pos = {
            x = 1,
            y = 9
        },
        cost = 20,
        rarity = 4,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        soul_pos = {
            x = 6,
            y = 9
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.h_plays, card.ability.extra.h_size}}
        end,


        add_to_deck = function(self, card, from_debuff)
            G.hand:change_size(card.ability.extra.h_size)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.h_plays
        end,
    
        remove_from_deck = function(self, card, from_debuff)
            G.hand:change_size(-card.ability.extra.h_size)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.h_plays
        end
    }
    
    
end