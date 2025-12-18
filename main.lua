
--- Find out how to add this to JSON!!!!!
--- ICON_ATLAS: HomestuckLogo

local mod = SMODS.current_mod

local function batch_load(txt) 
    local joker_files = NFS.getDirectoryItems(mod.path.."data/"..txt)
    sendInfoMessage(mod.path.."data/"..txt)
    local joker_defs = {}
    for _, file in pairs(joker_files) do
        sendInfoMessage(file)
        if string.find(file, ".lua") then
            local joker = NFS.load(mod.path.."data/"..txt.."/"..file)()
            table.insert(joker_defs, joker)
        end
    end
    sendInfoMessage("FINISHED BATCH LOAD FOR "..txt)
    return joker_defs
end

NFS.load(mod.path.."lib.lua")()
NFS.load(mod.path.."utils.lua")()
NFS.load(mod.path.."utils/color_defs.lua")()
NFS.load(mod.path.."bsui/core.lua")()
NFS.load(mod.path.."bsui/modules/credits.lua")()
NFS.load(mod.path.."bsui/modules/gametext.lua")()
NFS.load(mod.path.."bsui/modules/buttons.lua")()
NFS.load(mod.path.."consumables/main.lua")()
NFS.load(mod.path.."consumables/aspect.lua")()
NFS.load(mod.path.."consumables/zodiac.lua")()
NFS.load(mod.path.."game_override.lua")()


local joker_list = {

-- Page 11
"cruxiteapple", "ascend", "enterthemedium", "descend", "cascade", 
"betacopy", "echeladder","captchacard", "strifespecibus","collide",
"applejuice", "clover", "mirthful", "synchronization", "jetpack", 

-- Page 12
"jocker", "frogbreeding", "cloudwatching","note_desolation", "clownincar",
"commandervantas", "bigkahuna", "dolorosa", "twinarmageddons", "mobiusdoublereacharound",
"cueball", "alltheirons", "fluoriteoctet", "backseater", "lucky_break",

-- Page 13
"caledfwlch", "nepetajoker", "cruxitedowel", "dead_shuffle", "operation_regisurp",
"courtyarddroll", "hegemonicbrute", "draconiandignitary", "sovereignslayer", "snowman",
"lowas", "lolar", "lohac", "lofaf", "skaia",

-- Page 14
"kernelsprite", "whatpumpkin", "genejoker", "whoisthis", "biscuits",
"culling", "pairing_grid", "innapropriatebucket", "frustration", "ectobiology",
"smallerbutterflies", "misspaint", "consortconcierge", "tanglebuddies", "horrorterrors",

-- Page 15
"waywardvagabond", "amberfirefly", "whitequeen", "parcelmistress", "aimlessrenegade",
"balletslippers", "lonegunbird", "oldsecret","trolltrain", "hotdogjuggler",
"vasterror", "verticlemovements", "paintseal", "descendascend", "conventioncenter", 

-- Page 16
"sucker", "roundtwo", "tumor", "vodkamutini", "purrfectwarrior", 
"lordoftime", "museofspace", "problemsleuth", "pickleinspector", "aceDick",
"gristtorrent", "batterwitch", "beyondcanon", "therapture", "ahabscrosshairs",

-- Page 17
"faygo", "stump", "porkhollow", "ringoflife", "ringofvoid",
"pawnrevolution", "dark_carnival", "soporpie", "darkscholar","wake",
"impetuscombcharging", "sepulcritude", "dadswallet", "gamebro", "complacencyofthelearned",

-- Page 18
"joker", "theplotpoint", "objectduality","conditionalimmortality", "questbed",
"yourlordandmaster", "magnificent", "jokermode", "crowbarsfelt", "signofthesignless",
"echidna", "abraxas", "yaldabaoth", "hephaestus","typheus",
-- Page 19
"template", "pranxis", "successor", "blackjack", "break", 
"coloursmayhem", "frogsprite", "scalemate", "scourgesisters", "cherubshackles", "blindjustice"
}

local aspect_list = {
    "time", "light", "heart", "doom", "rage", "blood",
    "space","void", "mind", "life", "hope", "breath", 
    "piss"
}

local zodiac_list = {
    "gemini", "taurus", "cancer", "leo", "virgo", "libra",
    "scorpio", "sagittarius", "capricorn", "aquarius",
    "pisces", "ophiuchus", "aries"
}

local edition_list = {
    "paradox"
}

local seal_list = {
    "felt"
}

local blind_list = {
}

local voucher_list = {
    "riseup","giftofgab","aspect_mastery","godtier"
}

