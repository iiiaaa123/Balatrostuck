function Balatrostuck.INIT.Jokers.j_waywardvagabond()
    SMODS.Joker{
        name = "Wayward Vagabond", -- Must later be converted into Pawn Revolution
        key = "waywardvagabond",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Wayward Vagabond',
            ['text'] = {
                [1] = 'All {C:attention}Kings{} are debuffed',
                [2] = 'other cards give {C:mult}+4 Mult{}',
                [3] = 'when {C:attention}scored{} or {C:attention}held in hand'
            }
        },
        pos = {
            x = 9,
            y = 5
        },
        cost = 3,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calculate = function(self, context)
            if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) then
                if context.other_card:get_id() ~= 13 then
                    if context.cardarea == G.play then
                        return {
                            mult = 4,
                            card = card
                        }
                    elseif context.cardarea == G.hand then
                        return {
                            h_mult = 4,
                            card = card
                        }
                    end
                end
            end
        end
    }
end