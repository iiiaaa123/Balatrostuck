SMODS.ConsumableType{
  key = 'Aspect',
  collection_rows = { 6, 6 },
  primary_colour = G.C.SET.Aspect,
  secondary_colour = G.C.SECONDARY_SET.Aspect,
  loc_txt = {
    name = 'Aspect',
    collection = 'Aspect Cards',
    label = 'Aspect',
    undiscovered = {}
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
  return G.GAME.BALATROSTUCK.aspect_levels[self.name] or default or 0
end

function Balatrostuck.Aspect:next_level()
  return self:level()+1
end

function Balatrostuck.Aspect:get_level_color()
  return G.C.UI.TEXT_DARK
end

function Balatrostuck.Aspect:get_formula(level)
  if self.name == 'Blood' then return level+1
  
  elseif self.name == 'Breath' or
         self.name == 'Hope' or
         self.name == 'Mind' then
    return level

  elseif self.name == 'Doom' then return {amt = summation(level) + get_grollars(), chance = level+2}

  elseif self.name == 'Heart' or
         self.name == 'Space' or
         self.name == 'Time' or
         self.name == 'Void' then
    return summation(level)

  elseif self.name == 'Life' then return {amt = level+1, money = level*2}
  elseif self.name == 'Light' then return 1 + level/2
  elseif self.name == 'Piss' then return summation(level+1)
  elseif self.name == 'Rage' then return level*0.25
  else return 0
  end
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
  local name_to_check, loc_vars = self.name, {}
  if name_to_check == 'Uncommon Tag' then
  elseif name_to_check == 'Investment Tag' then loc_vars = {self.config.dollars}
  elseif name_to_check == 'Handy Tag' then loc_vars = {self.config.dollars_per_hand, self.config.dollars_per_hand*(G.GAME.hands_played or 0)}
  elseif name_to_check == 'Garbage Tag' then loc_vars = {self.config.dollars_per_discard, self.config.dollars_per_discard*(G.GAME.unused_discards or 0)}
  elseif name_to_check == 'Juggle Tag' then loc_vars = {self.config.h_size}
  elseif name_to_check == 'Top-up Tag' then loc_vars = {self.config.spawn_jokers}
  elseif name_to_check == 'Skip Tag' then loc_vars = {self.config.skip_bonus, self.config.skip_bonus*((G.GAME.skips or 0)+1)}
  elseif name_to_check == 'Orbital Tag' then loc_vars = {
      (self.ability.orbital_hand == '['..localize('k_poker_hand')..']') and self.ability.orbital_hand or localize(self.ability.orbital_hand, 'poker_hands'), self.config.levels}
  elseif name_to_check == 'Economy Tag' then loc_vars = {self.config.max}
  end
  self.ability_UIBox_table = generate_card_ui(G.P_TAGS['tag_handy'], nil, loc_vars, (self.hide_ability) and 'Undiscovered' or 'Tag', nil, (self.hide_ability))
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
  return G.GAME.BALATROSTUCK.aspect_levels[aspect] or default or 0
end

function Slab:increase_level(amount)
  amount = amount or 1
  local aspect = string.gsub(self.key, "slab_bstuck_", "")
  aspect = string.gsub(aspect, "^%l", string.upper)
  G.GAME.BALATROSTUCK.aspect_levels[aspect] = G.GAME.BALATROSTUCK.aspect_levels[aspect] + amount
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
    sendInfoMessage("Slab injected: "..self.key)
    G.P_SLABS[self.key] = self
    SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
  end,
  process_loc_text = function(self) end,
  -- apply like a tag
  apply = function(self, context) end,
  generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
  
  end
}

function add_slab(_slab)
  if G.GAME.slab == nil then
    sendInfoMessage("First slab: ".._slab.name)
    G.GAME.slab = _slab
    _slab:increase_level()
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
  _slab:increase_level()
  _slab:calculate({ activated = true, old_slab = old_slab, after_level_up = true, returning = prevLevel},true)
  sendInfoMessage("LEVEL UP ".._slab.name.." to ".._slab:level())
end