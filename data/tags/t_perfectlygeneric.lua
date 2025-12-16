--TODO: booster pack thang
function Balatrostuck.INIT.Tags.t_perfectlygeneric()
    SMODS.Tag{
        key = "perfecltygeneric",
        config = {type = "using_consumeable"},
        loc_txt = {
            ['name'] = 'Perfectly Generic Tag',
            ['text'] = {
                "Creates a {C:paradox}Paradox{} copy",
                "of the {C:attention}next{} consumable used",
                "{C:inactive} does not copy aspects"
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
            if context.type == self.config.type and not (context.consumeable.ability.set == 'Aspect') then
                tag:yep("-Ify!",G.C.Green, 
                function()
                    SMODS.add_card({key = context.consumeable.config.center.key,edition = 'e_bstuck_paradox'})
                    tag.triggered = true
                    return true
                end)
            end
        end
    }
end