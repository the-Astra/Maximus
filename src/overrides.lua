-- Classic init_game_object hook
local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)

    -- Conditional/tracking Modifiers
    ret.mxms_choose_mod = 0
    ret.mxms_war_mod = 1
    ret.mxms_soy_mod = 0
    ret.mxms_purchased_jokers = {}
    ret.mxms_gambler_mod = 1
    ret.mxms_creep_mod = 1
    ret.mxms_last_bought = {
        card = nil,
        pos = nil
    }
    ret.mxms_shop_price_multiplier = 1
    ret.mxms_base_planet_levels = 1
    ret.mxms_breadstick_scales = 0

    --Rotating Modifiers
    ret.current_round.mxms_impractical_hand = 'Straight Flush'
    ret.current_round.mxms_marco_polo_pos = 1
    ret.current_round.mxms_go_fish = {
        rank = "Ace",
        mult = 8
    }
    ret.current_round.mxms_zombie_target = {
        card = nil,
        pos = nil
    }
    ret.current_round.mxms_jello_suit = 'Spades'

    --Horoscope
    ret.mxms_horoscope_buffer = 0

    ret.zodiac_killer_pools = {
        ['Aries'] = true,
        ['Taurus'] = true,
        ['Gemini'] = true,
        ['Cancer'] = true,
        ['Leo'] = true,
        ['Virgo'] = true,
        ['Libra'] = true,
        ['Scorpio'] = true,
        ['Sagittarius'] = true,
        ['Capricorn'] = true,
        ['Aquarius'] = true,
        ['Pisces'] = true,
    }

    ret.open_ante_end_pack = false

    ret.mxms_libra_bonus = 0
    ret.mxms_aries_bonus = 0
    ret.mxms_sagittarius_bonus = false

    --Pool Flags
    ret.pool_flags.mxms_cavendish_removed = false

    return ret
end

-- after_scoring hook; derived from Ortalab
local draw_discard = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
    local obj = G.GAME.blind.config.blind
    if obj.after_scoring and not G.GAME.blind.disabled then
        obj:after_scoring()
    end
    draw_discard(e)
end

local save_r = save_run
save_run = function(self)
    -- Save position of Zombie target
    if G.GAME.current_round.mxms_zombie_target and G.GAME.current_round.mxms_zombie_target.card then
        local pos = 1
        for k, v in pairs(G.jokers.cards) do
            if v == G.GAME.current_round.mxms_zombie_target.card then
                G.GAME.current_round.mxms_zombie_target.pos = pos
                break
            end
            pos = pos + 1
        end
    end

    -- Save position of Bootleg target
    if G.GAME.mxms_last_bought and G.GAME.mxms_last_bought.card then
        local pos = 1
        for k, v in pairs(G.jokers.cards) do
            if v == G.GAME.mxms_last_bought.card then
                G.GAME.mxms_last_bought.pos = pos
                break
            end
            pos = pos + 1
        end
    end

    -- Save position of Gutbuster generated card
    local gutbusters = SMODS.find_card('j_mxms_gutbuster')
    if next(gutbusters) then
        for i = 1, #gutbusters do
            for k, v in ipairs(G.jokers.cards) do
                if gutbusters[i].ability.extra.card and v == gutbusters[i].ability.extra.card then
                    gutbusters[i].ability.extra.pos = k
                    break
                end
            end
        end
    end

    save_r(self)
end

local start_r = Game.start_run
---@diagnostic disable-next-line: duplicate-set-field
Game.start_run = function(self, args)
    start_r(self, args)

    -- Set Bootleg target card based on saved position
    if G.GAME.mxms_last_bought and G.GAME.mxms_last_bought.pos then
        G.GAME.mxms_last_bought.card = G.jokers.cards[G.GAME.mxms_last_bought.pos]
        G.GAME.mxms_last_bought.pos = nil
    end

    -- Set Zombie target card based on saved position
    if G.GAME.current_round.mxms_zombie_target and G.GAME.current_round.mxms_zombie_target.pos then
        G.GAME.current_round.mxms_zombie_target.card = G.jokers.cards[G.GAME.current_round.mxms_zombie_target.pos]
        G.GAME.current_round.mxms_zombie_target.pos = nil
    end

    -- Set each Gutbuster target card based on saved position
    local gutbusters = SMODS.find_card('j_mxms_gutbuster')
    if next(gutbusters) then
        for i = 1, #gutbusters do
            if gutbusters[i].ability.extra.pos then
                gutbusters[i].ability.extra.card = G.jokers.cards[gutbusters[i].ability.extra.pos]
                gutbusters[i].ability.extra.pos = nil
            end
        end
    end
