function Balatrostuck.INIT.Spectrals.c_spectral_jailkey()
    local coolstuff =SMODS.Gradient{
        key = 'JAILKEY_GRAD',
        colours = {
            HEX('f03464'),
            HEX('f06b3f'),
            HEX("403995"),
            HEX("235955")
        },
        cycle = 2,
        interpolation = 'linear' 
    }



    SMODS.Consumable {
        key = 'jailkey',
        name = 'Jail Key',
        set = 'Spectral',
        loc_vars = function(self,info_queue,card)
            local doublekey = nil
            local doublename = nil
            local colour = G.C.GREY
            if G.hand and G.jokers and #G.hand.highlighted == 1 and #G.jokers.highlighted == 0 then
                doublename = get_innocuous(G.hand.highlighted[1],true)
                doublekey = get_innocuous(G.hand.highlighted[1],false)
                local hehe = G.hand.highlighted[1]
                if SMODS.has_no_rank(hehe) then
                    colour = G.C.JOKER_GREY
                elseif SMODS.has_any_suit(hehe) then
                    colour = coolstuff
                elseif hehe.base.suit == 'Hearts' then
                    colour = G.C.SUITS.Hearts
                elseif hehe.base.suit == 'Diamonds' then
                    colour = G.C.SUITS.Diamonds 
                elseif hehe.base.suit == 'Clubs' then
                    colour = G.C.SUITS.Clubs 
                elseif hehe.base.suit == 'Spades' then
                    colour = G.C.SUITS.Spades 
                end
            elseif G.hand and G.jokers and #G.hand.highlighted == 0 and #G.jokers.highlighted == 1 then
                doublename = get_innocuous(G.jokers.highlighted[1],true)
                local doublekey, double_enh = get_innocuous(G.jokers.highlighted[1],false)
                if doublekey then
                    if double_enh and double_enh == "m_stone" then
                        colour = G.C.JOKER_GREY
                    elseif double_enh and double_enh == "m_wild" then
                        colour = coolstuff
                    elseif string.sub(doublekey, 1, 1) == 'H' then
                        colour = G.C.SUITS.Hearts
                    elseif string.sub(doublekey, 1, 1) == 'D'  then
                        colour = G.C.SUITS.Diamonds 
                    elseif string.sub(doublekey, 1, 1) == 'C'  then
                        colour = G.C.SUITS.Clubs 
                    elseif string.sub(doublekey, 1, 1) == 'S' then
                        colour = G.C.SUITS.Spades 
                    end
                end
            else
                doublename = 'Unselected'
                colour = G.C.GREY
            end


            if doublekey == 'j_bstuck_jocker' then
                colour = G.C.RARITY[4]
            end

            return {
                main_end = {
                    BSUI.Modules.GameText.FormatBadge(' '..doublename..' ', colour)
                }
            }
        end,
        loc_txt = {
            name = 'Jail Key',
            text = {
                'Destroy {C:attention}1{} selected',
                'card and create its',
                '{E:2,C:dark_edition}innocuous double',
                '{C:inactive}(Must have room)'
            }
        },
        pos = {
            x = 3,
            y = 0
        },
        atlas = 'HomestuckSpectrals',
        can_use = function(self,card)
            return (#G.hand.highlighted == 1 and #G.jokers.cards < G.jokers.config.card_limit and #G.jokers.highlighted == 0) 
            or ((#G.hand.cards > 0 and #G.hand.highlighted == 0 and #G.jokers.highlighted == 1) and get_innocuous(G.jokers.highlighted[1],false))
        end,
        use = function(self, card, area, copier)
            if #G.hand.highlighted ~= 0 then
                local _card = G.hand.highlighted[1]
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true end }))
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('timpani')
                            local new_card = SMODS.create_card({set = 'Joker',no_edition = true, key = get_innocuous(_card,false)})
                            new_card:start_materialize(nil, false)
                            G.jokers:emplace(new_card)
                            if next(SMODS.find_card('j_bstuck_quarters')) then
                                new_card:set_edition('e_negative')
                            end
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function() 
                        if _card.ability.name == 'Glass Card' then 
                            _card:shatter()
                        else
                            _card:start_dissolve(nil, i == #G.hand.highlighted)
                        end
                        return true 
                end }))
                delay(0.2)
            else
                local _card = G.jokers.highlighted[1]
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true end }))
                G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('timpani')
                    local card_key, card_enh = get_innocuous(_card,false)
                    local new_card = create_playing_card({front = G.P_CARDS[card_key], center = G.P_CENTERS.c_base}, nil, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                    if card_enh then 
                        new_card:set_ability(G.P_CENTERS[card_enh])
                    end
                    --new_card:start_materialize(nil, false)
                    G.hand:emplace(new_card)
                    return true
                end}))
                G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function() 
                    _card:start_dissolve(nil, i == #G.jokers.highlighted)
                    return true 
                end }))
                delay(0.2)
            end
        end
    }
end