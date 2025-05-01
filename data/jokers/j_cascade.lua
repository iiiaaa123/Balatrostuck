-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_cascade()
    SMODS.Joker{
        name = "Cascade",
        key = "cascade",
        config = {
            extra = {
                retrigger_every = 5
            }
        },
        loc_txt = {
            ['name'] = 'Cascade',
            ['text'] = {
                [1] = '{C:attention}Retrigger{} all played cards an',
                [2] = 'additional time for every {C:attention}#1#',
                [3] = 'levels in the played {C:attention}poker hand'
            },
            unlock = {'Unlocked by',
            'finishing Act 4'}
        },
        pos = {
            x = 3,
            y = 7
        },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.retrigger_every}}
        end,
        calculate = function (self, card, context)
            if context.repetition and context.cardarea == G.play then
                local text,disp_text = G.FUNCS.get_poker_hand_info(context.full_hand)
                local retrigs = math.floor(G.GAME.hands[text].level/card.ability.extra.retrigger_every)
    
                return {
                    message = localize('k_again_ex'),
                    repetitions = retrigs,
                    card = card
                }
            end
        end,
        add_to_deck = function(self,card,from_debuff)
            check_for_unlock({type = 'bstuck_cascade'})
            if G.GAME.pool_flags.bstuck_actprogress <= 4 then
                G.GAME.pool_flags.bstuck_actprogress = 5
            end
        end,
        in_pool = function(self,args)
            return G.GAME.pool_flags.bstuck_actprogress >= 4
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_descend' then
                unlock_card(self)
            end
        end
    }
end