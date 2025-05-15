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
            triggers_left = 5,
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
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
            vars = { stg.triggers_left },
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

        if my_pos < #G.jokers.cards and stg.triggers_left > 0 then
            local other_joker = G.jokers.cards[my_pos + 1]

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
                    return other_joker_ret
                end
            end
        end

        if context.after then
            stg.triggers_left = stg.triggers_left - (1 / G.GAME.fridge_mod)
            SMODS.calculate_effect(
            { message = stg.triggers_left .. ' ' .. localize('k_mxms_left_el'), colour = G.C.RED }, card)
            if stg.triggers_left <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot2')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
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
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    other_joker = G.jokers.cards[i + 1]
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
