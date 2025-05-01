SMODS.Joker {
    key = 'zombie',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 5
    },
    rarity = 2,
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        if G.GAME.current_round.zombie_target.card ~= nil then
            local copied_key = G.GAME.current_round.zombie_target.card.config.center.key
            info_queue[#info_queue + 1] = G.P_CENTERS[copied_key]
            return {
                vars = { G.localization.descriptions.Joker[copied_key].name }
            }
        else
            return {
                vars = { localize('k_mxms_no_target_el') }
            }
        end
    end,
    calculate = function(self, card, context)
        if G.GAME.current_round.zombie_target.card and not context.no_blueprint then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card
            local zombie_target_ret = G.GAME.current_round.zombie_target.card:calculate_joker(context)
            context.blueprint = nil
            local eff_card = context.blueprint_card or card
            context.blueprint_card = nil
            if zombie_target_ret then
                zombie_target_ret.card = eff_card
                zombie_target_ret.colour = G.C.GREEN
                return zombie_target_ret
            end
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
