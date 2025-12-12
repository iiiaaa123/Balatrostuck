function Balatrostuck.INIT.Tags.t_perfectlygeneric()
    SMODS.Tag{
        key = "perfecltygeneric",
        config = {type = "using_consumeable"},
        loc_txt = {
            ['name'] = 'Perfectly Generic Tag',
            ['text'] = {
                [1] = 'Creates a paradox copy',
                [2] = 'Of your next used',
                [3] = 'Consumable'         
            }
        },
        pos = {
            x = 0,
            y = 0
        },
        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['c_fool']
            art_credit('akai', info_queue)
            -- PUT RELEVENT LOC VARS HERE WHEN YOU GET TO REWORDING THIS!!!!!!! - Delirium
            return {true}
        end,
        apply = function(self, tag, context)
            if context.using_consumeable and not (context.consumeable.ability.set == 'Aspect') then
                tag:yep("Ify!",G.C.Green,
                function()
                    SMODS.add_card({key = context.consumeable.config.center.key,edition = 'e_bstuck_paradox'})
                    return true
                end)
                tag.triggered = true
            end
        end
    }
end