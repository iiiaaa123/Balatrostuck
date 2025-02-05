function Balatrostuck.INIT.Jokers.j_theplotpoint()
    SMODS.Joker{
        name = "The Plot Point",
        key = "theplotpoint",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'The Plot Point',
            ['text'] = {
                [1] = "Sell this joker: Destroy all jokers except leftmost",
                [2] = "Gain a Black Hole and -1 ante. Once per game."
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.selling_self then
                ease_ante(-1)
                for j = 2, #G.jokers.cards do 
                    if G.jokers.cards[j] ~= card and not G.jokers.cards[j].eternal then
                        G.jokers.cards[j]:start_dissolve()
                        G.jokers.cards[j]:remove_from_deck()
                    end
                end
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    local blackhole = SMODS.create_card({set = 'Zodiac', key = 'c_black_hole'})
                    blackhole:add_to_deck()
                    G.consumeables:emplace(blackhole)
                    G.GAME.consumeable_buffer = 0
                end
            end
        end
    }
end 