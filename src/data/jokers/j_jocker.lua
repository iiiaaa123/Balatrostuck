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
                [1] = 'Creates a {C:dark_edition}Negative',
                [2] = '{C:attention}duplicate{} of itself',
                [3] = 'when a blind is',
                [4] = '{C:attention}selected{} or {C:attention}skipped'
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
                    local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jocker', 'jpg')
                    card:set_edition({negative = true}, nil, true)
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    card:start_materialize()
                    G.GAME.joker_buffer = 0
                    return true
                    end
                }))
            end
        end
    }
end