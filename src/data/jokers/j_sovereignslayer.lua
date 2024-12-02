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
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calculate = function(self,card,context)
            if context.cardarea == G.jokers and context.after and (next(context.poker_hands["Flush"]) or next(context.poker_hands["Flush Five"]) or next(context.poker_hands["Flush House"]) or next(context.poker_hands["Straight Flush"])) then
                local has_spades = false
                for _, v in ipairs(context.scoring_hand) do
                    if v:is_suit("Spades") then has_spades = true end
                end

                if has_spades then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function() 
                            for i=1, #context.full_hand, 1 do
                                local _card = context.full_hand[i]
                                table.insert(card.ability.extra.trash_list, _card)
                                if _card.ability.name == 'Glass Card' then 
                                    _card:shatter()
                                else
                                    _card:start_dissolve(nil, i == #context.full_hand)
                                end
                            end
                            return true end }))
                end
            elseif context.end_of_round then
                if not context.blueprint and not context.repetition and not context.individual then
                    for i = 1, #card.ability.extra.trash_list do
                        card.ability.extra.trash_list[i]:start_dissolve(nil, true, 0, true)
                    end
                    card.ability.extra.trash_list = {}
                end
            end
        end
    }
end