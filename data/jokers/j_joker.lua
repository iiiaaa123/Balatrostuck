function Balatrostuck.INIT.Jokers.j_joker()
    SMODS.Joker{
        name = "Joker",
        key = "joker",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Joker',
            ['text'] = {
                [1] = 'Gives {C:red}+4 Mult',
                [2] = '{C:white}a',
                [3] = '{C:blue}JOHN: hey there!'
            },
            unlock = {'Unlocked by',
            'finishing Act 6'}
        },
        pos = {
            x = 6,
            y = 4
        },
        cost = 2,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {key='warn_bstuck_wip', set='Other'}
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        soul_pos = {
            x = 5,
            y = 4
        },
        loc_vars = function(self, info_queue, card)
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