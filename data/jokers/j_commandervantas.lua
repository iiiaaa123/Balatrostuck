function Balatrostuck.INIT.Jokers.j_commandervantas()
    SMODS.Joker{
        name = "Commander Vantas",
        key = "commandervantas",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Commander Vantas',
            ['text'] = {
                '{C:attention}Wild Cards{} have' , '{C:attention}+1 {C:zodiac}Zodiac{} level'
            }
        },
        pos = {
            x = 2,
            y = 1
        },
        cost = 3,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        add_to_deck = function(self,card,from_debuff)
            for k,v in pairs(G.GAME.BALATROSTUCK.zodiac_levels) do 
                if v < 1 then
                    local newCaste = Caste('caste_bstuck_' .. k,G.P_CASTES['caste_bstuck_' .. k])
                    table.insert(G.GAME.BALATROSTUCK.active_castes, newCaste)
                end
            end
        end,
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            info_queue[#info_queue + 1] = G.P_CENTERS['m_wild']
        end
    }
end