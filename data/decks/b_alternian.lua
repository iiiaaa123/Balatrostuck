function Balatrostuck.INIT.Decks.b_alternian()
    SMODS.Back {
        key = 'alternian',
        loc_txt = {
            name = "Alternian Deck",
            text = {
                '{C:attention}+#3#{} Joker slot',
                '{C:blue}+#2#{} hands',
                '{C:red}+#1#{} discard',
                '{C:red}X#4#{} base Blind size'
            },
               unlock = {'Win 3 games with the',
                    '{C:attention}Prospitian{} or {C:attention}Dersite{}',
                'decks'}
        },
        config = {
            discards = 1,
            hands = 2,
            slots = 1,
            scaling = 4
        },
        loc_vars = function(self, info_queue, center)
            return {vars = {self.config.discards, self.config.hands, self.config.slots, self.config.scaling}}
        end,
        atlas = 'HomestuckDecks',
        pos = {x = 1,y = 0},
        unlocked = false,
        apply = function(self,back)
            G.GAME.starting_params.discards = 3
            G.GAME.starting_params.hands = 4
            G.GAME.starting_params.joker_slots = 6
            G.GAME.starting_params.ante_scaling = 4
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_altdeck' then
                unlock_card(self)
            end
        end
    }
end