function Balatrostuck.INIT.Jokers.j_itchy()
    SMODS.Joker{
        name = "Itchy",
        key = "itchy",
        config = {
            extra = { 
            }
        },
        loc_txt = {
            ['name'] = 'Itchy',
            ['text'] = {
                [1] = "Your handsize is the size of your deck",
                [2] = "At start of blind, set your {C:blue}hands{} to 1"
            }
        },
        pos = {
            x = 9,
            y = 12
        },

        
        cost = 4,
        rarity = "bstuck_felt",
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.setting_blind then
                ease_hands_played(1-G.GAME.current_round.hands_left)
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
            return false
        end
    }
end 