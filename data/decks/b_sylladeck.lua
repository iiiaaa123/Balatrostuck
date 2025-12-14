function Balatrostuck.INIT.Decks.b_sylladeck()
    SMODS.Back {
        key = 'sylladeck',
        loc_txt = {
            name = "Sylladeck",
            text = {
                '{C:attention}+3{} Consumable Slots',
                'All {C:attention}Jokers{} are {C:attention}Pinned'
            }
        },
        config = {        },
        loc_vars = function(self, info_queue, center)
            return {vars = {}}
        end,
        atlas = 'HomestuckDecks',
        pos = {x = 3,y = 0},
        unlocked = true,
        apply = function(self,back)
            G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots + 3
        end,
    }
end