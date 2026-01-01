function Balatrostuck.INIT.Blinds.bl_legacylatula()
    SMODS.Blind({
        key = 'legacylatula',
        loc_txt = {
            name = "Latula's Legacy",
            text = {'next boss blind is 1.1x',
                'times larger per hand used this round',
                '(multiplicative)'}
        },
        config = {hands_played = 0}, -- G.GAME.blind.effect at runtime 
        hands_sub = 0,
        legacy=true,
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=1},
        mult = 1.5,
        dollars = 4,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,context)
            if context.before then 
                if G.GAME.GAMEMODE and G.GAME.GAMEMODE.ability then
                    G.GAME.GAMEMODE.ability.latula_hands = G.GAME.GAMEMODE.ability.latula_hands + 1 --rest is in the gamemode code
                end
            end
        end,

        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if as_legacy and G.GAME.round_resets.ante >= 2 then return true end
            return false
        end
    })
end

