function Balatrostuck.INIT.Vouchers.v_godtier()
    SMODS.Voucher {
        key = 'godtier',
        loc_txt = {
            name = 'Godtier',
            text = {'Gain +1 level on current aspect'}
        },
        pos = {x=1,y=1},
        atlas = 'HomestuckVouchers',
        requires = {'v_bstuck_aspect_mastery'},
        redeem = function(self,card)
            if G.GAME.slab then
                G.GAME.slab:increase_level(card.ability.extra)
                local aspect = string.gsub(G.GAME.slab.key, "slab_bstuck_", "")
                aspect = string.upper(aspect)
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('bstuck_HomestuckAscend',0.7,0.1)
                    return true
                end
            }))
        end,
        in_pool = function(self,args)
            return G.GAME.slab ~= nil
        end
    }
end