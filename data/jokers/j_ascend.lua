-- DONE
function Balatrostuck.INIT.Jokers.j_ascend() 
    SMODS.Joker{
        name = "Ascend",
        key = "ascend",
        config = {
            extra = {
                full_houses = {},
                hand = "Full House",
                mult = 4,
                mult_total = 0
            }
        },
        loc_txt = {
            ['name'] = 'Ascend',
            ['text'] = {
                [1] = "This Joker gains {C:mult}+#1#{} Mult for each",
                [2] = "unique {C:inactive}(rank-wise) {C:attention}#2#{} played",
                [3] = "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 0,
            y = 7
        },
        cost = 6,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.mult, card.ability.extra.hand, card.ability.extra.mult_total}}
        end,

        calculate = function(self,card,context)
            if context.cardarea == G.jokers and (context.joker_main or context.before) then
                if next(context.poker_hands[card.ability.extra.hand]) and not context.blueprint and context.before then
                    local apply_mult = false
                    local temp = {}
                    for _, v in ipairs(context.scoring_hand) do
                        temp[v.base.id] = (temp[v.base.id] or 0) + 1
                    end
        
                    local temp2 = {}
                    for k, v in pairs(temp) do
                        temp2[v] = k
                    end
        
                    if #card.ability.extra.full_houses > 0 then
                        for _,v in ipairs(card.ability.extra.full_houses) do
                            if (v[2] == temp2[2] and v[3] == temp2[3]) then goto continue end
                            apply_mult = true
                            ::continue::
                        end
                    else
                        apply_mult = true
                    end
        
                    if apply_mult and context.before then 
                        table.insert(card.ability.extra.full_houses, temp2)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
                        card.ability.extra.mult_total = card.ability.extra.mult_total + card.ability.extra.mult 
                    end
                end
    
                if context.joker_main then
                    return {
                        mult_mod = card.ability.extra.mult_total,
                        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_total } },
                        colour = G.C.MULT
                    }
                end
            end
        end,
        add_to_deck = function(self,card,from_debuff)
            -- check_for_unlock({type = 'bstuck_ascend'})
            if G.GAME.pool_flags.bstuck_actprogress <= 1 then
                for k,v in ipairs(UnlockedByAscend) do
                    G.P_CENTERS["j_bstuck_"..v].unlocked = true
                end
                notify_bstuck_alert("j_bstuck_ascend", 2)
                G.GAME.pool_flags.bstuck_actprogress = 2
            end
        end,
        in_pool = function(self,args)
            return G.GAME.pool_flags.bstuck_actprogress >= 1
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end