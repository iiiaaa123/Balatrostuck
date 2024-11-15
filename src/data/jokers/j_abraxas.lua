function Balatrostuck.INIT.Jokers.j_abraxas()
    SMODS.Joker{
        name = "Abraxas",
        key = "abraxas",
        config = {
            extra = {
                h_plays = 3,
                h_size = 3
            }
        },
        loc_txt = {
            ['name'] = 'Abraxas',
            ['text'] = {
                [1] = '{C:blue}+#1#{} hands',
                [2] = '{C:attention}+#2# hand size'
            }
        },
        pos = {
            x = 1,
            y = 9
        },
        cost = 6,
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
            return {vars = {card.ability.extra.h_plays, card.ability.extra.h_size}}
        end
    }:register()
    
    -- local remove_from_deckref = Card.add_to_deck
    -- function Card:remove_from_deck(from_debuff)
    --     if self.ability.name == "Abraxas" and self.added_to_deck then
    --         self.added_to_deck = false
    --         G.hand:change_size(-self.ability.extra.h_size)
    --         G.GAME.round_resets.hands = G.GAME.round_resets.hands - self.ability.extra.h_plays
    --     end
    --     remove_from_deckref(self, from_debuff)
    -- end

    -- local add_to_deckref = Card.add_to_deck
    -- function Card:add_to_deck(from_debuff)
    --     if self.ability.name == "Abraxas" and not self.added_to_deck then
    --         self.added_to_deck = true
    --         G.hand:change_size(self.ability.extra.h_size)
    --         G.GAME.round_resets.hands = G.GAME.round_resets.hands + self.ability.extra.h_plays
    --     end
    --     add_to_deckref(self, from_debuff)
    -- end
end