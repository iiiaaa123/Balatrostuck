function Balatrostuck.INIT.Jokers.j_frogbreeding()
    SMODS.Joker{
        name = "Frog Breeding",
        key = "frogbreeding",
        config = {
            extra = {
                rounds = 5,
                active = true,
            }
        },
        loc_txt = {
            ['name'] = 'Frog Breeding',
            ['text'] = {
                [1] = "Create a {C:paradox}Paradox{} copy",
                [2] = "of the {C:attention}first{} consumable",
                [3] = "used each round",
                [4] = "{C:inactive}({C:attention}#1#{C:inactive} rounds remaining)"
            }
        },
        pos = {
            x = 5,
            y = 10
         },
        cost = 6,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            art_credit('garb', info_queue)
            return {vars = {card.ability.extra.rounds}}
        end,
        calculate = function(self,card,context)
            if context.end_of_round and context.main_eval then
                card.ability.extra.active = true
                card.ability.extra.rounds = card.ability.extra.rounds - 1
                if card.ability.extra.rounds == 0 then card:start_dissolve() end
                return {
                    message = card.ability.extra.rounds .. ' Rounds left!',
                    card = card
                }
            end

            if context.using_consumeable and card.ability.extra.active and not (context.consumeable.ability.set == 'Aspect') then
                card.ability.extra.active = false
                bstuck_add_paradox_card({key = context.consumeable.config.center.key})
                return {
                    message = 'Cloned!',
                    card = card
                }
            end
        end
    }
end 