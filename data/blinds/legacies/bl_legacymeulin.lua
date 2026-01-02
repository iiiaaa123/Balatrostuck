function Balatrostuck.INIT.Blinds.bl_legacymeulin()
    SMODS.Blind({
        key = 'legacymeulin',
        loc_txt = {
            name = "Meulin's Legacy",
            text = {'#1# are drawn',
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
                        context.other_card.flipped_by_meulin = true
                        return {
                            stay_flipped = true
                        }
                    end
            end
            if context.round_eval then
                G.GAME.GAMEMODE.meulin_suit = nil
            end
        end,

        get_suit = function(self)
                if G.GAME.GAMEMODE.meulin_suit then return G.GAME.GAMEMODE.meulin_suit end
                local suits = {'Spades','Hearts','Diamonds','Clubs'}
                G.GAME.GAMEMODE.meulin_suit = pseudorandom_element(suits,pseudoseed(':33> hiii'))
                return G.GAME.GAMEMODE.meulin_suit
        end,
        disable = function(self)
            bstuck_undebuff_and_unflip_from_boss()
        end,
        in_pool = function(self)
            return false
        end,
        loc_vars = function(self)
            return {vars = {self:get_suit()}}
        end,
        collection_loc_vars = function(self)
            local suits = {'Spades','Hearts','Diamonds','Clubs'}
            local suit = pseudorandom_element(suits,pseudoseed(':33> hiii'))
            return {vars = {suit}}
        end,
        should_spawn = function(self,as_legacy)
            if as_legacy and G.GAME.round_resets.ante >= 2 then return true end
            return false
        end
    })
end

