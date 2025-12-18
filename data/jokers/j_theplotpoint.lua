function Balatrostuck.INIT.Jokers.j_theplotpoint()
    SMODS.Joker{
        name = "The Plot Point",
        key = "theplotpoint",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'The Plot Point',
            ['text'] = {
                'Sell this card to create',
                'a {C:paradox}Paradox {C:dark_edition}Black Hole{},',
                '{C:red}destroy{} all but {C:attention}leftmost{}',
                'Joker, and {C:attention}-1{} ante',
                --'',
                -- [1] = "Sell this joker: Destroy all jokers except leftmost",
                -- [2] = "Gain a Black Hole and -1 ante. Once per game."
            },
            unlock = {'Unlocked by',
            'finishing Act 6'}
        },
        pos = {
            x = 0,
            y = 1
         },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = false,
        atlas = 'HomestuckJokersAnimated',
        animated = true,
        frames = 8,
        animation_speed = 20,
        loc_vars = function (self, info_queue, card) 
            info_queue[#info_queue + 1 ] = G.P_CENTERS['c_black_hole']
            art_credit('akai', info_queue)
        end,
        calculate = function(self,card,context)
            if context.selling_self then
                ease_ante(-1)
                for j = 2, #G.jokers.cards do 
                    if G.jokers.cards[j] ~= card and not G.jokers.cards[j].eternal then
                        G.jokers.cards[j]:start_dissolve()
                        G.jokers.cards[j]:remove_from_deck()
                    end
                end
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    local blackhole = SMODS.create_card({set = 'Zodiac', key = 'c_black_hole'})
                    blackhole:set_edition('e_bstuck_paradox')
                    blackhole:add_to_deck()
                    G.consumeables:emplace(blackhole)
                    G.GAME.consumeable_buffer = 0
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_collide' then
                unlock_card(self)
            end
        end
    }
end 