function Balatrostuck.INIT.Jokers.j_captchacard()
    SMODS.Joker{
        name = "Captchalogue Card",
        key = "captchacard",
        config = {
            extra = {
                rank = 10,
                suit = "Hearts"
            }
        },
        loc_txt = {
            ['name'] = 'Captchalogue Card',
            ['text'] = {
                [1] = "Gives a random consumable",
                [2] = "when a {C:attention}#1# of #2#{} is played",
                [3] = "{C:inactive}Card changes every round{}"
            }
        },
        pos = {
            x = 5,
            y = 0
        },
        cost = 7,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_def = function(card)
            return {card.ability.extra.rank, card.ability.extra.suit}
        end
    }:register()
end