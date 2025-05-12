function Balatrostuck.INIT.Jokers.j_whoisthis()
    SMODS.Joker{
        name = "Who Even Is This?",
        key = "whoisthis",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Who Even Is This?',
            ['text'] = {
                'When {C:attention}Blind{} is selected, create',
                'a random {C:paradox}Paradox{} {C:attention}Joker{}',
                
            },
            unlock = {'Unlocked by',
            'finishing Act 2'}
        },
        pos = {
            x = 6,
            y = 2
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card) 
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            art_credit('akai', info_queue)
        end,
        calculate = function (self,card,context)
            if context.setting_blind then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
    
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                    local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'who')
                    card:set_edition("e_bstuck_paradox", nil)
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    card:start_materialize()
                    G.GAME.joker_buffer = 0
                    return true
                    end
                }))
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_ascend' then
                unlock_card(self)
            end
        end
    }
end