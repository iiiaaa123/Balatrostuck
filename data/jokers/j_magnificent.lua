-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_magnificent() 
    SMODS.Joker{
        name = "Magnificent Joker",
        key = "magnificent",
        config = {
            extra = {
                xchips = 1,
                xchips_mod = 0.4
            }
        },
        loc_txt = {
            ['name'] = 'MAGNIFICENT JOKER',
            ['text'] = {
                [1] = "THIS JOKER DEPICTS A HANDSOME",
                [2] = "YOUNG CHERUB. HE GAINS {C:white,X:chips}+0.4X{} {C:chips}CHIPS",
                [3] = "FOR EACH {C:attention}KING{} HE IS PRESENTED WITH.",
                [4] = "{C:inactive}(Currently {C:white,X:chips}X#1#{}{C:inactive} CHIPS){C:red} DO NOT SELL",
                -- [5] = "DO NOT SELL.",
            },
            unlock = {'Unlocked by',
            'finishing Act 6'}
        },
        pos = {
            x = 5,
            y = 6
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.xchips}}
        end,
        calculate = function (self,card,context)
            if context.before and context.cardarea == G.jokers then
                local suits = {'Diamonds','Spades','Hearts','Clubs'}
                local amount = 0
                for k,v in pairs(G.play.cards) do
                    if v:get_id() == 13 then
                        -- maybe add some caliborn dialogue trigger here
                        for i=1, #suits do
                            if v:is_suit(suits[i]) then
                                amount = amount + 1
                                card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_mod
                                table.remove(suits,i)
                            end
                        end
                    end
                end
                if amount >= 1 then
                    return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xchips}},
                            colour = G.C.BLUE,
                            delay = 0.45, 
                        card = card
                    }
                end
            end

            if context.joker_main then
                return {
                    x_chips = card.ability.extra.xchips,
                    card = card
                }
            end
        end,
        in_pool = function(self)
            return Balatrostuck.peanut_gallery
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_collide' then
                unlock_card(self)
            end
        end
    }
end