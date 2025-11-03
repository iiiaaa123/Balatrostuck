function Balatrostuck.INIT.Jokers.j_amberfirefly()
    SMODS.Joker{
        name = "Amber Firefly",
        key = "amberfirefly",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Amber Firefly',
            ['text'] = {
                [1] = "Shuffle a random {C:paradox}Paradox",
                [2] = "card with a {C:purple}Purple Seal{} into",
                [3] = "deck when {C:attention}Blind{} is selected"
            },
        unlock = {'Unlocked by',
                'finishing Act 1'}
        },
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            info_queue[#info_queue + 1] = {key = 'purple_seal', set = 'Other'}
        end,
        pos = {
            x = 8,
            y = 1
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        discovered = false,
        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.bstuck_pre_shuffle_deck then
                local front = pseudorandom_element(G.P_CARDS, pseudoseed('cert_fr'))
                local _card = create_playing_card({
                    front = front, 
                    center = G.P_CENTERS.c_base}, nil, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                _card:set_edition('e_bstuck_paradox',true,true)
                _card:set_seal('Purple',true,true)
                _card:flip()
                card:juice_up()
                G.deck:emplace(_card)
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 
