--effect will be awkward with pack timings; needs lovely patch for pack tags (and also consider aquarius)
function Balatrostuck.INIT.Jokers.j_descendascend()
    SMODS.Joker{
        name = "Descendascend",
        key = "descendascend",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Descendascend', 
            ['text'] = {
                [1] = "Gain a {C:attention}Buffoon Tag{} at end of shop,",
                [2] = "{C:attention}Jokers{} in {C:attention}Buffoon Packs{} are {C:green}Paradox"
            }
        },
        pos = {
            x = 8,
            y = 8
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function (self, info_queue, card) 
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            info_queue[#info_queue + 1] = G.P_TAGS['tag_buffoon']
        end,
        calculate = function(self, card, context)
            if context.ending_shop then
                add_tag(Tag('tag_buffoon'))
                return {
                    card = card,
                    message = "Egbert!"
                }    
            end
        end
    }
end 