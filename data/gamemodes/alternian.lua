function Balatrostuck.INIT.Gamemodes.gamemode_alternian()
    Balatrostuck.Gamemode{
        key = 'alternian',
        config = {
            used_bosses = {},
            applied = false,
        },
        name = 'Alternian',
        apply = function(self,instance,context) --at the start of the run or when applied to the run
            if instance.ability.applied then return end --only do things once in case this is somehow called again!
            G.GAME.win_ante = 12
            instance.ability.applied = true
        end,
        calculate = function(self,instance,context) --instance refers to the Gamemode object, while self refers to the template Balatrostuck.Gamemode object.
            
            if context.blind_replace and context.blind_type == "big" and G.GAME.round_resets.ante >= 2 then
                context.new_boss = self.get_next_boss(instance,true)
            end

            if context.blind_replace and context.blind_type == "boss" then
                context.new_boss = self.get_next_boss(instance,false)
            end
        end,
        get_next_boss = function(instance,is_legacy)
            if G.GAME.round_resets.ante >= 13 and not is_legacy then return "bl_bstuck_lordenglish" end --lord english mode.
            local bosses_pool = {
                                "bettycrocker","demoness","disciple","dolorosa","executioner",
                                "helmsman","legislacerator","manipulator","orphaner","subjuggulator",
                                "sufferer","summoner",'legacydamara', 'legacyrufioh', 'legacymituna',
                                'legacykankri', 'legacymeulin', 'legacyporrim', 'legacylatula', 'legacyaranea',
                                'legacyhoruss', 'legacykurloz', 'legacycronus', 'legacymeenah'
                            }
            local superbosses_pool = {'cherub','host','clown','shades','muscle','juju'}
            local prefix = "bl_bstuck_"
            local valid_boss_pool = {}
            if G.GAME.round_resets.ante % 4 == 0 and not is_legacy then --superbosses/showdown
                bosses_pool = superbosses_pool
            end
            for _,boss in ipairs(bosses_pool) do
                if not bstuck_in_table(prefix..boss,instance.ability.used_bosses) 
                and G.P_BLINDS[prefix..boss].should_spawn and G.P_BLINDS[prefix..boss]:should_spawn(is_legacy) then
                    valid_boss_pool[#valid_boss_pool+1] = prefix..boss
                    
                end
            end
            
            print("Valid bosses: (legacy?) "..tostring(is_legacy))
            print(valid_boss_pool)
            local picked_boss = pseudorandom_element(valid_boss_pool,pseudoseed('alternian_boss'..tostring(is_legacy)..G.GAME.round_resets.ante))
            if not picked_boss then picked_boss = "bl_bstuck_legacydamara" end --fallback
            instance.ability.used_bosses[#instance.ability.used_bosses+1] = picked_boss
            return picked_boss
        end
    }
end 