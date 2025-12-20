function Balatrostuck.INIT.Jokers.j_oldsecret()
    SMODS.Joker{
        name = "Old Secret",
        key = "oldsecret",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Old Secret',
            ['text'] = {
                [1] = "A random held {C:attention}consumeable{} becomes",
                [2] = "{C:paradox}Paradox{} at end of round, {C:paradox}Paradox",
                [3] = "consumables cannot be destroyed"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 9,
            y = 8
         },
        cost = 6,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers then
                local _pool = {}
                for i=1, #G.consumeables.cards do
                    if G.consumeables.cards[i].edition == nil then
                        _pool[#_pool+1] = G.consumeables.cards[i]
                    end
                end
                if #_pool >= 1 then
                    local _card = pseudorandom_element(_pool,pseudoseed('oldsecret')) 
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:set_edition('e_bstuck_paradox',true)
                            card:juice_up()
                            return true
                        end
                    }))
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end,
        loc_vars = function(self, info_queue, card) 
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            art_credit('akai', info_queue)
        end,
    }
end 