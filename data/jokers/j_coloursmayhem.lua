function Balatrostuck.INIT.Jokers.j_coloursmayhem()
    SMODS.Joker{
        name = "ColoUrs and Mayhem",
        key = "coloursmayhem",
        config = {
            extra = { xmult = 1,xmult_loss = 0.05, bonus_choices = 1,
            color_table = {--eyedropped from the art
                            HEX("1880FF"), 
                            HEX("194EFF"),
                            HEX("FF4B18"),
                            HEX("7712FF"),
                            HEX("3CFF00"),
                            HEX("202FFF"),
                            HEX("FF1F17"),
                            HEX("29A1FF")
                        }
            }
        }, --1 more card can be chosen in a Booster Pack. Loses X0.05 Mult per Booster Pack opened (Currently: X1 Mult)

        loc_txt = {
            ['name'] = "ColoUrs and Mayhem",
            ['text'] = {
                "{C:attention}#3#{} more card can be chosen in a {C:attention}Booster Pack{}",
                "Loses {C:white,X:mult}X#2#{} Mult per {C:attention}Booster Pack{} opened",
                "{C:inactive}(Currently:{} {C:white,X:mult}X#1#{}{C:inactive} Mult){}"
            }
        },
        pos = {
            x = 0,
            y = 4
        },

        
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = true,

        atlas = 'HomestuckJokersAnimated',
        animated = true,
        frames = 8,
        animation_speed = 20,

        calculate = function (self, card, context)
            if context.joker_main and context.cardarea == G.jokers then

                        if card.ability.extra.xmult ~= 1 then return {
                            message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                            Xmult_mod = card.ability.extra.xmult
                        } end
            end
            if context.open_booster and not context.blueprint then
                    if card.ability.extra.xmult - self.config.extra.xmult_loss <= 0 then
                        card.explode(card, bstuck_concat_tables(card.ability.extra.color_table,{G.C.WHITE,G.C.WHITE,G.C.WHITE,G.C.WHITE,G.C.WHITE}), 0.5 )--half speed
                    else
                        local _color = pseudorandom_element(card.ability.extra.color_table,pseudoseed('mayhem'..card.ability.extra.xmult))
                        card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_loss
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "-"..card.ability.extra.xmult_loss.." XMult", colour = _color})
                    end
            end

        end,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) + card.ability.extra.bonus_choices
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) - card.ability.extra.bonus_choices
        end,

        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.xmult, card.ability.extra.xmult_loss, card.ability.extra.bonus_choices}}
        end,
        explode = function(self,dissolve_colours, explode_time_fac) --lowkey just the booster pack animation without the sound
            local explode_time = 1.3*(explode_time_fac or 1)*(math.sqrt(G.SETTINGS.GAMESPEED))
            self.dissolve = 0
            self.dissolve_colours = dissolve_colours
                or {G.C.WHITE}

            local start_time = G.TIMERS.TOTAL
            local percent = 0
            self.juice = {
                scale = 0,
                r = 0,
                handled_elsewhere = true,
                start_time = start_time, 
                end_time = start_time + explode_time
            }

            local childParts1 = Particles(0, 0, 0,0, {
                timer_type = 'TOTAL',
                timer = 0.01*explode_time,
                scale = 0.2,
                speed = 2,
                lifespan = 0.2*explode_time,
                attach = self,
                colours = self.dissolve_colours,
                fill = true
            })
            local childParts2 = nil

            G.E_MANAGER:add_event(Event({
                blockable = false,
                func = (function()
                        if self.juice then 
                            percent = (G.TIMERS.TOTAL - start_time)/explode_time
                            self.juice.r = 0.05*(math.sin(5*G.TIMERS.TOTAL) + math.cos(0.33 + 41.15332*G.TIMERS.TOTAL) + math.cos(67.12*G.TIMERS.TOTAL))*percent
                            self.juice.scale = percent*0.15
                        end
                        if G.TIMERS.TOTAL - start_time > 1.5*explode_time then return true end
                    end)
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                blockable = false,
                ref_table = self,
                ref_value = 'dissolve',
                ease_to = 0.3,
                delay =  0.9*explode_time,
                func = (function(t) return t end)
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                blockable = false,
                delay =  0.9*explode_time,
                func = (function()
                    childParts2 = Particles(0, 0, 0,0, {
                        timer_type = 'TOTAL',
                        pulse_max = 30,
                        timer = 0.003,
                        scale = 0.6,
                        speed = 15,
                        lifespan = 0.5,
                        attach = self,
                        colours = self.dissolve_colours,
                    })
                    childParts2:set_role({r_bond = 'Weak'})
                    G.E_MANAGER:add_event(Event({
                        trigger = 'ease',
                        blockable = false,
                        ref_table = self,
                        ref_value = 'dissolve',
                        ease_to = 1,
                        delay =  0.1*explode_time,
                        func = (function(t) return t end)
                    }))
                    self:juice_up()
                    G.VIBRATION = G.VIBRATION + 1
                    childParts1:fade(0.3*explode_time) return true end)
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                blockable = false,
                delay =  1.4*explode_time,
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'ease',
                        blockable = false, 
                        blocking = false,
                        ref_value = 'scale',
                        ref_table = childParts2,
                        ease_to = 0,
                        delay = 0.1*explode_time
                    }))
                    return true end)
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                blockable = false,
                delay =  1.5*explode_time,
                func = (function() self:remove() return true end)
            }))
        end
    }
end 