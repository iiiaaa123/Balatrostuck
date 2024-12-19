function Balatrostuck.INIT.Jokers.j_sovereignslayer()
    SMODS.Joker{
        name = "Sovereign Slayer",
        key = "sovereignslayer",
        config = {
            extra = {
                trash_list = {}
            }
        },
        loc_txt = {
            ['name'] = 'Sovereign Slayer',
            ['text'] = {
                [1] = 'If played hand contains',
                [2] = 'a {C:attention}Flush{} and {C:spades}Spades{},',
                [3] = 'destroy all {C:attention}played cards',
            }
        },
        pos = {
            x = 8,
            y = 5
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calculate = function(self,card,context)
            if context.cardarea == G.jokers and context.before and not context.blueprint and (next(context.poker_hands["Flush"]) or next(context.poker_hands["Flush Five"]) or next(context.poker_hands["Flush House"]) or next(context.poker_hands["Straight Flush"])) then
                card.ability.extra.trash_list = {}
                local has_spades = false
                for _, v in ipairs(context.scoring_hand) do
                    if v:is_suit("Spades") then has_spades = true end
                end

                if has_spades then
                    for i=1, #context.full_hand do
                        card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.full_hand[i]
                    end                              
                end
            elseif context.destroying_card and not context.blueprint then
                for _, v in pairs(card.ability.extra.trash_list) do
                    if v == context.destroying_card then
                        return true
                    end
                end
                return nil
            end
        end
    }
end