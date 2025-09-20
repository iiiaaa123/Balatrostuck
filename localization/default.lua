return {
    descriptions = {
        Other = {
            art_bstuck_1 = {
                name = 'Artist',
                text = {'{E:1,V:1}#1#{}'}
            },
            art_bstuck_2 = {
                name = 'Artists',
                text = {
                    '{E:1,V:1}#1#{}',
                    '{E:1,V:2}#2#{}'
                }
            },
            warn_bstuck_wip = {
                name = 'WIP Content',
                text = {
                    'Will {C:red}not{} appear',
                    'in {C:attention}regular play{}'
                }
            },
            c_bstuck_levelup = {
                text = {'{s:1.1,E:2,V:1}(lvl.1){} Level up'}
            },
            bstuck_scratchwarning = {
                text = {'{C:scratch}#1# in 1000 chance', '{C:scratch}to self destruct'}
            }
        },
        Joker = {
            j_bstuck_descend = {
                name = 'Descend', --would like to replace entire description with just "X1 Mult" for however much mult it has after the removal thangs
                text = {
                    'After {C:attention}#1#{} rounds, set level',
                    'of all {C:attention}poker hands{} to 1 and',
                    'this Joker gains {C:white,X:mult}X#2#{} Mult',
                    'per {C:attention}level removed{}',
                    '{C:inactive}(Currently #3#/#1#)'
                },
                unlock = {'Unlocked by',
                'finishing Act 3'}
            },
            j_bstuck_descend_alt = {
                name = 'Descend',
                text = {
                    '{C:white,X:mult}X#1#{} Mult'
                }
            },
            j_bstuck_darkscholar = {
                name = 'Dark Scholar', 
                text = {
                    "{C:attention}+1{} hand size every time",
                    "a {C:tarot}Tarot{} card is used,",
                    "goes {C:dark_edition}Grimdark{} at {C:attention}+#2#",
                    "{C:inactive}(Currently: {C:attention}+#1#{} hand size)"
                },
                unlock = {'Unlocked by',
                'finishing Act 4'}
            },
            j_bstuck_darkscholar_alt = {
                name = 'Dark Scholar',
                text = {
                    "{X:mult,C:white} X#3# {} Mult if a {C:tarot}Tarot{} card",
                    "has been used this round",
                    "otherwise {X:mult,C:white} X#4# {} Mult"
                    },
                unlock = {'Unlocked by',
                'finishing Act 4'}
            },
            j_bstuck_backseater_1 ={
                name = '8acks8er',
                text = {
                    '{C:dark_edition}Quest #1#:',
                    'Play a {C:attention}Straight Flush'
                }
            },
            j_bstuck_backseater_2 ={
                name = '8acks8er',
                text = {
                    '{C:dark_edition}Quest #1#:',
                    '{C:green}#2# in #3#{} chance to',
                    'beat this quest each round'
                }
            },
            j_bstuck_backseater_3 ={
                name = '8acks8er',
                text = {
                    '{C:dark_edition}Quest #1#:',
                    'Win a round with',
                    '#2# {C:attention}empty{} Joker slots'
                }
            },
            j_bstuck_backseater_4 ={
                name = '8acks8er',
                text = {
                    '{C:dark_edition}Quest #1#:',
                    'Skip both Blinds',
                    'in one ante, then',
                    'beat the Boss Blind'
                }
            },
            j_bstuck_backseater_5 ={
                name = '8acks8er',
                text = {
                    '{C:dark_edition}Quest #1#:',
                    'Destroy #2# playing cards',
                    'in a single round',
                    '{C:inactive}(Currently {C:attention}#3#{C:inactive}/#2#)'
                }
            },
            j_bstuck_backseater_6 ={
                name = '8acks8er',
                text = {
                    '{C:dark_edition}Quest #1#:',
                    'Create #2# Consumable',
                    'Cards in one round',
                    '(Currently #3#/#2#)'
                }
            },
            j_bstuck_backseater_7 ={
                name = '8acks8er',
                text = {
                    '{C:dark_edition}Quest #1#:',
                    'Trigger played cards',
                    '#2# times in one hand'
                }
            },
            j_bstuck_backseater_8 ={
                name = '8acks8er',
                text = {
                    '{C:dark_edition}Quest #1#:',
                    'Score #2# Chips',
                    'in one hand'
                }
            },
        },
        Zodiac = {
            c_bstuck_aries_current = {
                text = {'{C:inactive}(Currently gains {C:white,X:mult}X#1#{C:inactive})'}
            },
            c_bstuck_gemini_current = {
                text = {'{C:inactive}(Currently {C:attention}#1#{C:inactive} time#2#{C:inactive})'}
            },
            c_bstuck_taurus_current = {
                text = {'{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive})'}
            },
            c_bstuck_cancer_current = {
                text = {'{C:inactive}(Currently {C:chips}+#1#{} permament chips{C:inactive})'}
            },
            c_bstuck_leo_current = {
                text = {'{C:inactive}(Currently {C:money}$#2#{C:inactive})'}
            },
            c_bstuck_virgo_current = {
                text = {'{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'}
            },
            c_bstuck_libra_current = {
                text = {'{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive} Mult)'}
            },
            c_bstuck_scorpio_current = {
                text = {'{C:inactive}(Currently up to {C:attention}#1# {C:inactive}time#2#)'}
            },
            c_bstuck_sagittarius_current = {
                text = {'{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)'}
            },
            c_bstuck_capricorn_current = {
                text = {'{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive} and {C:white,X:mult}X#2#{C:inactive})'}
            },
            c_bstuck_aquarius_current = {
                text = {'{C:inactive}(Currently {C:attention}#1#{C:inactive} Tag#2#{C:inactive})'}
            },
            c_bstuck_pisces_current = {
                text = {'{C:inactive}(Currently {C:money}$#1#{C:inactive})'}
            },
            c_bstuck_ophiuchus_current = {
                text = {'{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive} Mult)'}
            }
        },
        Aspect = {
            c_bstuck_blood_current = {
                text = {'{C:inactive}(Currently {C:attention}#1# cards'}
            },
            c_bstuck_breath_current = {
                text = {'{C:inactive}(Currently {C:attention}#1# reroll#2#'}
            },
            c_bstuck_doom_current = {
                text = {'{C:inactive}(Currently {C:green}#1# {C:inactive}level#2# and {C:green}1 in #3#{C:inactive})'}
            },
            c_bstuck_heart_current = {
                text = {'{C:inactive}(Currently {C:attention}#1# {C:inactive}level#2#)'}
            },
            c_bstuck_hope_current = {
                text = {'{C:inactive}(Currently {C:attention}+#1# {C:inactive}card#2#)'}
            },
            c_bstuck_life_current = {
                text = {'{C:inactive}(Currently {C:paradox}#1# {C:inactive}and {C:money}$#2#{C:inactive})'}
            },
            c_bstuck_light_current = {
                text = {'{C:inactive}(Currently {C:white,X:mult}X#1# {C:inactive}Mult)'}
            },
            c_bstuck_mind_current = {
                text = {'{C:inactive}(Currently {C:attention}#1# {C:inactive}cop#2#)'}
            },
            c_bstuck_piss_current = {
                text = {'{C:inactive}(Currently {C:paradox}#1# {C:inactive}Jokers)'}
            },
            c_bstuck_rage_current = {
                text = {'{C:inactive}(Currently {C:white,X:mult}X#1# {C:inactive}Mult)'}
            },
            c_bstuck_space_current = {
                text = {'{C:attention}+#1# {C:inactive}hand size)'}
            },
            c_bstuck_time_current = {
                text = {'{C:inactive}(Currently {C:blue}+#1# {C:inactive}hand#2# each round)'}
            },
            c_bstuck_void_current = {
                text = {'{C:inactive}(Currently {C:dark_edition}#1# {C:inactive}or fewer)'}
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
            Virgo = {
                text = {'{C:attention}Held 6s{} give {C:mult}+#1#{} Mult'}
            },
            Cancer = {
                text = {'Played {C:attentions}4s{} give {C:chips}+#1# {C:attention}permanent{} Chips',
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
                    "{C:paradox}Paradox{} and gives {X:mult,C:white}X#1#{} Mult", --next level value
                }
            }
        }
    },
    misc = {
        quips={
            john_bought={
                "{C:blue}JOHN: hey there!"
            },
            john_cost={
                "{C:blue}JOHN: do you want to see my balls",
            },

        },
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