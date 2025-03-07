function Balatrostuck.INIT.Jokers.j_objectduality()
    SMODS.Joker{
        name = "Object Duality",
        key = "objectduality",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Object Duality',
            ['text'] = {
                [1] = "If first played hand of round is a high card then create",
                [2] = "the paradox joker corresponding to each scored card"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.first_hand_drawn then
                local eval = function() return G.GAME.current_round.hands_played == 0 end
                juice_card_until(card, eval, true)
            end
            
            if context.individual and context.cardarea == G.play and context.scoring_name == 'High Card' and G.GAME.current_round.hands_played == 0 then
                local othercard = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('timpani')
                        SMODS.add_card({set = 'Joker',edition = 'e_bstuck_paradox', key = get_innocuous(othercard,false)})
                        return true
                    end
                }))
            end
        end
    }
end 