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

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.money, card.ability.extra.slots_gain, card.ability.extra.slots_current, card.ability.extra.slots_max}}
        end
    }
end 