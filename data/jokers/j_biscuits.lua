-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_biscuits()
    SMODS.Joker{
        name = "Biscuits",
        key = "biscuits",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Biscuits',
            ['text'] = {
                [1] = "{C:paradox}Paradox{} cards cannot",
                [2] = "be {C:attention}sold{}, {C:attention}destroyed{}",
                [3] =  "or {C:paradox}disappeared{}"
            }
        },
        loc_vars = function(self, info_queue, card) 
            art_credit('akai', info_queue)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
        end,
        pos = {
            x = 0,
            y = 11
         },
        soul_pos = {
            x = 1,
            y = 11
        },
        calculate = function(self, card, context)
            if context.check_eternal and context.trigger.from_sell == true and context.other_card.edition and context.other_card.edition.key == "e_bstuck_paradox" then
                return {no_destroy = {override_compat = true}}
            end
        end,
        cost = 13,
        rarity = "bstuck_felt",
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        in_pool = function(self,args)
            return true --should be safe to do since the rarity weight is set to 0
        end
    }
end 