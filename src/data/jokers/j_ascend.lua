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
                [1] = "Gains {C:mult}+#1# Mult{} per",
                [2] = "unique {C:inactive}(rank-wise){}",
                [3] = "{C:attention}#2#{} played",
                [4] = "{C:inactive}(Currently: {}{C:mult}+#3# Mult{}{C:inactive}){}"
            }
        },
        pos = {
            x = 0,
            y = 7
        },
        cost = 5,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.mult, card.ability.extra.hand, card.ability.extra.mult_total}}
        end,

        calculate = function(self, context)
            if context.cardarea == G.jokers and (context.joker_main or context.before) then
                if next(context.poker_hands[self.ability.extra.hand]) and not context.blueprint and context.before then
                    local apply_mult = false
                    local temp = {}
                    for _, v in ipairs(context.scoring_hand) do
                        temp[v.base.id] = (temp[v.base.id] or 0) + 1
                    end
        
                    local temp2 = {}
                    for k, v in pairs(temp) do
                        temp2[v] = k
                    end
        
                    if #self.ability.extra.full_houses > 0 then
                        for _,v in ipairs(self.ability.extra.full_houses) do
                            if (v[2] == temp2[2] and v[3] == temp2[3]) then goto continue end
                            apply_mult = true
                            ::continue::
                        end
                    else
                        apply_mult = true
                    end
        
                    if apply_mult and context.before then 
                        table.insert(self.ability.extra.full_houses, temp2)
                        card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
                        self.ability.extra.mult_total = self.ability.extra.mult_total + self.ability.extra.mult 
                    end
                end
    
                if context.joker_main then
                    return {
                        mult_mod = self.ability.extra.mult_total,
                        message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult_total } },
                        colour = G.C.MULT
                    }
                end
            end
        end
    }:register()
end