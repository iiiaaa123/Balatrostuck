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
    return
  end

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