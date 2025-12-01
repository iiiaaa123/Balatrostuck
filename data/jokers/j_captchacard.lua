function Balatrostuck.INIT.Jokers.j_captchacard()
    SMODS.Joker{
        name = "Captchalogue Card",
        key = "captchacard",
        config = {
            extra = {mult = 7}
        },
        loc_txt = {
            ['name'] = 'Captchalogue Card',
            ['text'] = {
                [1] = "{C:red}+#1# Mult{} for each held {C:attention}consumable{} card",
                [2] = "{C:inactive}(Currently {C:red}+#2#{} {C:inactive}Mult)"
            }
        },
        loc_vars = function(self,info_queue,card)
            art_credit('akai', info_queue)
           return { vars = { card.ability.extra.mult, card.ability.extra.mult * (G.consumeables and #G.consumeables.cards or 0) } }
        end,
        pos = {
            x = 5,
            y = 0
        },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.joker_main then
            return {
                mult = card.ability.extra.mult * #G.consumeables.cards
            }
            end

        end
    }
end