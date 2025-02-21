SMODS.Joker {
    key = 'trick_or_treat',
    loc_txt = {
        name = 'Trick or Treat',
        text = { 'When held, {C:attention}Booster packs{}', 'now let you take #1# more', 'card than usual' }
    },
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 1
    },
    rarity = 1,
    config = {
        extra = {
            extra_choices = 1
        }
    },
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.extra_choices }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        local stg = card.ability.extra
        G.GAME.choose_mod = G.GAME.choose_mod + stg.extra_choices
    end,

    remove_from_deck = function(self, card, from_debuff)
        local stg = card.ability.extra
        G.GAME.choose_mod = G.GAME.choose_mod - stg.extra_choices
    end,
    calculate = function(self, card, context)
        if context.open_booster then
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    card:juice_up(0.3, 0.4)
                    return true
                end)
            }))
        end
    end
}
