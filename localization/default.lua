return {
    descriptions = {
        Joker = {
            j_bstuck_darkscholar = {
                name = 'Dark Scholar', 
                text = {
                    "{C:attention}+1{} hand size every time",
                    "a {C:tarot}Tarot{} card is used,",
                    "goes {C:dark_edition}Grimdark{} at {C:attention}+#2#",
                    "{C:inactive}(Currently: {C:attention}+#1#{} hand size)"
                }    
            },
            j_bstuck_darkscholar_alt = {
                name = 'Dark Scholar',
                text = {
                    "{X:mult,C:white} X#3# {} Mult if a {C:tarot}Tarot{} card",
                    "has been used this round",
                    "otherwise {X:mult,C:white} X#4# {} Mult"
                    }        
            }
        },
        zodiacui = {
            Inactive = {
                text = {'{C:inactive}(Currently inactive){}'}
            },
            Aries = {
                text = {'{C:attention}Aces{} gain {X:mult,C:white}X#1#{} Mult for', --next level value
                    'each {C:attention}Ace discarded{} this round',
                    'or currently in your {C:attention}deck'}
            },
            Gemini = {
                text = {'{C:attention}Retrigger{} played {C:attention}2s',
                        '{C:attention}#1#{} additional time#2#'}
            },
            Taurus = {
                text = {'Discarded {C:attention}3s{} multiply the current' ,
                        '{C:attention}Blind requirement{} by {C:white,X:mult}X#1#{}'}
            },
            Cancer = {
                text = {'{C:attention}Held 4s{} give {C:mult}+#1#{} Mult'}
            },
            Virgo = {
                text = {'Played {C:attentions}6s{} give {C:chips}+#1# {C:attention}permanent{} Chips',
                        'to all {C:attention}other{} scoring cards when scored'}
            },
            Leo = {
                text = {'{C:attention}Held 5s{} have a {C:green}#1# in 4{} chance',
                        'to give {C:money}$#2#{} when any played card is scored'}
            },
            Libra = {
                name = 'Libra' ,
                text = {'Played {C:attention}7s{} give {X:mult,C:white}X#1#{} Mult'}
            },
            Scorpio = {
                text = {'Played {C:attention}8s{} double all {C:green,E:1,S:1.1}probabilities{}',
                    'when scored, up to ',
                    '{C:attention}#1#{} time#2# per hand, and',
                    'resets when next hand is played'}
            },
            Sagittarius = {
                text = {
                    'Played cards give',
                    '{C:chips}+#1#{} Chips if played hand', --next level value
                    'contains a {C:attention}non-scoring 9'
                }
            },
            Capricorn = {
                text = {
                    "Played {C:attention}10s{} give {X:mult,C:white}X#1#{} Mult", --X2 should be the next level's value
                    "when scored, held {C:attention}10s",
                    "give {X:mult,C:white}X#2#{} Mult"
                }
            },
            Aquarius = {
                text = {
                    '{C:attention}Jacks{} create {C:attention}#1#{} random',
                    '{C:attention}Tag#2#{} when {C:attention}destroyed' --next level value + dynamic plural
                }
            },
            Pisces = {
                text = {
                    'Played{C:attention} Queens{} give {C:money}$#1# {C:red,E:2}minus{} the', --next level value
                    'amount of {C:attention}remaining hands{} when scored'
                }
            },
            Ophiuchus = {
                text = {
                    "When played {C:attention}Kings{} are scored, a",
                    "random card held in hand becomes",
                    "{C:green}Paradox{} and gives {X:mult,C:white}X#1#{} Mult", --next level value
                }
            }
        }
    },
    misc = {
        zodiac_names = {
            Taurus = 'Taurus',
            Gemini = 'Gemini',
            Cancer = 'Cancer',
            Leo = 'Leo',
            Virgo = 'Virgo',
            Libra = 'Libra',
            Scorpio = 'Scorpio',
            Sagittarius = 'Sagittarius',
            Capricorn = 'Capricorn',
            Aquarius = 'Aquarius',
            Pisces = 'Pisces',
            Ophiuchus = 'Ophiuchus',
            Aries = 'Aries'
        },
    },
    
}