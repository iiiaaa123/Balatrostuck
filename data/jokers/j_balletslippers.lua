function Balatrostuck.INIT.Jokers.j_balletslippers()
    SMODS.Joker{
        name = "Ballet Slippers",
        key = "balletslippers",
        config = {
            extra = {
                to_do_poker_hand = "High Card",
                mult_gain = 5,
                mult = 0
            }
        },
        loc_txt = {
            ['name'] = 'Ballet Slippers',
            ['text'] = {
                [1] = "This Joker gains {C:mult}+#1#{} Mult",
                [2] = "if {C:attention}poker hand{} is a {C:attention}#2#{},",
                [3] = "poker hand changes each hand,",
                [4] = "{C:attention}resets{} if a different hand is played",
                [5] = "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
            }
        },
        pos = {
            x = 6, -- 6 for abated, 7 for active
            y = 10
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        set_ability = function(self, card, initial, delay_sprites)
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible then _poker_hands[#_poker_hands+1] = k end
            end
            local old_hand = card.ability.extra.to_do_poker_hand
            card.ability.extra.to_do_poker_hand = nil    

            while not card.ability.extra.to_do_poker_hand do
                card.ability.extra.to_do_poker_hand = pseudorandom_element(_poker_hands, pseudoseed((self.area and self.area.config.type == 'title') and 'false_to_do' or 'to_do'))
                if card.ability.extra.to_do_poker_hand == old_hand then card.ability.extra.to_do_poker_hand = nil end
            end    
        end,

        loc_vars = function(self,info_queue,card)
            return {vars = {card.ability.extra.mult_gain, card.ability.extra.to_do_poker_hand, card.ability.extra.mult}}
        end,

        calculate = function(self,card,context)
            if context.setting_blind then
                local _poker_hands = {}
                for k, v in pairs(G.GAME.hands) do
                    if v.visible then _poker_hands[#_poker_hands+1] = k end
                end
                local old_hand = card.ability.extra.to_do_poker_hand
                card.ability.extra.to_do_poker_hand = nil    

                while not card.ability.extra.to_do_poker_hand do
                    card.ability.extra.to_do_poker_hand = pseudorandom_element(_poker_hands, pseudoseed((self.area and self.area.config.type == 'title') and 'false_to_do' or 'to_do'))
                    if card.ability.extra.to_do_poker_hand == old_hand then card.ability.extra.to_do_poker_hand = nil end
                end    
            end
            
            if context.before and context.scoring_name == card.ability.extra.to_do_poker_hand then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    card = card,
                    message = localize('k_upgrade_ex')
                }
            end

            if context.before and context.scoring_name ~= card.ability.extra.to_do_poker_hand then
                card.ability.extra.mult = 0
                return {
                    card = card,
                    message = localize('k_reset')
                }
            end

            if context.joker_main and card.ability.extra.mult > 0 then
                return {
                  mult_mod = card.ability.extra.mult,
                  message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end        
        end
    }
end 