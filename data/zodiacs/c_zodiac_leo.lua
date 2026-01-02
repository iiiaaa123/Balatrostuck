function Balatrostuck.INIT.Zodiacs.c_zodiac_leo()
    Balatrostuck.Zodiac{
        name = "Leo",
        key = "leo",
        config = {
        },
        pos = {
            x = 3,
            y = 0
        },
        loc_txt = {
            name = "Leo",
            text = {
                'Each {C:attention}held 5{} has a {C:green}#1# in 4{} chance',
                'to give {C:money}$#2#{} when any',
                'played card is scored',
            }
        },
        cost = 4,
        discovered = false,
        atlas = "HomestuckZodiacs",
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('timpani', 0.7)
                play_sound('bstuck_HomestuckBloodDrop', 1)
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Leo')
        end,
        can_use = function() return true end,
    }

    Balatrostuck.Caste{
        key = 'Leo',
        config = {base_money = 4, odds = 4},
        name = 'Leo',
        rank = 5,
        apply = function(self,context)
            if context.individual and self:level(context.other_card) < 1 then return end

            if context.individual and context.cardarea == G.play then
                for i=1, #G.hand.cards do
                    _card = G.hand.cards[i]

                    if _card:get_id() == self.rank then
                        if _card.debuff then
                            card_eval_status_text(_card, 'debuff')
                        else
                            if pseudorandom('leo') < G.GAME.probabilities.normal/self.ability.config.odds then
                                SMODS.calculate_context({zodiac_triggered = true, zodiac = self})
                                card_eval_status_text(_card, 'dollars', self:level(context.other_card))
                                ease_dollars(self:level(context.other_card))
                            end

                            --calculate if we need to retrigger due to mime or similar
                            local _rep_context = {}
                            SMODS.calculate_context({repetition = true, cardarea = G.hand, card_effects = {{1,2},2,3}},_rep_context) --dummy card effect, does nothing but needs this structure
 
                            

                            local _repjokers = {}
                            for _, value in pairs(_rep_context) do
                                if value.jokers then
                                    if value.jokers.repetitions then
                                        for i=1, value.jokers.repetitions do
                                            table.insert(_repjokers,value.jokers.card)
                                        end
                                    end
                                elseif value.seals then
                                    if value.seals.card == _card then
                                        if value.seals.repetitions then
                                            for i=1, value.seals.repetitions do
                                                table.insert(_repjokers,_card) --"_repjokers is just which cards to say "Again!" on.
                                            end
                                        end
                                    end
                                end
                                
                            end
                            for i=1, #_repjokers do
                                if pseudorandom('leo'..i) < G.GAME.probabilities.normal/self.ability.config.odds then
                                    SMODS.calculate_context({zodiac_triggered = true, zodiac = self})
                                    card_eval_status_text(_repjokers[i], 'extra', nil, nil, nil, {message = localize('k_again_ex')})
                                    card_eval_status_text(_card, 'dollars', self:level(context.other_card))
                                    ease_dollars(self:level(context.other_card))
                                    delay(0.3)
                                end
                            end
                        end
                    end
                end
            end
        end
    }
end