function Balatrostuck.INIT.Jokers.j_problemsleuth()
    SMODS.Joker{
        name = "Problem Sleuth",
        key = "problemsleuth",
        config = {
            extra = {
                
            
            }
        },
        loc_txt = {
            ['name'] = 'Problem Sleuth',
            ['text'] = {
                'If no hands were played',
                'during the {C:attention}Blind{}',
                'allow {C:attention}buying out{}',
                'of the {C:attention}Blind{} instead'
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 3,
            y = 0
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        in_pool = function ()
            return true
        end,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end,
        can_activate = function(self,card,args)
            local cost = card:activate_cost()
            if G.STATE == G.STATES.SELECTING_HAND and cost <= G.GAME.dollars + G.GAME.bankrupt_at then
                return true
            end
        end,
        activate_cost = function(self,card,args)
            local ante = G.GAME.round_resets.ante
            if G.GAME.round_resets.ante <= G.GAME.win_ante then
                return ante * 10
            else
                return math.floor(120 * (1.2^(ante-8)))
            end
        end,
        activate = function(self,card,args)
            card:juice_up()
            ease_dollars(-card:activate_cost())
            -- play_sound('bstuck_HomestuckBuyout')
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',delay = 0.4,
                func = (function()  update_hand_text({delay = 0, immediate = true}, {mult = 0, chips = 0, chip_total = math.floor(G.GAME.blind.chips), level = '', handname = ''});play_sound('button', 0.9, 0.6);return true end)
            }))
            
            delay(0.8)
                G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = (function() play_sound('chips2');return true end)
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "ease",
                delay = 1,
                ref_table = G.GAME,
                ref_value = "chips",
                ease_to = G.GAME.blind.chips,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                blocking = true,
                ref_table = G.GAME.current_round.current_hand,
                ref_value = 'chip_total',
                ease_to = 0,
                delay =  0.5,
                func = (function(t) return math.floor(t) end)
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = (function() G.GAME.current_round.current_hand.handname = '';return true end)
            }))
            G.E_MANAGER:add_event(Event({
				trigger = "immediate",
				func = function()
					if G.STATE ~= G.STATES.SELECTING_HAND then
						return false
					end
					G.GAME.current_round.semicolon = true
					G.STATE = G.STATES.HAND_PLAYED
					G.STATE_COMPLETE = true
					end_round()
					return true
				end
			}),"other")
        end
    }
end 