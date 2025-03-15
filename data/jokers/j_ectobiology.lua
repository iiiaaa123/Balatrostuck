function Balatrostuck.INIT.Jokers.j_ectobiology()
    SMODS.Joker{
        name = "Ectobiology",
        key = "ectobiology",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Ectobiology',
            ['text'] = {
                [1] = "When {C:attention}Blind{} is selected, create a",
                [2] = "{C:paradox}Paradox{} copy of {C:attention}Joker{} to the right"
            }
        },
        pos = {
            x = 5,
            y = 3
         },
        cost = 10,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.setting_blind and context.cardarea == G.jokers then
                local other_joker = nil
                for i = 1, #G.jokers.cards - 1 do
                    if G.jokers.cards[i] == card then 
                        other_joker = G.jokers.cards[i+1]
                        break
                    end
                end
            
            
                if other_joker then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = function()
                            local _card = copy_card(other_joker, nil, nil, nil)
                            _card:start_materialize()
                            _card:set_edition('e_bstuck_paradox')
                            _card:add_to_deck()
                            G.jokers:emplace(_card)
                            G.GAME.joker_buffer = 0
                        return true
                        end
                    }))
                end
            end
        end
    }
end 