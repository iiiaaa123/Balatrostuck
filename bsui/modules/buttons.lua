BSUI.Modules.Buttons = {}

BSUI.Modules.Buttons.CardButton = function(card,_button,_func,_one_press,_text,sell_price)
    local _minh = (card.area and card.area.config.type == 'joker') and 0 or 1
    return 
        BSUI.Col({align='cr',padding=0},{
            BSUI.Col({ref_table=card,align='cr',maxw=1.25,padding=0.1,r = 0.01,minh=_minh,hover=true,shadow=true,colour=G.C.UI.BACKGROUND_INACTIVE,
            one_press=_one_press,button=_button,func=_func},
            {
                BSUI.Pad(0.1,0.6),
                BSUI.Col({align='tm'},{
                    _text and BSUI.Row({align='cw',maxw=1.25},{
                        BSUI.Text(_text,G.C.UI.TEXT_LIGHT,0.55,true),
                    }),
                    sell_price and BSUI.Row({align='cw',maxw=1.25},{
                        BSUI.Pad(0.1,0.6),
                        BSUI.Text(sell_price,G.C.UI.TEXT_LIGHT,0.55,true)
                    })
                })
            })
        })
end

BSUI.Modules.Buttons.UseButton = function(card)
    return BSUI.Modules.Buttons.CardButton(card,'use_card','can_use_consumeable',true,localize('b_use'),true)
end


