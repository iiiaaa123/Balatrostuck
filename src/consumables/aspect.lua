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
}:register()

Balatrostuck.Aspect = SMODS.Consumable:extend{
  set = 'Aspect',
  prefix = 'c_aspect'
}

Balatrostuck.Slab = SMODS.GameObject:extend{
  required_params = {
    'key', -- same as aspect!!!!!!!!
    'atlas',
    'pos',
  },
  omit_prefix = true,
  inject = function(self)
    -- this is where all the chungusing occurs

    -- TODO: tie slabs to Aspect center
    -- TODO: make them *kind of* like tags but without all the fluff
    -- TODO: set it up so that slabs can be made in tandem with Aspects
  end,
  process_loc_text = function(self) end
}

function Balatrostuck.Slab:generate_ui()
  
end

function add_slab()

end