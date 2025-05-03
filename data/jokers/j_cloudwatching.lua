function Balatrostuck.INIT.Jokers.j_cloudwatching()
    SMODS.Joker{
        name = "Cloudwatching",
        key = "cloudwatching",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Cloudwatching',
            ['text'] = {
                [1] = "When round begins, create a {C:green}Paradox{} copy of",
                [2] = "the {C:attention}15th card{} from the top of your {C:attention}deck",
                [3] = "and add it to your {C:attention}hand"
            }
        },
        pos = {
            x = 9,
            y = 10
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.first_hand_drawn then
                local firstmat = nil
                for i=1, 1 do
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local _card = copy_card(G.deck.cards[#G.deck.cards - 14])
                            _card:start_materialize({G.C.PARADOX},firstmat)
                            firstmat = true
                            _card:set_edition('e_bstuck_paradox',true,true)
                            G.hand:emplace(_card)
                            G.GAME.blind:debuff_card(_card)
                            G.hand:sort()
                            if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
                            -- G.deck.config.card_limit = G.deck.config.card_limit + 1
                            delay(0.1)
                            return true
                        end}))
                    playing_card_joker_effects({_card})
                end
            end
        end,           
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
        end
    }
end 