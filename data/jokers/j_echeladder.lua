function Balatrostuck.INIT.Jokers.j_echeladder()
    SMODS.Joker{
        name = "Echeladder",
        key = "echeladder",
        config = {
            extra = {
                dollars = 10,
                given_tag = false,
                title_cur = "Junior Japer",
                title_list = {
                    {
                        text = "Junior Japer",
                        col = G.C.IMPORTANT
                    },
                    {
                        text = "99% of Gamblers",
                        col = G.C.GREEN
                    },
                    {
                        text = "Medieval Jester",
                        col = G.C.BREATH
                    },
                    {
                        text = "High Card Afficionado",
                        col = G.C.RED
                    },
                    {
                        text = "What Banana?",
                        col = G.C.PARADOX1
                    },
                    {
                        text = "1 in 4 Foil",
                        col = G.C.BLUE
                    },
                    {
                        text = "Roulette Graduate",
                        col = G.C.PURPLE
                    },
                    {
                        text = "Poker Face Maintenance Staff",
                        col = G.C.L_BLACK
                    },
                    {
                        text = "Endangered Card Shark",
                        col = G.C.RAGE
                    },
                    {
                        text = "Better than Vriska",
                        col = G.C.ZODIAC.Scorpio
                    },
                    {
                        text = "Went Fishing No Kidding",
                        col = G.C.ZODIAC.Pisces
                    },
                    {
                        text = "Cosmic Consequences Conman",
                        col = G.C.SUCKERS
                    },
                    {
                        text = "Lord of Light",
                        col = G.C.LIGHT
                    }
                },
                title_index = 1
            }
        },
        loc_txt = {
            ['name'] = 'Echeladder',
            ['text'] = {
                'Earn {C:money}$#1#{} after the',
                '{C:attention}Boss Blind{} is defeated'
                --[4] = '{C:attention}#2#{}'
            }
        },
        pos = {
            x = 4,
            y = 0
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('penny', info_queue)
            local ret = {}

            local balastuck = Sprite(0,0,(1*11/232)*6, 6,G.ASSET_ATLAS["bstuck_scrollbar"], {x=0, y=0})
            balastuck.states.drag.can = false

            ret[#ret+1] = BSUI.Row(BSUI.Config.Basic, {BSUI.Pad(0, 0.2)})

            for i = #card.ability.extra.title_list, 1, -1 do
                local top = i == card.ability.extra.title_index
                local col = i <= card.ability.extra.title_index 
                    and (card.ability.extra.title_list[i]).col 
                    or G.C.UI.TEXT_INACTIVE
                ret[#ret+1] = BSUI.Row(BSUI.Config.Basic, {
                    BSUI.Modules.GameText.EccheladderRung((card.ability.extra.title_list[i]).text, col, top)
                })
            end

            ret[#ret+1] = BSUI.Row(BSUI.Config.Basic, {BSUI.Pad(0, 0.1)})

            return {
                vars = {card.ability.extra.dollars}, 
                main_end = {BSUI.Row(BSUI.Config.Basic, {
                    BSUI.Col(BSUI.Config.Basic, {BSUI.Image(balastuck)}),
                    BSUI.Col(BSUI.Config.Basic, ret),
                })}
            }
        end,

        calc_dollar_bonus = function(self, card)
            if G.GAME.blind.boss then -- AND not alternia stake) OR (alternia stake AND alternian blind)
                if card.ability.extra.title_index < 13 then
                    card.ability.extra.title_index = card.ability.extra.title_index + 1
                    if card.ability.extra.title_index == 13 then
                        G.E_MANAGER:add_event(Event({
                        func = (function()
                            add_tag(Tag('tag_bstuck_sburb'))
                            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                            return true
                        end)
                        }))
                    end                    
                end
                return 10
            else
                return nil
            end
        end,

        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers and not card.ability.extra.given_tag then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_bstuck_sburb'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                --code for 8r8k unlock goes here
                card.ability.extra.given_tag = true
                return {
                    message = "-Ify!",
                    card = card
                }
            end
        end
    }
end