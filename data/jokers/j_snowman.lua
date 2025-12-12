function Balatrostuck.INIT.Jokers.j_snowman()
    SMODS.Joker{
        name = "Snowman",
        key = "snowman",
        config = {
            extra = {
                cap = nil, --change this to an int to add a per-round cap
                mult = 0,
                mult_gain = 2, --amo
                times_procced = 0,

            }
        },
        loc_txt = {
            ['name'] = 'Snowman',
            ['text'] = {
                "This Joker gains {C:mult}+#2#{} Mult",
                "if played hand is a",
                "{C:attention}Pair{} of {C:attention}8s{}",
                "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"


            },
            unlock = {'Play an 8 with',
                    '{C:attention}Pareidolia{}'}
        },
        pos = {
            x = 3,
            y = 5
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.times_procced,card.ability.extra.cap}}
        end,
        calculate = function(self,card,context)
            if context.scoring_name == "Pair" and not context.blueprint and context.before then
                if card.ability.extra.cap and card.ability.extra.times_procced > card.ability.extra.cap then return end

                local _8count = 0
                for _, scored_card in ipairs(context.scoring_hand) do
                    if scored_card:get_id() == 8 and not scored_card.debuff then _8count = _8count + 1 end
                end
                if _8count == 2 then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                    card.ability.extra.times_procced = card.ability.extra.times_procced + 1
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
                end
            end
            if context.joker_main then
                if card.ability.extra.mult > 0 then return {
                        mult_mod = card.ability.extra.mult,
                        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                        colour = G.C.MULT
                    } 
                end
            end
            if context.end_of_round then
                card.ability.extra.times_procced = 0
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_snowman' then
                unlock_card(self)
            end
        end

    }
end 