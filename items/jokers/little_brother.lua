SMODS.Joker {
    key = 'little_brother',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 11
    },
    rarity = 2,
    config = {
        extra = {
            current_triggers = 0,
            trigger_limit = 1,
            copied_key = nil
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = true,
    cost = 10,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ''
        card.ability.blueprint_compat_check = nil
        return {
            vars = { stg.trigger_limit },
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

        local my_pos = 0

        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_pos = i
                break
            end
        end

        if my_pos > 1 and stg.current_triggers < stg.trigger_limit then
            local other_joker = G.jokers.cards[my_pos - 1]
            if other_joker.config.center_key ~= stg.copied_key then
                stg.copied_key = other_joker.config.center_key
                stg.trigger_limit = 1
            end

            if other_joker and other_joker ~= card and not context.no_blueprint then
                context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
                context.blueprint_card = context.blueprint_card or card
                local other_joker_ret = other_joker:calculate_joker(context)
                context.blueprint = nil
                local eff_card = context.blueprint_card or card
                context.blueprint_card = nil
                if other_joker_ret then
                    other_joker_ret.card = eff_card
                    other_joker_ret.colour = G.C.BLUE
                    stg.current_triggers = stg.current_triggers + 1
                    return other_joker_ret
                end
            end
        end

        if context.after then
            stg.current_triggers = 0
            stg.trigger_limit = stg.trigger_limit + 1
        end
    end,
    update = function(self, card, front)
        if G.STAGE == G.STAGES.RUN then
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and i > 1 then
                    other_joker = G.jokers.cards[i - 1]
                end
            end
            if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
                card.ability.blueprint_compat = "compatible"
            else
                card.ability.blueprint_compat = "incompatible"
            end
        end
    end
}
