function Balatrostuck.INIT.Jokers.j_aceDick()
    SMODS.Joker{
        name = 'Ace Dick',
        key = 'aceDick',
        config = {extra = {mult = 10, chips = 100}},
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return { vars = { card.ability.extra.mult, card.ability.extra.chips} }
        end,   
        loc_txt = {
            name = 'Ace Dick',
            text = {'{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips,',
                    'always goes last'},
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {x = 7, y = 8},
        cost = 7,
        rarity = 2,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.ace_dick and not context.blueprint then 
                
                --hand_chips = hand_chips + card.ability.extra.chips
                --mult = mult + card.ability.extra.mult
                --update_hand_text({delay = 0}, {chips = card.ability.extra.chips and hand_chips, mult = card.ability.extra.mult and mult})
                --card_eval_status_text(card,'mult',card.ability.extra.mult,nil,nil,{message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }})
                --card_eval_status_text(card,'chips',card.ability.extra.chips,nil,nil,{message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }})
                --return hand_chips, mult
                
                --i think all of that is not necessary as we can just return an effects table like so
                --not deleting it just in case
                return {chips = card.ability.extra.chips, mult = card.ability.extra.mult}
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end

