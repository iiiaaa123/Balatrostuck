-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_lowas()
    SMODS.Joker{
        name = "Wind and Shade",
        key = "lowas",
        config = {
            extra = 3
        },
        loc_vars = function(self,info_queue,card)
            art_credit('yokcos', info_queue)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            info_queue[#info_queue + 1] = G.P_CENTERS['m_gold']
            return {
                vars = {card.ability.extra}
            }
        end,
        loc_txt = {
            ['name'] = 'Wind and Shade',
            ['text'] = {
                [1] = "When {C:attention}Blind{} is selected,",
                [2] = "shuffle {C:attention}#1# {C:paradox}Paradox{} {C:attention}Gold{}",
                [3] = "cards into deck"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 0,
            y = 8
         },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.setting_blind then
                for i=1, card.ability.extra do
                    G.E_MANAGER:add_event(Event{
                        delay = 0.25, trigger = 'after', func = function()
                            local front = pseudorandom_element(G.P_CARDS, pseudoseed('cert_fr'))
                            local _card = create_playing_card({
                                front = front, 
                                center = G.P_CENTERS.m_gold}, nil, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                            card:juice_up()
                            _card:set_edition('e_bstuck_paradox',true,true)
                            G.deck:emplace(_card,pseudorandom('LOWAS',1,#G.deck.cards))
                            return true
                        end
                    })
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 