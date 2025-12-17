function Balatrostuck.INIT.Jokers.j_therapture()
    SMODS.Joker{
        name = "The Rapture",
        key = "therapture",
        config = {
            extra = {
                x_mult = 0.25, gained_xmult = 1.00
            }
        },
        loc_txt = {
            ['name'] = 'The Rapture',
            ['text'] = {
                'This Joker gains {C:white,X:mult}X#1#{} Mult',
                'for each {C:attention}played card{}, all',
                'played cards are {E:2,C:red}destroyed',
                '{E:2,C:red}Sell this card to Game Over',
                '{C:inactive}(Currently {C:white,X:mult}X#2# {C:inactive} Mult)'
            },
            unlock = {'Unlocked by',
            'finishing Act 2'}
        },
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.x_mult, card.ability.extra.gained_xmult}}
        end,
        pos = {
            x = 4,
            y = 3
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.selling_self then
                G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false
            end
            
            if context.destroy_card and (context.cardarea == G.play or context.cardarea == 'unscored') then
                card.ability.extra.gained_xmult = card.ability.extra.gained_xmult + card.ability.extra.x_mult
                return true
            end

            if context.joker_main then
                return {
                    x_mult = card.ability.extra.gained_xmult,
                    card = card
                }
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_ascend' then
                unlock_card(self)
            end
        end
    }
end 