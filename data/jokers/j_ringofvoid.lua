function Balatrostuck.INIT.Jokers.j_ringofvoid()
    SMODS.Joker{
        name = "Ring of Void",
        key = "ringofvoid",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Ring of Void',
            ['text'] = {
                [1] = "Gain a Negative Tag",
                [2] = "at end of ante"
            },
            unlock = {'Unlocked by',
            'finishing Act 3'}
        },
        pos = {
            x = 3,
            y = 6
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card) 
            info_queue[#info_queue + 1] = G.P_TAGS['tag_negative']
        end,
        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss then
                add_tag(Tag('tag_negative'))
                return {
                    message = '+1 Negative Tag!'
                }
            end
        end,
        in_pool = function(self,args)
            if G.GAME.pool_flags.lost_rol then
                return true
            else
                return false
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_medium' then
                unlock_card(self)
            end
        end
    }
end 