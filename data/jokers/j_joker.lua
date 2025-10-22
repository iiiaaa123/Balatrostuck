function Balatrostuck.INIT.Jokers.j_joker()
    SMODS.Joker{
        name = "Joker",
        key = "joker",
        config = {
            extra = {
                booster_repeat = 3
            }
        },
        loc_txt = {
            ['name'] = 'Joker',
            ['text'] = {
                [1] = '{C:mult}+4{} Mult',
            },
            unlock = {'Unlocked by',
            'finishing Act 6'}
        },
        pos = {
            x = 6,
            y = 4
        },
        cost = 2,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {key='warn_bstuck_wip', set='Other'}
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        soul_pos = {
            x = 5,
            y = 4
        },
        in_pool = function(self)
            return Balatrostuck.peanut_gallery
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_collide' then
                unlock_card(self)
            end
        end,
        add_to_deck = function(self, card)
            card:add_dialogue("john_bought", "bm")
            card:remove_dialogue(3)
        end,
        calculate = function(self, card, context)
            if context.starting_shop or context.reroll_shop then
                local activated = false
                for k, v in pairs(G.shop_jokers.cards) do
                    if v.cost == G.GAME.dollars + 1 then
                        if not activated then
                            card:add_dialogue("john_cost", "bm")
                            card:remove_dialogue(7)

                            G.E_MANAGER:add_event(Event({trigger = "after", delay = 2, func = function()
                            v.cost = G.GAME.dollars
                            v:juice_up()
                            play_sound("coin1")
                            return true end}))
                            
                            G.E_MANAGER:add_event(Event({trigger = "after", delay = 2, func = function()
                            return true end}))
                        end
                        activated = true
                    end
                end

            elseif context.cardarea == G.play and context.repetition then
                if pseudorandom('john') < 1 / 8 then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = card
                    }
                end

            elseif context.skipping_booster and not context.open_booster then
                if pseudorandom('john') < 1 / card.ability.extra.booster_repeat then
                    card.ability.extra.booster_repeat = card.ability.extra.booster_repeat + 1
                    G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag(pseudorandom_element({'tag_buffoon','tag_charm','tag_meteor','tag_standard','tag_ethereal','bstuck_t_matriorb','bstuck_t_spirograph'}, pseudoseed('john'))))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                    }))
                end

            elseif context.end_of_round and not context.individual and not context.repetition then
                if G.GAME.blind.boss then

                end

                card.ability.extra.booster_repeat = 3
            end
        end
    }
end