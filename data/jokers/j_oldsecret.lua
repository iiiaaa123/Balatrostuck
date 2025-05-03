function Balatrostuck.INIT.Jokers.j_oldsecret()
    SMODS.Joker{
        name = "Old Secret",
        key = "oldsecret",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Old Secret',
            ['text'] = {
                [1] = "A random held {C:attention}consumeable{} becomes",
                [2] = "{C:green}Paradox{} at end of round, {C:green}Paradox",
                [3] = "consumeables cannot be destroyed"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 9,
            y = 8
         },
        cost = 6,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end,
        loc_vars = function(self, info_queue, card) 
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
        end,
    }
end 