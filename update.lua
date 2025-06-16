-- This file was taken from TheCoroboCorner's JoJoMod and adapted for Maximus

local modPath = "Mods/Maximus-main" -- This is the path to your mod folder
local id = "Maximus" -- This is the ID of your mod -- the same one you put in your metadata file
local subpath = ""

local function curl_fetch(url)
	local cmd = ('curl -sL "%s"'):format(url:gsub('"','\\"'))
	local fp = io.popen(cmd, "r")
	if not fp then return nil, "curl not available" end
	local body = fp:read("*a")
	local ok, _, exit = fp:close()
	if not ok then return nil, ("curl exited with code %s"):format(tostring(exit)) end
	return body
end

local function parse_tag(body)
	return body:match('"tag_name"%s*:%s*"([^"]+)"')
end

function check_version()
	local owner, repo = SMODS.Mods[id].git_owner, SMODS.Mods[id].git_repo
	
	if not owner then return nil, "git_owner parameter not found in metadata json file" end
	if not repo then return nil, "git_repo parameter not found in metadata json file" end
	
	local url = string.format("https://api.github.com/repos/%s/%s/releases/latest", owner, repo)
	
	local body, err = curl_fetch(url)
	if not body then
		print("Fetch failed:", err)
		return nil
	end
	
	local latest = parse_tag(body)
	if not latest then
		print("Couldn't parse JSON - tag_name missing")
		return nil
	end
	
	return latest
end

local function download_file(url, dest_path)
	local cmd = ('curl -sL -A "ModUpdater" -o "%s" "%s"'):format(dest_path, url)
	local success = os.execute(cmd)
	return success == true or success == 0
end

local function get_subdir(path)
	for entry in io.popen('dir "' .. path .. '" /b /ad'):lines() do
		return entry
	end
end

local function unzip_file(zip_path, zip_subpath, out_dir)
	modPath = modPath:gsub("/", "\\")
	out_dir = out_dir:gsub("/", "\\")
	
	zip_path = zip_path:gsub("/", "\\")
	zip_subpath = zip_subpath:gsub("/", "\\")

	local is_windows = package.config:sub(1,1) == '\\'
	local tmp_dir = out_dir .. "_tmp"
	local ok1, ok2, ok3
	
	if is_windows then
		os.execute(('if exist "%s" rmdir /S /Q "%s"'):format(tmp_dir, tmp_dir))
		os.execute(('if exist "%s" rmdir /S /Q "%s"'):format(out_dir, out_dir))
		ok1 = os.execute(string.format('powershell -NoProfile -Command "Expand-Archive -LiteralPath %q -DestinationPath %q -Force"', zip_path, tmp_dir))
		
		local subfolder = get_subdir(tmp_dir)
		if subfolder then
			local src_path = subpath and tmp_dir .. "\\" .. subfolder .. "\\" .. subpath or tmp_dir .. "\\" .. subfolder
			ok2 = os.execute(string.format('powershell -NoProfile -Command "Move-Item -Path %q -Destination %q -Force"', src_path, out_dir))
		else 
			ok2 = false
		end
		
		ok3 = os.execute(string.format('rmdir /S /Q "%s"', tmp_dir))
	else
		ok1 = os.execute(string.format('unzip -o %q %q\'*\' -d %q', zip_path, zip_subpath, out_dir))
		ok2 = true
		ok3 = true
	end
	
	local ok4 = os.remove(zip_path)
	
	return  (ok1 == true or ok1 == 0) and
			(ok2 == true or ok2 == 0) and
			(ok3 == true or ok3 == 0) and
			ok4 == true
	
end

