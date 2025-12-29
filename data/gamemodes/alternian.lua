function Balatrostuck.INIT.Gamemodes.gamemode_alternian()
    Balatrostuck.Gamemode{
        key = 'alternian',
        config = {
            used_bosses = {},
            used_legacies = {},
            used_mid_bosses = {},

            LE_mode = false,

            
            legacies_pool = {},
            


        },
        name = 'Alternian',
        apply = function(self) --at the start of the run

        end,
        calculate = function(self,instance,context)

            if context.blind_replace and context.blind_type == "big" and G.GAME.round_resets.ante >= 2 then
                
            end

            if context.blind_replace and context.blind_type == "boss" then
                
            end
        end,
        get_next_boss = function(self)
            local bosses_pool = {}
            local mid_bosses_pool = {}
        end
    }
end 