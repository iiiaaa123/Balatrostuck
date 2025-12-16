--TODO: booster pack thang
function Balatrostuck.INIT.Tags.t_sburb()
    SMODS.Tag{
        key = "sburb",
        config = {type = "new_blind_choice"},
        loc_txt = {
            ['name'] = 'Sburb Tag',
            ['text'] = {
                [1] = 'Gives a free',
                [2] = '{C:aspect}Sburb Pack'            
            }
        },
        pos = {
            x = 0,
            y = 1
        },
        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['p_bstuck_sburb_booster']
            art_credit('akai', info_queue)
            -- PUT RELEVENT LOC VARS HERE WHEN YOU GET TO REWORDING THIS!!!!!!! - Delirium
            return {true}
        end,
        apply = function(self, tag, context)
            if context.type == self.config.type then
                check_for_unlock({ type = "bstuck_frogdeck" })
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                tag:yep('+', G.C.SECONDARY_SET.Aspect,function() 
                        local key = 'p_bstuck_sburb_booster'
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
                return true
            end
        end,
        in_pool = function(self,args)
            return false
        end
    }
end