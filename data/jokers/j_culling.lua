function Balatrostuck.INIT.Jokers.j_culling()
    SMODS.Joker{
        name = "Culling",
        key = "culling",
        config = {
            extra = {mult = 0, mult_gain = 1, rank1 = {rank = 'Ace'}, rank2 = {rank = '2'}}
        },
        loc_txt = {
            ['name'] = 'Culling',
            ['text'] = {
                [1] = "This Joker gains {C:mult}+#1#{} Mult", 
                [2] = "per discarded {C:attention}#2#{} or {C:attention}#3#{},",
                [3] = "ranks change every round,",
                [4] = "face cards excluded",
                [5] = "{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult)"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 3,
            y = 12
         },
        cost = 5,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.mult_gain,card.ability.extra.rank1.rank or 'Ace',card.ability.extra.rank2.rank or '2',card.ability.extra.mult}}
        end,
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end

            if (context.discard and context.other_card:get_id() == card.ability.extra.rank1.id) or (context.discard and context.other_card:get_id() == card.ability.extra.rank2.id) then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                    return {
                        message = localize('k_upgrade_ex'),
                        card = card,
                        colour = G.C.MULT
                    }

            elseif context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
                self.get_next_card(self,card)
                return {}
            end

        end,
        add_to_deck = function(self,card,from_debuff)
            self.get_next_card(self,card)
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end,
        get_next_card = function(self,card,args)
            --very clunky, could be refactored into a loop
            local valid_culling_cards = {}
            for k, v in ipairs(G.playing_cards) do
                if v.ability.effect ~= 'Stone Card' and not v:is_face() then
                    if not SMODS.has_no_rank(v) then
                        valid_culling_cards[#valid_culling_cards+1] = v
                    end
                end
            end
            if valid_culling_cards[1] then 
                local culling_card, index = pseudorandom_element(valid_culling_cards, pseudoseed('culling'..G.GAME.round_resets.ante))
                card.ability.extra.rank1.rank = culling_card.base.value
                card.ability.extra.rank1.id = culling_card.base.id
                table.remove(valid_culling_cards, index)
            else
                card.ability.extra.rank1.rank = "None!"

            end

            local valid_culling_cards = {}
            for k, v in ipairs(G.playing_cards) do
                if v.ability.effect ~= 'Stone Card' and not v:is_face() and v.base.id ~= card.ability.extra.rank1.id then
                    if not SMODS.has_no_rank(v) then
                        valid_culling_cards[#valid_culling_cards+1] = v
                    end
                    
                end
            end
            if valid_culling_cards[1] then
                local culling_card = pseudorandom_element(valid_culling_cards, pseudoseed('cullingx'..G.GAME.round_resets.ante)) --made the seeds different to avoid patterns
                card.ability.extra.rank2.rank = culling_card.base.value
                card.ability.extra.rank2.id = culling_card.base.id
            else
                card.ability.extra.rank2.rank = "None!"
            end

        end
    }
end 