local function install_update()
	local owner, repo, tag = SMODS.Mods[id].git_owner, SMODS.Mods[id].git_repo, check_version()
	local zip_url = string.format("https://github.com/%s/%s/releases/download/%s/Maximus-main.zip", owner, repo, tag)
	local zip_path = ("Mods\\%s-%s.zip"):format(repo, tag)
	local target_dir = ("%s"):format(modPath)
	local true_subpath = subpath and string.format("%s-%s\\%s", repo, tag, subpath) or string.format("%s-%s", repo, tag)
	
	if not download_file(zip_url, zip_path) then
		print("Failed to download update from " ..zip_url)
		return
	end
	
	if not unzip_file(zip_path, true_subpath, target_dir) then
		print("Failed to unzip " ..zip_path)
		return
	end
	
	SMODS.restart_game()
end

G.FUNCS.update_accepted = function(e)
	install_update()
	G.FUNCS.exit_overlay_menu()
end

G.FUNCS.update_denied = function(e)
	G.FUNCS.exit_overlay_menu()
end

local function create_multiline(lines, args)
	opts = opts or {}
	local txt_nodes = {}
	for _, line in ipairs(lines) do
		table.insert(txt_nodes, {
			n = G.UIT.R,
			config = {
				align = opts.align or "cm",
				padding = opts.line_padding or 0.05,
			},
			nodes = {
				n = G.UIT.T,
				config = {
					text = line,
					scale = opts.scale or 0.5,
					colour = opts.colour or G.C.UI.TEXT_LIGHT,
					shadow = opts.shadow or false
				}
			}
		})
	end
	return {
		n = G.UIT.C,
		config = {
			align = opts.align or "cm",
			padding = opts.padding or 0.1
		},
		nodes = txt_nodes
	}
end

local function show_update_prompt(latest, current)
	local msg = {
		("A new version of %s is available!\n"):format(SMODS.Mods[id].name),
		("Installed: %s\n"):format(current),
		("Latest:    %s\n\n"):format(latest),
		"Update now? (This will restart Balatro.)"
	}
	
	local lines = {
		n = G.UIT.R,
		config = {
			padding = 0.2,
			align = "tm"
		},
		nodes = {
			{
				n = G.UIT.C,
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = msg[1] .. msg[2] .. msg[3] .. msg[4],
							scale = 0.5
						}
					},
					--[[
					{
						n = G.UIT.T,
						config = {
							text = msg[2],
							scale = 0.5
						}
					},
					{
						n = G.UIT.T,
						config = {
							text = msg[3],
							scale = 0.5
						}
					},
					{
						n = G.UIT.T,
						config = {
							text = msg[4],
							scale = 0.5
						}
					}
					]]--
				}
			}
		}
	}
	
	local button_row = {
		n = G.UIT.R,
		config = {
			padding = 0.2,
			align = "bm"
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					padding = 0.1
				},
				nodes = {
					UIBox_button {
						colour = G.C.GREEN,
						label = { "Yes" },
						button = "update_accepted",
					}
				}
			},
			{
				n = G.UIT.C,
				config = {
					padding = 0.1
				},
				nodes = {
					UIBox_button {
						colour = G.C.RED,
						label = { "No" },
						button = "update_denied",
					}
				}
			}
		}	
	}
	local confirm_ui = {
		n = G.UIT.ROOT,
		config = {
			align = "cm",
			minw = 4,
			minh = 5,
			padding = 0.3,
			colour = G.C.UI.TEXT_DARK,
			outline = 5,
			outline_colour = G.C.BLACK,
			r = 0.1
		},
		nodes = {
			lines,
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.B,
						config = {
							h = 2,
							w = 0
						}
					}
				}
			},
			button_row
		}
	}
	G.FUNCS.overlay_menu {
		definition = confirm_ui,
		config = {
			align = "cm",
			bond = "Weak",
			no_esc = true,
			major = G.ROOM_ATTACH
		}
	}
end

Maximus.update_check = function()
	local raw_version = check_version()
	if not raw_version then return nil, "There appears to have been a connection error" end
	local git_version = raw_version:match("^v?(%d+%.%d+%.%d+%a*)$")
	local current_version = SMODS.Mods[id].version:match("^v?(%d+%.%d+%.%d+%a*)$")
	if git_version and current_version and V(git_version) > V(current_version) then
		show_update_prompt('v' .. git_version, 'v' .. current_version)
	end
end