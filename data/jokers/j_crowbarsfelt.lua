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
            },
            unlock = {'Unlocked by',
            'finishing Act 6'}
        },
        pos = {
            x = 9,
            y = 4
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return{ vars = {card.ability.extra.mult, card.ability.extra.mult_gain}}
        end,

        in_pool = function(self)
            if next(SMODS.find_card('j_bstuck_yourlordandmaster')) then return true else return false end
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
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_collide' then
                unlock_card(self)
            end
        end
    }
end 