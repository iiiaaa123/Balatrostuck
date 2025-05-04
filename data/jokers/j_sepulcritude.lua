function Balatrostuck.INIT.Jokers.j_sepulcritude()
    SMODS.Joker{
        name = "Sepulchritude",
        key = "sepulcritude",
        config = {
            extra = {
                Xmult = 4
            }
        },
        loc_txt = {
            ['name'] = 'Sepulchritude',
            ['text'] = {
                "{X:mult,C:white}X#1#{} Mult if played hand",
                "contains a {C:attention}Three of a Kind",
                "and a scoring {C:attention}face{} card"

            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 20,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokersAnimated',
        animated = true,
        frames = 8,
        animation_speed = 20,
        photosensitive = true,

        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.Xmult}}
        end,

        calculate = function(self, card, context)
            if context.joker_main and context.scoring_name == "Three of a Kind" then
                local all_good = 0
                for i = 1, #G.play.cards do
                    if G.play.cards[i]:is_face() then all_good = all_good + 1 else all_good = 0 end
                end
                if all_good == 3 then
                    return {Xmult = card.ability.extra.Xmult}
                end
            end
        end
    }
end 