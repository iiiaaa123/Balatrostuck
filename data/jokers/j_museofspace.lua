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
                "{C:attention}+3{} hand size",
                "Transforms into",
                "{C:attention}Lord of Time",
                "at end of round"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 4,
            y = 2
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function (self, info_queue, card) 
            art_credit('akai', info_queue)
            info_queue[#info_queue + 1] = {key="j_bstuck_lordoftime", set = "Joker", config = {extra = {h_size = 3}}}
        end,
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
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 