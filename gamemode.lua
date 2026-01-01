
Gamemode = Object:extend()
function Gamemode:init(key,loadtable)
  self.key = loadtable and loadtable.key or key

  local proto = Balatrostuck.Gamemodes[loadtable and loadtable.key or key]
  self.config = copy_table(proto.config)
  self.name = proto.name
  if loadtable and loadtable.ability then self.ability = loadtable.ability 
  else self.ability = copy_table(self.config) end
end


function Gamemode:calculate(_context)
    local obj = Balatrostuck.Gamemodes[self.key]
    local res
    if obj and obj.calculate and type(obj.calculate) == 'function' then
      res = obj.calculate(obj,self, _context)
    end
    return res
end
function Gamemode:apply(_context)
    local obj = Balatrostuck.Gamemodes[self.key]
    local res
    if obj and obj.apply and type(obj.apply) == 'function' then
      res = obj.apply(obj,self, _context)
    end
    return res
end
function Gamemode:save()
  return {key = self.key, ability = self.ability}
end



Balatrostuck.Gamemodes = {}
Balatrostuck.Gamemode = SMODS.GameObject:extend{
  obj_table = Balatrostuck.Gamemodes,
  obj_buffer = {},
  set = 'Gamemodes',
  class_prefix = 'gamemode',
  required_params = {
    'key' 
  },
  omit_prefix = true, -- don't know what this does either (you and me both my mysterious green friend)
  get_obj = function(self, key) return Balatrostuck.Gamemodes[key] end,
  inject = function(self)
    if not Balatrostuck.Gamemodes then Balatrostuck.Gamemodes = {} end
    Balatrostuck.Gamemodes[self.key] = self
  end,
  -- What Loc Text?
  process_loc_text = function(self) end,
  apply = function(self, context) end
}

function Balatrostuck.Gamemode:init(key)
  self.key = key
  local proto = Balatrostuck.Gamemodes[key]
  self.config = copy_table(proto.config)
  self.name = proto.name
  self.triggered = false

  self.ability = copy_table(self.config)
end

function Balatrostuck.set_gamemode(key)
  G.GAME.GAMEMODE = Gamemode(key)
  G.GAME.GAMEMODE:apply() --for debug, do not ship!!
end


function Blind:calculate(_context)
    local obj = G.P_BLINDS[self.config.blind.key]
    local res
    if obj and obj.calculate and type(obj.calculate) == 'function' then
      res = obj.calculate(obj,self, _context)
    end
    return res
end

--eval Balatrostuck.set_gamemode("gamemode_bstuck_alternian")