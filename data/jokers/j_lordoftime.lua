function Balatrostuck.INIT.Jokers.j_lordoftime()
    SMODS.Joker{
        name = "Lord Of Time",
        key = "lordoftime",
        config = {
            extra = {hands = 3}
        },
        loc_txt = {
            ['name'] = 'Lord Of Time',
            ['text'] = {
                [1] = "{C:blue}+3{} Hands",
                [2] = "At end of round,",
                [3] = "transforms into {C:attention}Muse of Space"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 3,
            y = 2
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        loc_vars = function (self, info_queue, card) 
            info_queue[#info_queue + 1] = {key="j_bstuck_museofspace", set = "Joker", config = {extra = {h_size = 3}}}
        end,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true end }))
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    card:remove_from_deck()
                    card.config.center = G.P_CENTERS['j_bstuck_museofspace']
                    card:set_ability(card.config.center,true)
                    card:add_to_deck()
                    return true 
                end}))
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('tarot2', percent);card:juice_up(0.3, 0.3);return true end }))
            end
        end,
        add_to_deck = function(self,card,from_debuff)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 