SMODS.Joker {
    key = 'chef',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 2
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({
                        set = 'Food',
                    })
                    card:juice_up(0.3, 0.4)
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    return true;
                end
            }))
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_chef',
    type = 'loss',
    extra = { center = 'j_mxms_chef' }
}

SMODS.JimboQuip {
    key = 'wq_chef',
    type = 'win',
    extra = { center = 'j_mxms_chef' }
}
