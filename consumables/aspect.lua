SMODS.ConsumableType{
  key = 'Aspect',
  collection_rows = { 6, 6 },
  primary_colour = G.C.SET.Aspect,
  secondary_colour = G.C.SECONDARY_SET.Aspect,
  loc_txt = {
    name = 'Aspect',
    collection = 'Aspect Cards',
    label = 'Aspect',
    undiscovered = {
      ['name'] = 'Not Discovered',
      ['text'] = {
                    "Purchase or use",
                    "this card in an",
                    "unseeded run to",
                    "learn what it does",
                },
    tooltip = {

    }
    },
  },
}

Balatrostuck.Aspect = SMODS.Consumable:extend{
  set = 'Aspect',
  prefix = 'c_aspect'
}

function Balatrostuck.Aspect:switch_slab()
  local aspect = string.gsub(self.key, "c_bstuck_", "")
  G.GAME.BALATROSTUCK.current_aspect = aspect
  add_slab(Slab('slab_bstuck_' .. aspect))
end

function Balatrostuck.Aspect:level(default)
  local level = G.GAME.BALATROSTUCK.aspect_levels[self.name] or default or 0
  local hi = {}
  if G.deck then
    SMODS.calculate_context({aspect_level = true, aspect = key},hi)
    for i=1, #hi do
      for k,v in pairs(hi[i]) do
        if v and v.amount then
          level = v.amount + level
        end
      end
    end
  end
  return level
end

function Balatrostuck.Aspect:next_level()
  return self:level()+1
end

function Balatrostuck.Aspect:get_level_color()
  return G.C.UI.TEXT_DARK
end

function Balatrostuck.Aspect:get_formula(level)
  if self.name == 'Blood' then 
    return {level*2}
  
  elseif self.name == 'Breath' or
         self.name == 'Void' or
         self.name == 'Heart' or
         self.name == 'Hope' then
    return {level, level~=1 and 's' or ''}

  elseif self.name == 'Mind' then
    return {level, level~=1 and 'ies' or 'y'}

  elseif self.name == 'Doom' then
    return {
      summation(level) + get_grollars(), 
      (summation(level) + get_grollars())~=1 and 's' or '',
      level+2
    }

  elseif self.name == 'Space' or
         self.name == 'Time' then
    return {
      summation(level), 
      summation(level)~=1 and 's' or ''
    }

  elseif self.name == 'Life' then 
    return {level*2, 2}

  elseif self.name == 'Light' then
    return {1 + (level * 0.3)}

  elseif self.name == "Rage" then
    -- positive xmult, negative xmult, netxmult
    local max_discards = G.GAME.round_resets.discards + G.GAME.round_bonus.discards
    local max_hands = G.GAME.round_resets.hands + G.GAME.round_bonus.next_hands
    
    return {1 + (level * 0.5),1 / (1 + (level / 2)),(1 + (level * 0.5))^(G.GAME.current_round.discards_left - (G.GAME.current_round.hands_left-1))}
  elseif self.name == 'Piss' then 
    return {summation(level+1)}

  else return {}
  
  end
end

function Balatrostuck.Aspect:loc_vars(info_queue, card)
  art_credit2('akai', 'yokcos', info_queue)

  local ret = {}
  local nodes = {}

  localize{
      type = 'descriptions',
      set = 'Aspect',
      key = "c_bstuck_"..(string.lower(self.name)).."_current",
      vars = self:get_formula(self:level()),
      nodes = ret
  }

  for i=1,#ret do
      table.insert(nodes, BSUI.Row({align = "cm"}, ret[i]))
  end

  return {
      vars = self:get_formula(self:next_level()),

      main_start = {BSUI.Modules.GameText.LevelUp(self:get_level_color(), self:next_level() )},

      main_end = self:level() > 0 and {BSUI.Row(BSUI.Config.Basic, nodes)} or {}
  }
end


Slab = Object:extend()
function Slab:init(key)
  self.key = key
  local proto = G.P_SLABS[key]
  self.config = copy_table(proto.config)
  self.pos = proto.pos
  self.name = proto.name
  self.triggered = false

  self.ability = copy_table(self.config)
end

function Slab:calculate(_context,trigger)
  if not self.triggered then

    
    
    local obj = Balatrostuck.Slabs[self.key]
    local res
    if obj and obj.apply and type(obj.apply) == 'function' then
      res = obj:apply(self, _context)
    end

    if res then
      if trigger then self.triggered = true end
      return res
    end
  end
