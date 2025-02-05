function Balatrostuck.INIT.Jokers.j_innapropriatebucket()
    SMODS.Joker{
        name = "Innapropriate Bucket",
        key = "innapropriatebucket",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Innapropriate Bucket',
            ['text'] = {
                [1] = "{V:1}#1#{} also acts as {V:2}#2#{}",
                [2] = "Both suits change every round"
            }
        },
        pos = {
            x = 2,
            y = 3
         },
        loc_vars = function(self,info_queue,card)
            return {vars = {G.GAME.BALATROSTUCK.bucket_suits[1],G.GAME.BALATROSTUCK.bucket_suits[2], colours = {G.C.SUITS[G.GAME.BALATROSTUCK.bucket_suits[1]], G.C.SUITS[G.GAME.BALATROSTUCK.bucket_suits[2]]}}}
        end,
        cost = 4,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
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
        end      
    }
end 