
function Balatrostuck.INIT.Tags.t_carapacian()
    SMODS.Tag{
        key = "carapacian",
        config = {type = "immediate"},
        loc_txt = {
            ['name'] = 'Carapacian Tag',
            ['text'] = {
                [1] = 'Create two',
                [2] = 'random Tags'            
            }
        },
        pos = {
            x = 1,
            y = 1
        },
        atlas = 'HomestuckTags',
        

        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)

            return {true}
        end,

        apply = function(self, tag, context)
                local lock = tag.ID
                if context.type == self.config.type then
                    tag:yep("Tags!",G.C.Green, 
                    function()
                        
                        bstuck_give_random_tag("carapace","tag_bstuck_carapacian")
                        bstuck_give_random_tag("carapace2","tag_bstuck_carapacian")

                    return true
                    end)
                    tag.triggered = true
                end
        end,
    }
end