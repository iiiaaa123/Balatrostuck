function Balatrostuck.INIT.Jokers.j_hephaestus()
    SMODS.Joker{
        name = "Hephaestus",
        key = "hephaestus",
        config = {
            extra = 2
        },
        loc_txt = {
            ['name'] = 'Hephaestus',
            ['text'] = {
                [1] = 'Played and held',
                [2] = '{C:attention}Steel{} cards give',
                [3] = '{C:white,X:mult}X#1#{} Mult' 
            }
        },
        pos = {
            x = 2,
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
            x = 7,
            y = 9
        },
    
        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra}}
        end,

        calculate = function(self, context)
            if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) then
                local card = context.other_card
                if card.config.center == G.P_CENTERS.m_steel then
                    if context.other_card.debuff then
                        return {
                            message = localize('k_debuffed'),
                            colour = G.C.RED,
                            card = self,
                        }
                    else
                        return {
                            x_mult = self.ability.extra,
                            card = self
                        }
                    end
                end
            end
        end
    }
end