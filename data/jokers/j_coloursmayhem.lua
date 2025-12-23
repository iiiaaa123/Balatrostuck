function Balatrostuck.INIT.Jokers.j_coloursmayhem()
    SMODS.Joker{
        name = "ColoUrs and Mayhem",
        key = "coloursmayhem",
        config = {
            extra = { xmult = 1,xmult_loss = 0.05, bonus_choices = 1
            }
        }, --1 more card can be chosen in a Booster Pack. Loses X0.05 Mult per Booster Pack opened (Currently: X1 Mult)

        loc_txt = {
            ['name'] = "ColoUrs and Mayhem",
            ['text'] = {
                "#3# more card can be chosen in a {C:attention}Booster Pack{}",
                "Loses {C:white,X:mult}X#2#{} Mult per {C:attention}Booster Pack{} opened",
                "({C:inactive}Currently:{} {C:white,X:mult}X#1#{}{C:inactive} Mult{})"
            }
        },
        pos = {
            x = 0,
            y = 4
        },

        
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = true,

        atlas = 'HomestuckJokersAnimated',
        animated = true,
        frames = 8,
        animation_speed = 20,

        calculate = function (self, card, context)
            if context.joker_main and context.cardarea == G.jokers then

                        if card.ability.extra.xmult ~= 1 then return {
                            message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                            Xmult_mod = card.ability.extra.xmult
                        } end
            end
            if context.open_booster and not context.blueprint then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_value = "xmult_loss",
                        operation = "-",
                        message_key = 'a_xmult_minus',
                        colour = G.C.RED
                    })
            end

        end,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) + card.ability.extra.bonus_choices
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) - card.ability.extra.bonus_choices
        end,

        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.xmult, card.ability.extra.xmult_loss, card.ability.extra.bonus_choices}}
        end,
    }
end 