-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_jokermode() 
    SMODS.Joker{
        name = "Joker Mode",
        key = "jokermode",
        config = {
            extra = {
                chips = 0,
                chip_gain = 25
            }
        },
        loc_txt = {
            ['name'] = 'Joker Mode',
           ['text'] = {
                [1] = "{C:zodiac}Gains {C:chips}+#2#{} {C:zodiac}Chips",
                [2] = "{C:zodiac}if played hand",
                [3] = "{C:zodiac}contains a {C:attention}Flush{}",
                [4] = "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
            },
            unlock = {'Unlocked by',
            'finishing Act 6'}
        },
        pos = {
            x = 6,
            y = 6
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
            return{ vars = {card.ability.extra.chips, card.ability.extra.chip_gain}}
        end,

        in_pool = function(self)
            if next(SMODS.find_card('j_bstuck_yourlordandmaster')) then return true else return false end
        end,

        calculate = function (self, card, context)
            if context.joker_main then
                return {
                  chip_mod = card.ability.extra.chips,
                  message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
                }
            end
          
            if context.before and next(context.poker_hands['Flush']) and not context.blueprint then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
                return {
                  message = 'UPGRADED!',
                  colour = G.C.CHIPS,
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