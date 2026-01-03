function Balatrostuck.INIT.Blinds.bl_clown()
    SMODS.Blind({
        key = 'clown',
        loc_txt = {
            name = 'The Clown',
            text = {'destroy leftmost joker each hand',
                'even eternals'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10, showdown=true},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=11},
        mult = 2,
        dollars = 8,
        boss_colour = HEX('2b0057'),
        calculate = function(self,instance,context)
            if context.after then
                if G.jokers.cards[1] then
                    G.E_MANAGER:add_event(Event{
                        func = function()
                            G.jokers.cards[1]:splatter()
                            return true 
                        end
                    })
                end
            end
        end,



        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if (not as_legacy) and G.GAME.round_resets.ante % 4 == 0 then return true end
            return false
        end
    })
end

