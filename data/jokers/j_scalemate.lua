function Balatrostuck.INIT.Jokers.j_scalemate()
    SMODS.Joker{
        name = "Scalemate",
        key = "scalemate",
        config = {
            extra = { mult = 7, ranks = {}, custom_name = false,
            names = {
                "Senator Lemonsnout",
                "Professor Pucefoot",
                "Inspector Berrybreath",
                "Doctor Honeytongue",
                "Duke Pinesnort",
                "Liaison Pumpkinsnuffle",
                "Officer Cinnamonwhiff"
            }
            }
        },
        loc_txt = {
            ['name'] = '#2#',
            ['text'] = {
                "3 {C:attention}ranks{} are drawn face down",
                "each round, {C:mult}+#1#{} Mult for each",
                "played face down card that scored"
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
            

            if context.setting_blind then
                local _ranks = card.ability.extra.ranks
                _ranks = {}
                for i=1,3 do
                    _ranks[#_ranks+1], _ = bstuck_get_random_rank("H3H3"..i,_ranks)
                end


            elseif context.stay_flipped and context.to_area == G.hand then
                
                for _,rank in ipairs(card.ability.extra.ranks) do
                    if context.other_card:get_id() == rank then
                        return {
                            stay_flipped = true
                        }
                    end
                end

            elseif context.modify_scoring_hand then --kinda silly but this seems to be the best context to do this..
                if context.other_card.facing == 'back' and not context.other_card.ability.scalemate_bonus then
                    context.other_card.ability.scalemate_bonus = true
                end
            elseif context.individual and context.cardarea == G.play and context.other_card.ability.scalemate_bonus then
                context.other_card.ability.scalemate_bonus = nil
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end

            
            
        end,
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            if not card.ability.extra.custom_name then
                card.ability.extra.custom_name = pseudorandom_element(card.ability.extra.names, pseudoseed("PLUSH13"..G.GAME.round_resets.ante))
            end
            return {vars = {card.ability.extra.mult, card.ability.extra.custom_name}}
        end,
        add_to_deck = function(self,card,from_debuff)
            local _ranks = card.ability.extra.ranks
            for i=1,3 do
                _ranks[#_ranks+1], _ = bstuck_get_random_rank("H3H3"..i,_ranks)
            end
        end,
    }
end 