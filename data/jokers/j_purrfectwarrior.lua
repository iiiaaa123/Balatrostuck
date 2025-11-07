function Balatrostuck.INIT.Jokers.j_purrfectwarrior()
    SMODS.Joker{
        name = "Purrfect Warrior",
        key = "purrfectwarrior",
        config = {
            extra = {
                h_gain = 1,
                levels = 5,
                h_plays = 0
            }
        },
        loc_txt = {
            ['name'] = 'Purrfect Warrior',
            ['text'] = {
                '{C:blue}+#1#{} hand each round for every',
                '{C:attention}#2#{} hand levels above level {C:attention}1',
                '{C:inactive}(Currently {C:blue}+#3#{C:inactive} hands)'
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 0,
            y = 2
        },
        cost = 8,
        rarity = 3,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        animated = true,
        frames = 2,
        animation_speed = 20,
        photosensitive = true,
        atlas = 'HomestuckJokersAnimated',

        loc_vars = function(self, info_queue, card)
            art_credit('baqly', info_queue)
            local thunk = math.floor(math.max((sum_levels()-12)/5,0))
            return {vars = {card.ability.extra.h_gain, card.ability.extra.levels, thunk}}
        end,

        add_to_deck = function(self, card, from_debuff)
            card.ability.extra.h_plays = math.floor(math.max((sum_levels()-12)/5,0))
            if card.ability.extra.h_plays > 0 then
                ease_hands_played(card.ability.extra.h_plays)
            end
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.h_plays
        end,
    
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.h_plays
        end,

        calculate = function(self, card, context)
            if context.bstuck_level_up_hand and not context.blueprint then
                G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
                    
                    local thunk = math.floor(math.max((sum_levels()-12)/5,0))
                    if thunk > card.ability.extra.h_plays then
                        ease_hands_played(thunk - card.ability.extra.h_plays)
                        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.h_plays
                        card.ability.extra.h_plays = thunk 
                        G.GAME.round_resets.hands = G.GAME.round_resets.hands + thunk
                    end
                return true end }))
            end
            
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end