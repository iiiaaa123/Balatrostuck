function Balatrostuck.INIT.Zodiacs.c_zodiac_ophiuchus()
    Balatrostuck.Zodiac{
        name = "Ophiuchus",
        key = "ophiuchus",
        config = {
        },
        pos = {
            x = 5,
            y = 1
        },
        loc_txt = {
            name = "Ophiuchus",
            text = {
                "When played {C:attention}Kings{} are scored, a",
                "random card held in hand becomes",
                "{C:paradox}Paradox{} and gives {X:mult,C:white}X#1#{} Mult", --next level value
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
            self:add_caste('Ophiuchus')
        end,
        can_use = function() return true end,
    }

    Balatrostuck.Caste{
        key = 'Ophiuchus',
        config = {},
        name = 'Ophiuchus',
        rank = 13,
        apply = function(self,context)
            if context.individual and self:level(context.other_card) < 1 then return end
        
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                return {
                    x_mult = 1.25 ^ self:level(context.other_card),
                    card = context.other_card,
                    func = function()
                        local possible_choices = {}
                        for i=1, #G.hand.cards do 
                            if not G.hand.cards[i].edition and not G.hand.cards[i].alreadyDead then
                                table.insert(possible_choices,G.hand.cards[i])
                            end
                        end
                        if #possible_choices >= 1 then
                            local _card = pseudorandom_element(possible_choices,pseudoseed('Looking for me?  O  '))
                            _card.alreadyDead = true
                            G.E_MANAGER:add_event(Event({func = function()
                                play_sound('bstuck_HomestuckParadox',0.7)
                                _card:juice_up()
                                _card:set_edition('e_bstuck_paradox',true,true)
                                _card.alreadyDead = false
                                return true
                            end}))
                            SMODS.calculate_effect({xmult = 1.25 ^ self:level(_card)}, _card)


                            --calculate retriggers due to mime or other effects
                            --basically reimplements seals and retriggers
                            --checks for joker effects & seals that retrigger cards held in hand
                            --if a zodiac or slab does this, it will need to be added here.
                            --it should probably be its own function
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
                                card_eval_status_text(_repjokers[i], 'extra', nil, nil, nil, {message = localize('k_again_ex')})
                                SMODS.calculate_effect({xmult = 1.25 ^ self:level(_card)}, _card)
                                delay(0.3)
                            end
                            
                        end
                    end
                }
            end
        end
    }



end