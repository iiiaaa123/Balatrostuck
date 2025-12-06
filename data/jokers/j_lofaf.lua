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
                [1] = "{C:attention}Booster packs{} have {C:attention}+#1# ",
                [2] = "cards to choose from,",
                [3] = "{C:attention}+1{} at end of round",
                [4] = "{C:inactive}(Up to +3){}"
            },
            unlock = {"Create {C:attention}100{}", "{C:paradox}Paradox{} cards", "{C:inactive}(#1#){}"}
        },
        loc_vars = function(self,info_queue,card)
            art_credit('yokcos', info_queue)
            return {vars = {card.ability.extra.pack_bonus }}
        end,
        locked_loc_vars = function(self,info_queue,card)
            return {vars = {G.paradoxCounter or "0"}}
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_frostandfrogs' then
                unlock_card(self)
            end
        end,
        pos = {
            x = 3,
            y = 8
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers and card.ability.extra.pack_bonus < card.ability.extra.max then
                if card.ability.extra.pack_bonus == 0 then
                    card.ability.extra.pack_bonus = card.ability.extra.pack_bonus + 1
                    G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + card.ability.extra.pack_bonus
                else
                    card.ability.extra.pack_bonus = card.ability.extra.pack_bonus + 1
                    G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + (card.ability.extra.pack_bonus - card.ability.extra.pack_bonus+1)
                end
                return {
                    message = '+1 Booster Card!',
                    card = card
                }
            end
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) - card.ability.extra.pack_bonus
        end,
        add_to_deck = function(self,card,from_debuff)
            if from_debuff then
                G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + card.ability.extra.pack_bonus
            end
        end
    }
end 