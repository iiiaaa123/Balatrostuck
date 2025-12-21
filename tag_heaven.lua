--tag heaven code
--gonna add a bunch of maybe unecessary comments here because i feel like this whole thing is a mess
--could be realistically done through lovely overrides but i think that may even be worse
function add_tag(_tag)
    local _done = false
    local _stacks = _tag.config.base_stacks or 1
    --mind call
    if G.GAME.slab ~= nil then
        _stacks = G.GAME.slab:calculate({modify_tag_stacks = _tag, stacks = _stacks}) or _stacks
    end
    local _current_tag = nil
    --print("adding ".._tag.key)
    for i = 1, #G.GAME.tags do
        _current_tag = G.GAME.tags[i]
        if _current_tag.key == _tag.key and _current_tag.ability.orbital_hand == _tag.ability.orbital_hand  then
            --handle the case where we are adding a tag that we already have 
            _stacks = (_current_tag.ability.extra.stack_count or 1) + _stacks
            _current_tag.ability.extra.stack_count = _stacks
           
            _done = true
            break
        end
    end
    if not _done then
        if not _tag.from_load then --this line is really important, otherwise tags always load with 1 stack? somehow, not sure why
            if not _tag.ability.extra then
                _tag.ability.extra = {}
            end
            if not _tag.ability.stack_count then
                _tag.ability.extra.stack_count = _stacks
            end
        end
    end

    if not _done then --we only need to create a new hud if we're adding a tag for the first time
        G.HUD_tags = G.HUD_tags or {}

        --this appends the double click to delete
        local ui_ref = _tag.get_uibox_table
        _tag.get_uibox_table = function(self,tag_sprite,vars_only)
            local ret = ui_ref(self,tag_sprite,vars_only)
            local _line_to_add = {
                {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                    {n=G.UIT.C, config={align = "m", colour = G.C.CLEAR, r = 0.05, padding = 0.05}, nodes={
                        {n=G.UIT.T, config={text = ' double-click to delete ', colour = G.C.UI.TEXT_INACTIVE, scale = 0.3, shadow = false}},
                    }}
                }}}
            ret.ability_UIBox_table.main[#ret.ability_UIBox_table.main+1] = _line_to_add
            return ret
        end

        local tag_sprite_ui, tag_sprite = _tag:generate_UI()


        tag_sprite.click = function(self)
            self.last_clicked = self.last_clicked or 0
            if self.last_clicked > G.TIMERS.REAL - 0.5 then --500 ms is the default double click time on windows so...
                self.config.tag:manual_delete()
            else
                self.last_clicked = G.TIMERS.REAL
            end

            --TODO: add better feedback

            play_sound('button', 1, 0.3)

            G.ROOM.jiggle = G.ROOM.jiggle + 0.5
            self.button_clicked = true
        end
        



        tag_sprite.states.click.can = true

        

        G.HUD_tags[#G.HUD_tags+1] = UIBox{
            definition = {n=G.UIT.ROOT, config={align = "cm",padding = 0.05, colour = G.C.CLEAR}, nodes={
                tag_sprite_ui,
                --if a sprite needs to be added, it probably goes in here
                {n=G.UIT.O, config={object = DynaText({string = {{suffix = "x", ref_table = _tag.ability.extra, ref_value = 'stack_count'}}, colours = {G.C.UI.TEXT_LIGHT},shadow = true, scale = 0.25})}},
                -- v this makes a red "x" button that deletes the tag
                --UIBox_button({colour = G.C.RED, button = "delete_tag",label={"x"},minw=0.3,minh=0.3, ref_table = _tag,r=1,align="bm"})
            }},
            config = {
                align = G.HUD_tags[1] and 'tm' or 'bri',
                offset = G.HUD_tags[1] and {x=0,y=0} or {x=0.7,y=0},
                major = G.HUD_tags[1] and G.HUD_tags[#G.HUD_tags] or G.ROOM_ATTACH}
        }
    end

        

  discover_card(G.P_TAGS[_tag.key])

  --this is for when we just added a double tag
  for i = 1, #G.GAME.tags do
    G.GAME.tags[i]:apply_to_run({type = 'tag_add', tag = _tag})
  end

  --skip actually adding the tag if we're just adding a stack
  if not _done then
    G.GAME.tags[#G.GAME.tags+1] = _tag
  end
  --this is to proc *other* double tags
  if not _tag.from_load then SMODS.calculate_context({tag_added = _tag}) end
  _tag.from_load = nil

    --skip adding the hud if we didn't make one, this could realistically be in one of the blocks above
    if not _done then 
        _tag.HUD_tag = G.HUD_tags[#G.HUD_tags]
        --print("added hud: ".._tag.HUD_tag)
    end
end
--this is the function that actually does the tag effect
function Tag:yep(message, _colour, func)
    stop_use()


    G.E_MANAGER:add_event(Event({
        delay = 0.4,
        trigger = 'after',
        func = (function()
            attention_text({
                text = message,
                colour = G.C.WHITE,
                scale = 1, 
                hold = 0.3/G.SETTINGS.GAMESPEED,
                cover = self.HUD_tag,
                cover_colour = _colour or G.C.GREEN,
                align = 'cm',
                })
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true
        end)
    }))
    G.E_MANAGER:add_event(Event({
        func = func
    }))
    --print(self.key.." checking removal conditions: count: "..self.ability.extra.stack_count.." triggered: "..tostring(self.triggered))
    --the part under here removes the tag, so it should only proc if the tag is called while triggered (shouldn't really happen)
    --or the stack count is 1 or less (last execution should be 1)
    if not self.ability.extra.stack_count or self.ability.extra.stack_count <= 1 or self.triggered then
        
        G.E_MANAGER:add_event(Event({
            func = (function()
                self.HUD_tag.states.visible = false
                return true
            end)
        }))

        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = (function()
                self:remove()
                return true
            end)
        }))
    end
end

function Tag:apply_to_run(_context)
    --self.triggered is set and un-set a bunch of times, it is only kept as "true" after evaluation if the tag is fully done (and should be destroyed)
    --i'm also (unfortunately, due to how things are set up,) using it to check whether the current evaluation did anything (because the return value is important for other things)
    if self.triggered then return end
    if not self.ability.extra.stack_count then self.ability.extra.stack_count = 1 end
    --haven't touched this block
    local flags = SMODS.calculate_context({prevent_tag_trigger = self, other_context = _context})
    if flags.prevent_trigger then return end
    local obj = SMODS.Tags[self.key] --not sure why this references the base class instead of the instance, maybe a lua thing?
    local res

    --if the object is a modded tag (only modded tags have obj.apply) then loop over it.
    if obj and obj.apply and type(obj.apply) == 'function' then
        local _count = self.ability.extra.stack_count

        for i=1,_count do
            res = obj:apply(self, _context)
            
            if self.triggered and not res then --"res" is the return value for the tag, it's only used for store joker create and store joker modify contexts
            --do NOT return anything from tag evaluation unless its in those contexts as this causes this function to return early and possibly a bunch of issues
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                self.triggered = false --unset tag.triggered so that it can then trigger again if necessary

            else
                break --if the tag is not triggering anymore (do this when the tag doesn't have an applicable effect), exit the loop early
            end
            if self.config.do_not_retrigger then --config.do_not_retrigger is used to make it so that packs dont open all at once
                res = true -- i honestly dont know why this is needed, but if its not here then all packs open at once
                break 
                end 
        end
    end

    --this mess of a line just makes sure we dont go on to the bottom execution (which locks actions if broken)
    --if we are not actually processing a vanilla tag 
    --remember to only set tag.triggered = true if the tag procced *succesfully* 
    if res or self.triggered or (self.config.type == _context.type and obj and obj.apply and type(obj.apply) == 'function') then 
            self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 0)
            return res
    end
    --print("proceeding with vanilla tag eval for "..self.key)
    --vanilla tag evaluation
    --some of them i unrolled the repetitions and made them do in one single loop, for both performance
    --and gameplay reasons
    if not self.triggered and self.config.type == _context.type then
        if _context.type == 'eval' then 
            if self.name == 'Investment Tag' and
                G.GAME.last_blind and G.GAME.last_blind.boss then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                    self:yep('+', G.C.GOLD,function() 
                        return true
                    end)
                self.triggered = true


                return {
                    dollars = self.config.dollars*_count,
                    condition = localize('ph_defeat_the_boss'),
                    pos = self.pos,
                    tag = self
                }
            end
        elseif _context.type == 'immediate' then 
            local lock = self.ID
            G.CONTROLLER.locks[lock] = true
            if self.name == 'Top-up Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.PURPLE,function() 
                    for i = 1, self.config.spawn_jokers*_count do
                        if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                            local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'top')
                            card:add_to_deck()
                            G.jokers:emplace(card)
                        end
                    end
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = true
                return true
            end
            if self.name == 'Skip Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.MONEY,function() 
                        G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                ease_dollars((G.GAME.skips or 0)*self.config.skip_bonus*_count)
                self.triggered = true
                
                return true
            end
            if self.name == 'Garbage Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.MONEY,function() 
                        G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                ease_dollars((G.GAME.unused_discards or 0)*self.config.dollars_per_discard*_count)
                self.triggered = true
                
                return true
            end
            if self.name == 'Handy Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.MONEY,function() 
                        G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                ease_dollars((G.GAME.hands_played or 0)*self.config.dollars_per_hand*_count)
                self.triggered = true
                
                return true
            end
            if self.name == 'Economy Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.MONEY,function() 
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        ease_dollars(math.min(self.config.max*_count, math.max(0,(G.GAME.dollars*(2^_count)) - G.GAME.dollars)), true)
                        return true
                    end
                }))
                self.triggered = true
                
                return true
            end
            if self.name == 'Orbital Tag' then
                local _count = self.ability.extra.stack_count
                --orbital should never crash with this, even if its visually corrupted
                if not self.ability.orbital_hand or self.ability.orbital_hand  == "[poker hand]" then 
                    local _poker_hands = {}
                    for k, v in pairs(G.GAME.hands) do
                        if v.visible then _poker_hands[#_poker_hands+1] = k end
                    end
                    self.ability.orbital_hand = pseudorandom_element(_poker_hands,pseudoseed("orbital"))
                end
                self.ability.extra.stack_count = 0
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
                    handname= self.ability.orbital_hand,
                    chips = G.GAME.hands[self.ability.orbital_hand].chips,
                    mult = G.GAME.hands[self.ability.orbital_hand].mult,
                    level= G.GAME.hands[self.ability.orbital_hand].level})
                level_up_hand(self, self.ability.orbital_hand, nil, self.config.levels*_count)
                update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
                self:yep('+', G.C.MONEY,function() 
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = true
                
                return true
            end
        elseif _context.type == 'new_blind_choice' then 
            local lock = self.ID
            G.CONTROLLER.locks[lock] = true
            if self.name == 'Charm Tag' then
                self:yep('+', G.C.PURPLE,function() 
                    local key = 'p_arcana_mega_'..(math.random(1,2))
                    local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                    G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({config = {ref_table = card}})
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
            if self.name == 'Meteor Tag' then
                self:yep('+', G.C.SECONDARY_SET.Planet,function() 
                    local key = 'p_celestial_mega_'..(math.random(1,2))
                    local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                    G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({config = {ref_table = card}})
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
            if self.name == 'Ethereal Tag' then
                self:yep('+', G.C.SECONDARY_SET.Spectral,function() 
                    local key = 'p_spectral_normal_1'
                    local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                    G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({config = {ref_table = card}})
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
            if self.name == 'Standard Tag' then
                self:yep('+', G.C.SECONDARY_SET.Spectral,function() 
                    local key = 'p_standard_mega_1'
                    local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                    G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({config = {ref_table = card}})
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
            if self.name == 'Buffoon Tag' then
                
                self:yep('+', G.C.SECONDARY_SET.Spectral,function() 
                    local key = 'p_buffoon_mega_1'
                    local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                    G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({config = {ref_table = card}})
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
            if self.name == 'Boss Tag' then
                
                local lock = self.ID
                G.CONTROLLER.locks[lock] = true
                self:yep('+', G.C.GREEN,function() 
                    G.from_boss_tag = true
                    G.FUNCS.reroll_boss()
                    
                    G.E_MANAGER:add_event(Event({func = function()
                        G.E_MANAGER:add_event(Event({func = function()
                            G.CONTROLLER.locks[lock] = nil
                        return true; end}))
                    return true; end}))

                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
        elseif _context.type == 'voucher_add' then 
            if self.name == 'Voucher Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.SECONDARY_SET.Voucher,function() 
                    for i=1, _count or 1 do
                        G.ARGS.voucher_tag = G.ARGS.voucher_tag or {}
                        local voucher_key = get_next_voucher_key(true)
                        G.ARGS.voucher_tag[voucher_key] = true
                        G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
                        local card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2,
                        G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[voucher_key],{bypass_discovery_center = true, bypass_discovery_ui = true})
                        card.from_tag = true
                        create_shop_card_ui(card, 'Voucher', G.shop_vouchers)
                        card:start_materialize()
                        G.shop_vouchers:emplace(card)
                        
                    end
                    G.ARGS.voucher_tag = nil
                    return true
                end)
                self.triggered = true
                
            end
        elseif _context.type == 'tag_add' then 
            if self.name == 'Double Tag' and _context.tag.key ~= 'tag_double' and _context.tag.key ~= 'tag_bstuck_scratch' and  _context.tag.key ~= 'sburb' then
                local lock = self.ID
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                G.CONTROLLER.locks[lock] = true
                self:yep('+', G.C.BLUE,function()
                    if _context.tag.ability and _context.tag.ability.orbital_hand then
                        G.orbital_hand = _context.tag.ability.orbital_hand
                    end
                    for i=1,_count do
                        add_tag(Tag(_context.tag.key))
                    end
                    G.orbital_hand = nil
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = true
                
            end
        elseif _context.type == 'round_start_bonus' then 
            if self.name == 'Juggle Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 1
                self:yep('+', G.C.BLUE,function() 
                    G.hand:change_size(self.config.h_size*_count)
                    G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + (self.config.h_size*_count)
                    return true
                end)

                self.triggered = true
                
                return true
            end
        elseif _context.type == 'store_joker_create' then 
            local _has_another_store_joker_create_tag
            for _,taggy in pairs(G.GAME.tags) do
                if taggy.config.type == 'store_joker_create'  and taggy.key ~= self.key then _has_another_store_joker_create_tag = true end
            end
            if G.GAME.pool_flags.last_used_modify_joker_tag_key == self.key and _has_another_store_joker_create_tag
            then return end --stagger joker tag types
            local card = nil
            if self.name == 'Rare Tag' then
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                local rares_in_posession = {0}
                for k, v in ipairs(G.jokers.cards) do
                    if v.config.center.rarity == 3 and not rares_in_posession[v.config.center.key] then
                        rares_in_posession[1] = rares_in_posession[1] + 1 
                        rares_in_posession[v.config.center.key] = true
                    end
                end

                if #G.P_JOKER_RARITY_POOLS[3] > rares_in_posession[1] then 
                    card = create_card('Joker', _context.area, nil, 1, nil, nil, nil, 'rta')
                    create_shop_card_ui(card, 'Joker', _context.area)
                    card.states.visible = false
                    self:yep('+', G.C.RED,function() 
                        card:start_materialize()
                        card.ability.couponed = true
                        card:set_cost()
                        return true
                    end)
                else
                    self:nope()
                end
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                
            elseif self.name == 'Uncommon Tag' then
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                card = create_card('Joker', _context.area, nil, 0.9, nil, nil, nil, 'uta')
                    create_shop_card_ui(card, 'Joker', _context.area)
                    card.states.visible = false
                    
                    self:yep('+', G.C.GREEN,function() 
                        card:start_materialize()
                        card.ability.couponed = true
                        card:set_cost()
                        return true
                    end)
                end
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                if card then G.GAME.pool_flags.last_used_modify_joker_tag_key = self.key end
                return card
        elseif _context.type == 'shop_start' then
            
            if self.name == 'D6 Tag' and not G.GAME.shop_d6ed then
                G.GAME.shop_d6ed = true
                self:yep('+', G.C.GREEN,function() 
                    G.GAME.round_resets.temp_reroll_cost = 0
                    calculate_reroll_cost(true)
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
        elseif _context.type == 'store_joker_modify' then
            local _applied = nil
            if not _context.card.edition and not _context.card.temp_edition and _context.card.ability.set == 'Joker' then
                local lock = self.ID
                G.CONTROLLER.locks[lock] = true
                
                if self.name == 'Foil Tag' then
                    _context.card.temp_edition = true
                    self:yep('+', G.C.DARK_EDITION,function() 
                        _context.card:set_edition({foil = true}, true)
                        _context.card.ability.couponed = true
                        _context.card:set_cost()
                        _context.card.temp_edition = nil
                        G.CONTROLLER.locks[lock] = nil
                        return true
                    end)
                    _applied = true
                elseif self.name == 'Holographic Tag' then
                    _context.card.temp_edition = true
                    self:yep('+', G.C.DARK_EDITION,function() 
                        _context.card.temp_edition = nil
                        _context.card:set_edition({holo = true}, true)
                        _context.card.ability.couponed = true
                        _context.card:set_cost()
                        G.CONTROLLER.locks[lock] = nil
                        return true
                    end)
                    _applied = true
                elseif self.name == 'Polychrome Tag' then
                    _context.card.temp_edition = true
                    self:yep('+', G.C.DARK_EDITION,function() 
                        _context.card.temp_edition = nil
                        _context.card:set_edition({polychrome = true}, true)
                        _context.card.ability.couponed = true
                        _context.card:set_cost()
                        G.CONTROLLER.locks[lock] = nil
                        return true
                    end)
                    _applied = true
                elseif self.name == 'Negative Tag' then
                    _context.card.temp_edition = true
                    self:yep('+', G.C.DARK_EDITION,function() 
                        _context.card.temp_edition = nil
                        _context.card:set_edition({negative = true}, true)
                        _context.card.ability.couponed = true
                        _context.card:set_cost()
                        G.CONTROLLER.locks[lock] = nil
                        return true
                    end)
                    _applied = true
                end
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
            end

            return _applied
        elseif _context.type == 'shop_final_pass' then
            if self.name == 'Coupon Tag' and (G.shop and not G.GAME.shop_free) then
                G.GAME.shop_free = true
                
                self:yep('+', G.C.GREEN,function() 
                    if G.shop_jokers and G.shop_booster then 
                        for k, v in pairs(G.shop_jokers.cards) do
                            v.ability.couponed = true
                            v:set_cost()
                        end
                        for k, v in pairs(G.shop_booster.cards) do
                            v.ability.couponed = true
                            v:set_cost()
                        end
                    end
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
        end
    end
end

--bandaid for some visual bugs i dont know why they're happening (uibox related fuckery)
--deletes all tag uis and regenerates them, currently called when skipping a blind or at the end of the shop
function bstuck_clean_tags()
    for _, HUD_tag in ipairs(G.HUD_tags) do
        HUD_tag:remove()
    end
    G.HUD_tags = {}
    
    for _, tag_object in ipairs(G.GAME.tags) do
        if tag_object.ability.extra.stack_count <= 0 then
            --remove any tags that have 0 stack size
            --print("removed "..tag_object.key.." because it had 0 stack size")
            tag_object:remove()
        else
            local tag_sprite_ui = tag_object:generate_UI()
            G.HUD_tags[#G.HUD_tags+1] = UIBox{
                definition = {n=G.UIT.ROOT, config={align = "cm",padding = 0.05, colour = G.C.CLEAR}, nodes={
                    tag_sprite_ui,
                    {n=G.UIT.O, config={object = DynaText({string = {{suffix = "x", ref_table = tag_object.ability.extra, ref_value = 'stack_count'}}, colours = {G.C.UI.TEXT_LIGHT},shadow = true, scale = 0.25})}}
                }},
                config = {
                    align = G.HUD_tags[1] and 'tm' or 'bri',
                    offset = G.HUD_tags[1] and {x=0,y=0} or {x=0.7,y=0},
                    major = G.HUD_tags[1] and G.HUD_tags[#G.HUD_tags] or G.ROOM_ATTACH}
            }
            tag_object.HUD_tag = G.HUD_tags[#G.HUD_tags]
        end
    end
    
    

end

function Tag:manual_delete()
    local context_effects = SMODS.calculate_context({deleted_tag = self})
    if context_effects.prevent_delete then return false end

    G.E_MANAGER:add_event(Event({
        delay = 0.2,
        trigger = 'after',
        func = (function()
            attention_text({
                text = 'DELETED!',
                colour = G.C.WHITE,
                scale = 0.7, 
                hold = 0.3/G.SETTINGS.GAMESPEED,
                cover = self.HUD_tag,
                cover_colour = G.C.RED,
                align = 'cm',
                })
            play_sound('cancel', 1.4, 0.5)
            return true
        end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = (function()
            self.HUD_tag.states.visible = false
            play_sound('cancel', 1.26, 0.5)
            return true
        end)
    }))

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = (function()
            self:remove()
            return true
        end)
    }))
end


function bstuck_remove_tag_ui(_tag)
    local HUD_tag_key = nil
    for k, v in pairs(G.HUD_tags) do
        if v == _tag.HUD_tag then HUD_tag_key = k end
    end

    if HUD_tag_key then 
        if G.HUD_tags and G.HUD_tags[HUD_tag_key+1] then
            if HUD_tag_key == 1 then
                G.HUD_tags[HUD_tag_key+1]:set_alignment({type = 'bri',
                offset = {x=0.7,y=0},
                xy_bond = 'Weak',
                major = G.ROOM_ATTACH})
            else
                G.HUD_tags[HUD_tag_key+1]:set_role({
                xy_bond = 'Weak',
                major = G.HUD_tags[HUD_tag_key-1]})
            end
        end
        table.remove(G.HUD_tags, HUD_tag_key)
    end

    _tag.HUD_tag:remove()
end