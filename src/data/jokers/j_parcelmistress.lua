function Balatrostuck.INIT.Jokers.j_parcelmistress()
    SMODS.Joker{
        name = "Parcel Mistress",
        key = "parcelmistress",
        config = {
            extra = {mult = 7, seal_count = 0}
        },
        loc_txt = {
            ['name'] = 'Parcel Mistress',
            ['text'] = {
                [1] = "{C:mult}+#1#{} mult for each",
                [2] = "card with a seal",
                [3] = "in your full deck",
                [4] = "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
            }
        },
        loc_vars = function(self,info_queue,card)
            return {vars = {card.ability.extra.mult,card.ability.extra.mult * card.ability.extra.seal_count}}
        end,
        pos = {
            x = 2,
            y = 0
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            card.ability.extra.seal_count = 0
            for _, v in ipairs(G.playing_cards) do
                if v:get_seal(true) then
                    card.ability.extra.seal_count = card.ability.extra.seal_count + 1
                end
            end

            if context.joker_main then
                return {
                    mult = card.ability.extra.seal_count * card.ability.extra.mult,
                    card = card
                }
            end
        end
    }
end 