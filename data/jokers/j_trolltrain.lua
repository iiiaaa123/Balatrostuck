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
                '{C:attention}Played cards{} give',
                '{C:mult}+#1#{} Mult per {C:zodiac}Zodiac{}',
                '{C:zodiac}level{} of their rank',
                'when scored'
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return { vars = {card.ability.extra.mult}}
        end,
        pos = {
            x = 9,
            y = 7
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
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
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 