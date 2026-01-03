function Balatrostuck.INIT.Blinds.bl_helmsman()
    SMODS.Blind({
        key = 'helmsman',
        loc_txt = {
            name = 'The Helmsman',
            text = {'Discards half your deck',}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=2},
        mult = 2,
        dollars = 5,
        boss_colour = HEX('a1a100'),
        calculate = function(self,instance,context)
            if context.setting_blind then
                for i=1, #G.deck.cards/2 do
                    local card = G.deck.cards[#G.deck.cards-(i-1)]
                    card.discarded_by_blind = true
                    draw_card(G.deck,G.discard, i*100/(#G.deck.cards/2),'down', nil, nil, 0.07)
                end
            end
        end,
        disable = function(self)
            for _,v in pairs(G.discard.cards) do
                if v.discarded_by_blind then 
                    draw_card(G.disacrd,G.deck, 100/(#G.deck.cards/2),'up', nil, v, 0.07)
                end
            end
        end,
        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if (not as_legacy) and G.GAME.round_resets.ante >= 5 then return true end
            return false
        end
    })
end