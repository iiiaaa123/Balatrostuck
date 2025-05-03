-- DONE: This joker doesn't need any more work unless something comes up
function Balatrostuck.INIT.Jokers.j_cruxitedowel() 
    SMODS.Joker{
        name = "Cruxite Dowel",
        key = "cruxitedowel",
        config = {
            extra = {
                first_consum = nil,
                second_consum = nil,
                index = {},
                tildeath = 3
            }
        },
        loc_txt = {
            ['name'] = 'Cruxite Dowel',
            ['text'] = {
                [1] = "{C:attention}Alchemize{} a {C:green}Paradox {C:purple}Tarot{} card every",
                [2] = "{C:attention}2{} {C:attention}non-{C:green}Paradox {C:attention}consumables{} used,",
                [3] = "destroyed after {C:attention}3{} {C:green}Paradox {C:purple}Tarots{} used",
                [4] = "{C:inactive}(Currently {C:attention}#1#{C:inactive}/2)"
            }
        },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            return { vars = {#card.ability.extra.index} }
        end,
        pos = {
            x = 4,
            y = 1
            },
        cost = 5,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function(self, card, context)
            if context.using_consumeable then
                local _card = context.consumeable
                local _pool = G.P_CENTER_POOLS[_card.config.center.set]
                local tarot_pool = G.P_CENTER_POOLS["Tarot"]
                local new_tarot = "c_fool"
                local alchemy = 0

                if not (_card.edition and _card.edition.key == 'e_bstuck_paradox') then
                    if card.ability.extra.first_consum then card.ability.extra.second_consum = _card.config.center.key end
                    if not card.ability.extra.first_consum then card.ability.extra.first_consum = _card.config.center.key end

                    for i = 1, table_length(_pool) do
                        if _pool[i].key == _card.config.center.key then 
                            card.ability.extra.index[#card.ability.extra.index+1] = i
                            break
                        end
                    end
    
                    if #card.ability.extra.index == 2 then 
                        alchemy = math.max(0, math.mod( bit.bor( math.abs(card.ability.extra.index[1]-card.ability.extra.index[2]), bit.lshift(card.ability.extra.index[1]+card.ability.extra.index[2], 21)) , 22 )) 
                        new_tarot = tarot_pool[alchemy].key
                        G.E_MANAGER:add_event(Event({
                            func = function()
                            local card = SMODS.create_card{key = new_tarot, no_edition = true}
                            card:set_edition('e_bstuck_paradox', true)
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            return true
                        end
                        }))
                        card.ability.extra.index = {}
                        card.ability.extra.first_consum = nil
                        card.ability.extra.second_consum = nil
                    end
                else
                    card.ability.extra.tildeath = card.ability.extra.tildeath-1
                    if card.ability.extra.tildeath == 0 then card:start_dissolve() end    
                end
            end
        end
    }
end
