function Balatrostuck.INIT.Decks.b_frog()
    SMODS.Back {
        key = 'frog',
        loc_txt = {
            name = "Frog Deck",
            text = {
                'Start with 3 {C:attention}Sburb Tags',
                'base Blind size increases by',
                '{C:red}X0.5{} after each Boss Blind'
            },
                        unlock = {'Beat every single',
                    '{C:attention}Balatrostuck{} challenge'}
        },
        config = {        },
        loc_vars = function(self, info_queue, center)
            return {vars = {}}
        end,
        atlas = 'HomestuckDecks',
        pos = {x = 0,y = 0},
        unlocked = false,
        apply = function(self,back)
            local i = 0
            repeat
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_bstuck_sburb'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
                i = i + 1
            until i == 3
            
        end,

        calculate = function(self, back, context)
            if context.end_of_round and not context.repetition and not context.individual and G.GAME.blind.boss then
                G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling + 0.5
            end
        end,

        check_for_unlock = function(self,args)
            if args.type == 'bstuck_frogdeck' then
                unlock_card(self)
            end
        end
    }
end