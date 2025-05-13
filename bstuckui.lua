SMODS.current_mod.extra_tabs = function()
    local scale = BSUI.TextScale*1.2
    local imageScale = 2.4
    local balastuck = Sprite(0,0,(1*469/98)*imageScale,imageScale,G.ASSET_ATLAS["bstuck_logo"], {x=0, y=0})
    balastuck.states.drag.can = false

    local function dept_Direction()
        return BSUI.Row( BSUI.Config.Panel('cm', 0.125, G.C.BLACK, nil, 0.1), {
            BSUI.Col( BSUI.Config.Basic, {
                BSUI.Modules.Credits.Header(G.C.MIND, 'Direction', scale),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.12)}),
                BSUI.Row( BSUI.Config.Basic, {
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('Akai', scale)}),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.5, 0.0)}),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('Fazzie', scale)})
                }),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.1)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('CampfireCollective', scale*0.95)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.1)}),
            })
        })
    end

    local function dept_MusicSFX()
        return BSUI.Row( BSUI.Config.Panel('cm', 0.125, G.C.BLACK, nil, 0.1), {
            BSUI.Col( BSUI.Config.Basic, {
                BSUI.Modules.Credits.Header(G.C.RAGE, ' Music / SFX ', scale),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.12)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('Delirium', scale)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.12)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('dangerbites', scale)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.1)}),
            })
        })
    end

    local function dept_Trailer()
        return BSUI.Row( BSUI.Config.Panel('cm', 0.125, G.C.BLACK, nil, 0.1), {
            BSUI.Col( BSUI.Config.Basic, {
                BSUI.Modules.Credits.Header(G.C.HEART, 'SAHCon Trailer', scale),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.12)}),
                BSUI.Row( BSUI.Config.Basic, {
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('shmig', scale)}),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.5, 0.0)}),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('sinewavey', scale)})
                }),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.1)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('Knightmare', scale)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.1)})
            })
        })
    end

    local function dept_Artwork()
        return BSUI.Row( BSUI.Config.Panel('cm', 0.125, G.C.BLACK, nil, 0.1), {
            BSUI.Col( BSUI.Config.Basic, {
                BSUI.Modules.Credits.Header(G.C.LIGHT, 'Artwork', scale),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.12)}),
                BSUI.Row( BSUI.Config.Basic, {
                    BSUI.Modules.Credits.Names({'Akai', 'Yokcos',}, scale),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.2, 0.0)}),
                    BSUI.Modules.Credits.Names({'garb', 'Baqly', 'bconlon'}, scale),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.2, 0.0)}),
                    BSUI.Modules.Credits.Names({'Lyman', 'Miser', 'Delirium'}, scale)
                }),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.075)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('SagaciousCejai', scale*0.88)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.1)}),
            })
        })
    end

    local function dept_Programming()
        return BSUI.Row( BSUI.Config.Panel('cm', 0.125, G.C.BLACK, nil, 0.1), {
            BSUI.Col( BSUI.Config.Basic, {
                BSUI.Modules.Credits.Header(G.C.BREATH, 'Programming', scale),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.12)}),
                BSUI.Row( BSUI.Config.Basic, {
                    BSUI.Modules.Credits.Names({'Akai', 'garb',}, scale),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.2, 0.0)}),
                    BSUI.Modules.Credits.Names({ 'Victin', 'bconlon'}, scale),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.2, 0.0)}),
                    BSUI.Modules.Credits.Names({'Yokcos', 'Delirium'}, scale)
                }),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.075)}),
                BSUI.Row( BSUI.Config.Basic, {
                    BSUI.Modules.Credits.Names({'CampfireCollective', 'cozyGalvinism'}, scale*0.88),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.2, 0.0)}),
                    BSUI.Modules.Credits.Names({'lord-ruby', 'dangerbites'}, scale*0.88),
                    BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.1)}),
                }),
            })
        })
    end

    local function dept_Playtesting()
        return BSUI.Row( BSUI.Config.Panel('cm', 0.125, G.C.BLACK, nil, 0.1), {
            BSUI.Col( BSUI.Config.Basic, {
                BSUI.Modules.Credits.Header(G.C.BLOOD, 'Playtesting', scale),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.12)}),
                BSUI.Row( BSUI.Config.Basic, {
                    BSUI.Modules.Credits.Names({'conchors', 'Victin'}, scale*0.9),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.2, 0.0)}),
                    BSUI.Modules.Credits.Names({'Miser', 'Snowroom'}, scale*0.9),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.2, 0.0)}),
                    BSUI.Modules.Credits.Names({'Chloe (Teki)', 'pescia'}, scale*0.9)
                }),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.075)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('SagaciousCejai', scale*0.88)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.1)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('JadedDraconevix', scale*0.88)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.1)}),
            }),
        })
    end

    local function dept_Acknowledgements()
        return BSUI.Row( BSUI.Config.Panel('cm', 0.125, G.C.BLACK, nil, 0.1), {
            BSUI.Col( BSUI.Config.Basic, {
                BSUI.Modules.Credits.Header(G.C.LIFE, 'Acknowledgements', scale),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.12)}),
                BSUI.Row( BSUI.Config.Basic, {
                    BSUI.Modules.Credits.Names({
                        'Balatro by LocalThunk',
                        'Homestuck by Andrew Hussie',
                        'Cool and New Webcomic by o',
                        'Ligmastuck by Ymi',
                        'Vast Error by DECONRECONSTRUCTION',
                        'Karkat Goes to a Convention by Cole'
                    }, scale*0.75),
                })
            })
        })
    end

    return {
        {
            label = "Settings",
            tab_definition_function = function ()
                return BSUI.Root(BSUI.Config.Basic, {
                    BSUI.Row(BSUI.Config.Basic, {create_toggle({
                        label = 'Per card Credits',
                        ref_table = G.SETTINGS,
                        ref_value = 'bstuck_per_card_credits',
                        info = {'Display artist credits with each card\'s information'}
                    })}),
                    BSUI.PadRow(0.2),
                    BSUI.Row(BSUI.Config.Basic, {create_option_cycle({
                        current_option = G.SETTINGS.bstuck_animation_mode,
                        options = {'Regular', 'Reduced', 'None'},
                        label = 'Animation Mode',
                        opt_callback = 'bstuck_animation_change',
                        ref_table = G.SETTINGS,
                        ref_value = 'bstuck_animation_mode',
                        info = {'Display animated and photosensitive content'}
                    })}),
                    BSUI.PadRow(0.2),
                    BSUI.Row(BSUI.Config.Basic, {create_option_cycle({
                        current_option = G.SETTINGS.bstuck_animation_speed,
                        options = {'1X', '0.75X', '0.5X', '0.33X'},
                        label = 'Animation Speed',
                        opt_callback = 'bstuck_animation_speed_change',
                        ref_table = G.SETTINGS,
                        ref_value = 'bstuck_animation_speed',
                        info = {'Rate of animation for cards'}
                    })}),
                    BSUI.PadRow(0.2),
                    BSUI.Row(BSUI.Config.Basic, {create_option_cycle({
                        current_option = G.SETTINGS.bstuck_jocker_limit-6,
                        options = {'128', '256', '512', '1024', '2048', 'Unlimited'},
                        label = 'Jocker Limit',
                        opt_callback = 'bstuck_jocker_limit_change',
                        ref_table = G.SETTINGS,
                        ref_value = 'bstuck_jocker_limit',
                        info = {'Amount of spawnable Jockers','before the game forces a crash'}
                    })}),
                })
            end
        },

        -- reference for create_toggle(args)
        -- args.active_colour = args.active_colour or G.C.RED
        -- args.inactive_colour = args.inactive_colour or G.C.BLACK
        -- args.w = args.w or 3
        -- args.h = args.h or 0.5
        -- args.scale = args.scale or 1
        -- args.label = args.label or 'TEST?'
        -- args.label_scale = args.label_scale or 0.4
        -- args.ref_table = args.ref_table or {}
        -- args.ref_value = args.ref_value or 'test'
        -- args.callback - function to call
      
        -- reference for create_option_cycle(args)
        -- args = args or {}
        -- args.colour = args.colour or G.C.RED
        -- args.options = args.options or {
        --   'Option 1',
        --   'Option 2'
        -- }
        -- args.current_option = args.current_option or 1
        -- args.current_option_val = args.options[args.current_option]
        -- args.opt_callback = args.opt_callback or nil (i think this is the function callback)
        -- args.scale = args.scale or 1
        -- args.ref_table = args.ref_table or nil
        -- args.ref_value = args.ref_value or nil
        -- args.w = (args.w or 2.5)*args.scale
        -- args.h = (args.h or 0.8)*args.scale
        -- args.text_scale = (args.text_scale or 0.5)*args.scale
        -- args.l = '<'
        -- args.r = '>'
        -- args.focus_args = args.focus_args or {}
        -- args.focus_args.type = 'cycle'

        {
            label = "Credits",
            tab_definition_function = function()
            return BSUI.Root(BSUI.Config.Basic, {
                BSUI.Row(BSUI.Config.Basic, {BSUI.Image(balastuck)}),
                BSUI.Row(BSUI.Config.Basic, {
                    BSUI.Col( BSUI.Config.Basic, {
                        dept_Direction(),
                        BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.125)}),
                        dept_MusicSFX(),
                        BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.125)}),
                        dept_Trailer()
                    }),

                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.125, 0.0)}),

                    BSUI.Col( BSUI.Config.Basic, {
                        dept_Artwork(),
                        BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.125)}),
                        dept_Programming()
                    }),

                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.125, 0.0)}),

                    BSUI.Col( BSUI.Config.Basic, {
                        dept_Playtesting(),
                        BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.125)}),
                        dept_Acknowledgements()
                    }),
                })
            })
            end
            },

    }
end