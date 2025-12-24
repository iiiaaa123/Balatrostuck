-- DONE
function Balatrostuck.INIT.Jokers.j_ringoflife() 
    SMODS.Joker{
        name = "Ring of Life",
        key = "ringoflife",
        config = {extra = {do_not_update_pool = false, chip_gain = 8}},
        loc_txt = { --'+8 chips for each Zodiac Level you have 

            ['name'] = 'Ring of Life',
            ['text'] = {
                '{C:chips}+#2#{} Chips for each {C:attention}Zodiac{} level you have',
                '{C:inactive}(Currently {C:chips}+#1#{}{C:inactive} Chips)'
            },
            unlock = {'Unlocked by',
            'finishing Act 3'}
        },
        pos = {
            x = 4,
            y = 6
        },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {self:get_zodiac_chip_bonus(),card.ability.extra.chip_gain}}
        end,
        calculate = function(self, card, context)
            
            if context.joker_main then
                local _bonus = self:get_zodiac_chip_bonus()
                return {
                  chip_mod = _bonus,
                  message = localize { type = 'variable', key = 'a_chips', vars = { _bonus } }
                }
              end  

            if context.using_consumeable and not context.blueprint and context.consumeable and context.consumeable.ability.set == 'Zodiac' then
                    return {
                        message = localize('k_upgrade_ex'),
                        card = card,
                        colour = G.C.CHIPS
                    }
            end

            if context.selling_self then
                card.ability.extra.do_not_update_pool = true
            end
        end,
        in_pool = function(self,args)
            if G.GAME.pool_flags.lost_rol then
                return false
            else
                return true
            end
        end,
        get_zodiac_chip_bonus = function(self)
            local _bonus = 0
            for _,level in pairs(G.GAME.BALATROSTUCK.zodiac_levels) do
                _bonus = _bonus + (level*8)
            end
            return _bonus
        end,
        remove_from_deck = function(self,card,from_debuff)
            if not from_debuff and not card.ability.extra.do_not_update_pool then
                G.GAME.pool_flags.lost_rol = true
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_medium' then
                unlock_card(self)
            end
        end
    }
end
