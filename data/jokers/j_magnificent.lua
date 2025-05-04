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
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {key='warn_bstuck_wip', set='Other'}
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        calculate = function (self, context)
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