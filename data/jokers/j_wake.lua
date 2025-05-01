function Balatrostuck.INIT.Jokers.j_wake()
    SMODS.Joker{
        name = "Wake",
        key = "wake",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Wake',
            ['text'] = {
                [1] = "Played Jacks give +1 hand when scored and are destroyed",
                [2] = "If this card is sold during a blind create paradox copies of jacks destroyed by it"
            },
            
        },
        pos = {
            x = 8,
            y = 10
         },
        cost = 9,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_descend' then
                unlock_card(self)
            end
        end
    }
end 