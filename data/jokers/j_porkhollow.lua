function Balatrostuck.INIT.Jokers.j_porkhollow()
    SMODS.Joker{
        name = "Porkhollow",
        key = "porkhollow",
        config = {
            extra = {
                starting_chips = 15,
                chips = 15,
                chips_gain = 3
            }
        },
        loc_txt = {
            ['name'] = 'Porkhollow',
            ['text'] = {
                [1] = "Gain no interest", 
                [2] = "Instead, that money goes to this joker's sell value.",
                [3] = "{C:chips}+#2#{} chips for each {C:money}${} in sell value.", 
                [4] = "{C:inactive}(Currently: {C:chips}+#1#{}{C:inactive} Chips)"
            },
            unlock = {'Unlocked by',
            'finishing Act 3'}
        },
        pos = {
            x = 4,
            y = 4
         },
        cost = 10,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain } }
          end,        

        add_to_deck = function(self, card)
            if not G.GAME.selected_back.effect.config.no_interest then
                G.GAME.modifiers.no_interest = true
            end
        end,

        remove_from_deck = function(self, card)
            if not G.GAME.selected_back.effect.config.no_interest then
                G.GAME.modifiers.no_interest = false
            end
        end,
        
        calculate = function(self,card,context)
            if context.end_of_round and context.main_eval and not context.blueprint then
                card.ability.extra.mult_gain = 0
                if G.GAME.modifiers.no_interest then
                    card.ability.extra_value = card.ability.extra_value + G.GAME.interest_amount*math.min(math.floor(G.GAME.dollars/5), G.GAME.interest_cap/5)
                    card:set_cost()
                end
                local cur_chips = card.ability.extra.chips
                card.ability.extra.chips = card.ability.extra.starting_chips + card.ability.extra.chips_gain * card.ability.extra_value
                if card.ability.extra.chips ~= cur_chips then
                    return {
                        card = card,
                        message = "Upgraded!"
                    }
                end
            end

            if context.joker_main then
                return {
                  chip_mod = card.ability.extra.chips,
                  message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
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