--TODO: booster pack thang
function Balatrostuck.INIT.Tags.t_scratch()
    SMODS.Tag{
        key = "scratch",
        config = {type = "eval"},
        loc_txt = {
            ['name'] = 'Scratch Tag',
            ['text'] = {
                [1] = 'Restart current Ante,',
                [2] = 'convert all your {C:attention}Jokers{} ',
                [3] = 'into {C:attention}random Jokers{} with',
                [4] = 'the same rarity'            
            }
        },
        pos = {
            x = 2,
            y = 0
        },
        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            -- PUT RELEVENT LOC VARS HERE WHEN YOU GET TO REWORDING THIS!!!!!!! - Delirium
            return {true}
        end,
        apply = function(self, tag, context)
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                tag:yep("Ify!",G.C.Green,
                function()
                    G.GAME.round_resets.blind_states.Small = 'Current'
                    G.GAME.round_resets.blind_states.Big = 'Upcoming'
                    G.GAME.round_resets.blind_states.Boss = 'Upcoming'
                    return true
                end)
                tag.triggered = true
            end
        end
    }
end