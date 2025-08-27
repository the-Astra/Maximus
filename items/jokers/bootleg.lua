SMODS.Joker {
    key = 'bootleg',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 6
    },
    rarity = 3,
    config = {},
    blueprint_compat = true,
    cost = 3,
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME.mxms_last_bought.card ~= nil then
            local copied_key = G.GAME.mxms_last_bought.card.config.center_key
            info_queue[#info_queue + 1] = G.P_CENTERS[copied_key]
            return {
                vars = { G.localization.descriptions.Joker[copied_key].name }
            }
        else
            return {
                vars = { localize('k_none') }
            }
        end
    end,
    calculate = function(self, card, context)
        if G.GAME.mxms_last_bought.card and not context.no_blueprint then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card
            local bootleg_target_ret = G.GAME.mxms_last_bought.card:calculate_joker(context)
            context.blueprint = nil
            local eff_card = context.blueprint_card or card
            context.blueprint_card = nil
            if bootleg_target_ret then
                bootleg_target_ret.card = eff_card
                bootleg_target_ret.colour = G.C.YELLOW
                return bootleg_target_ret
            end
        end

        if context.buying_card and context.card.config.center.blueprint_compat
            and (context.card ~= card or context.card.config.center_key ~= "j_mxms_bootleg") then
            G.GAME.mxms_last_bought.card = context.card
            card:juice_up(0.3, 0.4)
            check_for_unlock({ type = 'bootleg_copy', card = context.card.config.center_key })
        end
    end,
    remove_from_deck = function(self, card, context)
        if not next(SMODS.find_card('j_mxms_bootleg')) then
            G.GAME.mxms_last_bought.card = nil
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_bootleg',
    type = 'loss',
    extra = { center = 'j_mxms_bootleg' }
}

