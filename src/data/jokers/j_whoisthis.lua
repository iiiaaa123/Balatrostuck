function Balatrostuck.INIT.Jokers.j_whoisthis()
    SMODS.Joker{
        name = "Who Even Is This?",
        key = "whoisthis",
        config = {
            extra = {
                -- current_joker = nil
            }
        },
        loc_txt = {
            ['name'] = 'Who Even Is This?',
            ['text'] = {
                [1] = 'Creates a random {C:dark_edition}Negative{}',
                [2] = 'joker when blind is selected,',
                [3] = 'Adjacent jokers are {C:red}destroyed{}',
                [4] = 'at the end of the round.'
            }
        },
        pos = {
            x = 6,
            y = 2
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calculate = function (self,card,context)
            if context.setting_blind then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
    
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                    local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'sou')
                    card:set_edition({negative = true}, nil, true)
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    card:start_materialize()
                    G.GAME.joker_buffer = 0
                    return true
                    end
                }))
            end
    
            if context.end_of_round then
                -- Ideally I'd like to have it destroy the exact joker it created, which works well
                -- Unless the game is saved and loaded, in which case it seems the reference to the created joker is mucked up
    
                -- if self.ability.extra.current_joker ~= nil then
                --     local card = self.ability.extra.current_joker
                --     card:start_dissolve()
    
                --     self.ability.extra.current_joker = nil
                -- end
    
                local my_pos = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then my_pos = i; break end
                end
    
                if my_pos and G.jokers.cards[my_pos+1] and not G.jokers.cards[my_pos+1].ability.eternal then 
                    local card = G.jokers.cards[my_pos+1]
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    G.E_MANAGER:add_event(Event({func = function()
                        G.GAME.joker_buffer = 0
                        card:start_dissolve()
                    return true end }))
                end
    
                if my_pos and G.jokers.cards[my_pos+1] and not G.jokers.cards[my_pos+1].ability.eternal then 
                    local card = G.jokers.cards[my_pos+1]
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    G.E_MANAGER:add_event(Event({func = function()
                        G.GAME.joker_buffer = 0
                        card:start_dissolve()
                    return true end }))
                end
            end
        end
    }
end