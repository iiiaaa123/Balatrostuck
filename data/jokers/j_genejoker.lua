function Balatrostuck.INIT.Jokers.j_genejoker()
    SMODS.Joker{
        name = "Gene Joker",
        key = "genejoker",
        config = {
            extra = {
                chips = 0,
                chip_mod = 4
            }
        },
        loc_txt = {
            ['name'] = 'Gene Joker',
            ['text'] = {
                [1] = "This Joker gains {C:blue}+#2#{} Chips every",
                [2] = "time a {C:paradox}Paradox{} card is {C:attention}created",
                [3] = "{C:inactive}(Currently {C:blue}+#1# {C:inactive}Chips)"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 2,
            y = 2
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.paradox_created then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}})
            end

            if context.joker_main then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
        end,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.chips, card.ability.extra.chip_mod}}
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 