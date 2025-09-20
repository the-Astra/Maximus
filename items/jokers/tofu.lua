SMODS.Joker {
    key = 'tofu',
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 11
    },
    rarity = 2,
    config = {
        extra = {
            hands_left = 5,
            hand_decrement = 1
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 7,
    pools = {
        Food = true
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ''
        card.ability.blueprint_compat_check = nil
        return {
            vars = { stg.hands_left },
            main_end = (card.area and card.area == G.jokers) and {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = {
                                ref_table = card,
                                align = "m",
                                colour = G.C.JOKER_GREY,
                                r = 0.05,
                                padding = 0.06,
                                func = "blueprint_compat",
                            },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        ref_table = card.ability,
                                        ref_value = "blueprint_compat_ui",
                                        colour = G.C.UI.TEXT_LIGHT,
                                        scale = 0.32 * 0.8,
                                    },
                                },
                            },
                        },
                    },
                },
            } or nil,
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if stg.hands_left > 0 then
            local other_joker = G.jokers.cards[#G.jokers.cards]

            if other_joker and other_joker ~= card and not context.no_blueprint then
                context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
                context.blueprint_card = context.blueprint_card or card
                local other_joker_ret = other_joker:calculate_joker(context)
                context.blueprint = nil
                local eff_card = context.blueprint_card or card
                context.blueprint_card = nil
                if other_joker_ret then
                    other_joker_ret.card = eff_card
                    other_joker_ret.colour = G.C.PURPLE
                    return other_joker_ret
                end
            end
        end

        if context.after and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "hands_left",
                scalar_value = "hand_decrement",
                operation = "-",
                no_message = true
            })

            SMODS.calculate_effect({ message = stg.hands_left .. ' ' .. localize('k_mxms_left_el'), colour = G.C.RED },
            card)
            if stg.hands_left <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    card = card,
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            end
        end
    end,
    update = function(self, card, front)
        if G.STAGE == G.STAGES.RUN then
            local other_joker = G.jokers.cards[#G.jokers.cards]
            if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
                card.ability.blueprint_compat = "compatible"
            else
                card.ability.blueprint_compat = "incompatible"
            end
        end
    end
}
