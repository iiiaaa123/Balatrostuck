function Balatrostuck.INIT.Jokers.j_museofspace()
    SMODS.Joker{
        name = "Muse of Space",
        key = "museofspace",
        config = {
            extra = {h_size = 3}
        },
        loc_txt = {
            ['name'] = 'Muse of Space',
            ['text'] = {
                [1] = "{C:attention}+3{} hand size",
                [2] = "At end of round,",
                [3] = "transforms into {C:attention}Lord of Time"
            }
        },
        pos = {
            x = 4,
            y = 2
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true end }))
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    card:remove_from_deck()
                    card.config.center = G.P_CENTERS['j_bstuck_lordoftime']
                    card:set_ability(card.config.center,true)
                    card:add_to_deck()
                    return true 
                end}))
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('tarot2', percent);card:juice_up(0.3, 0.3);return true end }))
            end
        end,
        add_to_deck = function(self,card,from_debuff)
            G.hand:change_size(card.ability.extra.h_size)
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.hand:change_size(-card.ability.extra.h_size)
        end
    }
end 