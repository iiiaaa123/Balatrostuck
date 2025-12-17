function Balatrostuck.INIT.Jokers.j_lolar()
    SMODS.Joker{
        name = "Light and Rain",
        key = "lolar",
        config = {
            extra = {
                chips = 0,
                chip_mod = 3
            }
        },
        loc_txt = {
            ['name'] = 'Light and Rain',
            ['text'] = {
                [1] = "This Joker gains {C:chips}+#2#{} Chips",
                [2] = "for each empty {C:attention}Joker{} slot",
                [3] = "when a hand is played",
                [4] = "{C:inactive}(Currently {C:chips}+#1#{} {C:inactive}Chips){}"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 2,
            y = 8
        },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('yokcos', info_queue)
            return {vars = {card.ability.extra.chips, card.ability.extra.chip_mod}}
        end,
    
        calculate = function(self, card, context)
    
            if context.cardarea == G.jokers and context.joker_main and card.ability.extra.chips > 0 then
                return {
                    message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                    chip_mod = card.ability.extra.chips
                }
            elseif context.before and not context.blueprint then
                if (G.jokers.config.card_limit - #G.jokers.cards) > 0 then
                    card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chip_mod * (G.jokers.config.card_limit - #G.jokers.cards))
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.CHIPS,
                        card = card
                    }
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 