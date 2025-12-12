-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_lohac()
    SMODS.Joker{
        name = "Heat and Clockwork",
        key = "lohac",
        config = {
            extra = {
                hands = 2,
                active = false,
                event_fired = false
            }
        },
        loc_txt = {
            ['name'] = 'Heat and Clockwork',
            ['text'] = {
                [1] = "Gain {C:blue}+#1#{} Hands when {C:attention}Blind{} is",
                [2] = "selected if previous round's",
                [3] = "score was {C:attention,E:2,S:1.1}set on fire"

            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 1,
            y = 8
        },
        cost = 8,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function (self, info_queue, card)
            art_credit('yokcos', info_queue)
            return {vars = {card.ability.extra.hands}}
        end,
        calculate = function (self, card, context)

            
            
            if context.setting_blind and card.ability.extra.active then
                ease_hands_played(card.ability.extra.hands)
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_hands', vars = {card.ability.extra.hands}}})
                if not context.blueprint_card then card.ability.extra.active = false end
            end
            if not card.ability.extra.active and not card.ability.extra.event_fired then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        if G.ARGS.score_intensity.earned_score <  G.ARGS.score_intensity.required_score then
                            return false
                        end
                        card.ability.extra.active = true
                        card.ability.extra.event_fired = false
                        local eval = function() return card.ability.extra.active end
                        juice_card_until(card, eval, true)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active')})
                        return true
                    end,
                    blocking = false
                }))
                card.ability.extra.event_fired = true
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 