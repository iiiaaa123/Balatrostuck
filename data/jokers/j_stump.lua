function Balatrostuck.INIT.Jokers.j_stump()
    SMODS.Joker{
        name = 'The Stump',
        key = 'stump',
        config = {extra = {chance = 2}},
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return { vars = { card.ability.extra.chance} }
        end,   
        loc_txt = {
            name = 'The Stump',
            text = {
                '{C:green}1 in #1#{} chance to', 
                'prevent Death,',
                'odds {C:red}cannot{}',
                'be changed'
                },
            unlock = {'Unlocked by',
            'finishing Act 3'}
        },
        pos = {x = 6, y = 8},
        cost = 6,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            card.ability.extra.chance = 1
            for j = 1, #G.jokers.cards do
                if G.jokers.cards[j].ability.name == "The Stump" then
                    card.ability.extra.chance = card.ability.extra.chance + 1
                end
            end

            if context.game_over and pseudorandom('stump') < 1/card.ability.extra.chance and not context.blueprint then
                return {
                    message = localize('k_saved_ex'),
                    saved = true,
                    colour = G.C.RED                    
                }
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_medium' then
                unlock_card(self)
            end
        end
    }
end

