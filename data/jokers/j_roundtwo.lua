function Balatrostuck.INIT.Jokers.j_roundtwo() 
    SMODS.Joker{
        name = "Round 2",
        key = "roundtwo",
        config = {
            extra = { ante_scaling = 2
            }
        },
        loc_txt = {
            ['name'] = 'Round 2',
            ['text'] = {
            }
        },
        pos = {
            x = 6,
            y = 7
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        add_to_deck = function(self,card,from_debuff)
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * card.ability.extra.ante_scaling
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / card.ability.extra.ante_scaling
        end,
        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers and G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer) > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = SMODS.add_card({set = 'Joker', rarity = 3})
                        _card:start_materialize()
                        return true
                end}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.RED})
            end 

            if context.ending_shop then
                G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / card.ability.extra.ante_scaling
                card.ability.extra.ante_scaling = card.ability.extra.ante_scaling + 2
                G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * card.ability.extra.ante_scaling

                return {
                    message = 'X' .. card.ability.extra.ante_scaling .. ' Blind Requirement!',
                    card = card
                }
            end
        end

    }
end