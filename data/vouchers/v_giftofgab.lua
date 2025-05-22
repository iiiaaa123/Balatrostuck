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
        atlas = 'HomestuckVouchers',
        requires = {'v_bstuck_riseup'}
    }
end