function Balatrostuck.INIT.Jokers.j_batterwitch() 
    SMODS.Joker{
        name = "Batterwitch",
        key = "batterwitch",
        config = {
            extra = {
                dollars = 4
            }
        },
        loc_txt = {
            ['name'] = 'Batterwitch',
            ['text'] = {
                [1] = 'If played {C:attention}poker hand{} is',
                [2] = 'your {C:attention}highest level{} hand, it',
                [3] = 'loses {C:attention}all{} levels and earn',
                [4] = '{C:money}$#1#{} for each level lost'
            },
        unlock = {'Unlocked by',
            'finishing Act 2'}
        },
        pos = {
            x = 1,
            y = 5
        }, 
        cost = 8,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.dollars}}
        end,

        calculate = function(self, card, context)
            if context.cardarea == G.jokers and context.before and not context.blueprint then

                local valid_hands, level, activate = {}, 1, false
                
                for k, v in pairs(G.GAME.hands) do 
                    if v.level ~= 1 and v.level == level then
                        valid_hands[#valid_hands+1] = k
                    elseif v.level > level then
                        valid_hands = {}
                        level = v.level
                        valid_hands[#valid_hands+1] = k
                    end
                end

                if level > 1 then
                    for k, v in pairs(valid_hands) do
                        if v == context.scoring_name then
                            activate = true break
                        end
                    end
                end



                if activate then
                    local amount = G.GAME.hands[context.scoring_name].level - 1
                    local text,disp_text = context.scoring_name
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Conquered!",colour = G.C.FILTER})
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
                    level_up_hand(card, text, false, -amount)
                    ease_dollars(amount * card.ability.extra.dollars)
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_ascend' then
                unlock_card(self)
            end
        end
    }
end