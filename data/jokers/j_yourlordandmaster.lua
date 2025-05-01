function Balatrostuck.INIT.Jokers.j_yourlordandmaster()
    SMODS.Joker{
        name = "YOUR LORD AND MASTER",
        key = "yourlordandmaster",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'YOUR LORD AND MASTER',
            ['text'] = {
                "{C:caliborn}YOU DO NOT NEED TO KNOW MY WAYS.",
                "{C:caliborn}MY PUTRID SOUL WILL MAKE A MOCKERY",
                "{C:caliborn}OF THIS GLORIFIED GAME OF SOLITAIRE."
            },
            unlock = {'Unlocked by',
            'finishing Act 6'}
        },
        pos = {
            x = 0,
            y = 0
         },
        cost = 1,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        atlas = 'TheCalibornJoker',
        animated = true,
        frames = 250,
        dimensions = {x=15,y=15},
        animation_speed = 50,
        photosensitive = false,
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