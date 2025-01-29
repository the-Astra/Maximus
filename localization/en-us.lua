return {
    descriptions = {
        Joker = {
            j_egg={
                name="Egg",
                text={
                    "Gains {C:money}$#1#{} of",
                    "{C:attention}sell value{} at",
                    "end of round",
                    "{C:inactive}Just maybe don't leave it",
                    "{C:inactive} in the microwave for too long..."
                },
            },
            j_trading={
                name="Trading Card",
                text={
                    "If {C:attention}first discard{} of round",
                    "has only {C:attention}#2#{} card(s), destroy",
                    "it and earn {C:money}$#1#",
                }
            },
            j_sixth_sense={
                name="Sixth Sense",
                text={
                    "If {C:attention}first hand{} of round is",
                    "at most #1# {C:attention}Six(es){}, destroy the card(s)",
                    "and create a {C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room)",
                },
            },
        },
        Spectral = {
            c_familiar={
                name="Familiar",
                text={
                    "Destroy {C:attention}#2#{} random",
                    "card(s) in your hand, add",
                    "{C:attention}#1#{} random {C:attention}Enhanced face",
                    "{C:attention}cards{} to your hand",
                },
            },
            c_grim={
                name="Grim",
                text={
                    "Destroy {C:attention}#2#{} random",
                    "card(s) in your hand, add",
                    "add {C:attention}#1#{} random {C:attention}Enhanced",
                    "{C:attention}Aces{} to your hand",
                },
            },
            c_incantation={
                name="Incantation",
                text={
                    "Destroy {C:attention}#2#{} random",
                    "card(s) in your hand, add {C:attention}#1#",
                    "random {C:attention}Enhanced numbered",
                    "{C:attention}cards{} to your hand",
                },
            }
        },
        Other={
            card_extra_mult={
                text={
                    "{C:mult}+#1#{} extra mult",
                },
            }
        }
    }
}
