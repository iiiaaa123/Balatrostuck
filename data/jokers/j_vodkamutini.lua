function Balatrostuck.INIT.Jokers.j_vodkamutini()
    SMODS.Joker{
        name = "Vodka Mutini",
        key = "vodkamutini",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Vodka Mutini',
            ['text'] = {
                "Whenever a {C:paradox}Paradox{} card",
                "is created, create a",
                "{C:attention}non-{C:paradox}Paradox{} copy of it",
                "{C:inactive}(Must have room)"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 2,
            y = 12
         },
        soul_pos = {
            x = 1,
            y = 12
        },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function (self, info_queue, card) 
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            art_credit('akai', info_queue)
        end,
        calculate = function(self,card,context)
            --check that we placed a paradox card
            if context.card_emplaced and context.card and context.card.edition and context.card.edition.key == "e_bstuck_paradox"  
            --check that the card wasn't just being moved
            and (not context.previous_card_area or (context.previous_card_area ~= G.shop_jokers and context.previous_card_area ~= G.deck and context.previous_card_area ~= G.hand and context.previous_card_area ~= G.discard and context.previous_card_area ~= G.pack_cards))
            --check that its one of the card areas we can generate cards in
            and (context.card_area == G.jokers or context.card_area == G.deck or context.card_area == G.hand or context.card_area == G.consumeables or context.card_area == G.shop_jokers or context.card_area == G.pack_cards) 
            then
                local _card = context.card
                local _area = context.card_area
                local pCard = {}
                local _is_playing_card = (_card.config.center.set == "Default" or _card.config.center.set == "Enhanced") and true
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Cloned!"})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
                    pCard = bstuck_copy_card(_card, true, nil) --middle param is to remove the edition
                    if not pCard then return end
                    pCard:add_to_deck()
                    if _is_playing_card then
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, pCard)
                    end
                    if context.card_area == G.shop_jokers then create_shop_card_ui(pCard) end
                    _area:emplace(pCard)
                    play_sound('bstuck_HomestuckMeow', 1 + math.random()*0.5, 0.4)
                    pCard:juice_up(0.3, 0.5)
                    return true end }))
            end

        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 