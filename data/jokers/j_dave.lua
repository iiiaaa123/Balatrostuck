function Balatrostuck.INIT.Jokers.j_dave()
    SMODS.Joker{
        name = "turntechGodhead",
        key = "dave",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'turntechGodhead',
            ['text'] = {
                '{C:red}sup{}'
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 6,
            y = 11
         },
         soul_pos = {
            x = 7,
            y = 11
        },
        cost = 3,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = false,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context) -- this is white queen's code btw
            if context.individual and context.cardarea == G.play then
                if context.other_card:get_id() == 12 and context.other_card:is_suit('Diamonds') and
                context.other_card:get_seal(true) ~= 'Gold' then
                    local cunningham = context.other_card
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            cunningham:set_seal('Gold', nil, true)
                            return true 
                        end
                    }))
                    return {
                        dollars = 3,
                        card = context.other_card
                    }
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end,
        loc_vars = function(self, info_queue, card) 
            art_credit('fazzie', info_queue)
        end,
    }
end