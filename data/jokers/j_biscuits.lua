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
                [1] = "{C:green}Paradox{} cards cannot",
                [2] = "be destroyed"
            }
        },
        loc_vars = function(self, info_queue, card) 
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
        cost = 13,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        in_pool = function(self,args)
            return false
        end
    }
end 