function Balatrostuck.INIT.Jokers.j_misspaint()
    SMODS.Joker{
        name = "Miss Paint",
        key = "misspaint",
        config = {
            extra = {mult = 1, mult_gain = 4}
        },
        loc_txt = {
            ['name'] = 'Miss Paint',
            ['text'] = {
                [1] = "Gains {C:mult}+#1#{} Mult for every",
                [2] = "card that {C:attention}changes suit",
                [3] = "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        loc_vars = function(self,info_queue,card)
            art_credit('garb', info_queue)
            return {vars = {card.ability.extra.mult, card.ability.extra.mult_gain}}
        end,
        pos = {
            x = 4,
            y = 10
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.changing_suit then
                card.ability.extra.mult_gain = card.ability.extra.mult_gain + card.ability.extra.mult
                return {
                    message = 'Upgraded!',
                    card = card
                }
            end

            if card.ability.extra.mult_gain > 0 and context.joker_main then
                return {
                    mult = card.ability.extra.mult_gain,
                    card = card
                }
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 