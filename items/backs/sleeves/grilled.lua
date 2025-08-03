CardSleeves.Sleeve {
    key = "grilled",
    atlas = "Sleeves",
    pos = {
        x = 1,
        y = 1
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    loc_vars = function(self, info_queue, card)
        local key
        if self.get_current_deck_key() == 'b_mxms_grilled' then
            key = self.key .. '_alt'
        else
            key = self.key
        end
        return { key = key }
    end,
    apply = function(self, sleeve)
        -- Some hooks for these modifiers are in backs/grilled.lua
        if self.get_current_deck_key() == 'b_mxms_grilled' then
            -- If on Grilled Deck, apply face card Xmult modifier
            G.GAME.modifiers.mxms_face_card_xmult = true
        else
            G.GAME.modifiers.mxms_even_card_mult = true
        end
    end
}

local cgcxm = Card.get_chip_x_mult
function Card:get_chip_x_mult(context)
    local ret = cgcxm(self, context)
    if G.GAME.modifiers.mxms_face_card_xmult and self:is_face() then
        ret = ret + 1.25
    end
    return ret
end
