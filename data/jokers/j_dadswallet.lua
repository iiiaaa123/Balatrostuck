function Balatrostuck.INIT.Jokers.j_dadswallet()
    SMODS.Joker{
        name = "Dads Wallet",
        key = "dadswallet",
        config = {
            extra = {
                money = 15,
                slots_gain = 1,
                slots_current = 0,
                slots_max = 3
            }
        },
        loc_txt = {
            ['name'] = 'Dads Wallet',
            ['text'] = {
                [1] = "{C:attention}+#2#{} consumable slot",
                [2] = "for every {C:money}$#1#{} you have",
                [3] = "{C:inactive}(Currently {C:attention}#3#{C:inactive}/#4#)"
            }
        },
        pos = {
            x = 7,
            y = 4
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        add_to_deck = function(self,card,from_debuff)
            card.ability.extra.slots_gain = math.min(card.ability.extra.slots_max,math.floor(G.GAME.dollars / card.ability.extra.money))
            G.consumeables:change_size(card.ability.extra.slots_gain)
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.consumeables:change_size(-card.ability.extra.slots_gain)
        end,
        calculate = function(self,card,context)
            if context.bstuck_money_increased then
                G.consumeables:change_size(-card.ability.extra.slots_gain)
                card.ability.extra.slots_gain = math.min(card.ability.extra.slots_max,math.floor(context.total_dollars / card.ability.extra.money))
                G.consumeables:change_size(card.ability.extra.slots_gain)
            end
        end,
        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.money, card.ability.extra.slots_gain, card.ability.extra.slots_current, card.ability.extra.slots_max}}
        end
    }
end 