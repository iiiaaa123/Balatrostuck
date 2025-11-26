function Balatrostuck.INIT.Jokers.j_impetuscombcharging()
    SMODS.Joker{
        name = "Impetus Comb Charging",
        key = "impetuscombcharging",
        config = {
            extra = {
                d6given = false,
                rerolls = 0
            },
        },
        loc_txt = {
            ['name'] = 'Impetus Comb Charging',
            ['text'] = {
                [1] = "First played {C:attention}Three of a Kind{}",
                [2] = "each ante gives a {C:attention}D6 tag{}.",
                [3] = "{C:green}Unleash Sepulcritude{} after {C:attention}20{} rerolls",
                [4] = "{C:inactive}(Currently {C:attention}#1#{C:inactive}/20 rerolls)"
            },
            unlock = {'Get an Aspect to',
                    'level 5 or higher'}
        },
        pos = {
            x = 0,
            y = 3
         },
        cost = 7,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = false,
        animated = false,
        frames = 8,
        animation_speed = 20,
        photosensitive = true,
        atlas = 'HomestuckJokersAnimated',

        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_TAGS['tag_d_six']
            art_credit('akai', info_queue)
            return{ vars = {card.ability.extra.rerolls}}
        end,

        check_for_unlock = function(self,args)
            if args.type == 'bstuck_impetus' then
                unlock_card(self)
            end
        end,

        calculate = function(self, card, context)
            if context.before and context.scoring_name == "Three of a Kind" and not card.ability.extra.d6given then
                add_tag(Tag('tag_d_six'))
                card.ability.extra.d6given = true
                return{message = "Triple!"}
            end

            if context.end_of_round and G.GAME.blind.boss and context.main_eval then
                card.ability.extra.d6given = false
            end

            if context.reroll_shop then
                card.ability.extra.rerolls = card.ability.extra.rerolls + 1
                if card.ability.extra.rerolls == 20 then 
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true end }))
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                        card:remove_from_deck()
                        card.config.center = G.P_CENTERS["j_bstuck_sepulcritude"]
                        card:set_ability(card.config.center.key,true)
                        card:add_to_deck()
                        return true 
                    end}))
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('tarot2', percent);card:juice_up(0.3, 0.3);return true end }))
                    card:juice_up(0.8, 0.5)
                    card.ability.extra_value = 7
                    card:set_cost()
                    play_sound('bstuck_HomestuckSword')
                    return{message = "Sepulchritude!"}
                end
            end
        end
    }
end 