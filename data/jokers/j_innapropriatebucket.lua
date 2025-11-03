function Balatrostuck.INIT.Jokers.j_innapropriatebucket()
    SMODS.Joker{
        name = "Inappropriate Bucket",
        key = "innapropriatebucket",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Inappropriate Bucket',
            ['text'] = {
                [1] = "{V:1}#1#{} also count as {V:2}#2#{},",
                [2] = "suits change at end of round"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 2,
            y = 3
         },
        loc_vars = function(self,info_queue,card)
            art_credit('akai', info_queue)
            return {vars = {G.GAME.BALATROSTUCK.bucket_suits[1],G.GAME.BALATROSTUCK.bucket_suits[2], colours = {G.C.SUITS[G.GAME.BALATROSTUCK.bucket_suits[1]], G.C.SUITS[G.GAME.BALATROSTUCK.bucket_suits[2]]}}}
        end,
        cost = 3,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.end_of_round then
                local suits = {'Spades','Hearts','Diamonds','Clubs'}
                local chosen_suits = {}
                chosen_suits[1] = pseudorandom_element(suits,pseudoseed(':33'))
                for i=1, #suits do
                    if suits[i] == chosen_suits[1] then
                        table.remove(suits,i)
                        break
                    end
                end
                chosen_suits[2] = pseudorandom_element(suits,pseudoseed(':33'))

                G.GAME.BALATROSTUCK.bucket_suits[1] = chosen_suits[1]
                G.GAME.BALATROSTUCK.bucket_suits[2] = chosen_suits[2]
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end   
    }
end 