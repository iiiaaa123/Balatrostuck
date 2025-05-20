function Balatrostuck.INIT.Jokers.j_strifespecibus()
    SMODS.Joker{
        name = "Strife Specibus",
        key = "strifespecibus",
        config = {
            extra = {
                hand = "Unassigned",
                mult = 20
            }
        },
        loc_txt = {
            ['name'] = 'Strife Specibus',
            ['text'] = {
                -- [1] = 'Gives {C:mult}+20{} Mult',
                -- [2] = 'After first hand played',
                -- [3] = 'disallows all other hands',
                '{C:red}+#1#{} Mult before cards',
                'are scored, all other',
                '{C:attention}hand types{} are {C:red}not {C:red}allowed{}',
                'after next hand is played'
            }
        },
        pos = {
            x = 6,
            y = 0
         },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            local colour = card.ability.extra.hand == "Unassigned" and G.C.JOKER_GREY or G.C.SPECIBUS
            return {
                vars = {card.ability.extra.mult},
                main_end = {BSUI.Modules.GameText.FormatBadge(card.ability.extra.hand, colour)}
            }            
        end,
        calculate = function (self, card, context)
            if context.debuff_hand then
                local strifed = false
                local grace = false

                for _,v in pairs(G.GAME.BALATROSTUCK.strife_assignment) do
                    if v == true then
                        strifed = true
                    end
                end
                
                for i=1, #G.jokers.cards do
                    if type(G.jokers.cards[i].ability.extra) == 'table' and G.jokers.cards[i].ability.extra.hand == 'Unassigned' then
                        grace = true
                    end
                end



                if G.GAME.BALATROSTUCK.strife_assignment[context.scoring_name] == nil and strifed and not grace then
                    return {
                        debuff_text = 'Invalid Specibus Allocation',
                        debuff = true
                    }
                end
            end
            
            
        
            if context.modify_hand then
                if card.ability.extra.hand == 'Unassigned' and not G.GAME.BALATROSTUCK.strife_assignment[context.scoring_name] then
                    G.GAME.BALATROSTUCK.strife_assignment[context.scoring_name] = true
                    card.ability.extra.hand = context.scoring_name
                end
                mult = mult + card.ability.extra.mult
                update_hand_text({delay = 0}, {chips = card.ability.extra.chips and hand_chips, mult = card.ability.extra.mult and mult})
                card_eval_status_text(card,'mult',card.ability.extra.mult,nil,nil,{message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }})
                return hand_chips, mult
            end
        end,
        remove_from_deck = function(self,card,from_debuff)
            local dupe = nil

            for i=1, #G.jokers.cards do
                if G.jokers.cards[i].ability.extra and G.jokers.cards[i].ability.extra.hand == card.ability.extra.hand then
                    dupe = true
                end
            end

            G.GAME.BALATROSTUCK.strife_assignment[card.ability.extra.hand] = dupe
        end,
        add_to_deck = function(self,card,from_debuff)
            if from_debuff and card.ability.extra.hand then
                G.GAME.BALATROSTUCK.strife_assignment[card.ability.extra.hand] = true
            end   
        end
    }

end