--TODO: booster pack thang
function Balatrostuck.INIT.Tags.t_parcelpyxis()
    SMODS.Tag{
        key = "parcelpyxis",
        config = {type = "eval"},
        loc_txt = {
            ['name'] = 'Parcel Pyxis Tag',
            ['text'] = {
                [1] = 'Fills consumable slots with Fool',
                [2] = 'cards'            
            }
        },
        pos = {
            x = 1,
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
                    while #G.consumeables.cards < G.consumeables.config.card_limit do
                        local _card = SMODS.create_card({set = 'Tarot',area = G.consumeables, no_edition = true, key = 'c_fool'})
                        _card:add_to_deck()
                        G.consumeables:emplace(_card)
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end)
                tag.triggered = true
            end
        end
    }
end