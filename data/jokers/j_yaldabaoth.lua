function Balatrostuck.INIT.Jokers.j_yaldabaoth()
    SMODS.Joker{
        name = "Yaldabaoth",
        key = "yaldabaoth",
        config = {
            extra = {
                ante_scaling = 2            
            }
        },
        loc_txt = {
            ['name'] = 'Yaldabaoth',
            ['text'] = {
                [1] = 'Gains {C:white,X:mult}X#1#{} Mult per',
                [2] = 'unused {C:red}discard{} at',
                [3] = 'the end of round',
                [4] = '{C:inactive}Resets on discard',
                [5] = '{C:inactive}(Currently: {C:white,X:mult}X#2#{} {C:inactive}Mult)'
            }
        },
        pos = {
            x = 0,
            y = 9
        },
        cost = 20,
        rarity = 4,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        soul_pos = {
            x = 5,
            y = 9
        },
        add_to_deck = function(self,card,from_debuff)
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * card.ability.extra.ante_scaling
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / card.ability.extra.ante_scaling
        end,
        loc_vars = function(self, info_queue, card)
            return { vars = {card.ability.extra.xmult_mod, card.ability.extra.xmult}}
        end,
        calculate = function(self, card, context)
            if context.end_of_round and G.GAME.blind.boss and G.GAME.slab and context.cardarea == G.jokers then
                local color = G.C.WHITE
                if G.GAME.slab then
                    G.GAME.slab:increase_level(1)
                    local aspect = string.gsub(G.GAME.slab.key, "slab_bstuck_", "")
                    aspect = string.upper(aspect)
                    color = G.C[aspect]
                end
                
                return {
                    card = card,
                    message = '+1 Aspect Level!',
                    colour = color,
                    func = function()
                        play_sound('bstuck_HomestuckAscend',0.7,0.1)
                        return true
                    end
                }
            end
        end
    }
end