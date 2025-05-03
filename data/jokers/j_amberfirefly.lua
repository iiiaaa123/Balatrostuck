function Balatrostuck.INIT.Jokers.j_amberfirefly()
    SMODS.Joker{
        name = "Amber Firefly",
        key = "amberfirefly",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Amber Firefly',
            ['text'] = {
                [1] = "Shuffle a random {C:paradox}Paradox",
                [2] = "card with a {C:purple}Purple Seal{} into",
                [3] = "deck when {C:attention}Blind{} is selected",
                [4] = "{C:attention}-1{} hand size"
            },
        unlock = {'Unlocked by',
                'finishing Act 1'}
        },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            info_queue[#info_queue + 1] = {key = 'purple_seal', set = 'Other'}
        end,
        pos = {
            x = 8,
            y = 1
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        discovered = false,
        atlas = 'HomestuckJokers',
        add_to_deck = function(self,card,from_debuff)
            G.hand:change_size(-1)
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.hand:change_size(1)
        end,
        calculate = function (self, card, context)
            if context.setting_blind then
                local firstmat = nil
                for i=1, 1 do
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local front = pseudorandom_element(G.P_CARDS, pseudoseed('cert_fr'))
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local _card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.c_base, {playing_card = G.playing_card})
                            _card:start_materialize({G.C.PARADOX},firstmat)
                            firstmat = true
                            _card:set_edition('e_bstuck_paradox',true,true)
                            _card:set_seal('Purple')
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
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 