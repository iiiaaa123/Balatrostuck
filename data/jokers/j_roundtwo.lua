function Balatrostuck.INIT.Jokers.j_roundtwo() 
    SMODS.Joker{
        name = "Umbral Ultimatum",
        key = "roundtwo",
        config = {
            extra = { 
                ante_scaling = 2,
                current_scaling  = 2
            }
        },
        loc_txt = {
            ['name'] = 'Umbral Ultimatum',
            ['text'] = {
                '{C:red}X#2#{} base Blind size',
                'Create a {C:red}Rare Joker{} when',
                '{C:attention}Boss Blind{} is defeated',
                '{C:inactive}Increases by X#1# each ante'
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 6,
            y = 7
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.ante_scaling, card.ability.extra.current_scaling}}
        end,
        add_to_deck = function(self,card,from_debuff)
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * card.ability.extra.current_scaling
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / card.ability.extra.current_scaling
        end,
        calculate = function(self,card,context)
            if G.GAME.blind.boss and context.end_of_round and context.cardarea == G.jokers then
                if G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer) > 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local _card = SMODS.add_card({set = 'Joker', rarity = 3})
                            _card:start_materialize()
                            return true
                    end}))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.RED})
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                    func = function()
                            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * card.ability.extra.ante_scaling
                            card.ability.extra.current_scaling = card.ability.extra.current_scaling * card.ability.extra.ante_scaling
                        return true; end})) 
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end

    }
end