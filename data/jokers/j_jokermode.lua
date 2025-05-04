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
            ['name'] = 'Joker Mode.',
            ['text'] = {
            },
            unlock = {'Unlocked by',
            'finishing Act 6'}
        },
        pos = {
            x = 6,
            y = 6
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {key='warn_bstuck_wip', set='Other'}
            art_credit('akai', info_queue)
            return{ vars = {card.ability.extra.chips, card.ability.extra.chip_gain}}
        end,

        in_pool = function(self)
            return Balatrostuck.peanut_gallery
        end,

        calculate = function (self, card, context)
            if context.joker_main then
                return {
                  chip_mod = card.ability.extra.chips,
                  message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
                }
            end
          
            if context.before and context.scoring_name == "Flush" and not context.blueprint then
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