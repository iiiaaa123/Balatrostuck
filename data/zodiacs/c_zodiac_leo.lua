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
        discovered = true,
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

                    if _card:get_id() == self.rank and pseudorandom('leo') < G.GAME.probabilities.normal/self.ability.config.odds then
                        if _card.debuff then
                            card_eval_status_text(_card, 'debuff')
                        else
                            card_eval_status_text(_card, 'dollars', self:level(context.other_card))
                            ease_dollars(self:level(context.other_card))
                        end
                    end
                end
            end
        end
    }
end