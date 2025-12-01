function Balatrostuck.INIT.Jokers.j_snowman()
    SMODS.Joker{
        name = "Snowman",
        key = "snowman",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Snowman',
            ['text'] = {
                "Each {C:attention}8{} is considered",
                "a {C:attention}face{} card, {C:attention}face{}",
                "cards held in hand",
                "give {C:mult}+2{} Mult"
            },
            unlock = {'Play an 8 with',
                    '{C:attention}Pareidolia{}'}
        },
        pos = {
            x = 3,
            y = 5
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        calculate = function(self,card,context)
            if context.individual and context.cardarea == G.hand and not context.end_of_round then
                if context.other_card:is_face() and not context.other_card.debuff then
                    return {
                        h_mult = 2,
                        card = card
                    }
                elseif context.other_card:is_face() then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_snowman' then
                unlock_card(self)
            end
        end

    }
end 