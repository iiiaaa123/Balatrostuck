function Balatrostuck.INIT.Jokers.j_complacencyofthelearned()
    SMODS.Joker{
        name = "Complacency of the Learned",
        key = "complacencyofthelearned",
        config = {
            extra = {
                x_mult = 7,
                scored = 0,
                triggers = 0
            }
        },
        loc_txt = {
            ['name'] = 'Complacency of the Learned',
            ['text'] = {
                [1] = "If a {C:attention}Lucky Card {C:green}succeeds{},",
                [2] = "{X:red,C:white}XMult{} equal to {C:attention}#1#{} multiplied",
                [3] = "by the number of times Lucky",
                [4] = "cards {C:attention}succeeded{}, divided by how",
                [5] = "many times cards were {C:attention}scored"
            },
            unlock = {'Unlocked by',
            'finishing Act 4'}
        },
        pos = {
            x = 8,
            y = 11
         },

        in_pool = function(self, args)
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(playing_card, 'm_lucky') then
                    return true
                end
            end
        return false
        end,

        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self,info_queue,card)
            art_credit('garb', info_queue)
            info_queue[#info_queue + 1 ] = G.P_CENTERS['m_lucky'] 
            return {
                vars = {card.ability.extra.x_mult}
            }
        end,

        calculate = function(self, card, context)
            if context.before and not context.blueprint then 
                card.ability.extra.scored = 0
                card.ability.extra.triggers = 0
            end
            if context.individual and context.cardarea == G.play and not context.blueprint then
                card.ability.extra.scored = card.ability.extra.scored + 1
                if context.other_card.lucky_trigger then
                    card.ability.extra.triggers = card.ability.extra.triggers + 1
                end
            end
            if card.ability.extra.triggers > 0 and context.cardarea == G.jokers and context.joker_main then
                return {
                    x_mult = card.ability.extra.x_mult * (card.ability.extra.triggers / card.ability.extra.scored),
                    card = card
                }
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_descend' then
                unlock_card(self)
            end
        end
    }
end 
