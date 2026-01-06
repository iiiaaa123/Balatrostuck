function Balatrostuck.INIT.Jokers.j_eggs()
    SMODS.Joker{
        name = "Eggs",
        key = "eggs",
        config = {
            extra = { 
            }
        },
        loc_txt = {
            ['name'] = 'Eggs',
            ['text'] = {
                [1] = "Enables",
                [2] = "savestating"
            }
        },
        pos = {
            x = 11,
            y = 3
        },
        soul_pos = {
            x = 11,
            y = 6
        },
        
        cost = 6,
        rarity = "bstuck_felt",
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.setting_blind then
                ease_hands_played(1-G.GAME.current_round.hands_left)
                ease_discard(-G.GAME.current_round.discards_left, nil, true)
            end
        end,
        add_to_deck = function(self,card,from_debuff)
            card.ability.extra.hand_size_added = #G.playing_cards - G.hand.config.card_limit
            G.hand:change_size(card.ability.extra.hand_size_added)
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.hand:change_size(-card.ability.extra.hand_size_added)
        end,
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
        end,
        in_pool = function(self,args)
            return true
        end
    }
end 