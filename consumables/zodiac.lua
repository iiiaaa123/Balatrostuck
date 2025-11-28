
SMODS.ConsumableType{
  key = 'Zodiac',
  collection_rows = { 6, 7 },
  primary_colour = G.C.SET.Zodiac,
  secondary_colour = G.C.SECONDARY_SET.Zodiac,
  shop_rate = 4,
  loc_txt = {
    name = 'Zodiac',
    collection = 'Zodiac Cards',
    label = 'Zodiac',
    undiscovered = {
      ['name'] = 'Not Discovered',
      ['text'] = {'test'},
    tooltip = {

    }
    },
    process_loc_text = function(self)
      if not next(self.loc_txt) then return end
      SMODS.process_loc_text(G.localization.misc.dictionary, 'k_' .. string.lower(self.key), self.loc_txt, 'name')
      SMODS.process_loc_text(G.localization.misc.dictionary, 'b_' .. string.lower(self.key) .. '_cards',
          self.loc_txt, 'collection')
      SMODS.process_loc_text(G.localization.misc.labels, string.lower(self.key), self.loc_txt, 'label')
      SMODS.process_loc_text(G.localization.descriptions.Other, 'undiscovered_' .. string.lower(self.key),
          self.loc_txt, 'undiscovered')
      SMODS.process_loc_text()
    end
  }
}

Balatrostuck.Zodiac = SMODS.Consumable:extend{
  set = "Zodiac",
  prefix = 'c_zodiac',
}

function Balatrostuck.Zodiac:add_caste(key)
  if G.GAME.BALATROSTUCK.zodiac_levels[key] == 0 then
    local newCaste = Caste('caste_bstuck_' .. key,G.P_CASTES['caste_bstuck_' .. key])
    table.insert(G.GAME.BALATROSTUCK.active_castes, newCaste)
  end


  G.GAME.BALATROSTUCK.zodiac_levels[key] = G.GAME.BALATROSTUCK.zodiac_levels[key] + self:get_level_increase(key)
  if G.GAME.BALATROSTUCK.zodiac_levels[key] >= 5 then
  check_for_unlock({type = 'bstuck_giftofgab'})
  end
  if G.GAME.BALATROSTUCK.zodiac_levels.Scorpio >= 8 then
  check_for_unlock({type = 'bstuck_backseater'})
  end
end

function Balatrostuck.Zodiac:get_level_increase(key)
  local amount = 1
  local hi = {}
  SMODS.calculate_context({zodiac_upgrade = true, zodiac = key},hi)
  for i=1, #hi do
    if hi[i].joker and hi[i].joker.amount then
      amount = amount + hi.joker.amount
    elseif hi[i].individual and hi[i].individual.amount then
      amount = amount + hi[i].individual.amount
    end
  end
  return amount
end



function Balatrostuck.Zodiac:level()
  return G.GAME.BALATROSTUCK.zodiac_levels[self.name] or 0 
end


function Balatrostuck.Zodiac:next_level()
  return self:level()+1
end

function Balatrostuck.Zodiac:get_level_color()
  return self:next_level()==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, self:next_level())]
end

function Balatrostuck.Zodiac:get_formula(level)
  if self.name == 'Aries' then
    return {level * 0.5}

  elseif self.name == 'Taurus' then
    return {0.95 ^ level}

  elseif self.name == 'Gemini' or
         self.name == 'Scorpio' or
         self.name == 'Aquarius' then
    return {level, level ~= 1 and 's' or ''}

  elseif self.name == 'Leo' then
    return {G.GAME.probabilities.normal, level}

  elseif self.name == 'Cancer' then
    return {level * 12}

  elseif self.name == 'Virgo' then
    return {level > 0 and summation(level+2) or 0}

  elseif self.name == 'Libra' then
    return {1 + (level/10)}

  elseif self.name == 'Sagittarius' then
    return {level * 25}

  elseif self.name == 'Capricorn' then
    return {level+0.5, 1/(level+1)}

  elseif self.name == 'Pisces' then
    return {level * 2}

  elseif self.name == 'Ophiuchus' then
    return {1.25 ^ level}

  else return nil

  end
end

function Balatrostuck.Zodiac:loc_vars(info_queue, card)
  art_credit('akai', info_queue)

  local ret = {}
  local nodes = {}
  
  localize{
      type = 'descriptions',
      set = 'Zodiac',
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

SMODS.UndiscoveredSprite {
  key = 'Zodiac',
  atlas = 'HomestuckZodiacs',
  pos = {
    x = 6,
    y = 1
  }
}:register()


Caste = Object:extend()
function Caste:init(key,config)
  self.key = key
  self.ability = config
  self.rank = self.ability.rank
end


function Caste:calculate(_context)

  local peepee = self.ability.apply(self, _context)
  if peepee then
    return peepee
  end
end

function Caste:level(card)
  local level = G.GAME.BALATROSTUCK.zodiac_levels[self.ability.name]
  if card and SMODS.has_enhancement(card, 'm_wild') and next(SMODS.find_card('j_bstuck_commandervantas')) then
    level = level + 1
  end
  
  return level
end

Balatrostuck.Castes = {}
Balatrostuck.Caste = SMODS.GameObject:extend{
  obj_table = Balatrostuck.Castes,
  obj_buffer = {}, -- don't know what this does and couldn't learn anything from the SMOD GameObject code
  set = 'Castes',
  class_prefix = 'caste',
  required_params = {
    'key' -- keep this the same as the zodiac you fucking shithead
  },
  omit_prefix = true, -- don't know what this does either
  get_obj = function(self, key) return G.P_CASTES[key] end,
  inject = function(self)

    -- I think it's safe to just reuse this?
    sendInfoMessage("Caste injected: "..self.key)
    G.P_CASTES[self.key] = self
    SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
  end,
  -- What Loc Text?
  process_loc_text = function(self) end,
  apply = function(self, context) end
}
