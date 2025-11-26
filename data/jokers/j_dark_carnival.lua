function Balatrostuck.INIT.Jokers.j_dark_carnival()
    SMODS.Joker{
        name = "Dark Carnival",
        key = "dark_carnival",
        config = {
            extra = {
                trash_list = {}
            }
        },
        loc_txt = {
            ['name'] = 'Dark Carnival',
            ['text'] = {
                [1] = "Destroy all scoring",
                [2] = "ranks corresponding",
                [3] = "to consumable slot",
                [4] = "{C:attention}Zodiac cards{}"
            },
            unlock = {'Destroy at least one',
                    'card of each {C:attention}rank{} in',
                     'one single run'}
        },
        pos = {
            x = 0,
            y = 2
        },
        cost = 7,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_darkcarnival' then
                unlock_card(self)
            end
        end,
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        calculate = function(self, card, context)
            
    
            if context.before and not context.blueprint then
                card.ability.extra.trash_list = {}
                if G.consumeables.cards[1] then
                    for i=1, #context.scoring_hand do
                        local thunk = context.scoring_hand[i]:get_id()
                        for j=1, #G.consumeables.cards do
                            if G.consumeables.cards[j].ability.name == "Aquarius" and thunk == 11 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Aries" and thunk == 14 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Cancer" and thunk == 4 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Capricorn" and thunk == 10 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Gemini" and thunk == 2 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Leo" and thunk == 5 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Libra" and thunk == 7 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Ophiuchus" and thunk == 13 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Pisces" and thunk == 12 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Sagittarius" and thunk == 9 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Scorpio" and thunk == 8 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Taurus" and thunk == 3 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                            if G.consumeables.cards[j].ability.name == "Virgo" and thunk == 6 then
                                card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.scoring_hand[i]
                                break
                            end
                        end
                    end
                end


            elseif context.destroying_card and not context.blueprint then
                for _, v in pairs(card.ability.extra.trash_list) do
                    if v == context.destroying_card then
                        return true
                    end
                end
                return nil
            end
        end
    }
end