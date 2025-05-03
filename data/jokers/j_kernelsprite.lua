function Balatrostuck.INIT.Jokers.j_kernelsprite()
    SMODS.Joker{
        name = "Kernelsprite",
        key = "kernelsprite",
        config = {
            extra = {
                discards = 2,
                card1 = "Unassigned",
                card2 = "Unassigned"
            }
        },
        loc_txt = {
            ['name'] = 'Kernelsprite',
            ['text'] = {
                [1] = "The next {C:attention}#1# discards{} that have only",
                [2] = "{C:attention}1 card{} are {C:red}destroyed{} and {C:attention}stored{}.",
                [3] = "At start of round, create two {C:green}Paradox",
                [4] = "cards with the {C:attention}stored{} rank and suits",
                [5] = "{C:inactive}(#2#) (#3#)"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },

        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            local get_card_name = function(_card)
                if _card then
                    local rank = _card.base.value
                    local suit = _card.base.suit
        
                    if _card.ability.effect ~= 'Stone Card' then
                        return localize(rank, 'ranks') .. " of " .. localize(suit, "suits_plural")
                    else
                        return "Stone"
                    end
                else
                    return "Unassigned"
                end
            end

            card.ability.extra.card1 = get_card_name(archived[1]) 
            card.ability.extra.card2 = get_card_name(archived[2]) 

            return {vars = {card.ability.extra.discards, card.ability.extra.card1, card.ability.extra.card2}}
        end,

        pos = {
            x = 3,
            y = 3
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',

        set_ability = function(self, card, initial, delay_sprites)
            if next(SMODS.find_card('j_bstuck_kernelsprite')) then
                archived = archived
            else
                archived = {}
            end
        end,

        calculate = function(self, card, context)
            if context.discard and not context.blueprint then   
                if #context.full_hand == 1 and #archived < 2 then
                    local scard = context.full_hand[1]
                    table.insert(archived, scard)
                    context.full_hand[1]:start_dissolve(nil, true)              
                    return {
                        remove = true,
                        message = 'Stored!',
                        card = card
                    }          
                end
            end
        
            if context.setting_blind then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                for i = 1, #archived do
                    pCard = copy_card(archived[i], nil, nil, G.playing_card, true)
                    if pCard.ability.effect ~= 'Stone Card' then
                        pCard:set_ability(G.P_CENTERS.c_base, nil, true)
                    end
                    pCard:set_edition("e_bstuck_paradox")
                    pCard:set_seal(nil,true,true)
                    pCard:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, pCard)
                    G.hand:emplace(pCard)
                end
                
                if #archived > 0 then
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Kerneled!"})
                end
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