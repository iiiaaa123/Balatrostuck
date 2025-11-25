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
                    'Cards in one Blind',
                    '{C:inactive}(Currently {C:attention}#3#{C:inactive}/#2#)'
                }
            },
            j_bstuck_backseater_7 ={
                name = '8acks8er',
                text = {
                    '{C:dark_edition}Quest #1#:',
                    'Trigger played cards',
                    '#2# times in one hand,',
                    'then beat the Blind',
                    '{C:inactive}(Currently {C:attention}#3#{C:inactive}/#2#)'
                }
            },
            j_bstuck_backseater_8 ={
                name = '8acks8er',
                text = {
                    '{C:dark_edition}Quest #1#:',
                    'Score #2# Chips in one',
                    'hand, then beat the Blind'
                }
            },
            j_bstuck_backseater_0 ={
                name = '8acks8er',
                text = {
                    '8ruh my quests 8roke',
                    'cant have shit in',
                    '{C:paradox}8alatrostuck'
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
                text = {'{C:inactive}(Currently {C:attention}#1# {C:inactive}cards)'}
            },
            c_bstuck_breath_current = {
                text = {'{C:inactive}(Currently {C:attention}#1# {C:inactive}reroll#2#)'}
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
                text = {'{C:inactive}(Currently {C:attention}#1#{C:inactive} Paradox cards)'}
            },
            c_bstuck_light_current = {
                text = {'{C:inactive}(Currently {C:white,X:mult}X#1# {C:inactive} Mult)'}
            },
            c_bstuck_mind_current = {
                text = {'{C:inactive}(Currently {C:attention}#1# {C:inactive}cop#2#)'}
            },
            c_bstuck_piss_current = {
                text = {'{C:inactive}(Currently {C:paradox}#1# {C:inactive}Jokers)'}
            },
            c_bstuck_rage_current = {
                text = {'{C:inactive}(Currently {C:white,X:mult}X#1# {C:inactive} Mult)'}
            },
            c_bstuck_space_current = {
                text = {'{C:inactive}(Currently {C:attention}+#1#{C:inactive})'}
            },
            c_bstuck_time_current = {
                text = {'{C:inactive}(Currently {C:blue}+#1#{C:inactive})'}
            },
            c_bstuck_void_current = {
                text = {'{C:inactive}(Currently {C:dark_edition}+#1#{C:inactive})'}
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
        v_text = {
            ch_c_mult_dollar_cap = {
                '{C:red}Mult{} cannot exceed {C:attention}half{} of current {C:money}$'
            },
            ch_c_tripleblindsize = {
                '{C:red}3x{} base Blind size'
            },
            ch_c_perfectly_generic = {
                'Only {C:attention}Perfectly Generic{} tags appear'
            },
            ch_c_only_shop_zodiac = {
                '{C:attention}Jokers{}, {C:planet}Planets{}, and {C:tarot}Tarots{} don\'t appear in the shop'
            },
            ch_c_lylac1 = {
                'All {C:attention}Jokers{} are {C:red}destroyed{} at the end of the Ante'
            },
            ch_c_lylac2 = {
                'All Jokers cost {C:money}2${} and sell for {C:money}1${}'
            },
        },
        quips={
            john_bought={
                "{C:blue}JOHN: hey there!"
            },
            john_balls={
                "{C:blue}JOHN: oh shit another me!",
            },
            john_future={
                "{C:blue}JOHN: dont mind me!",
            },
            john_loop={
                "{C:blue}JOHN: sorry! gotta close the loop!",
            },
            john_cost={
                "{C:blue}JOHN: dont worry, i got you!",
            },
            john_pack_1={
                "{C:blue}JOHN: didnt want that one?"
            },
            john_pack_2={
                "{C:blue}JOHN: how about another!"
            },
            john_pack_3={
                "{C:blue}JOHN: lets try a different pack instead"
            },
            john_charity = {
                "{C:blue}JOHN: oh, youre down on your bucks? you can use some of mine"
            },
            backseater_pickup={
                "{C:vriska}AG: heyyyyyyyy there! fancy seeing you here",
                "{C:vriska}I'm hiding from some post-canon nonsense,",
                "{C:vriska}mind if I hang around for a 8it? :::;)",
            },
            backseater_quest_1_start={
                "{C:Scorpio}AG: Ughhhhhhhh, I've seen gru8s",
                "{C:Scorpio}play 8etter than you! Come oooooooon,",
                "{C:Scorpio}give me a Str8 Flush at least!",
            },
            backseater_quest_1_done={
                "{C:Scorpio}AG: Okay, may8e you're not",
                "{C:Scorpio}completely useless after all! You can",
                "{C:Scorpio}play a good hand if you want to."
            },
            backseater_quest_2_start={
                "{C:Scorpio}AG: Real gamers cut to the chase.",
                "{C:Scorpio}They power through all the nonsense",
                "{C:Scorpio}and go for the gold. They cheat.",
                "{C:Scorpio}It is time you learned to start cheating."
            },
            backseater_quest_2_done={
                "{C:Scorpio}AG: Talk a8out a lucky 8r8k!!!!!!!!",
                "{C:Scorpio}You're lucky you have me as a co-player, so I",
                "{C:Scorpio}can challenge you and help you get strong.",
                "{C:Scorpio}Here. Some cash for your trou8le."
            },
            backseater_quest_3_start={
                "{C:Scorpio}AG: I think you can do 8etter though!",
                "{C:Scorpio}8eat a 8lind like I taught you,",
                "{C:Scorpio}8ut keep 2 slots empty. Good luck!"
            },
            backseater_quest_3_done={
                "{C:Scorpio}AG: Now that I know you're not some half-thinkpan",
                "{C:Scorpio}8oy skylark, it's time for your first REAL challenge!"
            },
            backseater_quest_4_start={
                "{C:Scorpio}AG: Skip these 8a8y 8linds, go str8 for",
                "{C:Scorpio}the 8oss! I know you can do it! ::::)"
            },
            backseater_quest_4_done={
                "{C:Scorpio}AG: Hahahaha! I didn't actually think you'd",
                "{C:Scorpio}pull it off. I was fully ready to 8ounce.",
                "{C:Scorpio}Here, this next shop is on me."
            },
            backseater_quest_5_start={
                "{C:Scorpio}AG: I wasn't going to mention it 8efore, 8ut your",
                "{C:Scorpio}deck is preeeeeeeetty 8loated. I keep mine at",
                "{C:Scorpio}only 8 cards, 8ut that m8 8e a bit too much for you.",
                "{C:Scorpio}You should 8e a8le to take off at least 8 cards though!"
            },
            backseater_quest_5_done={
                "{C:Scorpio}AG: What? You're expecting a reward? That was",
                "{C:Scorpio}your reward, I made you thin out your misera8le",
                "{C:Scorpio}deck to make it easier to manipul8!"
            },
            backseater_quest_6_start={
                "{C:Scorpio}AG: If you want a reward, I've got another",
                "{C:Scorpio}challenge for you. Gener8 8 consuma8les in a",
                "{C:Scorpio}single 8lind. Shouldn't 8e too hard for a",
                "{C:Scorpio}poker prodigy like yourself :::;)"
            },
            backseater_quest_6_done={
                "{C:Scorpio}AG: Yeah!!!!!!!!! You're doing gr8, 8ut don't let that",
                "{C:Scorpio}get to your head! You've still got a looooooot to learn",
                "{C:Scorpio}from me 8efore you can be as gr8 as someone like me ::::)"
            },
            backseater_quest_7_start={
                "{C:Scorpio}AG: You've got one challenge left 8efore that though.",
                "{C:Scorpio}Show me what you're made of and trigger 20 cards",
                "{E:2}in a single hand.{} {C:Scorpio}Sounds impossi8le? It very",
                "{C:Scorpio}may well 8e for you. I won't tell you how to do it,",
                "{C:Scorpio}figure it out yourself! You need to learn to 8e independent!"
            },
            backseater_quest_7_done={
                "{C:Scorpio}Alrightttttttt I got a request for you",
                "{C:Scorpio}now that you've finished your Vriska training.",
                "{C:Scorpio}I gotta go soon, 8ut I need a 8it of a push.",
                "{C:Scorpio}Multifiction travel, you know how it is.",
            },
            backseater_quest_8_start={
                "{C:Scorpio}Score 16777216 chips in a single hand. If it sounds",
                "{C:Scorpio}like a lot, it's 8ecause it is. 8eat it, and I'll",
                "{C:Scorpio}throw you a little 8onus on my way out. 8ut I",
                "{C:Scorpio}understand if you're not cut out for it."
            },
            backseater_quest_8_done={
                "{C:Scorpio}AG: Anyway, my time's running out and I gotta 8ounce.",
                "{C:Scorpio}For your trou8le I would like to pass my favorite jokers",
                "{C:Scorpio}on to you. If my outrageously gr8 luck has any say in the",
                "{C:Scorpio}matter, we will 8e meeting up in no time! L8r! <33333333"
            },
            backseater_invalid_tier={
                "{C:Scorpio}Something meddled with my varia8les",
                "{C:Scorpio}and I'm on an invalid quest num8er.",
                "{C:Scorpio}Soooooooo, wanna make out?"
            },
            caliborn_bought1={
                "{C:green}I WANT TO PLAY A GAME"
            },
            caliborn_bought2={
                "{C:green}NO MORE CHANGING THE DECK.",
                "{C:green}NO WEAK HANDS EITHER.",
                "{C:green}POKER AS POKER IS.",
                "{C:green}REAL POKER."
            },
            caliborn_bought3={
                "{C:green}SHOW ME YOU CAN BE A REAL MAN.",
                "{C:green}AND I'LL REWARD YOU. HANDSOMELY.",
                "{C:green}WITH MY JUJUS. AKA. JOKERS."
            },
            caliborn_straight1={
                "{C:red}NO STRAIGHTS TODAY.",
                "{C:green}THEY'RE TOO EASY."
            },
            caliborn_straight2={
                "{C:red}NO STRAIGHTS.",
                "{C:green}PLAY HARDER."
            },
            caliborn_fullhouse1={
                "{C:red}NO MORE FULL HOUSES.",
                "{C:green}I GOT SICK OF THEM."
            },
            caliborn_fullhouse2={
                "{C:red}FORGET FULL HOUSES.",
                "{C:green}HOUSES ARE STUPID!"
            },
            caliborn_flush1={
                "{C:red}FLUSHES ARE BAD.",
                "{C:green}THEY'RE BORING."
            },
            caliborn_flush2={
                "{C:red}I HATE FLUSHES.",
                "{C:green}CALLIOPE LIKED THEM."
            },
            caliborn_gift={
                "{C:green}BEHOLD.",
                "{C:green}A GIFT. FROM ME!!",
                "{C:green}ITS ONE OF MY PRIZED JUJUS.",
                "{C:green}TAKE GOOD CARE OF IT."
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
