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
            }
        },
        pos = {
            x = 3,
            y = 6
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
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
        end
    }
end 