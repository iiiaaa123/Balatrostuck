Balatrostuck = {}
Balatrostuck.INIT = {
    Aspects = {},
    Zodiacs = {},
    Jokers = {},
    Editions = {},
    Tags = {},
    Spectrals = {},
    Seals = {},
    Blinds = {},
    Vouchers = {},
    Decks = {}

}
Balatrostuck.peanut_gallery = false

G.SETTINGS.bstuck_per_card_credits = true
G.SETTINGS.bstuck_animation_speed = 1 -- 1 is 1x, 2 is 0.75x, 3 is 0.5x
G.SETTINGS.bstuck_animation_mode = 2 -- 1 is normal, 2 is reduced animation, 3 is no animation
G.SETTINGS.bstuck_jocker_limit = 9 -- power of jocker

G.FUNCS.bstuck_animation_change = function (args)
    G.SETTINGS.bstuck_animation_mode = args.to_key
end
G.FUNCS.bstuck_animation_speed_change = function (args)
    G.SETTINGS.bstuck_animation_speed = args.to_key
end
G.FUNCS.bstuck_jocker_limit_change = function (args)
    G.SETTINGS.bstuck_jocker_limit = args.to_key+6
end

G.bstuck_team = {
    akai = {
        name = "Akai",
        color = HEX("1793D1"),
        depts = {
            "Art",
            "Design",
            "Direction",
            "Programming"
        }
    },

    fazzie = {
        name = "Fazzie",
        color = HEX('323232'), -- placeholder
        depts = {
            "Direction",
            "Stagehand",
            "Design"
        }
    },

    campfire = {
        name = "CampfireCollective",
        color = HEX('323232'), -- placeholder
        depts = {
            "Direction",
            "Design",
            "Programming"
        }
    },

    baqly = {
        name = "Baqly",
        color = HEX("c10c1c"),
        depts = {"Art"}
    },

    yokcos = {
        name = "Yokcos",
        color = HEX('7a417d'),
        depts = {
            "Art",
            "Programming"
        }
    },

    lyman = {
        name = "Lyman",
        color = HEX('27ca01'),
        depts = {"Art"}
    },

    garb = {
        name = "garb",
        color = HEX('8c5c90'),
        depts = {
            "Art",
            "Programming"
        }
    },

    delirium = {
        name = "Delirium",
        color = HEX('FF7F7F'),
        depts = {
            "Art",
            "Programming"
        }
    },

    cozy = {
        name = "cozyGalvinism",
        color = HEX('323232'), -- placeholder
        depts = {"Programming"}
    },

    miser = {
        name = "Miser",
        color = HEX('416600'),
        depts = {"Art"}
    },

    victin = {
        name = "Victin",
        color = HEX('323232'), -- placeholder
        depts = {"Programming"}
    },

    bea = {
        name = "bconlon",
        color = HEX('1bd4d0'),
        depts = {
            "Art",
            "Programming"
        }
    }

}

-- this should techncially create a new uibox
-- that's gonna be above tags
