
--- Find out how to add this to JSON!!!!!
--- ICON_ATLAS: HomestuckLogo

G.C.SET.Zodiac = HEX("77003c")
G.C.SET.Aspect = HEX("033476")
G.C.SECONDARY_SET.Zodiac = HEX("77003c")
G.C.SECONDARY_SET.Aspect = HEX("033476")

G.C.BREATH = HEX('0086EB')
G.C.BLOOD = HEX('BA1915')
G.C.SPACE = HEX('000000')
G.C.TIME = HEX('ff2106')
G.C.LIGHT = HEX('f98100')
G.C.VOID = HEX('00164F')
G.C.MIND = HEX('50b250')
G.C.HEART = HEX('bd1864')
G.C.LIFE = HEX('77c350')
G.C.DOOM = HEX('20401f')
G.C.HOPE = HEX('FFE094')
G.C.RAGE = HEX('9c4dad')

G.C.PARADOX = HEX('4EA752')
G.C.PARADOX1 = HEX('4EA752')
G.C.PARADOX2 = HEX('9dd54d')
G.C.CALIBORN = HEX("009c68")
G.C.SUCKERS = HEX('000666')

G.C.ZODIAC = {
    Aries = HEX('a10000'),
    Taurus = HEX('a25203'),
    Gemini = HEX('a1a100'),
    Cancer = HEX('ff0000'),
    Leo = HEX('336601'),
    Virgo = HEX('078446'),
    Libra = HEX('008282'),
    Scorpio = HEX('004182'),
    Sagittarius = HEX('0021cb'),
    Capricorn = HEX('440a7f'),
    Aquarius = HEX('6a006a'),
    Pisces = HEX('99004d'),
    Ophiuchus = HEX('4ce24e')
}



-- DON'T REMOVE, THIS ALLOWS US TO ADD LOC_COLOURS!!!!
loc_colour('red')
-- Change later maybe!!!!!!
G.ARGS.LOC_COLOURS['paradox'] = G.C.PARADOX
G.ARGS.LOC_COLOURS['suckers'] = G.C.SUCKERS
G.ARGS.LOC_COLOURS['caliborn'] = HEX("009c68")
-- artist colors
G.ARGS.LOC_COLOURS['baqly'] = HEX("c10c1c")
G.ARGS.LOC_COLOURS['akai'] = HEX("1793D1")
G.ARGS.LOC_COLOURS['yokcos'] = HEX('7a417d')
G.ARGS.LOC_COLOURS['delirium'] = HEX('FF7F7F')
G.ARGS.LOC_COLOURS['lyman'] = HEX('27ca01')
G.ARGS.LOC_COLOURS['miser'] = HEX('416600')
G.ARGS.LOC_COLOURS['garb'] = HEX('8c5c90')
G.ARGS.LOC_COLOURS['bea'] = HEX('1bd4d0')


-- temporary!!!!!!!! will be changed to cooler colors
G.C.ZODIAC_LEVELS = {
    HEX("efefef"),
    HEX("95acff"),
    HEX("65efaf"),
    HEX('fae37e'),
    HEX('ffc052'),
    HEX('f87d75'),
    HEX('caa0ef')
}

G.C.SPECIBUS = HEX("008c45")
G.C.VRISKA = HEX("005682")
G.C.VRISKA_2 = HEX("007ebd")



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
NFS.load(mod.path.."consumables/main.lua")()
NFS.load(mod.path.."consumables/aspect.lua")()
NFS.load(mod.path.."consumables/zodiac.lua")()
NFS.load(mod.path.."game_override.lua")()
NFS.load(mod.path.."utils.lua")()

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
"conditionalimmortality", "theplotpoint", "objectduality","joker", "questbed",
"yourlordandmaster", "magnificent", "jokermode", "crowbarsfelt", "signofthesignless",
"echidna", "abraxas", "yaldabaoth", "hephaestus","typheus","donotship"
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
    "demoness","summoner","helmsman","sufferer","disciple","dolorosa","legislacerator","manipulator","executioner","subjuggulator","orphaner","bettycrocker"
}

local voucher_list = {
    "riseup","giftofgab","aspect_mastery","godtier"
}

local tag_list = {
    "perfectlygeneric",
    "parcelpyxis",
    "scratch",
    "spirograph",
    "matriorb",
    "sburb"
}

local spectral_list = {
    'jailkey',
    'lotuscapsule',
    "scratchconstruct",
    "thetreasure",
    '13ofstars'
}

local deck_list = {
    'dersite','prospitan','alternian','frog'
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

-- SMODS.Atlas({key = "HomestuckZodiacBooster", path = "booster_zodiac.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()

local UI, load_error = SMODS.load_file("bstuckui.lua")
if load_error then
  sendDebugMessage ("something fucked!!!! its this: "..load_error)
else
  UI()
end


mod.optional_features = { 
    cardareas = { unscored = true, deck = true, discard = true},
    quantum_enhancements = true,
    post_trigger = true
}
