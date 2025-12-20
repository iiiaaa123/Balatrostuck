--TODO: booster pack thang
function Balatrostuck.INIT.Tags.t_perfectlygeneric()
    SMODS.Tag{
        key = "perfecltygeneric",
        config = {type = "eval"},
        loc_txt = {
            ['name'] = 'Perfectly Generic Tag',
            ['text'] = {
                "Creates a {C:paradox}Paradox{} copy",
                "of the {C:attention}next{} consumable used"
            }
        },
        pos = {
            x = 0,
            y = 0
        },
        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            -- PUT RELEVENT LOC VARS HERE WHEN YOU GET TO REWORDING THIS!!!!!!! - Delirium
            return {true}
        end,
        apply = function(self, tag, context)
            if context.type == 'using_consumeable' and not (context.consumeable.ability.set == 'Aspect') then
                tag:yep("-Ify!",G.C.Green, 
                function()
                    bstuck_add_paradox_card({key = context.consumeable.config.center.key})
                    tag.triggered = true
                    return true
                end)
            
            end
        end
    }
end