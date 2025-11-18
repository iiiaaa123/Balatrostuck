function Balatrostuck.INIT.Jokers.j_conventioncenter()
    SMODS.Joker{
        name = "Convention Center",
        key = "conventioncenter",
        config = {
            extra = { shop_size = 1}
        },
        loc_txt = {
            ['name'] = 'Convention Center',
            ['text'] = {
                [1] = "{C:attention}+1{} booster pack",
                [2] = "available in shop"
            },
            unlock = {"Win with the",
            "{C:attention}Painted Deck"}
        },
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_convention' then
                unlock_card(self)
            end
        end,
        pos = {
            x = 9,
            y = 11
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('delirium', info_queue)
            return {vars = {}}
        end,
        add_to_deck = function(self,card,from_debuff)
            SMODS.change_booster_limit(card.ability.extra.shop_size)
        end,
        remove_from_deck = function(self,card,from_debuff)
            SMODS.change_booster_limit(-card.ability.extra.shop_size)
        end
    }
end 


