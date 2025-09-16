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

if not G.SETTINGS.bstuck_per_card_credits then
    G.SETTINGS.bstuck_per_card_credits = true
end

if not G.SETTINGS.bstuck_animation_speed then
    G.SETTINGS.bstuck_animation_speed = 1 -- 1 is 1x, 2 is 0.75x, 3 is 0.5x
end

if not G.SETTINGS.bstuck_animation_mode then
    G.SETTINGS.bstuck_animation_mode = 2 -- 1 is normal, 2 is reduced animation, 3 is no animation
end

if not G.SETTINGS.bstuck_jocker_limit then
    G.SETTINGS.bstuck_jocker_limit = 8 -- power of jocker
end

G.FUNCS.bstuck_animation_change = function (args)
    G.SETTINGS.bstuck_animation_mode = args.to_key
    G:save_settings()
end
G.FUNCS.bstuck_animation_speed_change = function (args)
    G.SETTINGS.bstuck_animation_speed = args.to_key
    G:save_settings()
end
G.FUNCS.bstuck_jocker_limit_change = function (args)
    G.SETTINGS.bstuck_jocker_limit = args.to_key+6
    G:save_settings()
end

function create_act_complete_alert(_key, _act, _last)
  local _act = _act or 0
  local _atlas = G.ASSET_ATLAS["Joker"]
  local _c = G.P_CENTERS[_key]

    local _smods_atlas = _c and ((G.SETTINGS.colourblind_option and _c.hc_atlas or _c.lc_atlas) or _c.atlas)
    if _smods_atlas then
        _atlas = G.ASSET_ATLAS[_smods_atlas] or _atlas
    end
     
    local subtext = "End of Act ".._act
    local maintext = _last and "All Jokers Unlocked!" or "New Jokers Unlocked!"
    local t_s = Sprite(0,0,1.5*(_atlas.px/_atlas.py),1.5,_atlas, _c and _c.pos or {x=3, y=0})
        t_s.states.drag.can = false
        t_s.states.hover.can = false
        t_s.states.collide.can = false

    local t = {n=G.UIT.ROOT, config = {align = 'cl', r = 0.1, padding = 0.06, colour = G.C.UI.TRANSPARENT_DARK}, nodes={
    {n=G.UIT.R, config={align = "cl", padding = 0.2, minw = 20, r = 0.1, colour = G.C.BLACK, outline = 1.5, outline_colour = G.C.GREY}, nodes={
      {n=G.UIT.R, config={align = "cm", r = 0.1}, nodes={
        {n=G.UIT.R, config={align = "cm", r = 0.1}, nodes={
          {n=G.UIT.O, config={object = t_s}},
        }},
        _type ~= 'achievement' and {n=G.UIT.R, config={align = "cm", padding = 0.04}, nodes={
          {n=G.UIT.R, config={align = "cm", maxw = 3.4}, nodes={
            {n=G.UIT.T, config={text = subtext, scale = 0.5, colour = G.C.FILTER, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", maxw = 3.4}, nodes={
            {n=G.UIT.T, config={text = maintext, scale = 0.35, colour = G.C.FILTER, shadow = true}},
          }}
        }}
        or {n=G.UIT.R, config={align = "cm", padding = 0.04}, nodes={
          {n=G.UIT.R, config={align = "cm", maxw = 3.4, padding = 0.1}, nodes={
            {n=G.UIT.T, config={text = name, scale = 0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", maxw = 3.4}, nodes={
            {n=G.UIT.T, config={text = subtext, scale = 0.3, colour = G.C.FILTER, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", maxw = 3.4}, nodes={
            {n=G.UIT.T, config={text = maintext, scale = 0.35, colour = G.C.FILTER, shadow = true}},
          }}
        }}
      }}
    }}
  }}
  return t
end

function notify_bstuck_alert(_achievement, _act, _last)
    local _last = _last or false
    G.E_MANAGER:add_event(Event({
      no_delete = true,
      pause_force = true,
      timer = 'UPTIME',
      func = function()
        if G.achievement_notification then
            G.achievement_notification:remove()
            G.achievement_notification = nil
        end
        G.achievement_notification = G.achievement_notification or UIBox{
            definition = create_act_complete_alert(_achievement, _act, _last),
            config = {align='cr', offset = {x=20,y=0},major = G.ROOM_ATTACH, bond = 'Weak'}
        }
        return true
      end
    }), 'achievement')
    G.E_MANAGER:add_event(Event({
        no_delete = true,
        trigger = 'after',
        pause_force = true,
        timer = 'UPTIME',
        delay = 0.1,
        func = function()
            G.achievement_notification.alignment.offset.x = G.ROOM.T.x - G.achievement_notification.UIRoot.children[1].children[1].T.w - 0.8
          return true
        end
    }), 'achievement')
    G.E_MANAGER:add_event(Event({
        no_delete = true,
        pause_force = true,
        trigger = 'after',
        timer = 'UPTIME',
        delay = 0.1,
        func = function()
            play_sound('highlight1', nil, 0.5)
            play_sound('foil2', 0.5, 0.4)
          return true
        end
    }), 'achievement')
    G.E_MANAGER:add_event(Event({
      no_delete = true,
      pause_force = true,
      trigger = 'after',
      delay = 3,
      timer = 'UPTIME',
      func = function()
        G.achievement_notification.alignment.offset.x = 20
        return true
      end
    }), 'achievement')
    G.E_MANAGER:add_event(Event({
        no_delete = true,
        pause_force = true,
        trigger = 'after',
        delay = 0.5,
        timer = 'UPTIME',
        func = function()
            if G.achievement_notification then
                G.achievement_notification:remove()
                G.achievement_notification = nil
            end
          return true
        end
    }), 'achievement')
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
    cejai = {
        name = 'SagaciousCejai',
        color = HEX('078446'),
        depts = {
            'Art',
            'Playtesting'
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


Balatrostuck.enhancement_cards = {
    m_bonus = 'c_heirophant',
    m_wild = 'c_lovers',
    m_steel = 'c_chariot',
    m_stone = 'c_tower',
    m_glass = 'c_justice',
    m_gold = 'c_devil',
    m_lucky = 'c_magician',
    m_mult = 'c_empress'
}




-- this should techncially create a new uibox
-- that's gonna be above tags
