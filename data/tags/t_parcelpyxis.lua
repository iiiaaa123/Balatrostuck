--TODO: booster pack thang
function Balatrostuck.INIT.Tags.t_parcelpyxis()
    SMODS.Tag{
        key = "parcelpyxis",
        config = {type = "eval"},
        loc_txt = {
            ['name'] = 'Parcel Pyxis Tag',
            ['text'] = {
                [1] = 'Create {C:attention}2 {C:green}Paradox',
                [2] = '{C:spectral}Spectral{} cards that',
                [3] = 'create seals'
            }
        },
        pos = {
            x = 1,
            y = 0
        },
        atlas = 'HomestuckTags',

        in_pool = function(self)
            return (G.GAME.round_resets.ante > 1)
        end,

        loc_vars = function(self, info_queue, card)
            -- PUT RELEVENT LOC VARS HERE WHEN YOU GET TO REWORDING THIS!!!!!!! - Delirium
            return {true}
        end,
        
        apply = function(self, tag, context)
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                tag:yep("Ify!",G.C.Green,
                function()
                    for i = 1, 2 do
                        local seal_cards = {"c_talisman", "c_deja_vu", "c_trance", "c_medium", "c_bstuck_lotuscapsule"}
                        local _key = pseudorandom_element(seal_cards,pseudoseed('pyxis'))
                        local _card = SMODS.create_card({set = 'Spectral',area = G.consumeables, no_edition = true, key = _key})
                        _card:set_edition('e_bstuck_paradox',true,true)
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