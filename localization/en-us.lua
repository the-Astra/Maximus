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
            c_ankh={
                name="Ankh",
                text={
                    "Create a copy of a",
                    "random {C:attention}Joker{},",
                    "{C:green}#1# in #2#{} chance to destroy",
                    "each remaining Joker",
                },
            },
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
            c_hex={
                name="Hex",
                text={
                    "Add {C:dark_edition}Polychrome{} to a",
                    "random {C:attention}Joker{},",
                    "{C:green}#1# in #2#{} chance to destroy",
                    "each remaining Joker",
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
            mxms_card_extra_mult={
                text={
                    "{C:mult}+#1#{} extra mult",
                },
            },
            posted_right={
                name="Posted",
                text={
                    "This Joker stays",
                    "posted to the",
                    "rightmost position",
                },
            },
        }
    },
    misc = {
        labels = {
            posted_right="Posted"
        },
        v_text={
            ch_c_mxms_X_blind_size={
                "{X:mult,C:white}X#1#{} blind size"
            },
            ch_c_mxms_X_blind_scale={
                "Blinds scale {X:mult,C:white}X#1#{} as fast"
            },
            ch_c_mxms_highlight_limit={
                "Only {C:attention}#1#{} card(s) can be selected at a time"
            },
            ch_c_mxms_bullseye_requirement={
                "Bullseye must have at least {C:chips}+#1#{} Chips by the end of ante 8 boss blind"
            },
            ch_c_mxms_feast={
                "{C:attention}Only food Jokers{} (including Microwave and Refrigerator) can appear in shops"
            },
            ch_c_mxms_random_suit_debuff={
                "A random suit is {C:attention}debuffed{} each round"
            },
            ch_c_mxms_all_rare={
                "Only {C:red}Rare{} Jokers can show up in the shop"
            },
            ch_c_mxms_picky={
                "A copy of {C:attention}Four-Course Meal{} spawns in hand at the start of each round if there's room"
            },
        }
    }
}
