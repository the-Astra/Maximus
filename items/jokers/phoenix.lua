SMODS.Joker {
    key = 'phoenix',
    atlas = 'Placeholder',
    pos = {
        x = 3,
        y = 0
    },
    rarity = 4,
    unlocked = false,
    unlock_condition = {
        type = '', 
        extra = '', 
        hidden = true
    },
    blueprint_compat = true,
    cost = 20,
    config = {
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS.Red
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.after then
            local faces = 0
            for k, v in pairs(context.scoring_hand) do
                if v:is_face() then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                            v:start_dissolve()
                            card:juice_up(0.8, 0.8)
                            return true;
                        end
                    }))
                    faces = faces + 1
                end
            end

            if faces > 0 then
                for k, v in pairs(context.scoring_hand) do
                    if not v:is_face() then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.5,
                            func = function()
                                v:set_seal('Red', nil, true)
                                card:juice_up(0.3, 0.4)
                                return true;
                            end
                        }))
                    end
                end
                return {
                    message = localize('k_mxms_deserved_ex'),
                    colour = G.C.RED
                }
            end
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': anerdymous', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
