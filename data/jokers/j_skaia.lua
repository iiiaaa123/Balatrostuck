-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_skaia()
    SMODS.Joker{
        name = "Skaia",
        key = "skaia",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Skaia',
            ['text'] = {
                [1] = "Create a {C:paradox}paradox{} copy of every", 
                [2] = "{C:mult}discarded{} card.",
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 4,
            y = 8
        },
        cost = 6,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
        end,
        calculate = function(self,card,context)
            if context.pre_discard then
                for i = 1, #context.full_hand do
                    pCard = copy_card(context.full_hand[i], nil, nil, G.playing_card, true)
                    pCard:set_edition("e_bstuck_paradox")
                    pCard:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, pCard)
                    G.hand:emplace(pCard)
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 