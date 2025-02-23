function Balatrostuck.INIT.Jokers.j_jocker() 
    SMODS.Joker{
        name = "Jocker",
        key = "jocker",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Jocker',
            ['text'] = {
                [1] = 'Create a {C:dark_edition}Negative{}',
                [2] = 'copy of this Joker',
                [3] = 'after {C:attention}beating{} or',
                [4] = '{C:attention}skipping{} a blind',
            }
        },
        pos = { x = 5, y = 2},
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calculate = function (self,card,context)
            if context.setting_blind or context.skip_blind then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1

                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                    local _card = copy_card(card, nil, nil, nil, card.edition)
                    _card:set_edition({negative = true}, nil, true)
                    _card:add_to_deck()
                    G.jokers:emplace(_card)
                    _card:start_materialize()
                    G.GAME.joker_buffer = 0
                    return true
                    end
                }))
            end
        end
    }
end