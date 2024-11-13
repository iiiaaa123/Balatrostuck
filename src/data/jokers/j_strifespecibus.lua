function Balatrostuck.INIT.Jokers.j_strifespecibus()
    SMODS.Joker{
        name = "Strife Specibus",
        key = "strifespecibus",
        ability = {
            extra = {
                hand = "Unassigned"
            }
        },
        loc_txt = {
            ['name'] = 'Strife Specibus',
            ['text'] = {
                [1] = 'Gives {C:white,X:mult}X4{} Mult',
                [2] = 'After first hand played',
                [3] = 'disallows all other hands',
            }
        },
        pos = {
            x = 6,
            y = 0
         },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_def = function(card)
            local color = G.GAME.BALATROSTUCK.strife_assignment == "Unassigned" and G.C.JOKER_GREY or G.C.SPECIBUS
            return {}, {
                { n=G.UIT.C, config={align = "bm", minh = 0.45}, nodes={
                    {n=G.UIT.C, config={ref_table = self, align = "m", colour = color, r = 0.05, padding = 0.08}, nodes={
                        {n=G.UIT.T, config={ref_table = G.GAME.BALATROSTUCK, ref_value = 'strife_assignment',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.8}}
                }}}}
            }
        end,

        calculate = function (self, context)
            if context.cardarea == G.jokers and context.joker_main then
                if G.GAME.BALATROSTUCK.strife_assignment == 'Unassigned' then
                    G.GAME.BALATROSTUCK.strife_assignment = context.scoring_name
                end
                return {
                    Xmult_mod = 4,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { 4 } }
                }
            elseif context.selling_self then
                G.GAME.BALATROSTUCK.strife_assignment = 'Unassigned'
            end
        end
    }:register()

    -- TODO: For some reason this breaks Mouth, Eye and Psychic, that shouldn't be happening
    local blind_debuff_handref = Blind.debuff_hand
    function Blind:debuff_hand(cards, hand, handname, check)
        blind_debuff_handref(self, cards, hand, handname, check)
        if G.GAME.BALATROSTUCK.strife_assignment ~= 'Unassigned' and handname ~= G.GAME.BALATROSTUCK.strife_assignment then
                return true
        end
    end
end