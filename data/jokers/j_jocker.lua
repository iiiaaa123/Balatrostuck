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
                -- [1] = 'Create a {C:dark_edition}Negative{}',
                -- [2] = 'copy of this Joker',
                -- [3] = 'after {C:attention}beating{} or',
                -- [4] = '{C:attention}skipping{} a blind',
            }
        },
        pos = { x = 5, y = 2},
        cost = -3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_negative']
            art_credit('akai', info_queue)
            local balastuck = Sprite(0,0,(1*348/232)*1.6, 1.6,G.ASSET_ATLAS["bstuck_howhigh"], {x=0, y=0})
            balastuck.states.drag.can = false
            return {
                main_start = {BSUI.Col(BSUI.Config.Basic, {BSUI.Image(balastuck)})}
            }
         end,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.setting_blind and context.cardarea == G.jokers then 
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                        if #G.jokers.cards >= 2 ^ G.SETTINGS.bstuck_jocker_limit and G.SETTINGS.bstuck_jocker_limit ~= 13 then
                            G.E_MANAGER:clear_queue()
                            I_WARNED_YOU_ABOUT_THE_JOCKERS_BRO()
                        end
                        local _card = copy_card(card, nil, nil, nil, card.edition)
                        _card:start_materialize()
                        _card:add_to_deck()
                        _card:set_edition({negative = true}, true)
                        G.jokers:emplace(_card)
                        G.GAME.joker_buffer = 0
                        return true
                    end
                }))
            end
        end
    }
end