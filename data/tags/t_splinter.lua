
function Balatrostuck.INIT.Tags.t_splinter()
    SMODS.Tag{
        key = "splinter",
        config = {type = "new_blind_choice", do_not_retrigger=true},
        loc_txt = {
            ['name'] = 'Splinter Tag',
            ['text'] = {
                [1] = 'Gives a free',
                [2] = '{C:aspect}Splinter Pack'            
            }
        },
        pos = {
            x = 3,
            y = 1
        },
        atlas = 'HomestuckTags',
        
        in_pool = function(self)
            return (G.GAME.round_resets.ante > 1)
        end,

        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['p_bstuck_splinter_booster']
            art_credit('akai', info_queue)

            return {true}
        end,
        apply = function(self, tag, context)
            if context.type == 'new_blind_choice' then
                local lock = tag.ID
                tag:yep('+', G.C.SECONDARY_SET.Aspect,function() 
                        local key = 'p_bstuck_splinter_booster'
                        local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                        G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                        card.cost = 0
                        card.from_tag = true
                        G.FUNCS.use_card({config = {ref_table = card}})
                        card:start_materialize()
                        G.CONTROLLER.locks[lock] = nil
                        return true
                    end)
                tag.triggered = true
            end
            return true
        end
    }
end