function Balatrostuck.INIT.Jokers.j_cueball()
    SMODS.Joker{
        name = "Magic Cue Ball",
        key = "cueball",
        config = {
            extra = {
                cards = {nil, nil, nil}
            }
        },
        loc_txt = {
            ['name'] = 'Magic Cue Ball',
            ['text'] = {
                'Displays the next {C:attention}3{} cards',
            }
        },
        pos = {
            x = 1,
            y = 6
        },
        cost = 3,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = false,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.after and pseudorandom('cueball') < G.GAME.probabilities.normal/1000 then
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'SUCKER', colour = G.C.WHITE})
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                        return true; end})) 
                        G.E_MANAGER:add_event(Event({
                            func = function()
                            for i=1, #G.jokers.cards do
                                if not G.jokers.cards[i].ability.eternal then
                                    G.jokers.cards[i]:start_dissolve()
                                end
                            end
                            return true
                        end}))
                        return true
                    end
                }))
            end
        end,
        loc_vars = function(self, info_queue, card)
            art_credit('yokcos', info_queue)
            local get_card_name = function(card)
                if card then
                    local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                    local rank_suffix = card.base.id
                    if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                    elseif rank_suffix == 10 then rank_suffix = 'T'
                    elseif rank_suffix == 11 then rank_suffix = 'J'
                    elseif rank_suffix == 12 then rank_suffix = 'Q'
                    elseif rank_suffix == 13 then rank_suffix = 'K'
                    elseif rank_suffix == 14 then rank_suffix = 'A'
                    end
        
                    if card.ability.effect ~= 'Stone Card' then
                        return suit_prefix..rank_suffix
                    else
                        return "Stone"
                    end
                end
            end
    
                if G.deck and G.deck.cards then
                    local index, cards
                    cards = {}
                    index = #G.deck.cards
                    for k, card in ipairs(G.deck.cards) do
                        if k == index then
                            cards[1] = card
                        end
                        if k == index - 1 then
                            cards[2] = card
                        end
                        if k == index - 2 then
                            cards[3] = card
                        end
                    end
                    
                    if #cards > 0 then
                        card.ability.extra.cards[1] = {
                            name = get_card_name(cards[1]),
                            seal = cards[1]:get_seal(true),
                            center = cards[1].config.center,
                            edition = cards[1].edition or nil,
                            debuff = cards[1].debuff,
                            juice = true
                        }
                    else
                        card.ability.extra.cards[1] = nil
                    end
                    
                    if #cards > 1 then
                        card.ability.extra.cards[2] = {
                            name = get_card_name(cards[2]),
                            seal = cards[2]:get_seal(true),
                            center = cards[2].config.center,
                            edition = cards[2].edition or nil,
                            debuff = cards[2].debuff,
                            juice = true
                        }
                    else
                        card.ability.extra.cards[2] = nil
                    end
                    
                    if #cards > 2 then
                        card.ability.extra.cards[3] = {
                            name = get_card_name(cards[3]),
                            seal = cards[3]:get_seal(true),
                            center = cards[3].config.center,
                            edition = cards[3].edition or nil,
                            debuff = cards[3].debuff,
                            juice = true
                        }
                    else
                        card.ability.extra.cards[3] = nil
                    end
                end
    
            --card.calculate_joker({generate_ui = true})
            local ret = {}

            local cardarea = CardArea(
                0,0,
                2*G.CARD_W,
                0.75*G.CARD_H, 
                {card_limit = 3, type = 'title', highlight_limit = 0}
            )
            
            if G.deck and G.deck.cards then
                for k, v in ipairs(card.ability.extra.cards) do
                    local chungus = Card(0,0, 0.5*G.CARD_W, 0.5*G.CARD_H, G.P_CARDS[v.name], v.center)
                    if card.added_to_deck then chungus.edition = v.edition end
                    chungus.seal = v.seal
                    chungus.debuff = v.debuff
                    chungus.sprite_facing = card.added_to_deck and 'front' or 'back'
                    if v.juice then chungus:juice_up(0.3, 0.2) end
                    ease_value(chungus.T, 'scale', v.juice and 0.25 or -0.15,nil,'REAL',true,0.2)
                    cardarea:emplace(chungus)
                end

            else
                for i=1, 3, 1 do
                    local chungus = Card(0,0, 0.5*G.CARD_W, 0.5*G.CARD_H, G.P_CARDS['H_4'], G.P_CENTERS.c_base)
                    chungus.sprite_facing = 'back'
                    chungus:juice_up(0.3, 0.2)
                    ease_value(chungus.T, 'scale', 0.25,nil,'REAL',true,0.2)
                    cardarea:emplace(chungus)
                end
            end

            ret[1] = BSUI.Image(cardarea)

            local ret2 = {}
            local nodes = {}
            
            localize{
                type = 'descriptions',
                set = 'Other',
                key = "bstuck_scratchwarning",
                vars = {G.GAME.probabilities.normal},
                nodes = ret2
            }
          
            for i=1,#ret2 do
                table.insert(nodes, BSUI.Row({align = "cm"}, ret2[i]))
            end
            
            return {
                main_end = {
                    BSUI.PadRow(0.1),
                    BSUI.Row(BSUI.Config.Basic, ret),
                    BSUI.Row(BSUI.Config.Basic, nodes)
                }
            }
        end
    }
end