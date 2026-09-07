SMODS.Back {
    key = 'scarred',
    atlas = 'Modifiers',
    pos = {
        x = 3,
        y = 1
    },
    mxms_credits = {
        art = { "Inky" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    config = {
        extra = {
            slots = -1
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.slots } }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                G.jokers:change_size(self.config.extra.slots)
                return true;
            end
        }))
    end
}

local uc = unlock_card
function unlock_card(card)
    if not G.MXMS_SCARRED_SPAWN then
        uc(card)
    end
end

local dc = discover_card
function discover_card(card)
    if not G.MXMS_SCARRED_SPAWN then
        dc(card)
    end
end

SMODS.RunSelectPage({
	key = 'scarred_choice',
    type = 'Joker',
	generate_pool = function()
        local legendary_pool = {}
        for _, v in pairs(G.P_CENTER_POOLS.Joker) do
            if SMODS.has_attribute(v, 'mxms_legendary') then
                table.insert(legendary_pool, v)
            end
        end
        return legendary_pool
        
     end,
	grid_size = {2, 4},
	automatic_preview = true,
	random_select = true,
    choose_random = function(self)
        local options = {}
        for i=1, #self.pool do
            options[#options + 1] = self.pool[i].key
        end
        if self.selection_limit > 1 then
            for k,_ in pairs(SMODS.RunSelect.Setup.choices[self.key]) do
                SMODS.RunSelect.Setup.choices[self.key][k] = nil
                SMODS.RunSelect.Functions.populate_preview_ui(self.key, SMODS.RunSelect.Internals.preview_area.cards[1], self.silent, true)
            end
        end
        for i=1, self.selection_limit do
            local selected = false
            while not selected do
                selected = pseudorandom_element(options, pseudoseed(os.time()))
                if (selected == SMODS.RunSelect.Setup.choices[self.key] or SMODS.RunSelect.Setup.choices[self.key][selected]) and #options > 1 then selected = false end
            end
            play_sound('whoosh1', math.random()*0.2 + 0.99, 0.35)
            self:handle_choice({config = {center = {key = selected}}})
        end
    end,
    optional = function()
        return SMODS.RunSelect.Setup.choices.deck_choice == 'b_mxms_scarred' or SMODS.RunSelect.Setup.choices.casl_sleeve_choice == 'sleeve_mxms_scarred'
    end,
	quick_start_text = function()
		if not G.PROFILES[G.SETTINGS.profile].last_choices.mxms_scarred_choice then return end
		local choice = G.PROFILES[G.SETTINGS.profile].last_choices.mxms_scarred_choice or 'j_mxms_hugo'
		return localize({type = 'name_text', set = 'Joker', key = choice})
	end,
	selected_text = function(self, selection)
		if not selection then return end
		return localize({set = 'Joker', key = SMODS.RunSelect.Setup.choices[self.key], type = 'name_text'})
	end,
    create_selection_card = function(self, card_key, card_number, area)
        local _c = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[card_key] or G.P_CENTERS.b_red, {bypass_discovery_center = true, bypass_discovery_ui = true, bypass_lock = true})
        if SMODS.RunSelect.Setup.choices.deck_choice == 'b_mxms_scarred' and SMODS.RunSelect.Setup.choices.casl_sleeve_choice == 'sleeve_mxms_scarred' then
            _c:set_edition('e_negative', true, true)
        end
        return _c
    end,
	start_run = function(self, choice)
		choice = choice or 'j_mxms_hugo'
		G.MXMS_SCARRED_SPAWN = true
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                local _c = SMODS.add_card({
                    key = choice,
                    no_edition = true,
                    skip_materialize = false,
                    bypass_discovery_center = true,
                    bypass_discovery_ui = true,
                })
                _c.mxms_scarred = true
                G.MXMS_SCARRED_SPAWN = nil
                return true;
            end
        }))
	end,
	set_default = function(self, choice)
		return choice or 'j_mxms_hugo'
	end,
})