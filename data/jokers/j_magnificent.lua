-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_magnificent() 
    SMODS.Joker{
        name = "Magnificent Joker",
        key = "magnificent",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'MAGNIFICENT JOKER.',
            ['text'] = {
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

        calculate = function (self, context)
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_collide' then
                unlock_card(self)
            end
        end
    }
end