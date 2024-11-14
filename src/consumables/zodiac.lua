
SMODS.ConsumableType{
  key = 'Zodiac',
  collection_rows = { 6, 7 },
  primary_colour = G.C.SET.Zodiac,
  secondary_colour = G.C.SECONDARY_SET.Zodiac,
  loc_txt = {
    name = 'Zodiac',
    collection = 'Zodiac',
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
  },
}:register()

Balatrostuck.Zodiac = SMODS.Consumable:extend{
  set = "Zodiac",
  prefix = 'c_zodiac',
}

SMODS.UndiscoveredSprite {
  key = 'Zodiac',
  atlas = 'HomestuckZodiacs',
  pos = {
    x = 6,
    y = 1
  }
}:register()