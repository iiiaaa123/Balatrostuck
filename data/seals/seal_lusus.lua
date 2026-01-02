function Balatrostuck.INIT.Seals.seal_lusus()
    SMODS.Seal{
        key = 'lusus',
        config = {},
        loc_txt = {
            name = 'Lusus Seal',
            label = 'Lusus Seal',
            text = {
                "Adjacent cards", "have +1 {C:zodiac}Zodiac{} level"
            }
        },
        loc_vars = function (self, info_queue, card)
        end,
        badge_colour = HEX('70E05F'),
        atlas = 'HomestuckSeals',
        pos = {x=1,y=0},
        calculate = function(self,card,context)
        end
    }
end