function Balatrostuck.INIT.Blinds.bl_legacymeulin()
    SMODS.Blind({
        key = 'legacymeulin',
        loc_txt = {
            name = "Meulin's Legacy",
            text = {'[suit] is drawn',
                'face-down'}
        },
        hands_sub = 0,
        legacy=true,
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=1},
        mult = 1.5,
        dollars = 4,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,instance,context)
            if context.stay_flipped and context.to_area == G.hand then
                    local _suit = self:get_suit()
                    if context.other_card:is_suit(_suit)  then
                        return {
                            stay_flipped = true
                        }
                    end
            end
        end,

        get_suit = function(self)
                local suits = {'Spades','Hearts','Diamonds','Clubs'}
                return pseudorandom_element(suits,pseudoseed(':33> hiii'))
        end,
        in_pool = function(self)
            return false
        end,
        loc_vars = function(self)
            return {vars = {self:get_suit()}}
        end,
        should_spawn = function(self,as_legacy)
            if as_legacy and G.GAME.round_resets.ante >= 2 then return true end
            return false
        end
    })
end

