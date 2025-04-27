function Balatrostuck.INIT.Jokers.j_crowbarsfelt()
    SMODS.Joker{
        name = "Crowbars Felt",
        key = "crowbarsfelt",
        config = {
            extra = {
                mult = 0,
                mult_gain = 7
            }
        },
        loc_txt = {
            ['name'] = 'Crowbars Felt',
            ['text'] = {
                [1] = "Gains {C:mult}+#2#{} Mult",
                [2] = "if played hand",
                [3] = "contains a {C:attention}Straight{}",
                [4] = "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
            }
        },
        pos = {
            x = 9,
            y = 4
         },
        cost = 99,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, infoqueue, card)
            return{ vars = {card.ability.extra.mult, card.ability.extra.mult_gain}}
        end,

        in_pool = function(self)
            return false
        end,

        calculate = function (self, card, context)
            if context.joker_main then
                return {
                  mult_mod = card.ability.extra.mult,
                  message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
          
            if context.before and next(context.poker_hands['Straight']) and not context.blueprint then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                  message = 'UPGRADED!',
                  colour = G.C.MULT,
                  card = card
                }
            end          
        end

    }
end 