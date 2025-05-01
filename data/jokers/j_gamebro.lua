function Balatrostuck.INIT.Jokers.j_gamebro()
    SMODS.Joker{
        name = "Game Bro",
        key = "gamebro",
        config = {
            extra = {
                odds = 0,
                odds_divisor = 5,
                mult = 0,
                mult_increase = 10,
                odds_increase = 1
            }
        },
        loc_txt = {
            ['name'] = 'Game Bro',
            ['text'] = {
                [1] = "{C:green}#1# in #2#{} chance to give {C:mult}+#3#{} Mult,",
                [2] = "{C:mult}+#4#{} Mult and increase {C:green}probability{} by {C:attention}#5#",
                [3] = "for each scoring {C:attention}Bonus Card{} in played hand"
            },
            unlock = {'Unlocked by',
            'obtaining Descend'}
        },
        pos = {
            x = 2,
            y = 10
         },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        enhancement_gate = 'm_bonus',
        atlas = 'HomestuckJokers',

        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = G.P_CENTERS.m_bonus 
            return {vars = {card.ability.extra.odds, card.ability.extra.odds_divisor, card.ability.extra.mult, card.ability.extra.mult_increase, card.ability.extra.odds_increase}}
        end,

        calculate = function(self, card, context)                
            if context.joker_main and context.cardarea == G.jokers then
                if not context.blueprint then
                    for k, v in ipairs(context.scoring_hand) do
                        if SMODS.get_enhancements(v).m_bonus == true then
                            card.ability.extra.odds = card.ability.extra.odds + card.ability.extra.odds_increase
                            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_increase
                        end
                    end
                end
                if pseudorandom("tokeepitreal") < card.ability.extra.odds / card.ability.extra.odds_divisor then
                    return{
                        mult_mod = card.ability.extra.mult,
                        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                    }
                end
            elseif context.after then 
                card.ability.extra.odds = 0
                card.ability.extra.mult = 0
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_descend' then
                unlock_card(self)
            end
        end
    }
end 