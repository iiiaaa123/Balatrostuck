SMODS.ConsumableType{
  key = 'Aspect',
  collection_rows = { 3, 3 },
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
  add_slab(Slab('slab_bstuck_' .. aspect))
end

function Balatrostuck.Aspect:level(default)
  return G.GAME.BALATROSTUCK.aspect_levels[self.name] or default or 0
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

function Slab:apply_to_run(_context)
  if not self.triggered then
    local obj = Balatrostuck.Slabs[self.key]
    local res
    if obj and obj.apply and type(obj.apply) == 'function' then
      res = obj:apply(self, _context)
    end

    if res then
      self.triggered = true
      return res
    end
  end
end

function Slab:level(default)
  local aspect = string.gsub(self.key, "slab_bstuck_", "")
  aspect = string.gsub(aspect, "^%l", string.upper)
  return G.GAME.BALATROSTUCK.aspect_levels[aspect] or default or 0
end

function Slab:increase_level()
  local aspect = string.gsub(self.key, "slab_bstuck_", "")
  aspect = string.gsub(aspect, "^%l", string.upper)
  G.GAME.BALATROSTUCK.aspect_levels[aspect] = G.GAME.BALATROSTUCK.aspect_levels[aspect] + 1
end

function Slab:decrease_level()
  local aspect = string.gsub(self.key, "slab_bstuck_", "")
  aspect = string.gsub(aspect, "^%l", string.upper)
  G.GAME.BALATROSTUCK.aspect_levels[aspect] = G.GAME.BALATROSTUCK.aspect_levels[aspect] - 1
end

function Slab:juice_up(_scale, _rot)
  if self.slab_sprite then
    self.slab_sprite:juice_up(_scale, _rot)
  end
end

function Slab:generate_UI(_size)
  _size = _size or 0.8

  local slab_sprite_tab = nil

  local slab_sprite = Sprite(0, 0, _size * 1, _size * 1, G.ASSET_ATLAS[G.P_SLABS[self.key].atlas], self.pos)
  slab_sprite.T.scale = 1
  slab_sprite_tab = {n= G.UIT.C, config={align = "cm", ref_table = self}, nodes={
    {n=G.UIT.O, config={w=_size*1, h=_size*1, colour = G.C.BLUE, object = slab_sprite, focus_with_object = true}}
  }}

  slab_sprite:define_draw_steps({
    {shader = 'dissolve', shadow_height = 0.05},
    {shader = 'dissolve'},
  })
  slab_sprite.float = true
  slab_sprite.states.hover.can = true
  slab_sprite.states.drag.can = false
  slab_sprite.states.collide.can = true
  slab_sprite.config = {tag = self, force_focus = true}

  slab_sprite.hover = function(_self)
    if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then
      if not _self.hovering and _self.states.visible then
        _self.hovering = true
        if _self == slab_sprite then
          _self.hover_tilt = 3
          _self:juice_up(0.05, 0.02)
          play_sound('paper1', math.random()*0.1 + 0.55, 0.42)
          play_sound('tarot2', math.random()*0.1 + 0.55, 0.09)
        end

        self:get_uibox_table(slab_sprite)
        _self.config.h_popup = G.UIDEF.card_h_popup(self)
        _self.config.h_popup_config = {align = 'cl', offset = {x=-0.1, y=0}, parent=_self}
        Node.hover(_self)
        if _self.children.alert then
          _self.children.alert:remove()
          _self.children.alert = nil
          if self.key and G.P_SLABS[self.key] then G.P_SLABS[self.key].alerted = true end
          G:save_progress()
        end
      end
    end
  end

  slab_sprite.stop_hover = function(_self)
    _self.hovering = false
    Node.stop_hover(_self)
    _self.hover_tilt = 0
  end

  slab_sprite:juice_up()
  self.slab_sprite = slab_sprite

  return slab_sprite_tab, slab_sprite
end

function Slab:get_uibox_table(slab_sprite)
  slab_sprite = slab_sprite or self.slab_sprite
  slab_sprite.ability_UIBox_table = generate_card_ui(G.P_SLABS[self.key], nil, {}, 'Other', nil, false)
  return slab_sprite
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
    _slab:apply_to_run({ activated = true, after_level_up = true, is_new = true })
    return
  end

  old_slab = G.GAME.slab
  G.GAME.slab = _slab

  if old_slab.key ~= _slab.key and old_slab:level() > 0 then
    sendInfoMessage("Changing slab from "..old_slab.name.." to ".._slab.name)
    old_slab:apply_to_run({ deactivated = true, new_slab = _slab, before_level_down = true })
    old_slab:decrease_level()
    old_slab:apply_to_run({ deactivated = true, new_slab = _slab, after_level_down = true })
  end

  _slab:apply_to_run({ activated = true, old_slab = old_slab, before_level_up = true })
  _slab:increase_level()
  _slab:apply_to_run({ activated = true, old_slab = old_slab, after_level_up = true })
  sendInfoMessage("LEVEL UP ".._slab.name.." to ".._slab:level())
end