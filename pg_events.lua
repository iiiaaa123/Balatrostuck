-- Events for the batch of Jokers lovingly known as the Peanut Gallery
-- Naming convention is PG.<character_name>_<context>_events

PG = {}
PG.John = {}
PG.Vriska = {}
PG.Caliborn = {}

function PG.John:pick_random(set)
    return pseudorandom_element(self[set], pseudoseed('windything'))
end

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

PG.John.start_of_round_events = {
    paradox_common = {
        quip = 'john_paradox_common',
        func = function (_self,card,context)
            
        end
    },
    paradox_playingcard = {
        quip = 'john_paradox_playingcard',
        func = function (_self,card,context)
        end
    },
    draw = {
        size = 2,
        quip = 'john_draw_two',
        func = function (self,_self,card,context)
            
        end
    }
}