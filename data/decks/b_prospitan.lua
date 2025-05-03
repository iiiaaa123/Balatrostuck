function Balatrostuck.INIT.Decks.b_prospitan()
    SMODS.Back {
        key = 'prospitan',
        loc_txt = {
            name = "Prospitian Deck",
            text = {
                "Standard Packs are $4 cheaper",
                "Cards in Standard Packs are Paradox",
                "Paradox cards appear in starting hand"
            }
        },
        atlas = 'HomestuckDecks',
        pos = {x = 1,y = 1},
        unlocked = true,
        calculate = function(self,back,context)
            if context.bstuck_post_shuffle_deck then
                for i = #G.deck.cards,1,-1 do
                    v = G.deck.cards[i]
                    if v.edition and v.edition.key == 'e_bstuck_paradox' then
                        v:flip()
                        SMODS.recalc_debuff(v)
                        sendInfoMessage(i)
                        table.remove(G.deck.cards,i)
                        table.insert(G.deck.cards,v)
                        v = nil
                    end
                end
            end
        end
    }
end
