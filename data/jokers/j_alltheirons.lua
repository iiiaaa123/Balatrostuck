function Balatrostuck.INIT.Jokers.j_alltheirons()
    SMODS.Joker{
        name = "All the Irons",
        key = "alltheirons",
        config = {
            extra = { dollars = 3
            }
        },
        loc_vars = function(self,info_queue,card)
            art_credit('akai', info_queue)
            return {vars = {get_grollars() + 1}}
        end,
        loc_txt = {
            ['name'] = 'All the Irons',
            ['text'] = {
                [1] = "Each played {C:attention}8{} gives ",
                [2] = "{C:green}$#1#{} when scored"
            }
        },
        pos = {
            x = 7,
            y = 1
        },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == 8 then
                return {
                    dollars = get_grollars()+1,
                    card = context.other_card
                }
            end
        end
    }
end