SMODS.Joker {
    key = 'poindexter',
    atlas = 'Jokers',
    rarity = 2,
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = {
            Xmult = 1.0,
            gain = 0.25
        }
    },
    blueprint_compat = true,
    cost = 7,
    enhancement_gate = 'm_glass',
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return {
            vars = { stg.Xmult, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end

        if context.remove_playing_cards and not context.blueprint then
            -- Check for shattered glass
            if context.removed ~= nil then
                for k, v in ipairs(context.removed) do
                    if SMODS.has_enhancement(v, 'm_glass') and not v.debuff then
                        stg.Xmult = 1
                        stg.shattered = true
                        SMODS.calculate_effect({ message = localize('k_mxms_erm_el'), colour =  G.C.RED},card)
                        break
                    end
                end
            end
        end

        if context.after and not context.blueprint then
            if stg.shattered then
                stg.shattered = false
            else
                -- If no shattered glass, add to mult
                local glass = 0
                for k, v in ipairs(context.scoring_hand) do
                    if SMODS.has_enhancement(v,'m_glass') then
                        glass = glass + 1
                    end
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        stg.Xmult = stg.Xmult + glass * stg.gain
                    end
                }))
                return {
                    card = card,
                    message = localize('k_mxms_eureka_ex'),
                    colour = G.C.MULT,
                    func = function() SMODS.calculate_context({ scaling_card = true }) end
                }
            end
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}
