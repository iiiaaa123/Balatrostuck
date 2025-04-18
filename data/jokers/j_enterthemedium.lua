function Balatrostuck.INIT.Jokers.j_enterthemedium()
    SMODS.Joker{
        name = "Enter The Medium",
        key = "enterthemedium",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Enter The Medium',
            ['text'] = {
                [1] = "This Joker becomes a random",
                [2] = "{C:attention}Balatrostuck{} Joker at end of {C:attention}ante"
            }
        },
        pos = {
            x = 0,
            y = 10
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)

        end,
        add_to_deck = function(self,card,from_debuff)
            if G.GAME.pool_flags.bstuck_actprogress <= 2 then
                G.GAME.pool_flags.bstuck_actprogress = 3
            end
        end,
        in_pool = function(self,args)
            return G.GAME.pool_flags.bstuck_actprogress >= 2
        end
    }
end 