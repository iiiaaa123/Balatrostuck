function Balatrostuck.INIT.Jokers.j_hegemonicbrute()
    SMODS.Joker{
        name = "Hegemonic Brute",
        key = "hegemonicbrute",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Hegemonic Brute',
            ['text'] = {
                [1] = 'If played hand contains',
                [2] = 'a {C:attention}Flush{} and {C:hearts}Hearts{},',
                [3] = 'increase rank of all',
                [4] = '{C:attention}played cards{} by {C:attention}1',
            }
        },
        pos = {
            x = 6,
            y = 5
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        
        calculate = function(self,card,context)
            if context.cardarea == G.jokers and context.before and (next(context.poker_hands["Flush"]) or next(context.poker_hands["Flush Five"]) or next(context.poker_hands["Flush House"]) or next(context.poker_hands["Straight Flush"])) then
                local has_hearts = false
                for _, v in ipairs(context.scoring_hand) do
                    if v:is_suit("Hearts") then has_hearts = true end
                end

                if has_hearts then
                    for _, v in ipairs(context.full_hand) do
                        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                            local suit_prefix = string.sub(v.base.suit, 1, 1)..'_'
                            local rank_suffix = v.base.id == 14 and 2 or math.min(v.base.id+1, 14)
                            if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                            elseif rank_suffix == 10 then rank_suffix = 'T'
                            elseif rank_suffix == 11 then rank_suffix = 'J'
                            elseif rank_suffix == 12 then rank_suffix = 'Q'
                            elseif rank_suffix == 13 then rank_suffix = 'K'
                            elseif rank_suffix == 14 then rank_suffix = 'A'
                            end
                            v:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                        return true end }))

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:juice_up()
                                return true
                            end
                        })) 
                    end
                end
            end
        end
    }
end