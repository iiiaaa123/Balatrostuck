-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_cascade()
    SMODS.Joker{
        name = "Cascade",
        key = "cascade",
        config = {
            extra = {
                retrigger_every = 5
            }
        },
        loc_txt = {
            ['name'] = 'Cascade',
            ['text'] = {
                [1] = '{C:attention}Retriggers{} each hand once',
                [2] = 'for every {C:attention}#1#{} levels that',
                [3] = 'the played {C:attention}poker hand{} has'
            }
        },
        pos = {
            x = 3,
            y = 7
        },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_def = function(card)
            return {card.ability.extra.retrigger_every}
        end,
        calculate = function (self, context)
            if context.repetition and context.cardarea == G.play and not (context.blueprint or context.idividual or context.after or context.before) then
                local text,disp_text = G.FUNCS.get_poker_hand_info(context.full_hand)
                local retrigs = math.floor(G.GAME.hands[text].level/self.ability.extra.retrigger_every)
    
                return {
                    message = localize('k_again_ex'),
                    repetitions = retrigs,
                    card = self
                }
            end
        end
    }:register()
end