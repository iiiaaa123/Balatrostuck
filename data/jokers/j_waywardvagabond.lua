function Balatrostuck.INIT.Jokers.j_waywardvagabond()
    SMODS.Joker{
        name = "Wayward Vagabond", -- Must later be converted into Pawn Revolution
        key = "waywardvagabond",
        config = {
            extra = {mult = 2}
        },
        loc_txt = {
            ['name'] = 'Wayward Vagabond',
            ['text'] = {
                [1] = 'All {C:attention}Kings{} are debuffed,',
                [2] = 'played cards give {C:mult}+#1#{} Mult',
                [3] = 'when {C:attention}scored{} or {C:attention}held in hand'
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 9,
            y = 5
        },
        loc_vars = function(self,info_queue,card)
            art_credit('akai', info_queue)
            return{vars = {card.ability.extra.mult}}
        end,
        cost = 3,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self, card, context)
            if context.debuff_card and context.debuff_card:get_id() == 13 then
                return {
                    debuff = true
                }
            end
            if context.individual and not context.end_of_round then
                if context.cardarea == G.play then
                    return {
                        mult = card.ability.extra.mult,
                        card = card
                    }
                elseif context.cardarea == G.hand then
                    if context.other_card.debuff then
                        return {
                            message = localize('k_debuffed'),
                            colour = G.C.RED,
                            card = card,
                        }
                    end
                    return {
                        h_mult = card.ability.extra.mult,
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