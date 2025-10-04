function Balatrostuck.INIT.Vouchers.v_riseup()
    SMODS.Voucher {
        key = 'riseup',
        config = {extra = 1},
        loc_txt = {
            name = 'Rise Up',
            text = {
                'Zodiac Packs and Aspect Packs',
                'appear more frequently',
                'in the shop'
            }
        },
        pos = {x=0,y=0},
        -- loc_vars = function(self, info_queue, card)
          --  art_credit('akai', info_queue)
          --  return {true}
        --end,
        atlas = 'HomestuckVouchers',
        redeem = function(self,card)
          
        end
    }
end