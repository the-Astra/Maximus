SMODS.Back {
    key = 'grilled',
    atlas = 'Modifiers',
    pos = {
        x = 4,
        y = 0
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    apply = function(self, back)
        --Change card scoring
        G.GAME.modifiers.mxms_even_card_mult = true
    end
}

local cgcb = Card.get_chip_bonus
function Card:get_chip_bonus()
    local ret = cgcb(self)
    if G.GAME.modifiers.mxms_even_card_mult and self:get_id() % 2 == 0 and self:get_id() ~= 14 and not self:is_face() then
        ret = ret - self.base.nominal
    elseif G.GAME.modifiers.mxms_face_card_xmult and self:is_face() then
        ret = ret - self.base.nominal
    end
    return ret
end

local cgcm = Card.get_chip_mult
function Card:get_chip_mult()
    local ret = cgcm(self)
    if G.GAME.modifiers.mxms_even_card_mult and self:get_id() % 2 == 0 and self:get_id() ~= 14 and not self:is_face() then
        if not (self.ability.effect == 'Stone Card' and not next(SMODS.find_card('j_mxms_hammer_and_chisel'))) or not self.config.center.replace_base_card then
            ret = ret + self.base.nominal
        end
    end
    return ret
end
