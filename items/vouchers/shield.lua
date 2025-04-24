SMODS.Voucher {
    key = 'shield',
    atlas = 'Vouchers',
    pos = {
        x = 2,
        y = 0
    },
    redeem = function(self, card, from_debuff)
        G.GAME.v_destroy_reduction = G.GAME.v_destroy_reduction + 1
    end
}

-- Change Ankh and Hex to work with Shield and Guardian Vouchers
SMODS.Consumable:take_ownership('ankh', {
        config = {
            extra = {
                chance = 2,
                odds = 2,
            }
        },
        loc_vars = function(self, info_queue, center)
            return { vars = { center.ability.extra.chance - G.GAME.v_destroy_reduction, center.ability.extra.odds } }
        end,
        use = function(self, card, area, copier)
            local deletable_jokers = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
            end
            local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed('ankh_choice'))
            local _first_dissolve = nil
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.75,
                func = function()
                    for k, v in pairs(deletable_jokers) do
                        if v ~= chosen_joker then
                            if pseudorandom('ankh') < (card.ability.extra.chance - G.GAME.v_destroy_reduction) / card.ability.extra.odds then
                                v:start_dissolve(nil, _first_dissolve)
                                _first_dissolve = true
                            elseif not G.GAME.used_vouchers.v_mxms_guardian then
                                card_eval_status_text(v, 'extra', nil, nil, nil, { message = localize('k_safe_ex') })
                            end
                        end
                    end
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.4,
                func = function()
                    local card = copy_card(chosen_joker, nil, nil, nil,
                        chosen_joker.edition and chosen_joker.edition.negative)
                    card:start_materialize()
                    card:add_to_deck()
                    if card.edition and card.edition.negative then
                        card:set_edition(nil, true)
                    end
                    G.jokers:emplace(card)
                    return true
                end
            }))
        end
    },
    true)

SMODS.Consumable:take_ownership('hex', {
        config = {
            extra = {
                chance = 2,
                odds = 2,
            }
        },
        loc_vars = function(self, info_queue, center)
            return { vars = { center.ability.extra.chance - G.GAME.v_destroy_reduction, center.ability.extra.odds } }
        end,
        use = function(self, card, area, copier)
            local temp_pool = card.eligible_editionless_jokers or {}
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local over = false
                    local eligible_card = pseudorandom_element(temp_pool, pseudoseed('hex'))
                    local edition = { polychrome = true }
                    eligible_card:set_edition(edition, true)
                    check_for_unlock({ type = 'have_edition' })
                    local _first_dissolve = nil
                    for k, v in pairs(G.jokers.cards) do
                        if v ~= eligible_card and (not v.ability.eternal) then
                            if pseudorandom('hex') < (card.ability.extra.chance - G.GAME.v_destroy_reduction) / card.ability.extra.odds then
                                v:start_dissolve(nil, _first_dissolve); _first_dissolve = true
                            elseif not G.GAME.used_vouchers.v_mxms_guardian then
                                card_eval_status_text(v, 'extra', nil, nil, nil, { message = localize('k_safe_ex') })
                            end
                        end
                    end
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
        end
    },
    true)
