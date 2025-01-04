--TODO: booster pack thang
function Balatrostuck.INIT.Jokers.j_abraxas()
    SMODS.Joker{
        name = "Abraxas",
        key = "abraxas",
        config = {
            extra = {
                h_size = 4
            }
        },
        loc_txt = {
            ['name'] = 'Abraxas',
            ['text'] = {
                [1] = '{C:attention}+#1#{} hand size,',
                [2] = '{C:attention}Booster Packs{} have',
                [3] = '{C:attention}+#2#{} cards to choose from'
            }
        },
        pos = {
            x = 1,
            y = 9
        },
        cost = 20,
        rarity = 4,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        soul_pos = {
            x = 6,
            y = 9
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.h_size}}
        end,


        add_to_deck = function(self, card, from_debuff)
            G.hand:change_size(card.ability.extra.h_size)

        end,
    
        remove_from_deck = function(self, card, from_debuff)
            G.hand:change_size(-card.ability.extra.h_size)

        end
    }
    
    
end