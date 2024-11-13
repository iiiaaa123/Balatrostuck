```lua
    after: unknown,
    before: unknown,
    blind: unknown,
    blueprint: integer = 1,
    blueprint_card: unknown,
    buying_card: unknown,
    card_effects: unknown,
    cardarea: unknown,
    cards: unknown,
    cards_destroyed: unknown,
    consumeable: unknown,
    debuffed_hand: unknown,
    destroying_card: unknown,
    discard: unknown,
    end_of_round: unknown,
    ending_shop: unknown,
    first_hand_drawn: unknown,
    full_hand: unknown,
    game_over: unknown,
    glass_shattered: unknown,
    hook: unknown,
    individual: unknown,
    joker_main: unknown,
    open_booster: unknown,
    other_card: unknown,
    other_joker: unknown,
    playing_card_added: unknown,
    poker_hands: unknown,
    pre_discard: unknown,
    remove_playing_cards: unknown,
    removed: unknown,
    repetition: unknown,
    reroll_shop: unknown,
    scoring_hand: unknown,
    scoring_name: unknown,
    selling_card: unknown,
    selling_self: unknown,
    setting_blind: unknown,
    skip_blind: unknown,
    skipping_booster: unknown,
    using_consumeable: unknown,
```

## Possible Joker contexts (as taken from `calculate_joker()` func)

`cardarea`
: Probably one of the more important contexts in the game, specifies the card area in which an effect takes place.  
This value has two prominent uses in specifying where a Joker's effect takes place
- `G.jokers` : for the Joker cardarea
- `G.play` : for the playing card cardarea

---

`joker_main` : From what I can tell, this one refers to some kind of invisible **Main Joker**, that exists for weird edge cases like the Observatory effect (not executed on a Joker, but behaving like a Joker and using its context values)

---
`other_card` : This context also comes up multiple times, but it's moreso a specifier for the `cardarea == G.play` clause - it effectively works as an iterator over all cards in a scoring hand, without actually needing to iterate over them

---
`individual` : Exists specifically to set up logic to be executed on individual basis on contexts like `other_card` - because of that the individual context will error if it's used in a context combination that doesn't have a finite iterator (like `other_card` does)