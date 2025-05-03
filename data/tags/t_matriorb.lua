--TODO: booster pack thang
function Balatrostuck.INIT.Tags.t_matriorb()
    SMODS.Tag{
        key = "matriorb",
        config = {type = "eval"},
        loc_txt = {
            ['name'] = 'Matriorb',
            ['text'] = {
                [1] = 'Gives a free',
                [2] = '{C:zodiac}Mega Zodiac Pack'                  
            }
        },
        pos = {
            x = 3,
            y = 0
        },
        atlas = 'HomestuckTags',

        in_pool = function(self)
            return (G.GAME.round_resets.ante > 1)
        end,

        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['p_bstuck_zodiac_mega_booster']
            -- PUT RELEVENT LOC VARS HERE WHEN YOU GET TO REWORDING THIS!!!!!!! - Delirium
            return {true}
        end,
        apply = function(self, tag, context)
            if context.type == "new_blind_choice" then
                tag:yep("+", G.C.ATTENTION, function()
                    local key = "p_bstuck_zodiac_mega_booster"
                    local card = Card(
                        G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                        G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                        G.CARD_W * 1.27,
                        G.CARD_H * 1.27,
                        G.P_CARDS.empty,
                        G.P_CENTERS[key],
                        { bypass_discovery_center = true, bypass_discovery_ui = true }
                    )
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({ config = { ref_table = card } })
                    card:start_materialize()
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    }
end