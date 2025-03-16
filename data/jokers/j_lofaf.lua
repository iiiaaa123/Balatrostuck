-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_lofaf()
    SMODS.Joker{
        name = "Frost and Frogs",
        key = "lofaf",
        config = {
            extra = {pack_bonus = 0, max = 3}
        },
        loc_txt = {
            ['name'] = 'Frost and Frogs',
            ['text'] = {
                [1] = "{C:attention}Booster packs{} have {C:attention}+0 ",
                [2] = "cards to choose from,",
                [3] = "{C:attention}+1{} at end of round",
                [4] = "{C:inactive}(Up to +3){}"
            }
        },
        loc_vars = function(self,info_queue,card)
            return {vars = {card.ability.extra.pack_bonus}}
        end,
        pos = {
            x = 3,
            y = 8
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers and card.ability.extra.pack_bonus < card.ability.extra.max then
                if card.ability.extra.pack_bonus == 0 then
                    card.ability.extra.pack_bonus = card.ability.extra.pack_bonus + 1
                    G.GAME.BALATROSTUCK.pack_size_bonus = G.GAME.BALATROSTUCK.pack_size_bonus + card.ability.extra.pack_bonus
                else
                    card.ability.extra.pack_bonus = card.ability.extra.pack_bonus + 1
                    G.GAME.BALATROSTUCK.pack_size_bonus = G.GAME.BALATROSTUCK.pack_size_bonus + (card.ability.extra.pack_bonus - card.ability.extra.pack_bonus+1)
                end
                return {
                    message = '+1 Booster Card!',
                    card = card
                }
            end
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.GAME.BALATROSTUCK.pack_size_bonus = G.GAME.BALATROSTUCK.pack_size_bonus - card.ability.extra.pack_bonus
        end,
        add_to_deck = function(self,card,from_debuff)
            if from_debuff then
                G.GAME.BALATROSTUCK.pack_size_bonus = G.GAME.BALATROSTUCK.pack_size_bonus + card.ability.extra.pack_bonus
            end
        end
    }
end 