function Balatrostuck.INIT.Jokers.j_trolltrain()
    SMODS.Joker{
        name = "Troll Train",
        key = "trolltrain",
        config = {
            extra = {mult = 4}
        },
        loc_txt = {
            ['name'] = 'Troll Train',
            ['text'] = {
                [1] = "Scored cards give +4 mult",
                [2] = "per zodiac level of their rank"
            }
        },
        pos = {
            x = 9,
            y = 7
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.individual and context.cardarea == G.play then
                for k,v in ipairs(G.GAME.BALATROSTUCK.active_castes) do
                    if context.other_card:get_id() == v.ability.rank then
                        return {
                            mult = v:level() * card.ability.extra.mult,
                            card = card
                        }
                    end
                end
            end
        end
    }
end 