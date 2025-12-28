
function Balatrostuck.INIT.Tags.t_denizen()
    SMODS.Tag{
        key = "denizen",
        config = {type = "new_blind_choice"},
        loc_txt = {
            ['name'] = 'Denizen Tag',
            ['text'] = {
                [1] = 'Create a negative',
                [2] = 'eternal rare joker'            
            }
        },
        pos = {
            x = 2,
            y = 2
        },
        atlas = 'HomestuckTags',
        
        in_pool = function(self)
            return (G.GAME.round_resets.ante > 1)
        end,

        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['p_bstuck_aspect_booster']
            art_credit('akai', info_queue)

            return {true}
        end,
        apply = function(self, tag, context)
                local lock = tag.ID
                tag:yep("Choice.",G.C.Red, 
                function()

                     G.E_MANAGER:add_event(Event({
                        func = function()
                            local _card = SMODS.add_card({set = 'Joker', rarity = 3,edition = 'e_negative'})
                            _card:start_materialize()
                            _card:set_eternal(true)
                            return true
                    end}))
                    

                return true
                end)
                tag.triggered = true
        end,
    }
end