function Balatrostuck.INIT.Blinds.bl_manipulator()
    SMODS.Blind({
        key = 'manipulator',
        loc_txt = {
            name = 'The Manipulator',
            text = {'On play or discard create a paradox 8.',
                "It's always selected."}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=7},
        mult = 2,
        dollars = 5,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,instance,context)
            if context.hand_drawn and not context.first_hand_drawn then
                for _,card in pairs(G.hand.cards) do
                    if card.made_by_manipulator then return end --this gets called twice, so im making sure not to add 2 8s
                end
                local _card = SMODS.create_card({rank = "8",set = 'Base'})
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        _card:start_materialize({G.C.PARADOX},firstmat)
                        _card:set_edition('e_bstuck_paradox',true,true)
                        G.hand:emplace(_card)
                        G.hand:sort()
                        -- G.deck.config.card_limit = G.deck.config.card_limit + 1
                        delay(0.1)
                        return true
                    end}))
                _card.made_by_manipulator = true
                playing_card_joker_effects({_card})
                _card.ability.forced_selection = true
                G.hand:add_to_highlighted(_card)
            end
        end,


        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if (not as_legacy) and G.GAME.round_resets.ante >= 1 then return true end
            return false
        end
    })
end