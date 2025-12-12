function Balatrostuck.INIT.Jokers.j_blackjack()
    SMODS.Joker{
        name = "Rules Card for Blackjack",
        key = "blackjack",
        config = {
            extra = { activated = false
            }
        },
        loc_txt = {
            ['name'] = "Rules Card for Blackjack",
            ['text'] = {
                "If the {C:attention}sum{} of the played",
                "cards' {C:attention}ranks{} is 21",
                "this gives +{C:mult}21{} mult",
                "and all played cards {C:attention}score{}",
                "{C:inactive} (Face cards are 10, Aces are 1 or 11)"
            }
        },
        pos = {
            x = 9,
            y = 12
        },

        
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.modify_scoring_hand then
                local _total_chips = 0
                local _ace_count = 0
                if #context.full_hand == 0 then return end
                for _, played_card in ipairs(context.full_hand) do
                    if played_card.ability.effect ~= 'Stone Card' then 
                        _total_chips = _total_chips + played_card.base.nominal
                        if played_card.base.nominal == 11 then _ace_count = _ace_count + 1 end
                    end
                end
                while _ace_count > 0 do
                        if _total_chips == 21 then break end
                        _total_chips = _total_chips - 10
                        _ace_count = _ace_count -1
                end

                
                if _total_chips == 21 then 
                    card.ability.extra.activated = true
                    return { add_to_hand = true }

                end
            end
            if context.joker_main then 
                if card.ability.extra.activated then 
                    card.ability.extra.activated = false
                    return {
                        mult_mod = 21,
                        message = localize { type = 'variable', key = 'a_mult', vars = { 21 } },
                        colour = G.C.MULT
                    } 
                end
            end
        end,
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {G.GAME.probabilities.normal}}
        end,
    }
end 