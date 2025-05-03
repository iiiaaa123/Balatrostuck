function Balatrostuck.INIT.Jokers.j_bigkahuna()
    SMODS.Joker{
        name = "Big Kahuna",
        key = "bigkahuna",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Big Kahuna',
            ['text'] = {
                [1] = "Create a {C:paradox}Paradox {C:attention}Lovers",
                [2] = "card at end of round"
            }
        },
        pos = {
            x = 3,
            y = 1
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local _card = SMODS.add_card({set = 'Tarot', key = 'c_lovers'})
                        _card:set_edition('e_bstuck_paradox',true,true)
                        return true 
                    end
                }))
                return {
                    message = '+1 Lovers!'
                }
            end
        end,
        loc_vars = function (self, info_queue, card) 
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            info_queue[#info_queue + 1] = G.P_CENTERS['c_lovers']
        end
    }
end 