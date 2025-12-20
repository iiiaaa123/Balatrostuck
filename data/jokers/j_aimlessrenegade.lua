function Balatrostuck.INIT.Jokers.j_aimlessrenegade()
    SMODS.Joker{
        name = "Aimless Renegade",
        key = "aimlessrenegade",
        config = {
            extra = { mult = 0, multgain = 5
            }
        },
        loc_txt = {
            ['name'] = 'Aimless Renegade',
            ['text'] = {
                [1] = "When {C:attention}Blind{} is selected, this Joker",
                [2] = "gains {C:mult}+#1#{} Mult, {C:attention}destroys{} a random Joker,",
                [3] = "and creates a {C:paradox}Paradox {C:attention}Judgement card",
                [4] = "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
            },
            unlock = {'Unlocked by',
            'finishing Act 1'}
        },
        pos = {
            x = 3,
            y = 10
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        unlocked = false,
        discovered = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.setting_blind then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multgain
                local targets = {}
                for j=1, #G.jokers.cards do 
                    if not G.jokers.cards[j].ability.eternal and G.jokers.cards[j] ~= card then
                        targets[#targets+1] = G.jokers.cards[j]
                    end
                end

                
                if #targets > 0 then  
                    local thechosen = pseudorandom_element(targets,pseudoseed('AG'))
                    G.E_MANAGER:add_event(Event{
                        func = function()
                            card:juice_up()
                            thechosen:splatter()
                            return true 
                        end
                    })
                end

                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local _card = bstuck_add_paradox_card({set = 'Tarot', key = 'c_judgement'})
                        return true 
                    end
                }))

                return {
                    message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}},
                    colour = G.C.MULT,
                    card = card
                }
            end

            if context.joker_main then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end,
        loc_vars = function(self, info_queue, card) 
            art_credit('akai', info_queue)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            info_queue[#info_queue + 1] = G.P_CENTERS['c_judgement']
            return {vars = {card.ability.extra.multgain, card.ability.extra.mult}}
        end,
    }
end 