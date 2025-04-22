function Balatrostuck.INIT.Decks.b_frog()
    SMODS.Back {
        key = 'frog',
        loc_txt = {
            name = "Frog Deck",
            text = {
                'Start with 3',
                '{C:attention}Sburb Tags',
                '{C:red}X2{} base Blind size'
            }
        },
        config = {        },
        loc_vars = function(self, info_queue, center)
            return {vars = {}}
        end,
        atlas = 'HomestuckDecks',
        pos = {x = 0,y = 0},
        unlocked = true,
        apply = function(self,back)
            G.GAME.starting_params.ante_scaling = 2
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
            
        end
    }
end