end

local csc = Card.set_cost
function Card:set_cost()
    csc(self)
    self.cost = math.floor(self.cost * G.GAME.mxms_shop_price_multiplier) -- Shop price multiplier modifier
    self.cost = self.cost * G.GAME.mxms_creep_mod -- Power Creep modifier
end

-- Prevent other cards from spawning under certain conditions
local atp = SMODS.add_to_pool
function SMODS.add_to_pool(prototype_obj, args)
    local ret, pool_opts = atp(prototype_obj, args)

    if prototype_obj.set == 'Joker' then
        if Maximus.config.only_maximus_jokers and (not prototype_obj.original_mod or prototype_obj.original_mod ~= 'Maximus') then -- Only Maximus Jokers option
            ret = false
        end

        if G.GAME.modifiers.mxms_feast and not Maximus.key_has_attribute(prototype_obj.key, 'food') and prototype_obj.key ~= 'j_mxms_microwave' and prototype_obj.key ~= 'j_mxms_refrigerator' then -- Feast Challenge Modifier
            ret = false
        end

        if G.MXMS_SCARRED_SPAWN and Maximus.key_has_attribute(prototype_obj.key, 'mxms_legendary') then
            ret, pool_opts = true, {override_base_checks = true}
        end
    end

    if prototype_obj.set == 'Horoscope' or prototype_obj.soul_set == 'Horoscope' then
        if not Maximus_config.horoscopes or G.GAME.modifiers.mxms_zodiac_killer and G.GAME.mxms_zodiac_killer_pools[prototype_obj.key] then
            ret = false
        end
    end

    if (prototype_obj.set == 'Conspiracy' or prototype_obj.soul_set == 'Conspiracy') and not Maximus_config.conspiracies then
        ret = false
    end

    return ret, pool_opts
end

-- Don't generate tag UI at all if skipping is disabled by modifier
local cubt = create_UIBox_blind_tag
create_UIBox_blind_tag = function(blind_choice, run_info)
    if not G.GAME.modifiers.mxms_disable_blind_skips then
        return cubt(blind_choice, run_info)
    end
end

-- Open a Pack after each Ante (derived from Lobotomy Corporation)
local update_shopref = Game.update_shop
function Game.update_shop(self, dt)
    update_shopref(self, dt)
    if not G.GAME.modifiers.mxms_booster_ante_end or not next(G.GAME.modifiers.mxms_booster_ante_end) then return end
    if not G.GAME.open_ante_end_pack then return end
    G.GAME.open_ante_end_pack = false
    for _, v in pairs(G.GAME.modifiers.mxms_booster_ante_end) do
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            blockable = true,
            blocking = false,
            func = function()
                if G.STATE_COMPLETE and not G.GAME.PACK_INTERRUPT then
                    local card = SMODS.add_card({ area = G.play, key = v, skip_materialize = true, bypass_discovery_center = true, bypass_discovery_ui = true })
                    card.cost = 0
                    G.FUNCS.use_card({ config = { ref_table = card } })
                    card:start_materialize()
                    return true
                end
            end
        }))
    end
end

-- Prevent Horoscopes from overflowing when bought from shop
local gfcfbs = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.ability.set and card.ability.set == 'Horoscope' then
        if not (#G.mxms_horoscope.cards + (1 + card.ability.extra_slots_used) <= G.mxms_horoscope.config.card_limit + card.ability.card_limit) then
            alert_no_space(card, G.mxms_horoscope)
            return false
        end
    end
    return gfcfbs(card)
end

-- CardArea emplace hook for Horoscope cards
local cae = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    if self == G.consumeables and (card.ability.set == "Horoscope" or card.config.center_key == 'c_mxms_ophiucus') then
        card:remove_from_area()
        G.mxms_horoscope:emplace(card, location, stay_flipped)
        discover_card(card.config.center)
        card.bypass_discovery_center = true
        card.bypass_discovery_ui = true
        card.discovered = true
        return
    end

    cae(self, card, location, stay_flipped)

    if self == G.mxms_horoscope and TheFamily then
        G.GAME.horoscope_alert = true
    end
end