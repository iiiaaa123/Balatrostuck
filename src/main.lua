
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

-- Page 1
"cruxiteapple", "ascend", "enterthemedium", "descend", "cascade", 
"betacopy", "echeladder","captchacard", "strifespecibus","collide",
"applejuice", "clover", "mirthful", "synchronization", "jetpack", 

-- Page 3
"caledfwlch", "nepetajoker",


    --[[ Artifacts     ]] "whatpumpkin", "cueball","ringoflife",
    --[[ Derse Agents  ]] "draconiandignitary", "hegemonicbrute", "courtyarddroll", "sovereignslayer", "waywardvagabond","operation_regisurp",
    --[[ Sylladex      ]]  "cruxitedowel",
                        "questbed", "note_desolation","commandervantas",
                          "jocker", "joker", "whoisthis",
                        "batterwitch",
                          "dead_shuffle", "dark_carnival","tumor","kernelsprite",
    --[[ Other S pages ]] "roundtwo",
    --[[ Cherub Jokers ]] "magnificent", "jokermode", 
    --[[ Misc Joker    ]] "tanglebuddies", "horrorterrors","purrfectwarrior","lonegunbird","biscuits", "parcelmistress", "amberfirefly", "whitequeen", 
                           "conditionalimmortality", "misspaint", "cloudwatching",
    --[[ Troll Jokers  ]] "frustration", "twinarmageddons", "pairing_grid", "conventioncenter", "hotdogjuggler", "culling",
                          "trolltrain",
    --[[ Vriska Jokers ]] "fluoriteoctet", "lucky_break", "alltheirons",
    --[[ Food Jokers   ]] "soporpie", "sucker","faygo",
    --[[ Medium Jokers ]] "lohac", "lowas", "lofaf", "lolar", "skaia",
    --[[ Denizens      ]] "yaldabaoth", "abraxas", "hephaestus", "echidna", "typheus", "gristtorrent","consortconcierge","redblood",
    --[[ Post-canon    ]] "beyondcanon", "bigkahuna", "smallerbutterflies",
    --[[ MSPA Jokers   ]] "stump", "aceDick"
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

batch_load("jokers")
batch_load("aspects")
batch_load("zodiacs")
batch_load("boosters")

for _, joker in ipairs(joker_list) do
    Balatrostuck.INIT.Jokers["j_"..joker]()
end

for _, aspect in ipairs(aspect_list) do
    Balatrostuck.INIT.Aspects["c_aspect_"..aspect]()
end

for _, aspect in ipairs(zodiac_list) do
    Balatrostuck.INIT.Zodiacs["c_zodiac_"..aspect]()
end



SMODS.Atlas({key = "HomestuckJokers", path = "hsjokers.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckZodiacs", path = "zodiac.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckAspects", path = "aspect.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckLogo", path = "bstuck_logo.png", px = 34, py = 34, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "HomestuckAspectBooster", path = "booster.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
-- SMODS.Atlas({key = "HomestuckZodiacBooster", path = "booster_zodiac.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()

local UI, load_error = SMODS.load_file("bstuckui.lua")
if load_error then
  sendDebugMessage ("something fucked!!!! its this: "..load_error)
else
  UI()
end
