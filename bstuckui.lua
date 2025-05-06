SMODS.current_mod.extra_tabs = function() --Credits tab
    local scale = 0.42
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
                    BSUI.Modules.Credits.Names({'Akai', 'Yokcos', 'garb', 'Baqly'}, scale),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.2, 0.0)}),
                    BSUI.Modules.Credits.Names({'bconlon', 'Lyman', 'Miser', 'Delirium'}, scale)
                }),
            })
        })
    end

    local function dept_Programming() 
        return BSUI.Row( BSUI.Config.Panel('cm', 0.125, G.C.BLACK, nil, 0.1), {
            BSUI.Col( BSUI.Config.Basic, {
                BSUI.Modules.Credits.Header(G.C.BREATH, 'Programming', scale),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.12)}),
                BSUI.Row( BSUI.Config.Basic, {
                    BSUI.Modules.Credits.Names({'Akai', 'garb', 'Victin'}, scale),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.2, 0.0)}),
                    BSUI.Modules.Credits.Names({'bconlon', 'Yokcos', 'Delirium'}, scale)
                }),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.075)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('CampfireCollective', scale*0.88)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.125)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Modules.Credits.Name('cozyGalvinism', scale)}),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.1)}),
            })
        })
    end

    local function dept_Playtesting()
        return BSUI.Row( BSUI.Config.Panel('cm', 0.125, G.C.BLACK, nil, 0.1), {
            BSUI.Col( BSUI.Config.Basic, {
                BSUI.Modules.Credits.Header(G.C.BLOOD, 'Playtesting', scale),
                BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.12)}),
                BSUI.Row( BSUI.Config.Basic, {
                    BSUI.Modules.Credits.Names({'JadedDraconevix', 'conchors', 'Chloe (Teki)'}, scale*0.9),
                    BSUI.Col( BSUI.Config.Basic, {BSUI.Pad(0.2, 0.0)}),
                    BSUI.Modules.Credits.Names({'Miser', 'SagaciousCejai', 'Victin'}, scale*0.9)
                })
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
    }
end