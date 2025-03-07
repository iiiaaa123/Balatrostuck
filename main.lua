
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
G.ARGS.LOC_COLOURS['paradox'] = HEX("4EA752")







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
"echidna", "abraxas", "yaldabaoth", "typheus", "hephaestus",
}

local aspect_list = {
    "breath", "life", "light", "time", "heart", "rage",
    "blood", "doom", "void", "space", "mind", "hope"
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

batch_load("jokers")
batch_load("aspects")
batch_load("zodiacs")
batch_load("boosters")
batch_load("editions")
batch_load("tags")
batch_load("spectrals")
batch_load("seals")

bstuck_joker_keys = {}

for _, joker in ipairs(joker_list) do
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

SMODS.Sound({key = "HomestuckHeroicDeath", path = 'johnfuckingdies.ogg'})
SMODS.Sound({key = "HomestuckJustDeath", path = 'shhh.ogg'})

SMODS.Atlas({key = "HomestuckJokers", path = "hsjokers.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckZodiacs", path = "zodiac.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckAspects", path = "aspect.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "modicon", path = "bstuck_logo.png", px = 34, py = 34, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckAspectBooster", path = "booster.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckTags", path = "tags.png", px = 34, py = 34, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckSpectrals", path = "hsspectral.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckSeals", path = "hsseals.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()

-- SMODS.Atlas({key = "HomestuckZodiacBooster", path = "booster_zodiac.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()

local UI, load_error = SMODS.load_file("bstuckui.lua")
if load_error then
  sendDebugMessage ("something fucked!!!! its this: "..load_error)
else
  UI()
end


mod.optional_features = { 
    cardareas = { unscored = true, deck = true, discard = true} 
}
