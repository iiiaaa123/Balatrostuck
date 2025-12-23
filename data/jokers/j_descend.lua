-- TODO: Localization and calculation logic, make sure to replace description with just the mult after rounds are up
function Balatrostuck.INIT.Jokers.j_descend()
    SMODS.Joker{
        name = "Descend",
        key = "descend",
        config = {
            extra = {
                rounds_loc = 3,
                rounds_left = 3,
                mult_gain = 0.5,
                mult_total = 1
            }
        },
        -- loc_txt = {
        --     name = 'Descend', --would like to replace entire description with just "X1 Mult" for however much mult it has after the removal thangs
        --     text = {
        --         'After {C:attention}#1#{} rounds, set level',
        --         'of all {C:attention}poker hands{} to 1 and',
        --         'this Joker gains {C:white,X:mult}X#2#{} Mult',
        --         'per {C:attention}level removed{}',
        --         '{C:inactive}(Currently #3#/#1#)'
        --     },
        --     unlock = {'Unlocked by',
        --     'finishing Act 3'}
        -- },
        loc_vars = function (self, info_queue, card) 
            art_credit('lyman', info_queue)
            act_joker(4, "Purchase", info_queue)

            local key = self.key
            local table = {
                card.ability.extra.rounds_loc,
                card.ability.extra.mult_gain,
                3-card.ability.extra.rounds_left
            }
            if card.ability.extra.rounds_left == 0 then 
                key = key .. "_alt"
                table = {card.ability.extra.mult_total}
            end
            return {key = key, vars = table}
        end,
        pos = {
            x = 2,
            y = 7
         },
        cost = 9,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(Self,card,context)
            if context.joker_main then
                return {
                    x_mult = card.ability.extra.mult_total,
                    card = card
                }
            end

            
            
            if context.end_of_round and card.ability.extra.rounds_left >= 1 and context.cardarea == G.jokers then
                card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1 
                if card.ability.extra.rounds_left == 0 then
                    for k,v in pairs(G.GAME.hands) do
                        if v.level ~= 1 then
                            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(k, 'poker_hands'),chips = G.GAME.hands[k].chips, mult = G.GAME.hands[k].mult, level=G.GAME.hands[k].level})
                            local inc = reset_hand(card,k,false)
                            card.ability.extra.mult_total =  card.ability.extra.mult_total + (card.ability.extra.mult_gain*inc)
                            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
                        end
                    end

                    return {
                        message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.mult_total}},
                        colour = G.C.MULT,
                        card = card
                    }
                else
                    return {
                        message = card.ability.extra.rounds_left .. ' Left!',
                        card = card
                    }
                end
            end

        end,
        add_to_deck = function(self,card,from_debuff)
            -- check_for_unlock({type = 'bstuck_descend'})
            if G.GAME.pool_flags.bstuck_actprogress <= 3 then
                local _all_unlocked = true
                for k,v in ipairs(UnlockedByDescend) do
                    if G.P_CENTERS["j_bstuck_"..v].unlocked == false then 
                        G.P_CENTERS["j_bstuck_"..v].unlocked = true
                        _all_unlocked = false
                    end
                end
                if _all_unlocked == false then notify_bstuck_alert("j_bstuck_descend", 4) end
                G.GAME.pool_flags.bstuck_actprogress = 4
            end
        end,
        in_pool = function(self,args)
            return G.GAME.pool_flags.bstuck_actprogress >= 3
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_medium' then
                unlock_card(self)
            end
        end
    }
end