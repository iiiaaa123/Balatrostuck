-- TODO: Localization and spawn logic
function Balatrostuck.INIT.Jokers.j_collide()
    SMODS.Joker{
        name = "Collide",
        key = "collide",
        config = {
        },
        loc_txt = {
            ['name'] = 'Collide',
            ['text'] = {
                [1] = 'When round begins,',
                [2] = 'add four {C:attention}steel{}',
                [3] = '{C:spades}Jack of Spades{}',
                [4] = 'to your hand'
            },
            unlock = {'Unlocked by',
            'finishing Act 5'}
        },
        pos = {
            x = 4,
            y = 7
        },
        cost = 10,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['m_steel']
        end,
        calculate = function (self, card, context)
            if context.first_hand_drawn then
                for i=1, 4 do
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local _card = create_playing_card({
                                front = G.P_CARDS['S_J'], 
                                center = G.P_CENTERS.m_steel}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                            
                            G.GAME.blind:debuff_card(_card)
                            G.hand:sort()
                            if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            return true
                        end}))

                    playing_card_joker_effects({true})
                end
            end
        end,
        add_to_deck = function(self,card,from_debuff)
            check_for_unlock({type = 'bstuck_collide'})
            if G.GAME.pool_flags.bstuck_actprogress <= 5 then
                G.GAME.pool_flags.bstuck_actprogress = 6
            end
        end,
        in_pool = function(self,args)
            return G.GAME.pool_flags.bstuck_actprogress >= 5
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_cascade' then
                unlock_card(self)
            end
        end
    }
end