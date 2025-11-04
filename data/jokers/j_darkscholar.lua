function Balatrostuck.INIT.Jokers.j_darkscholar()
    SMODS.Joker{
        -- I will need to come back to this to implement the art
        name = "Dark Scholar",
        key = "darkscholar",
        config = {
            extra = {
                h_size = 0,
                h_max = 5,

                Xmult_up = 3,
                Xmult_down = 0.5,

                tarot_used = false,
            }
        },
        pos = {
            x = 8, -- 7 for negative
            y = 12
         },
        -- loc_txt is in localization/default.lua
        cost = 10,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_negative']
            local returntable = {vars = {card.ability.extra.h_size, card.ability.extra.h_max, card.ability.extra.Xmult_up, card.ability.extra.Xmult_down} }
            
            self.pos = {x = 8, y = 12}
            art_credit('akai', info_queue)
            if card.config.center.discovered then
                local key, vars
                if card.edition and card.edition.key == "e_negative" then
                    returntable.key = self.key .. "_alt"
                    self.pos = {x = 7, y = 12}
                end
            end
            return returntable
        end,

        remove_from_deck = function(self, card, from_debuff)
            if card.edition and card.edition.negative then
                G.hand:change_size(-card.ability.extra.h_size)
            end
        end,

        calculate = function(self, card, context)
            if context.using_consumeable and not (card.edition and card.edition.key == "e_negative") and context.consumeable.ability.set == 'Tarot' and not context.blueprint then
                card.ability.extra.h_size = card.ability.extra.h_size + 1
                G.hand:change_size(1)

                if card.ability.extra.h_size == 5 then 
                    play_sound('bstuck_HomestuckGrimdark')
                    card:set_edition("e_negative")
                    card:juice_up(0.8, 0.5)
                    G.hand:change_size(-card.ability.extra.h_size)
                    card.ability.extra.h_size = 0
                    return {message = "Grimdark!", colour = G.C.DARK_EDITION}
                else
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_handsize', vars = {card.ability.extra.h_size}}})
                end
            end

            if context.setting_blind then
                card.ability.extra.tarot_used = false
            end

            if context.using_consumeable and (card.edition and card.edition.key == "e_negative") and context.consumeable.ability.set == 'Tarot' then
                card.ability.extra.tarot_used = true
            end

            if context.joker_main and (card.edition and card.edition.key == "e_negative") then
                return {Xmult = card.ability.extra.tarot_used and card.ability.extra.Xmult_up or card.ability.extra.Xmult_down}
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_descend' then
                unlock_card(self)
            end
        end
    }
end 