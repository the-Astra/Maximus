Maximus.CREDITS = {}

Maximus.CREDITS.dev_colours = {
    ['theAstra'] = HEX('A600FF'),
    ['Maxiss02'] = HEX('0008FF'),
    ['anerdymous'] = Maximus.C.SECONDARY_SET.Conspiracy,
    ['pinkzigzagoon'] = HEX('e67ae0'),
    ['squeax09'] = HEX("0db829"),
    ['Willow'] = HEX('38A336'),
    ['Inky'] = HEX('189bcc'),
    ['SadCube'] = HEX('6cc2c3'),
    ['pangaea47'] = HEX('e6fab8'),
    ['GhostSalt'] = HEX('FFDDDD')
}

--#region Credits on Pop Up
Maximus.CREDITS.generate_string = function(developers, prefix)
    if type(developers) ~= 'table' then return end

    local amount = #developers
    local credit_string = {n=G.UIT.R, config={align = 'tm'}, nodes={
                {n=G.UIT.R, config={align='cm'}, nodes={{n=G.UIT.T, config={text = localize(prefix), shadow = true, colour = G.C.UI.BACKGROUND_WHITE, scale = 0.27}}}}
            }}

    for i, name in ipairs(developers) do
        local target_row = math.ceil(i/3)
        local dev = name
        if target_row > #credit_string.nodes then table.insert(credit_string.nodes, {n=G.UIT.R, config={align='cm'}, nodes ={}}) end
        table.insert(credit_string.nodes[target_row].nodes, {n=G.UIT.O, config = {object = DynaText({
                    string = dev or 'ERROR',
                    colours = { Maximus.CREDITS.dev_colours[dev] or G.C.ORANGE }, scale = 0.27,
                    silent = true, shadow = true, y_offset = -0.6,
                })
            }
        })
        if i < amount then
            table.insert(credit_string.nodes[target_row].nodes, {n=G.UIT.T, config = {text = localize(i+1 == amount and 'mxms_and_spacer' or 'mxms_comma_spacer'), shadow = true, colour = G.C.UI.BACKGROUND_WHITE, scale = 0.27 } })
        end
    end

    return credit_string
end

local mxms_card_popup = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
    local ret_val = mxms_card_popup(card)
    local obj = card.config.center or card.config.tag and SMODS.Tags[card.config.tag.key]
    local target = ret_val.nodes[1].nodes[1].nodes[1].nodes
    if obj and obj.mxms_credits then
        if obj.mxms_credits.art then
            local str = Maximus.CREDITS.generate_string(obj.mxms_credits.art, 'mxms_art_credit')
            if str then
                table.insert(target, str)
            end
        end
        if obj.mxms_credits.code then
            local str = Maximus.CREDITS.generate_string(obj.mxms_credits.code, 'mxms_code_credit')
            if str then
                table.insert(target, str)
            end
        end
        if obj.mxms_credits.idea then
            local str = Maximus.CREDITS.generate_string(obj.mxms_credits.idea, 'mxms_idea_credit')
            if str then
                table.insert(target, str)
            end
        end
    end
    return ret_val
end

local mxms_create_UIBox_blind_popup = create_UIBox_blind_popup
function create_UIBox_blind_popup(blind, discovered, vars)
    local ret_val = mxms_create_UIBox_blind_popup(blind, discovered, vars)
    local obj = blind
    local target = ret_val.nodes
    if obj and obj.mxms_credits then
        if obj.mxms_credits.art then
            local str = Maximus.CREDITS.generate_string(obj.mxms_credits.art, 'mxms_art_credit', obj.mod.prefix)
            if str then
                table.insert(target, str)
            end
        end
        if obj.mxms_credits.code then
            local str = Maximus.CREDITS.generate_string(obj.mxms_credits.code, 'mxms_code_credit', obj.mod.prefix)
            if str then
                table.insert(target, str)
            end
        end
        if obj.mxms_credits.idea then
            local str = Maximus.CREDITS.generate_string(obj.mxms_credits.idea, 'mxms_idea_credit', obj.mod.prefix)
            if str then
                table.insert(target, str)
            end
        end
    end
    return ret_val
end