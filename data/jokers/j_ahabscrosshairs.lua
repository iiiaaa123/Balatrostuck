function Balatrostuck.INIT.Jokers.j_ahabscrosshairs()
    SMODS.Joker{
        name = "Ahabs Crosshairs",
        key = "ahabscrosshairs",
        config = {
            extra = {x_mult_per = 0.25, money = 16, x_mult = 1}
        },
        loc_vars = function(self,info_queue,card)
            return {
                vars = {card.ability.extra.x_mult_per,card.ability.extra.money,card.ability.extra.x_mult}
            }
        end,
        loc_txt = {
            ['name'] = 'Ahabs Crosshairs',
            ['text'] = {
                [1] = "Gives {X:red,C:white}X#1#{} Mult per {C:money}$#2#",
                [2] = "of total {C:attention}sell value",
                [3] = "on all current {C:attention}Jokers",
                [4] = "{C:inactive}(Currently {X:red,C:white}X#3#{C:inactive} Mult)."
            },
            unlock = {'Unlocked by',
            'obtaining Ascend'}
        },
        pos = {
            x = 9,
            y = 0
         },
        cost = 20,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end,
        update = function(self,card,dt)
            local sell_cost = 0
            if G.jokers then
                for i = 1, #G.jokers.cards do
                    sell_cost = sell_cost + G.jokers.cards[i].sell_cost
                end
                sell_cost = math.floor(sell_cost/card.ability.extra.money) * card.ability.extra.x_mult_per
            end
            card.ability.extra.x_mult = 1 + sell_cost
        end,
        set_card_type_badge = function(self, card, badges)
            badges[1] = create_badge(localize('k_legendary'), HEX("791a79"), nil, 1.2)
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_ascend' then
                unlock_card(self)
            end
        end
    }
end 