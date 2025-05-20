-- Events for the batch of Jokers lovingly known as the Peanut Gallery
-- Naming convention is PG.<character_name>_<context>_events

PG = {}
PG.John = {}
PG.Vriska = {}
PG.Caliborn = {}

PG.John.shop_events = {
    free_voucher = {
        quip = 'john_free_voucher',
        func = function(_self,card,context)
          
        end
    },
    discount_card = {
        quip = 'john_discount_card',
        func = function (_self,card,context)
            
        end
    },
    add_pack = {
        quip = 'john_add_pack',
        func = function (_self,card,context)
            
        end
    },
    free_reroll = {
        quip = 'john_free_reroll',
        func = function (_self,card,context)
            
        end
    },
    add_rare = {
        quip = 'john_add_rare',
        func = function (_self,card,context)
            
        end
    },
    add_uncommon = {
        quip = 'john_add_uncommon',
        func = function (_self,card,context)
            
        end
    },
}

PG.John.round_events = {}