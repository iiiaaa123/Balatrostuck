function Balatrostuck.INIT.Blinds.bl_cherub()
    SMODS.Blind({
        key = 'cherub',
        loc_txt = {
            name = 'The Cherub',
            text = {'0.5x blind req',
                'all jokers debuffed'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10, showdown=true},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=16},
        mult = 0.5,
        dollars = 8,
        boss_colour = HEX('2ed73a'),
        calculate = function(self,instance,context)
            if context.setting_blind then
                    for _,card in ipairs(G.jokers.cards) do
                        if not card.debuff then
                            card.debuffed_by_blind = true
                            card:set_debuff(true)
                        end
                    end
            end
        end,

        disable = function(self)
            G.GAME.blind.chips = G.GAME.blind.chips * 4
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            bstuck_undebuff_and_unflip_from_boss()
        end,
        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if (not as_legacy) and G.GAME.round_resets.ante % 4 == 0 then return true end
            return false
        end
    })
end

