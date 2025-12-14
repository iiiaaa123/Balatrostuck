function Balatrostuck.INIT.Decks.b_genericdeck()
    SMODS.Back {
        key = 'genericdeck',
        loc_txt = {
            name = "Perfectly Generic Deck",
            text = {
                'End of ante create a',
                '{C:attention}Perfectly Generic tag'
            }
        },
        atlas = 'HomestuckDecks',
        pos = {x = 2,y = 0},
        unlocked = true,
        calculate = function(self,back,context)
           if context.end_of_round and not context.repetition and not context.individual and G.GAME.blind.boss then

                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_bstuck_perfecltygeneric'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))

            end
        end
    }
end