end


-- UI


SlabIcon = Moveable:extend()

function SlabIcon:init(X,Y,W,H)
  Moveable.init(self,X, Y, W, H)
  self.children = {}
  self.children.sprite = Sprite(self.T.x,self.T.y,self.T.w,self.T.h,G.ASSET_ATLAS['bstuck_HomestuckSlabs'],{x=0,y=0})
  self.children.sprite.T.scale = 1
  self.children.sprite:define_draw_steps({
    {shader = 'dissolve', shadow_height = 0.05},
    {shader = 'dissolve'},
  })
  self.states.float = false
  self.states.hover.can = true
  self.states.drag.can = false
  self.states.collide.can = true
  self.children.sprite.config = {force_focus = true}
  self.children.sprite:set_role({major = self, role_type = 'Glued', draw_major = self})
  self.states.visible = G.GAME.slab ~= nil


  self.tilt_var = {mx = 0, my = 0, amt = 0}
  self.ambient_tilt = 0.3
  self.zoom = true
  self.states.collide.can = true
  self.children.sprite.states = self.states
  self.states.collide.can = true

  self.shadow_height = 0
  self:update_atlas()

  if getmetatable(self) == SlabIcon then 
    table.insert(G.I.CARD, self)
  end
end





function SlabIcon:get_uibox_table(tag_sprite)
  local aspect = G.GAME.BALATROSTUCK.current_aspect or nil
  if aspect then 

    -- Get the aspect card from the centers
    local aspect_card = G.P_CENTERS['c_bstuck_'..aspect]

    -- Generate UI table - this is important for structure
    -- the actual contents we yeet the hell out later
    local card_ui = generate_card_ui(
      aspect_card,
      nil, aspect_card:get_formula(aspect_card:level()-1))
      
    local nodes = {}
    local ret = {}

    -- use localization trick to recalculate the UI properly
    localize{
        type = 'descriptions', 
        set = 'Aspect', 
        key = 'c_bstuck_'..aspect, 
        vars = aspect_card:get_formula(aspect_card:level()), 
        nodes = ret
    }

    -- decimate the info_queue
    card_ui.info = {}

    -- move localization to a nodes table
    for i=1,#ret do
      table.insert(nodes, ret[i])
    end

    -- add the last element of the main card ui - not sure why 
    -- but this prevents a crash from the Balalala parser
    nodes[#nodes+1] = (card_ui.main)[#table]
    
    -- replace main nodes with recalculated nodes
    card_ui.main = nodes

    -- values copied from previewing table of a generated name dynatext 
    -- will need to learn more about what each param does here
    table.insert(card_ui.name[1].nodes, 1, BSUI.Image(DynaText({
      y_offset = -0.6,
      scale = 0.53,
      W = 1.2927,
      silent = true,
      pop_in_rate = 4,
      maxw = 5,
      bump = true,
      H = 0.4399,
      string = '(lvl.'..aspect_card:level()..') ',
      pop_in = 0,
      spacing = 3.84,
      colours = {G.C.WHITE},
      shadow = true,
    })))

    self.ability_UIBox_table = card_ui
  end
  return self
end


function SlabIcon:hover()
  if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then 
    if not self.hovering and self.states.visible then
      self.hovering = true
      play_sound('paper1', math.random()*0.1 + 0.55, 0.42)
      play_sound('tarot2', math.random()*0.1 + 0.55, 0.09)
    end
    self:get_uibox_table()
    self.config.h_popup =  G.UIDEF.card_h_popup(self)
    self.config.h_popup_config ={align = 'cl', offset = {x=-0.1,y=0},parent = self}
    Node.hover(self)
  end
end

function SlabIcon:stop_hover()
  self.hovering = false
  Node.stop_hover(self)
end





function SlabIcon:update_atlas()
  if G.GAME.slab then
    self.children.sprite:set_sprite_pos(G.GAME.slab.pos)
  else
    self.children.sprite:set_sprite_pos({x=1,y=3})
  end
end

function SlabIcon:draw()
  if not self.states.visible then return end
  love.graphics.setShader()


  self.children.sprite:draw_shader('dissolve', 0.05)
  self.children.sprite:draw_shader('dissolve')    


  add_to_drawhash(self)
  self:draw_boundingrect()
end  


function Slab:level(default)
  local aspect = string.gsub(self.key, "slab_bstuck_", "")
  aspect = string.gsub(aspect, "^%l", string.upper)
  local level = G.GAME.BALATROSTUCK.aspect_levels[aspect] or default or 0
  local hi = {}
  if G.deck then
    SMODS.calculate_context({aspect_level = true, aspect = key},hi)
    for i=1, #hi do
      for k,v in pairs(hi[i]) do
        if v and v.amount then
          level = v.amount + level
        end
      end
    end
  end
  return level
end

function Slab:increase_level(amount)
  amount = amount or 1
  local aspect = string.gsub(self.key, "slab_bstuck_", "")
  aspect = string.gsub(aspect, "^%l", string.upper)
  G.GAME.BALATROSTUCK.aspect_levels[aspect] = G.GAME.BALATROSTUCK.aspect_levels[aspect] + amount
         -- unlocks
          if G.GAME.BALATROSTUCK.aspect_levels[aspect] >= 3 then
            check_for_unlock({type = 'bstuck_godtier'})
            if G.GAME.BALATROSTUCK.aspect_levels[aspect] >= 5 then
            check_for_unlock({type = 'bstuck_impetus'})
            check_for_unlock({type = 'bstuck_sepulchritude'})
            end
          end
          --end of unlocks
end

function Slab:decrease_level(amount)
  amount = amount or 1
  local aspect = string.gsub(self.key, "slab_bstuck_", "")
  aspect = string.gsub(aspect, "^%l", string.upper)
  G.GAME.BALATROSTUCK.aspect_levels[aspect] = G.GAME.BALATROSTUCK.aspect_levels[aspect] - amount
end

-- TODO: actually write our own functions for executing slabs akin to tags

Balatrostuck.Slabs = {}
Balatrostuck.Slab = SMODS.GameObject:extend{
  obj_table = Balatrostuck.Slabs,
  obj_buffer = {},
  set = 'Slabs',
  class_prefix = 'slab',
  required_params = {
    'key', -- same as aspect!!!!!!!!
    'atlas',
    'pos'
  },
  omit_prefix = true,
  get_obj = function(self, key) return G.P_SLABS[key] end,
  inject = function(self)
    -- this is where all the chungusing occurs

    -- TODO: tie slabs to Aspect center
    -- TODO: make them *kind of* like tags but without all the fluff
    -- TODO: set it up so that slabs can be made in tandem with Aspects
    --sendInfoMessage("Slab injected: "..self.key)
    G.P_SLABS[self.key] = self
    SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
  end,
  process_loc_text = function(self) end,
  -- apply like a tag
  apply = function(self, context) end,
  generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
  
  end
}

function add_slab(_slab,amount)
  amount = amount or 1
  if G.GAME.slab == nil then
    G.GAME.slab = _slab
    _slab:increase_level(amount)
    _slab:calculate({ activated = true, after_level_up = true, is_new = true },true)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.ui_slab.states.visible = true
        G.ui_slab:update_atlas()
        G.ui_slab:juice_up()
        play_sound('bstuck_HomestuckAscend',0.7,0.1)
        play_sound('chips1', math.random()*0.1 + 0.55, 0.42)
        play_sound('timpani')
        return true
      end
    }))
    return
  end
  
  G.E_MANAGER:add_event(Event({
    func = function()
      G.ui_slab:update_atlas()
      G.ui_slab:juice_up()
      play_sound('bstuck_HomestuckAscend',0.7,0.1)
      play_sound('chips1', math.random()*0.1 + 0.55, 0.42)
      return true
    end
  }))

  old_slab = G.GAME.slab
  G.GAME.slab = _slab

  if old_slab.key ~= _slab.key and old_slab:level() > 0 then
    sendInfoMessage("Changing slab from "..old_slab.name.." to ".._slab.name)
    old_slab:calculate({ deactivated = true, new_slab = _slab, before_level_down = true },true)
    old_slab:decrease_level()
    old_slab:calculate({ deactivated = true, new_slab = _slab, after_level_down = true },true)
  end

  local prevLevel = _slab:level() >= 1 and old_slab.key ~= _slab.key
  _slab:calculate({ activated = true, old_slab = old_slab, before_level_up = true, returning = prevLevel},true)
  _slab:increase_level(amount)
  _slab:calculate({ activated = true, old_slab = old_slab, after_level_up = true, returning = prevLevel},true)
  sendInfoMessage("LEVEL UP ".._slab.name.." to ".._slab:level())
end