local tag_list = {
    "perfectlygeneric", "parcelpyxis", "spirograph", "matriorb", "splinter", "denizen",
    "firefly", "mutation",  "carapacian", "consort", "scratch", "sburb",
}

local spectral_list = {
    'jailkey',
    'lotuscapsule',
    "scratchconstruct",
    "thetreasure",
    '13ofstars'
}

local deck_list = {
    'dersite','prospitan','alternian','frog','sylladeck', 'nymph', 'genericdeck'
}

batch_load("jokers")
batch_load("aspects")
batch_load("zodiacs")
batch_load("boosters")
batch_load("editions")
batch_load("tags")
batch_load("spectrals")
batch_load("seals")
batch_load("blinds")
batch_load("vouchers")
batch_load("decks")


bstuck_joker_keys = {}

for _, joker in ipairs(joker_list) do
    bstuck_joker_keys[#bstuck_joker_keys+1] = 'j_bstuck_' .. joker
    Balatrostuck.INIT.Jokers["j_"..joker]()
end

local blacklist = {
"j_bstuck_echidna","j_bstuck_abraxas","j_bstuck_yaldabaoth","j_bstuck_hephaestus","j_bstuck_typheus",
"j_bstuck_yourlordandmaster", "j_bstuck_magnificent", "j_bstuck_jokermode", "j_bstuck_crowbarsfelt",
"j_bstuck_joker", "j_bstuck_backseater", 'j_bstuck_biscuits', "vodkamutini"
}
bstuck_title_jokers = copy_table(bstuck_joker_keys)
for _, joker in ipairs(bstuck_title_jokers) do
    for k, ban in ipairs(blacklist) do
        if joker == ban then bstuck_title_jokers[_] = nil end
    end
end

batch_load("challenges")

for _, aspect in ipairs(aspect_list) do
    Balatrostuck.INIT.Aspects["c_aspect_"..aspect]()
end

for _, aspect in ipairs(zodiac_list) do
    Balatrostuck.INIT.Zodiacs["c_zodiac_"..aspect]()
end

for _, edition in ipairs(edition_list) do
    Balatrostuck.INIT.Editions["e_"..edition]()
end

for _, seal in ipairs(seal_list) do
    Balatrostuck.INIT.Seals["seal_"..seal]()
end

for _, tag in ipairs(tag_list) do
    Balatrostuck.INIT.Tags["t_"..tag]()
end

for _, spectral in ipairs(spectral_list) do
    Balatrostuck.INIT.Spectrals["c_spectral_"..spectral]()
end

for _, blind in ipairs(blind_list) do
    Balatrostuck.INIT.Blinds["bl_"..blind]()
end

for _, voucher in ipairs(voucher_list) do
    Balatrostuck.INIT.Vouchers["v_"..voucher]()
end

for _, deck in ipairs(deck_list) do
    Balatrostuck.INIT.Decks["b_"..deck]()
end


SMODS.Sound({key = "HomestuckHeroicDeath", path = 'johnfuckingdies.ogg'})
SMODS.Sound({key = "HomestuckJustDeath", path = 'shhh.ogg'})
SMODS.Sound({key = "HomestuckParadoxSaved", path = 'paradoxSaved.ogg'})
SMODS.Sound({key = "HomestuckParadox", path = 'paradoxTest.ogg'})
SMODS.Sound({key = "HomestuckAscend", path = 'homestuckAscend.ogg'})
SMODS.Sound({key = "HomestuckGunshot", path = 'gun.ogg'})
SMODS.Sound({key = "HomestuckScratch", path = 'scratch.ogg'})
SMODS.Sound({key = "HomestuckMeow", path = 'meow.ogg'})
SMODS.Sound({key = "HomestuckSword", path = 'sepulchritude.ogg'})
SMODS.Sound({key = "HomestuckGrimdark", path = 'grimdark.ogg'})
SMODS.Sound({key = "HomestuckBloodDrop", path = 'blood.ogg'})
SMODS.Sound({key = "HomestuckDoom", path = 'doom.ogg'})
SMODS.Sound({key = "HomestuckAscendAll", path = 'ascendAll.ogg'})
SMODS.Sound({key = "music_HomestuckTitle", path = 'music_title_cut.ogg', sync = false, pitch = 1, volume = 0.9, select_music_track = function() return (G.STATE == G.STATES.MENU) end})
SMODS.Sound({key = "music_HomestuckSbahj", path = 'music_title_cut.ogg', sync = false, pitch = 1, volume = 0, select_music_track = function() return I_TOLD_YOU_DAWG end})

SMODS.Sound({key = "introPad1", path = 'homestuckintropad.ogg', pitch = 1/0.704, prefix_config = { key = false }})

SMODS.Atlas({key = "HomestuckJokers", path = "hsjokers.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckZodiacs", path = "zodiac.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckAspects", path = "aspect.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "modicon", path = "bstuck_logo.png", px = 34, py = 34, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckAspectBooster", path = "booster.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckTags", path = "tags.png", px = 34, py = 34, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckSpectrals", path = "hsspectral.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckSeals", path = "hsseals.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckParadox", path = "paradox.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckJokersAnimated", path = "hsjokersanimated.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "TheCalibornJoker", path = "caliborn.png",  px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckBlinds",atlas_table = 'ANIMATION_ATLAS',frames = 8,px = 34,py = 34,path = {['default'] = 'Blinds.png'}}):register()
SMODS.Atlas({key = "HomestuckVouchers", path = "vouchers.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckDecks", path = "decks.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckSlabs", path = "aspect_icons.png", px = 34, py = 34, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "bstuck_logo", path="balatrostuck.png", px=469, py=98, atlas_table="ASSET_ATLAS"}):register()
SMODS.Atlas({key = "bstuck_howhigh", path="howhigh.png", px=348, py=232, atlas_table="ASSET_ATLAS"}):register()
SMODS.Atlas({key = "bstuck_scrollbar", path="scrollbar.png", px=11, py=232, atlas_table="ASSET_ATLAS"}):register()

if not next(SMODS.find_mod("Cryptid")) then
  SMODS.Atlas({
    key = "balatro",
    path = "Logo.png",
    px = 469,
    py = 216,
    prefix_config = { key = false }
  })
end

I_WARNED_YOU_ABOUT_THE_JOCKERS_BRO = function()
   G.SETTINGS.bstuck_chamlang = true
   G:save_settings()
    play_sound('cancel', 0.7, 0.8)
    if G.deck then
        G:delete_run()
    end
    G.STAGE = G.STAGES.SANDBOX
   I_TOLD_YOU_DAWG = true 
end

local main_menu_ref = Game.main_menu
Game.main_menu = function(change_context)
    local ret = main_menu_ref(change_context)
    G.title_top.T.w = G.title_top.T.w * 1.7675 * 1.2
    G.title_top.T.x = G.title_top.T.x - 0.8 * 1.8
    G.SPLASH_BACK:define_draw_steps({ {
        shader = 'splash',
        send = {
            { name = 'time',       ref_table = G.TIMERS, ref_value = 'REAL_SHADER' },
            { name = 'vort_speed', val = 0.4 },
            { name = 'colour_1',   ref_table = G.C,      ref_value = 'BSTUCK_T2' },
            { name = 'colour_2',   ref_table = G.C,      ref_value = 'BSTUCK_T1' },
        }
    } }) 
    return ret
end

local UI, load_error = SMODS.load_file("bstuckui.lua")
if load_error then
  sendDebugMessage ("something fucked!!!! its this: "..load_error)
else
  UI()
end

UnlockedByApple = {"skaia", "ectobiology", "purrfectwarrior", "vodkamutini", "lordoftime", "museofspace", "lofaf", "lowas", "lolar", "lohac", "sucker", "ascend", "mobiusdoublereacharound", "frustration", "problemsleuth", "aceDick", "pickleinspector", "whatpumpkin", "pairing_grid", "consortconcierge", "roundtwo", "tumor", "innapropriatebucket", "genejoker", "kernelsprite", "trolltrain", "misspaint", "culling", "smallerbutterflies", "hotdogjuggler", "waywardvagabond", "amberfirefly", "whitequeen", "parcelmistress", "aimlessrenegade","balletslippers","lonegunbird","oldsecret"}
UnlockedByAscend = {"beyondcanon", "batterwitch", "therapture", "ahabscrosshairs", "clownincar", "gristtorrent", "enterthemedium", "whoisthis"}
UnlockedbyEnterTheMedium = {"faygo", "stump", "ringofvoid", "porkhollow", "ringoflife", "descend"}
UnlockedByDescend = {"cascade", "wake", "complacencyofthelearned", "gamebro", "dadswallet", "darkscholar"}
UnlockedByCascade = {"collide", "joker","theplotpoint"}
UnlockedByCollide = { "yourlordandmaster", "conditionalimmortality", "objectduality","magnificent","jokermode","crowbarsfelt"}

mod.optional_features = { 
    cardareas = { unscored = true, deck = true, discard = true}
}
