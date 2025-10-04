function Balatrostuck.INIT.Vouchers.v_giftofgab()
    SMODS.Voucher {
        key = 'giftofgab',
        loc_txt = {
            name = 'Gift Of Gab',
            text = {
                'Every {C:zodiac}Zodiac{} gets the ',
                'same odd of spawning'
            }
        },
        pos = {x=0,y=1},
        loc_vars = function(self, info_queue, card)
            art_credit('garb', info_queue)
            return {true}
        end,
        atlas = 'HomestuckVouchers',
        requires = {'v_bstuck_riseup'}
    }
end