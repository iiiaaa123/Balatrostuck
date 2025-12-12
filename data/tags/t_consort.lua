
function Balatrostuck.INIT.Tags.t_consort()
    SMODS.Tag{
        key = "consort",
        config = {type = "eval"},
        loc_txt = {
            ['name'] = 'Consort Tag',
            ['text'] = {
                [1] = 'Fill empty consumable slots',
                [2] = 'with {C:tarot}The Fool{} cards',
                [3] = '{C:inactive} (Must have room)'
            }
        },
        pos = {
            x = 2,
            y = 1
        },
        atlas = 'HomestuckTags',
        
        in_pool = function(self)
            return (G.GAME.round_resets.ante > 1)
        end,

        atlas = 'HomestuckTags',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['c_fool']
            art_credit('akai', info_queue)
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