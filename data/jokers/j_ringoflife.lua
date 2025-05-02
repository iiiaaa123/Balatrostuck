-- DONE
function Balatrostuck.INIT.Jokers.j_ringoflife() 
    SMODS.Joker{
        name = "Ring of Life",
        key = "ringoflife",
        config = {extra = {do_not_update_pool = false}},
        loc_txt = {
            ['name'] = 'Ring of Life',
            ['text'] = {
                [1] = "Adjacent {C:attention}Jokers{}",
                [2] = "count as {C:tarot}Eternal{}",
            },
            unlock = {'Unlocked by',
            'finishing Act 3'}
        },
        pos = {
            x = 4,
            y = 6
        },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self, card, context)
            if context.remove_playing_cards then
                for i=1, #context.removed do
                    if context.removed[i]:is_face() then
                        local _card = copy_card(context.removed[i], nil, nil, G.playing_card)
                        if _card.edition and _card.edition.key == 'e_bstuck_paradox' then
                            _card:set_edition({})
                        end
                        _card:add_to_deck()
                        G.deck:emplace(_card)
                        playing_card_joker_effects({_card})
                        table.insert(G.playing_cards, _card)
                    end
                end
            end

            if context.selling_self then
                card.ability.extra.do_not_update_pool = true
            end
        end,
        in_pool = function(self,args)
            if G.GAME.pool_flags.lost_rol then
                return false
            else
                return true
            end
        end,
        remove_from_deck = function(self,card,from_debuff)
            if not from_debuff and not card.ability.extra.do_not_update_pool then
                G.GAME.pool_flags.lost_rol = true
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_medium' then
                unlock_card(self)
            end
        end
    }
end
