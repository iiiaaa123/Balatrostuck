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
                'Gives {C:white,X:mult}X0.2{} Mult',
                'for each remaining',
                '{C:attention}hand{}, discarded',
                '{C:attention}Jacks{} give {C:blue}+2{} hands',
                '{C:inactive}(Currently {C:white,X:mult}X0 {C:inactive} Mult)'

                -- 'Discarded Jacks',
                -- 'give {C:blue}+2{} hands,',
                -- 'this Joker gives',
                -- '{C:white,X:mult}X0.2{} Mult for each',
                -- 'hand remaining',
                -- '{C:inactive}(Currently {C:white,X:mult}X0 {C:inactive} Mult)'
                -- [1] = "Played Jacks give +1 hand when scored and are destroyed",
                -- [2] = "If this card is sold during a blind create paradox copies of jacks destroyed by it"
            },
            unlock = {'Unlocked by',
                    'finishing Act 4'}
            
        },
        loc_vars = function (self, info_queue, card) 
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
            art_credit('akai', info_queue)
        end,
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