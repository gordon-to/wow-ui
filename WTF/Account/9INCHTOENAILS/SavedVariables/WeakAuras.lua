
WeakAurasSaved = {
	["dynamicIconCache"] = {
	},
	["minimap"] = {
		["minimapPos"] = 17.1517862848976,
		["hide"] = false,
	},
	["displays"] = {
		["Ascendance (Elemental) 2"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["text2"] = "%p",
			["cooldownSwipe"] = true,
			["text1Enabled"] = true,
			["customTextUpdate"] = "update",
			["cooldownEdge"] = true,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["spellName"] = 114051,
						["unevent"] = "auto",
						["use_showOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Ascendance",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_absorbMode"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 114051,
					},
				}, -- [1]
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"114050", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
						["event"] = "Health",
						["unit"] = "player",
						["type"] = "aura2",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["glow"] = false,
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["useglowColor"] = false,
			["parent"] = "Luxthos - Shaman Rotations",
			["stickyDuration"] = false,
			["desaturate"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["text1Containment"] = "INSIDE",
			["load"] = {
				["use_petbattle"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["talent"] = {
					["single"] = 21,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_talent2"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["config"] = {
			},
			["zoom"] = 0.33,
			["anchorFrameType"] = "SCREEN",
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["frameStrata"] = 1,
			["selfPoint"] = "CENTER",
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Font"] = "Friz Quadrata TT",
			["text2FontSize"] = 24,
			["auto"] = true,
			["text1"] = " ",
			["alpha"] = 1,
			["xOffset"] = 58,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["id"] = "Ascendance (Elemental) 2",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Enabled"] = false,
			["width"] = 55,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["uid"] = "6dbDubhCP43",
			["inverse"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
		},
		["Icefury - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 17,
			["parent"] = "Luxthos - Shaman Rotations",
			["text1FontFlags"] = "OUTLINE",
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 116,
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"210714", -- [1]
						},
						["matchesShowOn"] = "showOnActive",
						["use_runesCount"] = true,
						["spellName"] = 210714,
						["use_debuffClass"] = false,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["runesCount"] = "2",
						["combineMatches"] = "showLowest",
						["useGroup_count"] = false,
						["use_absorbMode"] = true,
						["names"] = {
							"Icefury", -- [1]
						},
						["powertype"] = 7,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["use_showOn"] = true,
						["useName"] = true,
						["power"] = "0",
						["unevent"] = "auto",
						["type"] = "aura2",
						["use_unit"] = true,
						["use_requirePowerType"] = false,
						["use_power"] = false,
						["realSpellName"] = "Icefury",
						["use_spellName"] = true,
						["spellIds"] = {
							210714, -- [1]
						},
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["use_tooltip"] = false,
						["buffShowOn"] = "showOnActive",
						["rune"] = 0,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 210714,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["conditions"] = {
			},
			["text1Enabled"] = true,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["internalVersion"] = 15,
			["authorOptions"] = {
			},
			["uid"] = "LHnjV2bbS7o",
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["text1Point"] = "CENTER",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 18,
					["multi"] = {
						true, -- [1]
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 55,
			["alpha"] = 1,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text2Containment"] = "INSIDE",
			["glowType"] = "ACShine",
			["text1Font"] = "Friz Quadrata TT",
			["frameStrata"] = 1,
			["text2Font"] = "Friz Quadrata TT",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["auto"] = false,
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["icon"] = true,
			["text1"] = "%s",
			["glow"] = true,
			["cooldownTextDisabled"] = true,
			["zoom"] = 0.33,
			["semver"] = "1.1.4",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "Icefury - Active",
			["text1Containment"] = "INSIDE",
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["stickyDuration"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["displayIcon"] = 135849,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Flame Shock"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text1FontFlags"] = "OUTLINE",
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = -116,
			["cooldownSwipe"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"188389", -- [1]
						},
						["ownOnly"] = true,
						["use_runesCount"] = true,
						["spellName"] = 51505,
						["use_debuffClass"] = false,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["runesCount"] = "2",
						["combineMatches"] = "showLowest",
						["useGroup_count"] = false,
						["use_absorbMode"] = true,
						["names"] = {
							"Flame Shock", -- [1]
						},
						["unitExists"] = true,
						["use_tooltip"] = false,
						["use_showOn"] = true,
						["use_unit"] = true,
						["use_powertype"] = true,
						["buffShowOn"] = "showOnActive",
						["useName"] = true,
						["type"] = "aura2",
						["rune"] = 0,
						["power"] = "0",
						["use_specific_unit"] = false,
						["powertype"] = 7,
						["use_requirePowerType"] = false,
						["unit"] = "target",
						["realSpellName"] = "Lava Burst",
						["use_spellName"] = true,
						["spellIds"] = {
							163057, -- [1]
						},
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["debuffType"] = "HARMFUL",
						["matchesShowOn"] = "showAlways",
						["use_power"] = false,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 51505,
						["unit"] = "player",
					},
				}, -- [1]
				{
					["trigger"] = {
						["track"] = "auto",
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["use_showgcd"] = true,
						["spellName"] = 188389,
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Cooldown Progress (Spell)",
						["realSpellName"] = "Flame Shock",
						["use_spellName"] = true,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_absorbMode"] = true,
						["use_track"] = true,
						["use_genericShowOn"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "<=",
						["value"] = "6",
						["variable"] = "expirationTime",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [3]
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["glow"] = false,
			["config"] = {
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["cooldownEdge"] = false,
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 2,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["faction"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["ingroup"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text1Enabled"] = true,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["semver"] = "1.1.4",
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1"] = " ",
			["frameStrata"] = 1,
			["zoom"] = 0.33,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "Flame Shock",
			["text1Containment"] = "INSIDE",
			["text2Enabled"] = false,
			["width"] = 55,
			["stickyDuration"] = false,
			["uid"] = "8fLO6f3RfiB",
			["inverse"] = false,
			["text2Font"] = "Friz Quadrata TT",
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["authorOptions"] = {
			},
		},
		["Searing Assault"] = {
			["text2Point"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["useglowColor"] = false,
			["xOffset"] = 0,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["icon"] = true,
			["cooldownSwipe"] = true,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["use_absorbMode"] = true,
						["subeventPrefix"] = "SPELL",
						["auranames"] = {
							"268429", -- [1]
						},
						["rune"] = 0,
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["powertype"] = 7,
						["use_runesCount"] = true,
						["debuffType"] = "HARMFUL",
						["subeventSuffix"] = "_CAST_START",
						["useName"] = true,
						["use_powertype"] = true,
						["spellName"] = 187874,
						["unevent"] = "auto",
						["type"] = "aura2",
						["event"] = "Cooldown Progress (Spell)",
						["power"] = "0",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["use_requirePowerType"] = false,
						["use_showOn"] = true,
						["realSpellName"] = "Crash Lightning",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["use_unit"] = true,
						["runesCount"] = "2",
						["names"] = {
							"Bone Shield", -- [1]
						},
						["use_power"] = false,
						["matchesShowOn"] = "showAlways",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 17364,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 15,
			["text1Enabled"] = true,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["config"] = {
			},
			["text1Containment"] = "INSIDE",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["progressPrecision"] = 0,
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["anchorFrameType"] = "SCREEN",
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 10,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_petbattle"] = false,
				["use_combat"] = true,
				["faction"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
			},
			["alpha"] = 1,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Font"] = "Friz Quadrata TT",
			["useGlowColor"] = false,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["zoom"] = 0.33,
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["text1Font"] = "Friz Quadrata TT",
			["text1"] = " ",
			["semver"] = "1.1.4",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["id"] = "Searing Assault",
			["text2Enabled"] = false,
			["frameStrata"] = 1,
			["width"] = 55,
			["stickyDuration"] = false,
			["uid"] = "F1JiBeoJwii",
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 135847,
			["cooldown"] = true,
			["glow"] = false,
		},
		["Wellspring"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["zoom"] = 0.33,
			["cooldownSwipe"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["customTextUpdate"] = "update",
			["cooldownEdge"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["use_showgcd"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["use_unit"] = true,
						["unevent"] = "auto",
						["use_showOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["unit"] = "player",
						["realSpellName"] = "Wellspring",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["spellName"] = 197995,
						["use_absorbMode"] = true,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 114051,
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["useglowColor"] = false,
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["icon"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
			["stickyDuration"] = false,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["text1Containment"] = "INSIDE",
			["load"] = {
				["talent2"] = {
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_petbattle"] = false,
				["ingroup"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 20,
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_vehicleUi"] = false,
				["use_talent"] = true,
				["use_class"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["config"] = {
			},
			["selfPoint"] = "CENTER",
			["anchorFrameType"] = "SCREEN",
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["frameStrata"] = 1,
			["text1Enabled"] = true,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["text2"] = "%p",
			["text1FontFlags"] = "OUTLINE",
			["text2FontSize"] = 24,
			["auto"] = true,
			["text1"] = " ",
			["alpha"] = 1,
			["xOffset"] = 116,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["internalVersion"] = 15,
			["id"] = "Wellspring",
			["glow"] = false,
			["text2Enabled"] = false,
			["width"] = 55,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["uid"] = "Rg60oVuRxmf",
			["inverse"] = true,
			["desaturate"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "cooldownEdge",
						}, -- [2]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
		},
		["Stormstrike"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["authorOptions"] = {
			},
			["text2Font"] = "Friz Quadrata TT",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = -116,
			["cooldownSwipe"] = true,
			["cooldownEdge"] = true,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["useglowColor"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "buffed",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 1,
								["variable"] = "insufficientResources",
								["value"] = 0,
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "onCooldown",
								["value"] = 0,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "insufficientResources",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								0.31764705882353, -- [1]
								0.40392156862745, -- [2]
								0.78039215686274, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [4]
			},
			["text1Enabled"] = true,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_power"] = false,
						["duration"] = "1",
						["use_genericShowOn"] = true,
						["rune"] = 0,
						["use_absorbMode"] = true,
						["genericShowOn"] = "showAlways",
						["names"] = {
							"Bone Shield", -- [1]
						},
						["use_showgcd"] = true,
						["powertype"] = 7,
						["use_runesCount"] = true,
						["ownOnly"] = true,
						["debuffType"] = "HELPFUL",
						["subeventSuffix"] = "_CAST_START",
						["use_powertype"] = true,
						["spellName"] = 17364,
						["power"] = "0",
						["type"] = "status",
						["use_requirePowerType"] = false,
						["unevent"] = "auto",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["use_showOn"] = true,
						["realSpellName"] = "Stormstrike",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["use_unit"] = true,
						["runesCount"] = "2",
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 17364,
						["unit"] = "player",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"201846", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["config"] = {
			},
			["text1Containment"] = "INSIDE",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 3,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["use_petbattle"] = false,
				["race"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 55,
			["frameStrata"] = 1,
			["text2Enabled"] = false,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["internalVersion"] = 15,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["auto"] = true,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["text2"] = "%p",
			["text1"] = " ",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Font"] = "Friz Quadrata TT",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["progressPrecision"] = 0,
			["id"] = "Stormstrike",
			["desaturate"] = false,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["stickyDuration"] = false,
			["uid"] = "dG3)nF6BiLa",
			["inverse"] = true,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["glow"] = false,
		},
		["Healing Tide Totem 2 - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["xOffset"] = 58,
			["zoom"] = 0.33,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["cooldownSwipe"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["useglowColor"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["text1Enabled"] = true,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["conditions"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownEdge"] = false,
			["desaturate"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["config"] = {
			},
			["load"] = {
				["use_petbattle"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
						[5] = true,
						[4] = true,
					},
				},
				["talent"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_talent2"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["width"] = 55,
			["alpha"] = 1,
			["text2Containment"] = "INSIDE",
			["glowType"] = "ACShine",
			["text1Font"] = "Friz Quadrata TT",
			["frameStrata"] = 1,
			["stickyDuration"] = false,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["auto"] = false,
			["text2FontSize"] = 24,
			["text2"] = "%p",
			["text1"] = " ",
			["internalVersion"] = 15,
			["text2Font"] = "Friz Quadrata TT",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["selfPoint"] = "CENTER",
			["id"] = "Healing Tide Totem 2 - Active",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["text1Containment"] = "INSIDE",
			["uid"] = "jmAc1A)IUGL",
			["inverse"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["names"] = {
						},
						["type"] = "status",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["use_showOn"] = true,
						["unit"] = "player",
						["event"] = "Totem",
						["totemName"] = "108280",
						["realSpellName"] = "Healing Tide Totem",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["spellName"] = 108280,
						["use_totemName"] = true,
						["subeventPrefix"] = "SPELL",
						["use_genericShowOn"] = true,
						["use_absorbMode"] = true,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 108280,
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["displayIcon"] = 538569,
			["cooldown"] = true,
			["glow"] = true,
		},
		["Healing Tide Totem 2"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["text2"] = "%p",
			["cooldownSwipe"] = true,
			["useglowColor"] = false,
			["customTextUpdate"] = "update",
			["cooldownEdge"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["duration"] = "1",
						["unevent"] = "auto",
						["use_showOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Healing Tide Totem",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_absorbMode"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["spellName"] = 108280,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 108280,
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["use_inverse"] = true,
						["event"] = "Totem",
						["unit"] = "player",
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["use_totemName"] = true,
						["totemName"] = "108280",
						["use_absorbMode"] = true,
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["parent"] = "Luxthos - Shaman Rotations",
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["cooldownTextDisabled"] = false,
			["text2Font"] = "Friz Quadrata TT",
			["stickyDuration"] = false,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["text1Containment"] = "INSIDE",
			["load"] = {
				["use_petbattle"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
						[5] = true,
						[4] = true,
					},
				},
				["talent"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_talent2"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["race"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "quLHFWiN4W(",
			["text1Font"] = "Friz Quadrata TT",
			["anchorFrameType"] = "SCREEN",
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["alpha"] = 1,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Enabled"] = true,
			["text2FontSize"] = 24,
			["auto"] = true,
			["text1"] = " ",
			["icon"] = true,
			["frameStrata"] = 1,
			["zoom"] = 0.33,
			["semver"] = "1.1.4",
			["glow"] = false,
			["id"] = "Healing Tide Totem 2",
			["selfPoint"] = "CENTER",
			["text2Enabled"] = false,
			["width"] = 55,
			["xOffset"] = 58,
			["config"] = {
			},
			["inverse"] = true,
			["desaturate"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
		},
		["Lava Surge - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text1FontFlags"] = "OUTLINE",
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 0,
			["cooldownSwipe"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["customTextUpdate"] = "update",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"77756", -- [1]
						},
						["ownOnly"] = true,
						["use_runesCount"] = true,
						["spellName"] = 51505,
						["use_debuffClass"] = false,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["runesCount"] = "2",
						["combineMatches"] = "showLowest",
						["useGroup_count"] = false,
						["use_absorbMode"] = true,
						["names"] = {
							"Lava Surge", -- [1]
						},
						["use_tooltip"] = false,
						["use_showOn"] = true,
						["use_powertype"] = true,
						["buffShowOn"] = "showOnActive",
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["type"] = "aura2",
						["power"] = "0",
						["use_unit"] = true,
						["rune"] = 0,
						["use_requirePowerType"] = false,
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Lava Burst",
						["use_spellName"] = true,
						["spellIds"] = {
							77756, -- [1]
						},
						["powertype"] = 7,
						["matchesShowOn"] = "showOnActive",
						["unevent"] = "auto",
						["unit"] = "player",
						["use_power"] = false,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 51505,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["conditions"] = {
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["config"] = {
			},
			["text1Containment"] = "INSIDE",
			["progressPrecision"] = 0,
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["authorOptions"] = {
			},
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["race"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["ingroup"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 2,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["alpha"] = 1,
			["text1Enabled"] = true,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["semver"] = "1.1.4",
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1"] = " ",
			["text1Font"] = "Friz Quadrata TT",
			["zoom"] = 0.33,
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["desaturate"] = false,
			["id"] = "Lava Surge - Active",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text2Enabled"] = false,
			["width"] = 55,
			["stickyDuration"] = false,
			["uid"] = "xLpaaTnSOSQ",
			["inverse"] = false,
			["text2Font"] = "Friz Quadrata TT",
			["displayIcon"] = 451169,
			["cooldown"] = true,
			["glow"] = true,
		},
		["Icefury"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["authorOptions"] = {
			},
			["text2Font"] = "Friz Quadrata TT",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 116,
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["useglowColor"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = 1,
						["variable"] = "onCooldown",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "cooldownEdge",
						}, -- [2]
					},
				}, -- [1]
			},
			["text1Enabled"] = true,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_genericShowOn"] = true,
						["use_absorbMode"] = true,
						["names"] = {
							"Bone Shield", -- [1]
						},
						["runesCount"] = "2",
						["use_power"] = false,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["use_showgcd"] = true,
						["powertype"] = 7,
						["use_runesCount"] = true,
						["ownOnly"] = true,
						["debuffType"] = "HELPFUL",
						["power"] = "0",
						["use_powertype"] = true,
						["spellName"] = 210714,
						["unevent"] = "auto",
						["type"] = "status",
						["use_requirePowerType"] = false,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["use_showOn"] = true,
						["realSpellName"] = "Icefury",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["duration"] = "1",
						["rune"] = 0,
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 210714,
						["unit"] = "player",
					},
				}, -- [1]
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"210714", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
						["event"] = "Health",
						["unit"] = "player",
						["type"] = "aura2",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["config"] = {
			},
			["text1Containment"] = "INSIDE",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 18,
					["multi"] = {
						true, -- [1]
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["ingroup"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["faction"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 55,
			["frameStrata"] = 1,
			["text2Enabled"] = false,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["internalVersion"] = 15,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["auto"] = true,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["text2"] = "%p",
			["text1"] = "%s",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Font"] = "Friz Quadrata TT",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["progressPrecision"] = 0,
			["id"] = "Icefury",
			["desaturate"] = false,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["stickyDuration"] = false,
			["uid"] = "1FnNc8d(jIi",
			["inverse"] = true,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["glow"] = false,
		},
		["Ascendance (Restauration) - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["zoom"] = 0.33,
			["cooldownSwipe"] = true,
			["useglowColor"] = false,
			["customTextUpdate"] = "update",
			["cooldownEdge"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"114050", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["use_showOn"] = true,
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["useName"] = true,
						["realSpellName"] = "Ascendance",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["names"] = {
						},
						["use_absorbMode"] = true,
						["duration"] = "1",
						["spellName"] = 114051,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 114051,
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "preset",
					["preset"] = "alphaPulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["glow"] = true,
			["selfPoint"] = "CENTER",
			["stickyDuration"] = false,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["text1Containment"] = "INSIDE",
			["load"] = {
				["talent2"] = {
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["talent"] = {
					["single"] = 21,
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_vehicleUi"] = false,
				["use_talent"] = true,
				["use_class"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "xPK3fFeZiHm",
			["icon"] = true,
			["anchorFrameType"] = "SCREEN",
			["text2Containment"] = "INSIDE",
			["glowType"] = "ACShine",
			["text1Font"] = "Friz Quadrata TT",
			["frameStrata"] = 1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["auto"] = true,
			["text1"] = " ",
			["alpha"] = 1,
			["text1Enabled"] = true,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["internalVersion"] = 15,
			["id"] = "Ascendance (Restauration) - Active",
			["xOffset"] = 116,
			["text2Enabled"] = false,
			["width"] = 55,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["inverse"] = false,
			["desaturate"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
		},
		["Flame Shock - Cooldown 2"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text1FontFlags"] = "OUTLINE",
			["internalVersion"] = 15,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["cooldownSwipe"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["customTextUpdate"] = "update",
			["cooldownEdge"] = true,
			["icon"] = true,
			["useglowColor"] = false,
			["conditions"] = {
			},
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["use_showgcd"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["unevent"] = "auto",
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Flame Shock",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["duration"] = "1",
						["use_absorbMode"] = true,
						["use_track"] = true,
						["spellName"] = 188389,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"188389", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
						["event"] = "Health",
						["unit"] = "target",
						["unitExists"] = true,
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["config"] = {
			},
			["desaturate"] = true,
			["progressPrecision"] = 0,
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["xOffset"] = -116,
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 2,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["race"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["ingroup"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 2,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["alpha"] = 1,
			["text1Containment"] = "INSIDE",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["auto"] = true,
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["text1Font"] = "Friz Quadrata TT",
			["text1"] = " ",
			["selfPoint"] = "CENTER",
			["zoom"] = 0.33,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["id"] = "Flame Shock - Cooldown 2",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Enabled"] = false,
			["width"] = 55,
			["stickyDuration"] = false,
			["uid"] = "dOkIM1BxQj)",
			["inverse"] = true,
			["text1Enabled"] = true,
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["glow"] = false,
		},
		["Primal Storm Elemental - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["xOffset"] = 116,
			["text2"] = "%p",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["text1Enabled"] = true,
			["cooldownSwipe"] = true,
			["authorOptions"] = {
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.spell = 192249\naura_env.texture = 2065626\naura_env.primal = IsPlayerSpell(118291)\naura_env.pet = false",
					["do_custom"] = true,
				},
			},
			["useglowColor"] = false,
			["cooldownEdge"] = false,
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "preset",
					["preset"] = "alphaPulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["conditions"] = {
			},
			["selfPoint"] = "CENTER",
			["text1Containment"] = "INSIDE",
			["stickyDuration"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["config"] = {
			},
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["single"] = 11,
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 17,
					["multi"] = {
						[17] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_talent2"] = true,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["use_combat"] = true,
				["faction"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["unit"] = "player",
						["type"] = "event",
						["spellId"] = "157319",
						["unevent"] = "timed",
						["names"] = {
						},
						["use_absorbMode"] = true,
						["event"] = "Combat Log",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_SUMMON",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["duration"] = "30",
						["use_unit"] = true,
						["sourceUnit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["names"] = {
						},
						["duration"] = "1",
						["use_totemName"] = true,
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["spellName"] = 198067,
						["events"] = "PLAYER_TOTEM_UPDATE",
						["debuffType"] = "HELPFUL",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "custom",
						["realSpellName"] = "Fire Elemental",
						["custom_type"] = "status",
						["use_showOn"] = true,
						["unevent"] = "auto",
						["event"] = "Health",
						["totemName"] = "Greater Fire Elemental",
						["customDuration"] = "",
						["use_spellName"] = true,
						["custom"] = "function()\n    aura_env.petExists = UnitExists(\"pet\")\n    if aura_env.petExists and select(6, strsplit(\"-\", UnitGUID(\"pet\"))) == \"77942\" then\n        return true\n    end\nend",
						["custom_hide"] = "timed",
						["check"] = "update",
						["unit"] = "player",
						["use_absorbMode"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["custom"] = "function()\n    return not aura_env.petExists\nend",
						["spellName"] = 198067,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = 1,
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["text2Containment"] = "INSIDE",
			["glowType"] = "ACShine",
			["text1Font"] = "Friz Quadrata TT",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["icon"] = true,
			["auto"] = false,
			["text2FontSize"] = 24,
			["zoom"] = 0.33,
			["text1"] = " ",
			["alpha"] = 1,
			["glow"] = true,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["text1FontFlags"] = "OUTLINE",
			["id"] = "Primal Storm Elemental - Active",
			["text2Font"] = "Friz Quadrata TT",
			["text2Enabled"] = false,
			["width"] = 55,
			["desaturate"] = false,
			["uid"] = "SgCtdUzPLQx",
			["inverse"] = false,
			["parent"] = "Luxthos - Shaman Rotations",
			["displayIcon"] = 2065626,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Sundering"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon"] = true,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["cooldownSwipe"] = true,
			["cooldownEdge"] = true,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "insufficientResources",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								0.31764705882353, -- [1]
								0.40392156862745, -- [2]
								0.78039215686274, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 1,
								["variable"] = "onCooldown",
								["value"] = 0,
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "insufficientResources",
								["value"] = 0,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [3]
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["selfPoint"] = "CENTER",
			["text1Enabled"] = true,
			["config"] = {
			},
			["text1Containment"] = "INSIDE",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["progressPrecision"] = 0,
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 18,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_absorbMode"] = true,
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["runesCount"] = "2",
						["use_power"] = false,
						["genericShowOn"] = "showAlways",
						["names"] = {
							"Bone Shield", -- [1]
						},
						["use_showgcd"] = true,
						["powertype"] = 7,
						["use_runesCount"] = true,
						["ownOnly"] = true,
						["spellName"] = 197214,
						["subeventSuffix"] = "_CAST_START",
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["power"] = "0",
						["type"] = "status",
						["use_requirePowerType"] = false,
						["unevent"] = "auto",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["use_showOn"] = true,
						["realSpellName"] = "Sundering",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["unit"] = "player",
						["rune"] = 0,
						["use_unit"] = true,
						["use_track"] = true,
						["use_genericShowOn"] = true,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 17364,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["xOffset"] = 116,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["auto"] = true,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["text2"] = "%p",
			["text1"] = " ",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["text2Enabled"] = false,
			["id"] = "Sundering",
			["stickyDuration"] = false,
			["alpha"] = 1,
			["width"] = 55,
			["desaturate"] = false,
			["uid"] = "mpMfVnDRm1F",
			["inverse"] = true,
			["text2Font"] = "Friz Quadrata TT",
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["glow"] = false,
		},
		["Frostbrand - Hailstorm"] = {
			["text2Point"] = "CENTER",
			["text2"] = "%p",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["cooldownEdge"] = false,
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["glow"] = false,
			["cooldownSwipe"] = true,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "buffed",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "ACShine",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 2,
						["op"] = "<=",
						["value"] = "5",
						["variable"] = "expirationTime",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "buttonOverlay",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "buffed",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "buttonOverlay",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "insufficientResources",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								0.31764705882353, -- [1]
								0.40392156862745, -- [2]
								0.78039215686274, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [4]
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["useglowColor"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["preset"] = "alphaPulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["text1Enabled"] = true,
			["config"] = {
			},
			["desaturate"] = false,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["progressPrecision"] = 0,
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["anchorFrameType"] = "SCREEN",
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 11,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["text2Enabled"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Font"] = "Friz Quadrata TT",
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["selfPoint"] = "CENTER",
			["useGlowColor"] = false,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["cooldownTextDisabled"] = false,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2FontSize"] = 24,
			["auto"] = true,
			["text1"] = " ",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["xOffset"] = 0,
			["zoom"] = 0.33,
			["semver"] = "1.1.4",
			["frameStrata"] = 1,
			["id"] = "Frostbrand - Hailstorm",
			["text1Containment"] = "INSIDE",
			["alpha"] = 1,
			["width"] = 55,
			["stickyDuration"] = false,
			["uid"] = "5AFMkuM4d8j",
			["inverse"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["use_showgcd"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["unevent"] = "auto",
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Frostbrand",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["spellName"] = 196834,
						["use_absorbMode"] = true,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["use_unit"] = true,
						["unit"] = "player",
						["auranames"] = {
							"196834", -- [1]
						},
						["subeventPrefix"] = "SPELL",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["names"] = {
							"Bone Shield", -- [1]
						},
						["rune"] = 0,
						["powertype"] = 7,
						["use_runesCount"] = true,
						["matchesShowOn"] = "showAlways",
						["subeventSuffix"] = "_CAST_START",
						["useName"] = true,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["unevent"] = "auto",
						["type"] = "aura2",
						["event"] = "Cooldown Progress (Spell)",
						["power"] = "0",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["use_requirePowerType"] = false,
						["use_showOn"] = true,
						["realSpellName"] = "Crash Lightning",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["spellName"] = 187874,
						["runesCount"] = "2",
						["duration"] = "1",
						["use_power"] = false,
						["use_absorbMode"] = true,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 17364,
						["unit"] = "player",
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 2,
			},
			["displayIcon"] = 135847,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Unlimited Power 2 - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 17,
			["authorOptions"] = {
			},
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["cooldownSwipe"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"272737", -- [1]
						},
						["use_totemName"] = true,
						["use_unit"] = true,
						["use_tooltip"] = false,
						["useGroup_count"] = false,
						["debuffType"] = "HELPFUL",
						["use_specific_unit"] = false,
						["useName"] = true,
						["use_debuffClass"] = false,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "aura2",
						["event"] = "Totem",
						["totemName"] = "Ascendance - Active",
						["names"] = {
							"Unlimited Power", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["spellIds"] = {
							272737, -- [1]
						},
						["use_absorbMode"] = true,
						["buffShowOn"] = "showAlways",
						["combineMatches"] = "showLowest",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["useglowColor"] = false,
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["stickyDuration"] = false,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "CENTER",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["uid"] = "VrjUOsmz(im",
			["load"] = {
				["use_petbattle"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
						["WARLOCK"] = true,
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["talent"] = {
					["single"] = 19,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_talent2"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["use_vehicleUi"] = false,
				["race"] = {
					["multi"] = {
					},
				},
			},
			["text2Font"] = "Friz Quadrata TT",
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["xOffset"] = 58,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["text2Enabled"] = false,
			["auto"] = true,
			["text2FontSize"] = 24,
			["cooldownTextDisabled"] = true,
			["text1"] = "%s",
			["text2"] = "%p",
			["glow"] = false,
			["zoom"] = 0.33,
			["semver"] = "1.1.4",
			["text1Enabled"] = true,
			["id"] = "Unlimited Power 2 - Active",
			["text1Containment"] = "INSIDE",
			["alpha"] = 1,
			["width"] = 55,
			["desaturate"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 135791,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Earth Shock"] = {
			["text2Point"] = "CENTER",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1FontSize"] = 17,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon"] = true,
			["customText"] = "function()\n    if aura_env.state and aura_env.state.maelstrom then\n        return aura_env.state.maelstrom\n    end\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = -58,
			["cooldownSwipe"] = true,
			["authorOptions"] = {
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "insufficientResources",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "insufficientResources",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 3,
						["variable"] = "buffed",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [3]
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["text2Font"] = "Friz Quadrata TT",
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["use_showgcd"] = true,
						["powertype"] = 11,
						["use_attackable"] = true,
						["debuffType"] = "HELPFUL",
						["subeventPrefix"] = "SPELL",
						["type"] = "status",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["use_showOn"] = true,
						["use_unit"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["use_powertype"] = true,
						["realSpellName"] = "Earth Shock",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["duration"] = "1",
						["use_absorbMode"] = true,
						["names"] = {
						},
						["use_track"] = true,
						["spellName"] = 8042,
					},
					["untrigger"] = {
						["showOn"] = "showOnCooldown",
						["genericShowOn"] = "showAlways",
						["spellName"] = 188389,
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 11,
						["use_absorbMode"] = true,
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_powertype"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"285514", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "player",
						["type"] = "aura2",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(t)\n    if not t[1] then\n        return true\n    end\nend",
				["activeTriggerMode"] = 1,
			},
			["config"] = {
			},
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "CENTER",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["stickyDuration"] = false,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 2,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["use_petbattle"] = false,
				["race"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 55,
			["frameStrata"] = 2,
			["text1Enabled"] = true,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["alpha"] = 1,
			["text1Containment"] = "INSIDE",
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["auto"] = true,
			["cooldownTextDisabled"] = true,
			["text2FontSize"] = 24,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1"] = "%s",
			["glow"] = false,
			["text2"] = "%p",
			["zoom"] = 0.33,
			["semver"] = "1.1.4",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["id"] = "Earth Shock",
			["progressPrecision"] = 0,
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["desaturate"] = false,
			["uid"] = "7sf2gh5)PWb",
			["inverse"] = true,
			["cooldownEdge"] = false,
			["displayIcon"] = 136026,
			["cooldown"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
		},
		["Lava Burst"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text1FontFlags"] = "OUTLINE",
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 0,
			["cooldownSwipe"] = true,
			["icon"] = true,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_genericShowOn"] = true,
						["use_absorbMode"] = true,
						["names"] = {
							"Bone Shield", -- [1]
						},
						["runesCount"] = "2",
						["use_power"] = false,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["use_showgcd"] = true,
						["powertype"] = 7,
						["use_runesCount"] = true,
						["ownOnly"] = true,
						["debuffType"] = "HELPFUL",
						["power"] = "0",
						["use_powertype"] = true,
						["spellName"] = 51505,
						["unevent"] = "auto",
						["type"] = "status",
						["use_requirePowerType"] = false,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["use_showOn"] = true,
						["realSpellName"] = "Lava Burst",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["duration"] = "1",
						["rune"] = 0,
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 51505,
						["unit"] = "player",
					},
				}, -- [1]
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"77756", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
						["event"] = "Health",
						["unit"] = "player",
						["type"] = "aura2",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"260734", -- [1]
						},
						["ownOnly"] = true,
						["event"] = "Health",
						["unit"] = "player",
						["matchesShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["useName"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "all",
				["activeTriggerMode"] = 1,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "0",
						["variable"] = "charges",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 1,
								["variable"] = "onCooldown",
								["value"] = 0,
							}, -- [1]
							{
								["trigger"] = 3,
								["variable"] = "buffed",
								["value"] = 0,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "cooldownEdge",
						}, -- [1]
					},
				}, -- [3]
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["cooldownEdge"] = false,
			["config"] = {
			},
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["progressPrecision"] = 0,
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["use_petbattle"] = false,
				["race"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["text2Enabled"] = false,
			["glow"] = false,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["frameStrata"] = 1,
			["text2Font"] = "Friz Quadrata TT",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["auto"] = true,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["text1Enabled"] = true,
			["text1"] = "%s",
			["text1Containment"] = "INSIDE",
			["text2"] = "%p",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "Lava Burst",
			["stickyDuration"] = false,
			["alpha"] = 1,
			["width"] = 55,
			["desaturate"] = false,
			["uid"] = "Fag5oJUcWZF",
			["inverse"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Stormkeeper 2"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["text2"] = "%p",
			["cooldownSwipe"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_absorbMode"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["use_showgcd"] = false,
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["unit"] = "player",
						["unevent"] = "auto",
						["use_showOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["names"] = {
						},
						["realSpellName"] = "Stormkeeper",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["spellName"] = 191634,
						["use_genericShowOn"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 191634,
					},
				}, -- [1]
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"191634", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
						["event"] = "Health",
						["unit"] = "player",
						["type"] = "aura2",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["customTextUpdate"] = "update",
			["cooldownEdge"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["selfPoint"] = "CENTER",
			["parent"] = "Luxthos - Shaman Rotations",
			["desaturate"] = false,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["text1Enabled"] = true,
			["load"] = {
				["use_petbattle"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["talent"] = {
					["single"] = 20,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_talent2"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["config"] = {
			},
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["frameStrata"] = 1,
			["text1FontFlags"] = "OUTLINE",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["zoom"] = 0.33,
			["icon"] = true,
			["text2FontSize"] = 24,
			["auto"] = true,
			["text1"] = " ",
			["text1Containment"] = "INSIDE",
			["glow"] = false,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["internalVersion"] = 15,
			["id"] = "Stormkeeper 2",
			["xOffset"] = 58,
			["text2Enabled"] = false,
			["width"] = 55,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["uid"] = "bB(K0gQA)7V",
			["inverse"] = true,
			["stickyDuration"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Unleash Life - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text2"] = "%p",
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownSwipe"] = true,
			["authorOptions"] = {
			},
			["customTextUpdate"] = "update",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"73685", -- [1]
						},
						["use_power"] = false,
						["use_runesCount"] = true,
						["spellName"] = 73685,
						["use_debuffClass"] = false,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["runesCount"] = "2",
						["combineMatches"] = "showLowest",
						["useGroup_count"] = false,
						["use_absorbMode"] = true,
						["subeventPrefix"] = "SPELL",
						["powertype"] = 7,
						["use_showOn"] = true,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["useName"] = true,
						["power"] = "0",
						["unevent"] = "auto",
						["use_unit"] = true,
						["matchesShowOn"] = "showOnActive",
						["use_requirePowerType"] = false,
						["unit"] = "player",
						["realSpellName"] = "Unleash Life",
						["use_spellName"] = true,
						["spellIds"] = {
							73685, -- [1]
						},
						["use_tooltip"] = false,
						["use_specific_unit"] = false,
						["names"] = {
							"Unleash Life", -- [1]
						},
						["buffShowOn"] = "showOnActive",
						["rune"] = 0,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 73685,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["conditions"] = {
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["selfPoint"] = "CENTER",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["uid"] = "Y))1T7XyIwE",
			["desaturate"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["progressPrecision"] = 0,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 3,
					["multi"] = {
						[5] = true,
						[6] = true,
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["use_vehicleUi"] = false,
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["text1Font"] = "Friz Quadrata TT",
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text2Font"] = "Friz Quadrata TT",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["auto"] = true,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["text1FontFlags"] = "OUTLINE",
			["text1"] = " ",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["xOffset"] = 58,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["text2Enabled"] = false,
			["id"] = "Unleash Life - Active",
			["stickyDuration"] = false,
			["alpha"] = 1,
			["width"] = 55,
			["text1Containment"] = "INSIDE",
			["config"] = {
			},
			["inverse"] = false,
			["text1Enabled"] = true,
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["glow"] = true,
		},
		["Crash Lightning"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Enabled"] = true,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 58,
			["cooldownSwipe"] = true,
			["icon"] = true,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_genericShowOn"] = true,
						["duration"] = "1",
						["auranames"] = {
							"187878", -- [1]
						},
						["names"] = {
							"Bone Shield", -- [1]
						},
						["use_absorbMode"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["rune"] = 0,
						["powertype"] = 7,
						["use_runesCount"] = true,
						["spellName"] = 187874,
						["subeventSuffix"] = "_CAST_START",
						["useName"] = true,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["unevent"] = "auto",
						["type"] = "aura2",
						["event"] = "Cooldown Progress (Spell)",
						["power"] = "0",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["use_requirePowerType"] = false,
						["use_showOn"] = true,
						["realSpellName"] = "Crash Lightning",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["unit"] = "player",
						["runesCount"] = "2",
						["use_unit"] = true,
						["use_power"] = false,
						["matchesShowOn"] = "showOnActive",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 17364,
						["unit"] = "player",
					},
				}, -- [1]
				{
					["trigger"] = {
						["track"] = "auto",
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["use_showgcd"] = true,
						["spellName"] = 187874,
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Cooldown Progress (Spell)",
						["realSpellName"] = "Crash Lightning",
						["use_spellName"] = true,
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_absorbMode"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "ACShine",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [1]
			},
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["internalVersion"] = 15,
			["glow"] = false,
			["config"] = {
			},
			["stickyDuration"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["authorOptions"] = {
			},
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 3,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["desaturate"] = false,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["text2Enabled"] = false,
			["cooldownEdge"] = false,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["semver"] = "1.1.4",
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["useglowColor"] = false,
			["text1"] = " ",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["zoom"] = 0.33,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "Crash Lightning",
			["progressPrecision"] = 0,
			["alpha"] = 1,
			["width"] = 55,
			["text1Containment"] = "INSIDE",
			["uid"] = "8Skn4tLwpJ0",
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "custom",
					["colorR"] = 1,
					["scalex"] = 1,
					["duration_type"] = "seconds",
					["y"] = 0,
					["scaley"] = 1,
					["alpha"] = 0.3,
					["colorB"] = 1,
					["alphaType"] = "custom",
					["x"] = 0,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    if WeakAuras.GetActiveConditions(aura_env.id,aura_env.cloneId)[1] then\n        local angle = (progress * 2 * math.pi) - (math.pi / 2)\n        return start + (((math.sin(angle) + 1)/2) * delta)\n    end\nend",
					["colorA"] = 1,
					["rotate"] = 0,
					["duration"] = "0.7",
					["use_alpha"] = true,
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Surge of Power"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 17,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 15,
			["customText"] = "function()\n    if aura_env.state and aura_env.state.percentpower then\n        return aura_env.state.percentpower\n    end\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["glow"] = false,
			["cooldownSwipe"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["xOffset"] = -58,
			["text1Enabled"] = true,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = false,
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["text1Containment"] = "INSIDE",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "CENTER",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["cooldownEdge"] = false,
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 16,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"285514", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["powertype"] = 11,
						["subeventPrefix"] = "SPELL",
						["use_attackable"] = true,
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["use_showOn"] = true,
						["names"] = {
						},
						["event"] = "Cooldown Progress (Spell)",
						["spellName"] = 8042,
						["realSpellName"] = "Earth Shock",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["unit"] = "player",
						["use_powertype"] = true,
						["use_absorbMode"] = true,
						["duration"] = "1",
						["matchesShowOn"] = "showOnActive",
					},
					["untrigger"] = {
						["showOn"] = "showOnCooldown",
						["genericShowOn"] = "showAlways",
						["spellName"] = 188389,
					},
				}, -- [1]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(t)\n    if not t[1] then\n        return true\n    end\nend",
				["activeTriggerMode"] = 1,
			},
			["auto"] = true,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Font"] = "Friz Quadrata TT",
			["selfPoint"] = "CENTER",
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["uid"] = "chtJpE9RA98",
			["text2FontSize"] = 24,
			["stickyDuration"] = false,
			["progressPrecision"] = 0,
			["text1"] = " ",
			["frameStrata"] = 2,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.33,
			["semver"] = "1.1.4",
			["alpha"] = 1,
			["id"] = "Surge of Power",
			["text1Font"] = "Friz Quadrata TT",
			["text2Enabled"] = false,
			["width"] = 55,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["config"] = {
			},
			["inverse"] = false,
			["useGlowColor"] = false,
			["cooldownTextDisabled"] = true,
			["displayIcon"] = "",
			["cooldown"] = true,
			["text2"] = "%p",
		},
		["Fury of Air"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text2"] = "%p",
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownSwipe"] = true,
			["glow"] = false,
			["customTextUpdate"] = "update",
			["cooldownEdge"] = true,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["unit"] = "player",
						["use_genericShowOn"] = true,
						["subeventPrefix"] = "SPELL",
						["rune"] = 0,
						["use_power"] = false,
						["genericShowOn"] = "showAlways",
						["names"] = {
							"Bone Shield", -- [1]
						},
						["use_showgcd"] = true,
						["powertype"] = 7,
						["use_runesCount"] = true,
						["duration"] = "1",
						["spellName"] = 197211,
						["subeventSuffix"] = "_CAST_START",
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["unevent"] = "auto",
						["type"] = "status",
						["use_requirePowerType"] = false,
						["power"] = "0",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["use_showOn"] = true,
						["realSpellName"] = "Fury of Air",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["ownOnly"] = true,
						["runesCount"] = "2",
						["use_unit"] = true,
						["use_track"] = true,
						["use_absorbMode"] = true,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 17364,
						["unit"] = "player",
					},
				}, -- [1]
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"197211", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
						["event"] = "Health",
						["unit"] = "player",
						["type"] = "aura2",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = 1,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "insufficientResources",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								0.31764705882353, -- [1]
								0.40392156862745, -- [2]
								0.78039215686274, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [2]
			},
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["text1Enabled"] = true,
			["uid"] = "sicLPhO(N2t",
			["desaturate"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["authorOptions"] = {
			},
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 17,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["use_combat"] = true,
				["use_vehicleUi"] = false,
				["race"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["text2Enabled"] = false,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["progressPrecision"] = 0,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["auto"] = true,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["text1FontFlags"] = "OUTLINE",
			["text1"] = " ",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text1Containment"] = "INSIDE",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["text1Font"] = "Friz Quadrata TT",
			["id"] = "Fury of Air",
			["stickyDuration"] = false,
			["alpha"] = 1,
			["width"] = 55,
			["selfPoint"] = "CENTER",
			["config"] = {
			},
			["inverse"] = false,
			["internalVersion"] = 15,
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["xOffset"] = 116,
		},
		["Fury of Air - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text1FontFlags"] = "OUTLINE",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 116,
			["cooldownSwipe"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["customTextUpdate"] = "update",
			["cooldownEdge"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["conditions"] = {
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["icon"] = true,
			["text2Font"] = "Friz Quadrata TT",
			["uid"] = "xyr(ls3kPik",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["progressPrecision"] = 0,
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 17,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["text1Font"] = "Friz Quadrata TT",
			["text2Containment"] = "INSIDE",
			["glowType"] = "ACShine",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Containment"] = "INSIDE",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["auto"] = false,
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["zoom"] = 0.33,
			["text1"] = " ",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"197211", -- [1]
						},
						["matchesShowOn"] = "showOnActive",
						["event"] = "Health",
						["names"] = {
						},
						["spellIds"] = {
						},
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["useName"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["authorOptions"] = {
			},
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["alpha"] = 1,
			["id"] = "Fury of Air - Active",
			["desaturate"] = false,
			["text2Enabled"] = false,
			["width"] = 55,
			["stickyDuration"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["text1Enabled"] = true,
			["displayIcon"] = 136116,
			["cooldown"] = true,
			["glow"] = true,
		},
		["High Tide"] = {
			["text2Point"] = "BOTTOMRIGHT",
			["text1FontSize"] = 16,
			["parent"] = "Luxthos - Shaman Rotations",
			["zoom"] = 0.33,
			["customText"] = "function ()\n    return AbbreviateNumbers(aura_env.manacost )\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["text1Enabled"] = true,
			["cooldownSwipe"] = true,
			["authorOptions"] = {
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"288675", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["spellName"] = 197995,
						["useName"] = true,
						["type"] = "aura2",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["use_showOn"] = true,
						["auraspellids"] = {
							"288675", -- [1]
						},
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["realSpellName"] = "Wellspring",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_absorbMode"] = true,
						["unit"] = "player",
						["names"] = {
						},
						["duration"] = "1",
						["matchesShowOn"] = "showAlways",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 114051,
					},
				}, -- [1]
				{
					["trigger"] = {
						["custom_hide"] = "custom",
						["type"] = "custom",
						["events"] = "UNIT_SPELLCAST_SUCCEEDED ENCOUNTER_START PLAYER_TALENT_UPDATE",
						["subeventSuffix"] = "_CAST_START",
						["custom_type"] = "event",
						["custom"] = "function(event, ...)\n    local arg1, arg2, arg3 = ...;\n    \n    if event == \"ENCOUNTER_START\" then\n        if arg3 >= 14 and arg3 <= 17 then \n            aura_env.manacost = aura_env.startMana\n        end\n    end\n    \n    if event == \"PLAYER_TALENT_UPDATE\" then\n        local selected = select(10,GetTalentInfoBySpecialization(3,7,1))\n        if aura_env.selected == false then\n            if selected == true then\n                aura_env.manacost = aura_env.startMana\n            end\n        end\n        aura_env.selected = selected\n    end\n    \n    if event == \"SPELL_ACTIVATION_OVERLAY_GLOW_SHOW\" then\n        if arg1 == 1064 then\n            --possible fix for mana being off\n        end\n    end\n    \n    if event == \"UNIT_SPELLCAST_SUCCEEDED\" and arg1 == \"player\" then\n        if arg3 == 836 then\n            local data = WeakAuras.GetData(aura_env.id)\n            data.highTide = aura_env.startMana\n            aura_env.manacost = aura_env.startMana\n        end\n        \n        local costTable = GetSpellPowerCost(arg3);\n        if costTable then\n            local data = WeakAuras.GetData(aura_env.id)\n            \n            for _, costInfo in pairs(costTable) do\n                if (costInfo.type == UnitPowerType(\"player\")) then\n                    local spellCost = costInfo.cost\n                    if spellCost == 0 then\n                        spellCost = (costInfo.costPercent / 100 * aura_env.basemana)\n                    end\n                    aura_env.manacost = (aura_env.manacost - spellCost)\n                    break\n                end\n            end\n            if (aura_env.manacost <= aura_env.triggerMana) then\n                aura_env.manacost = aura_env.startMana + aura_env.manacost\n            end\n            data.highTide = aura_env.manacost\n        end\n    end\nend",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["useglowColor"] = false,
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["glow"] = false,
			["cooldownEdge"] = false,
			["desc"] = "Function by Niseko\nModified by Luxthos\nhttps://www.twitch.tv/luxthos",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "CENTER",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["config"] = {
			},
			["load"] = {
				["talent2"] = {
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_petbattle"] = false,
				["ingroup"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 19,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["width"] = 55,
			["alpha"] = 1,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["text1Containment"] = "INSIDE",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["frameStrata"] = 1,
			["auto"] = true,
			["text2FontSize"] = 13,
			["text2"] = "%s",
			["text1"] = "%c",
			["highTide"] = 10141,
			["text1FontFlags"] = "OUTLINE",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["stickyDuration"] = false,
			["id"] = "High Tide",
			["desaturate"] = false,
			["text2Enabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["text2Font"] = "Friz Quadrata TT",
			["uid"] = "Eh6BqOLaprR",
			["inverse"] = false,
			["xOffset"] = 116,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
							["property"] = "text1Color",
						}, -- [1]
					},
				}, -- [3]
			},
			["cooldown"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "local data = WeakAuras.GetData(aura_env.id)\naura_env.startMana = 40000\naura_env.triggerMana = 0\naura_env.manacost = data.highTide or aura_env.startMana\ndata.highTide = aura_env.manacost\naura_env.basemana = 20000\naura_env.selected = select(10,GetTalentInfoBySpecialization(3,7,1))",
					["do_custom"] = true,
				},
			},
		},
		["Fire Elemental 2"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["text2"] = "%p",
			["cooldownSwipe"] = true,
			["text1Enabled"] = true,
			["customTextUpdate"] = "update",
			["cooldownEdge"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["spellName"] = 198067,
						["unevent"] = "auto",
						["use_showOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Fire Elemental",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_absorbMode"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["spellName"] = 198067,
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom"] = "function()\n    if not WeakAuras.IsTriggerActive(\"Fire Elemental 2 - Active\") and not WeakAuras.IsTriggerActive(\"Primal Fire Elemental - Active\") and not WeakAuras.IsTriggerActive(\"Primal Storm Elemental - Active\") then\n        return true\n    end\nend\n",
						["subeventSuffix"] = "_CAST_START",
						["check"] = "update",
						["custom_type"] = "status",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["custom"] = "function()\n    if WeakAuras.IsTriggerActive(\"Fire Elemental 2 - Active\") or WeakAuras.IsTriggerActive(\"Primal Fire Elemental - Active\") or WeakAuras.IsTriggerActive(\"Primal Storm Elemental - Active\") then\n        return true\n    end\nend",
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = 1,
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["useglowColor"] = false,
			["parent"] = "Luxthos - Shaman Rotations",
			["stickyDuration"] = false,
			["text1Containment"] = "INSIDE",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["internalVersion"] = 15,
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = false,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
						[17] = true,
						[16] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_spellknown"] = false,
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["ingroup"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "CeSOzT4wrsk",
			["text1Font"] = "Friz Quadrata TT",
			["anchorFrameType"] = "SCREEN",
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 2,
			["selfPoint"] = "CENTER",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["icon"] = true,
			["text1FontFlags"] = "OUTLINE",
			["text2FontSize"] = 24,
			["auto"] = true,
			["text1"] = " ",
			["zoom"] = 0.33,
			["alpha"] = 1,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["glow"] = false,
			["id"] = "Fire Elemental 2",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text2Enabled"] = false,
			["width"] = 55,
			["xOffset"] = 116,
			["config"] = {
			},
			["inverse"] = true,
			["desaturate"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
		},
		["Earth Shock - Value"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 17,
			["authorOptions"] = {
			},
			["displayText"] = "%power",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["text1Enabled"] = true,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "Friz Quadrata TT",
			["text2FontFlags"] = "OUTLINE",
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 2,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["race"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["ingroup"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
			},
			["glowType"] = "buttonOverlay",
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "text",
			["text2FontSize"] = 24,
			["cooldownTextDisabled"] = true,
			["auto"] = true,
			["text2Enabled"] = false,
			["config"] = {
			},
			["displayIcon"] = 136026,
			["outline"] = "OUTLINE",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["customText"] = "function()\n    if aura_env.state and aura_env.state.maelstrom then\n        return aura_env.state.maelstrom\n    end\nend",
			["cooldownSwipe"] = true,
			["customTextUpdate"] = "update",
			["cooldownEdge"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["use_unit"] = true,
						["use_absorbMode"] = true,
						["event"] = "Power",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["powertype"] = 11,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["duration"] = "1",
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(t)\n    if not t[1] then\n        return true\n    end\nend",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 15,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["stickyDuration"] = false,
			["version"] = 15,
			["height"] = 55,
			["glow"] = false,
			["wordWrap"] = "WordWrap",
			["uid"] = "pimx2EvqZW(",
			["xOffset"] = 0,
			["fontSize"] = 16,
			["text2Containment"] = "INSIDE",
			["text1Containment"] = "INSIDE",
			["text1Font"] = "Friz Quadrata TT",
			["alpha"] = 1,
			["anchorFrameFrame"] = "WeakAuras:Earth Shock",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Font"] = "Friz Quadrata TT",
			["width"] = 55,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["automaticWidth"] = "Auto",
			["useglowColor"] = false,
			["text1"] = "%s",
			["anchorFrameParent"] = true,
			["semver"] = "1.1.4",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["justify"] = "CENTER",
			["text2"] = "%p",
			["id"] = "Earth Shock - Value",
			["text1Point"] = "CENTER",
			["frameStrata"] = 4,
			["anchorFrameType"] = "SELECTFRAME",
			["fixedWidth"] = 200,
			["zoom"] = 0,
			["inverse"] = false,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
				{
					["check"] = {
						["value"] = 0,
						["variable"] = "insufficientResources",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["value"] = 1,
						["variable"] = "insufficientResources",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["value"] = 1,
						["variable"] = "buffed",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [3]
			},
			["cooldown"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
		},
		["Elemental Blast"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["frameStrata"] = 1,
			["text2Font"] = "Friz Quadrata TT",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["cooldownSwipe"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["useglowColor"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = 1,
						["variable"] = "onCooldown",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "cooldownEdge",
						}, -- [2]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = 0,
						["variable"] = "onCooldown",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [2]
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["xOffset"] = 58,
			["config"] = {
			},
			["stickyDuration"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_petbattle"] = false,
				["use_combat"] = true,
				["faction"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_genericShowOn"] = true,
						["use_absorbMode"] = true,
						["use_unit"] = true,
						["runesCount"] = "2",
						["use_power"] = false,
						["genericShowOn"] = "showAlways",
						["names"] = {
							"Bone Shield", -- [1]
						},
						["use_showgcd"] = true,
						["powertype"] = 7,
						["use_runesCount"] = true,
						["duration"] = "1",
						["debuffType"] = "HELPFUL",
						["power"] = "0",
						["use_powertype"] = true,
						["spellName"] = 117014,
						["unevent"] = "auto",
						["type"] = "status",
						["use_requirePowerType"] = false,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["use_showOn"] = true,
						["realSpellName"] = "Elemental Blast",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["ownOnly"] = true,
						["rune"] = 0,
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 117014,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["cooldownEdge"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["auto"] = true,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["text2"] = "%p",
			["text1"] = "%s",
			["progressPrecision"] = 0,
			["text1FontFlags"] = "OUTLINE",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "Elemental Blast",
			["text1Containment"] = "INSIDE",
			["text2Enabled"] = false,
			["width"] = 55,
			["desaturate"] = false,
			["uid"] = "tuS9q6(HY6C",
			["inverse"] = true,
			["text1Enabled"] = true,
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["glow"] = false,
		},
		["Flame Shock - Cooldown"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["zoom"] = 0.33,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["cooldownSwipe"] = true,
			["cooldownEdge"] = true,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["useglowColor"] = false,
			["conditions"] = {
			},
			["text1Enabled"] = true,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["text2Font"] = "Friz Quadrata TT",
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["use_showgcd"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["unevent"] = "auto",
						["unit"] = "player",
						["spellName"] = 188389,
						["event"] = "Cooldown Progress (Spell)",
						["subeventSuffix"] = "_CAST_START",
						["realSpellName"] = "Flame Shock",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["use_absorbMode"] = true,
						["names"] = {
						},
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"188389", -- [1]
						},
						["event"] = "Health",
						["unit"] = "target",
						["unitExists"] = true,
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["config"] = {
			},
			["text1Containment"] = "INSIDE",
			["progressPrecision"] = 0,
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 2,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 55,
			["frameStrata"] = 2,
			["stickyDuration"] = false,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Enabled"] = false,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["auto"] = true,
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["text1FontFlags"] = "OUTLINE",
			["text1"] = " ",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["glow"] = false,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.1.4",
			["text1Font"] = "Friz Quadrata TT",
			["id"] = "Flame Shock - Cooldown",
			["desaturate"] = true,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["uid"] = "fLgVxzwC2yk",
			["inverse"] = true,
			["internalVersion"] = 15,
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["xOffset"] = -116,
		},
		["Overcharge"] = {
			["text2Point"] = "CENTER",
			["glow"] = false,
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownEdge"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["cooldownSwipe"] = true,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 2,
								["op"] = ">=",
								["value"] = "40",
								["variable"] = "power",
							}, -- [1]
							{
								["trigger"] = 3,
								["variable"] = "show",
								["value"] = 0,
							}, -- [2]
							{
								["trigger"] = 4,
								["variable"] = "onCooldown",
								["value"] = 1,
							}, -- [3]
							{
								["trigger"] = 1,
								["variable"] = "onCooldown",
								["value"] = 0,
							}, -- [4]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 2,
								["op"] = ">=",
								["value"] = "50",
								["variable"] = "power",
							}, -- [1]
							{
								["trigger"] = 3,
								["variable"] = "show",
								["value"] = 1,
							}, -- [2]
							{
								["trigger"] = 4,
								["variable"] = "onCooldown",
								["value"] = 1,
							}, -- [3]
							{
								["trigger"] = 1,
								["variable"] = "onCooldown",
								["value"] = 0,
							}, -- [4]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [3]
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["useglowColor"] = false,
			["internalVersion"] = 15,
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["preset"] = "alphaPulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["authorOptions"] = {
			},
			["config"] = {
			},
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["stickyDuration"] = false,
			["progressPrecision"] = 0,
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["width"] = 55,
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 12,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["faction"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
			},
			["frameStrata"] = 1,
			["desaturate"] = false,
			["text2Enabled"] = false,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"268429", -- [1]
						},
						["use_power"] = false,
						["use_showgcd"] = true,
						["use_runesCount"] = true,
						["spellName"] = 187837,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["runesCount"] = "2",
						["use_track"] = true,
						["use_absorbMode"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unitExists"] = true,
						["powertype"] = 7,
						["use_powertype"] = true,
						["debuffType"] = "HARMFUL",
						["rune"] = 0,
						["useName"] = true,
						["use_showOn"] = true,
						["unevent"] = "auto",
						["type"] = "status",
						["names"] = {
							"Bone Shield", -- [1]
						},
						["use_requirePowerType"] = false,
						["unit"] = "target",
						["realSpellName"] = "Lightning Bolt",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["duration"] = "1",
						["use_genericShowOn"] = true,
						["power"] = "0",
						["matchesShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 17364,
						["unit"] = "player",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["use_absorbMode"] = true,
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 11,
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_powertype"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "status",
						["talent"] = {
							["single"] = 17,
						},
						["use_absorbMode"] = true,
						["event"] = "Talent Known",
						["use_talent"] = true,
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["duration"] = "1",
						["unevent"] = "auto",
					},
					["untrigger"] = {
					},
				}, -- [3]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["use_absorbMode"] = true,
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["realSpellName"] = "Stormstrike",
						["use_spellName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["use_genericShowOn"] = true,
						["spellName"] = 17364,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [4]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["semver"] = "1.1.4",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["text2FontSize"] = 24,
			["text1FontFlags"] = "OUTLINE",
			["text1"] = " ",
			["zoom"] = 0.33,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2"] = "%p",
			["useGlowColor"] = false,
			["selfPoint"] = "CENTER",
			["id"] = "Overcharge",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["text1Containment"] = "INSIDE",
			["uid"] = "8tybFe1EVKL",
			["inverse"] = true,
			["text1Enabled"] = true,
			["displayIcon"] = 135847,
			["cooldown"] = true,
			["xOffset"] = 0,
		},
		["Crashing Storm"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text2"] = "%p",
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownSwipe"] = true,
			["glow"] = false,
			["customTextUpdate"] = "update",
			["cooldownEdge"] = true,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["use_absorbMode"] = true,
						["event"] = "Conditions",
						["unit"] = "player",
						["use_unit"] = true,
						["spellIds"] = {
						},
						["duration"] = "1",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["spellId"] = "187874",
						["use_power"] = false,
						["use_showgcd"] = false,
						["use_runesCount"] = true,
						["spellName"] = 197214,
						["subeventSuffix"] = "_CAST_SUCCESS",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Combat Log",
						["use_spellId"] = true,
						["use_sourceUnit"] = true,
						["runesCount"] = "2",
						["use_absorbMode"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["powertype"] = 7,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["use_showOn"] = true,
						["type"] = "event",
						["duration"] = "6",
						["unevent"] = "timed",
						["rune"] = 0,
						["ownOnly"] = true,
						["use_requirePowerType"] = false,
						["names"] = {
							"Bone Shield", -- [1]
						},
						["realSpellName"] = "Sundering",
						["use_spellName"] = false,
						["spellIds"] = {
							266201, -- [1]
						},
						["subeventPrefix"] = "SPELL",
						["power"] = "0",
						["use_genericShowOn"] = true,
						["sourceUnit"] = "player",
						["unit"] = "player",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 17364,
						["unit"] = "player",
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 2,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "ACShine",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [2]
			},
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["text1Enabled"] = true,
			["uid"] = "2d1EChA)MiN",
			["desaturate"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["authorOptions"] = {
			},
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 16,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["use_combat"] = true,
				["use_vehicleUi"] = false,
				["race"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["text2Enabled"] = false,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["progressPrecision"] = 0,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["auto"] = false,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["text1FontFlags"] = "OUTLINE",
			["text1"] = " ",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text1Containment"] = "INSIDE",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["text1Font"] = "Friz Quadrata TT",
			["id"] = "Crashing Storm",
			["stickyDuration"] = false,
			["alpha"] = 1,
			["width"] = 55,
			["selfPoint"] = "CENTER",
			["config"] = {
			},
			["inverse"] = true,
			["internalVersion"] = 15,
			["displayIcon"] = 136111,
			["cooldown"] = true,
			["xOffset"] = 116,
		},
		["Flametongue - Cooldown"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = -58,
			["cooldownSwipe"] = true,
			["authorOptions"] = {
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_genericShowOn"] = true,
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["runesCount"] = "2",
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["use_showgcd"] = true,
						["powertype"] = 7,
						["use_runesCount"] = true,
						["use_power"] = false,
						["spellName"] = 193796,
						["subeventSuffix"] = "_CAST_START",
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["unevent"] = "auto",
						["type"] = "status",
						["use_requirePowerType"] = false,
						["power"] = "0",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["use_showOn"] = true,
						["realSpellName"] = "Flametongue",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["use_absorbMode"] = true,
						["rune"] = 0,
						["unit"] = "player",
						["use_track"] = true,
						["names"] = {
							"Bone Shield", -- [1]
						},
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 17364,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = 1,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["cooldownEdge"] = true,
			["config"] = {
			},
			["desaturate"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["progressPrecision"] = 0,
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 3,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 55,
			["frameStrata"] = 2,
			["alpha"] = 1,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["text2Font"] = "Friz Quadrata TT",
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["auto"] = true,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["text2"] = "%p",
			["text1"] = " ",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Font"] = "Friz Quadrata TT",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.1.4",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "Flametongue - Cooldown",
			["text1Containment"] = "INSIDE",
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["stickyDuration"] = false,
			["uid"] = "cp8k3yE56wc",
			["inverse"] = true,
			["text1Enabled"] = true,
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["glow"] = false,
		},
		["Riptide"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text2"] = "%p",
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["cooldownSwipe"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["ownOnly"] = true,
						["use_showgcd"] = true,
						["use_runesCount"] = true,
						["spellName"] = 61295,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["rune"] = 0,
						["use_track"] = true,
						["use_absorbMode"] = true,
						["genericShowOn"] = "showAlways",
						["use_specific_unit"] = false,
						["powertype"] = 7,
						["use_powertype"] = true,
						["debuffType"] = "HARMFUL",
						["use_showOn"] = true,
						["type"] = "status",
						["duration"] = "1",
						["power"] = "0",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["use_requirePowerType"] = false,
						["unit"] = "target",
						["realSpellName"] = "Riptide",
						["use_spellName"] = true,
						["spellIds"] = {
							163057, -- [1]
						},
						["names"] = {
							"Flame Shock", -- [1]
						},
						["runesCount"] = "2",
						["use_unit"] = true,
						["use_genericShowOn"] = true,
						["use_power"] = false,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 61295,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "0",
						["variable"] = "charges",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "cooldownEdge",
						}, -- [1]
					},
				}, -- [2]
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["xOffset"] = -116,
			["text1Enabled"] = true,
			["config"] = {
			},
			["text1Containment"] = "INSIDE",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 2,
					["multi"] = {
						[5] = true,
						[6] = true,
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 55,
			["alpha"] = 1,
			["frameStrata"] = 1,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["progressPrecision"] = 0,
			["cooldownEdge"] = false,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["auto"] = true,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1"] = "%s",
			["text1Font"] = "Friz Quadrata TT",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["desaturate"] = false,
			["id"] = "Riptide",
			["stickyDuration"] = false,
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["selfPoint"] = "CENTER",
			["uid"] = "K(Sgt)xwFIA",
			["inverse"] = true,
			["text2Font"] = "Friz Quadrata TT",
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["glow"] = false,
		},
		["Flametongue - Active"] = {
			["text2Point"] = "CENTER",
			["semver"] = "1.1.4",
			["text1FontSize"] = 13,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["parent"] = "Luxthos - Shaman Rotations",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["cooldownSwipe"] = true,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "ACShine",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "<=",
						["value"] = "5",
						["variable"] = "expirationTime",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "buttonOverlay",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "buttonOverlay",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [4]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 3,
								["variable"] = "buffed",
								["value"] = 0,
							}, -- [1]
							{
								["trigger"] = 2,
								["variable"] = "onCooldown",
								["value"] = 0,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "buttonOverlay",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [5]
			},
			["customTextUpdate"] = "update",
			["cooldownEdge"] = false,
			["icon"] = true,
			["useglowColor"] = false,
			["text1Enabled"] = true,
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["text2Font"] = "Friz Quadrata TT",
			["config"] = {
			},
			["authorOptions"] = {
			},
			["stickyDuration"] = false,
			["progressPrecision"] = 0,
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["anchorFrameType"] = "SCREEN",
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 3,
					["multi"] = {
						[3] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["use_petbattle"] = false,
				["race"] = {
					["multi"] = {
					},
				},
			},
			["frameStrata"] = 1,
			["desaturate"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["unit"] = "player",
						["use_absorbMode"] = true,
						["auranames"] = {
							"194084", -- [1]
						},
						["names"] = {
							"Bone Shield", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["runesCount"] = "2",
						["powertype"] = 7,
						["use_runesCount"] = true,
						["spellName"] = 187874,
						["subeventSuffix"] = "_CAST_START",
						["useName"] = true,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["unevent"] = "auto",
						["type"] = "aura2",
						["event"] = "Cooldown Progress (Spell)",
						["power"] = "0",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["use_requirePowerType"] = false,
						["use_showOn"] = true,
						["realSpellName"] = "Crash Lightning",
						["use_spellName"] = true,
						["spellIds"] = {
							266201, -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["rune"] = 0,
						["use_unit"] = true,
						["use_power"] = false,
						["duration"] = "1",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 17364,
						["unit"] = "player",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["use_absorbMode"] = true,
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["realSpellName"] = "Flametongue",
						["use_spellName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["use_genericShowOn"] = true,
						["spellName"] = 193796,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"268429", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "target",
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["alpha"] = 1,
			["auto"] = true,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["text2"] = "%p",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2FontSize"] = 24,
			["cooldownTextDisabled"] = false,
			["text1"] = " ",
			["glow"] = false,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["zoom"] = 0.33,
			["useGlowColor"] = false,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["id"] = "Flametongue - Active",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Enabled"] = false,
			["width"] = 55,
			["text1Containment"] = "INSIDE",
			["uid"] = "m)nXrd03vPq",
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["xOffset"] = -58,
		},
		["Ascendance (Elemental) 2 - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["zoom"] = 0.33,
			["cooldownSwipe"] = true,
			["authorOptions"] = {
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["parent"] = "Luxthos - Shaman Rotations",
			["text1Enabled"] = true,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["glow"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = false,
			["stickyDuration"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"114050", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["spellName"] = 114051,
						["unevent"] = "auto",
						["use_showOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["type"] = "aura2",
						["realSpellName"] = "Ascendance",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["use_absorbMode"] = true,
						["unit"] = "player",
						["names"] = {
						},
						["duration"] = "1",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 114051,
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["load"] = {
				["use_petbattle"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["talent"] = {
					["single"] = 21,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_talent2"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["config"] = {
			},
			["text1Font"] = "Friz Quadrata TT",
			["anchorFrameType"] = "SCREEN",
			["text2Containment"] = "INSIDE",
			["glowType"] = "ACShine",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["alpha"] = 1,
			["frameStrata"] = 1,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["text1FontFlags"] = "OUTLINE",
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["auto"] = true,
			["text1"] = " ",
			["xOffset"] = 58,
			["internalVersion"] = 15,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["cooldownEdge"] = false,
			["id"] = "Ascendance (Elemental) 2 - Active",
			["text2Font"] = "Friz Quadrata TT",
			["text2Enabled"] = false,
			["width"] = 55,
			["text1Containment"] = "INSIDE",
			["uid"] = "49Ar3MJlR97",
			["inverse"] = false,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["conditions"] = {
			},
			["cooldown"] = true,
			["icon"] = true,
		},
		["Primal Fire Elemental - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["authorOptions"] = {
			},
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["cooldownSwipe"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
			["customTextUpdate"] = "update",
			["cooldownEdge"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.spell = 198067\naura_env.texture = 651081\naura_env.primal = IsPlayerSpell(118291)\naura_env.pet = false",
					["do_custom"] = true,
				},
			},
			["useglowColor"] = false,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["text1Enabled"] = true,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_absorbMode"] = true,
						["type"] = "event",
						["spellId"] = "118291",
						["unevent"] = "timed",
						["subeventPrefix"] = "SPELL",
						["duration"] = "30",
						["event"] = "Combat Log",
						["unit"] = "player",
						["subeventSuffix"] = "_SUMMON",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["use_unit"] = true,
						["names"] = {
						},
						["sourceUnit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["use_totemName"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["use_absorbMode"] = true,
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["spellName"] = 198067,
						["spellIds"] = {
						},
						["custom_hide"] = "timed",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "custom",
						["realSpellName"] = "Fire Elemental",
						["unevent"] = "auto",
						["use_showOn"] = true,
						["custom"] = "function()\n    aura_env.petExists = UnitExists(\"pet\")\n    if aura_env.petExists and select(6, strsplit(\"-\", UnitGUID(\"pet\"))) == \"61029\" then\n        return true\n    end\nend",
						["event"] = "Health",
						["totemName"] = "Greater Fire Elemental",
						["customDuration"] = "",
						["use_spellName"] = true,
						["events"] = "PLAYER_TOTEM_UPDATE",
						["custom_type"] = "status",
						["check"] = "update",
						["duration"] = "1",
						["use_genericShowOn"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["custom"] = "function()\n    return not aura_env.petExists\nend",
						["spellName"] = 198067,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = 1,
			},
			["text1Containment"] = "INSIDE",
			["stickyDuration"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["config"] = {
			},
			["load"] = {
				["use_petbattle"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 17,
					["multi"] = {
						[17] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
			},
			["desaturate"] = false,
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["text2Containment"] = "INSIDE",
			["glowType"] = "ACShine",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Font"] = "Friz Quadrata TT",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["icon"] = true,
			["auto"] = false,
			["text2FontSize"] = 24,
			["cooldownTextDisabled"] = false,
			["text1"] = " ",
			["text2Font"] = "Friz Quadrata TT",
			["zoom"] = 0.33,
			["text2"] = "%p",
			["semver"] = "1.1.4",
			["internalVersion"] = 15,
			["id"] = "Primal Fire Elemental - Active",
			["glow"] = true,
			["alpha"] = 1,
			["width"] = 55,
			["text2Enabled"] = false,
			["uid"] = "5A)r4daaF(3",
			["inverse"] = false,
			["xOffset"] = 116,
			["displayIcon"] = 135790,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Cloudburst Totem - Active"] = {
			["text2Point"] = "CENTER",
			["zoom"] = 0.33,
			["text1FontSize"] = 17,
			["xOffset"] = 0,
			["text2Font"] = "Friz Quadrata TT",
			["customText"] = "function()\n    if not WeakAuras.IsOptionsOpen() then\n        if WeakAuras.triggerState[aura_env.id][2][\"\"] then\n            if type(WeakAuras.triggerState[aura_env.id][2][\"\"].tooltip2) == \"number\" then\n                return AbbreviateNumbers(WeakAuras.triggerState[aura_env.id][2][\"\"].tooltip2)\n            end\n        end\n    end\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["cooldownSwipe"] = true,
			["useglowColor"] = false,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["use_totemName"] = true,
						["event"] = "Totem",
						["unit"] = "player",
						["use_absorbMode"] = true,
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["use_unit"] = true,
						["totemName"] = "157153",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["auranames"] = {
							"157504", -- [1]
						},
						["duration"] = "1",
						["names"] = {
						},
						["use_tooltipValue"] = true,
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["fetchTooltip"] = true,
						["event"] = "Totem",
						["totemName"] = "157153",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["use_totemName"] = true,
						["tooltipValueNumber"] = 2,
						["use_unit"] = true,
						["use_absorbMode"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "ACShine",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [1]
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["stickyDuration"] = false,
			["uid"] = "lh5)BRvfa)E",
			["desaturate"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "CENTER",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 18,
					["multi"] = {
						[5] = true,
						[6] = true,
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["role"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["glow"] = false,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["semver"] = "1.1.4",
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["selfPoint"] = "CENTER",
			["text1"] = "%c",
			["text1Enabled"] = true,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["text1Font"] = "Friz Quadrata TT",
			["id"] = "Cloudburst Totem - Active",
			["progressPrecision"] = 0,
			["text2Enabled"] = false,
			["width"] = 55,
			["text1Containment"] = "INSIDE",
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 971076,
			["cooldown"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
		},
		["Luxthos - Shaman Rotations"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"Riptide", -- [1]
				"Tidal Waves", -- [2]
				"Cloudburst Totem - Active", -- [3]
				"Healing Stream Totem", -- [4]
				"Unleash Life - Active", -- [5]
				"Unleash Life", -- [6]
				"Undulation", -- [7]
				"Earth Shield (Restoration)", -- [8]
				"Healing Tide Totem 2 - Active", -- [9]
				"Healing Tide Totem 2", -- [10]
				"Ascendance (Restauration) - Active", -- [11]
				"Ascendance (Restauration)", -- [12]
				"Wellspring", -- [13]
				"High Tide", -- [14]
				"Flame Shock", -- [15]
				"Flame Shock - Cooldown", -- [16]
				"Flame Shock - Cooldown 2", -- [17]
				"Earth Shock - Value", -- [18]
				"Earth Shock", -- [19]
				"Surge of Power", -- [20]
				"Lava Burst", -- [21]
				"Lava Surge - Active", -- [22]
				"Elemental Blast", -- [23]
				"Icefury - Active", -- [24]
				"Icefury", -- [25]
				"Stormkeeper 2 - Active", -- [26]
				"Stormkeeper 2", -- [27]
				"Ascendance (Elemental) 2 - Active", -- [28]
				"Ascendance (Elemental) 2", -- [29]
				"Unlimited Power 2 - Active", -- [30]
				"Primal Storm Elemental - Active", -- [31]
				"Primal Fire Elemental - Active", -- [32]
				"Fire Elemental 2 - Active", -- [33]
				"Fire Elemental 2", -- [34]
				"Stormstrike", -- [35]
				"Flametongue - Active", -- [36]
				"Flametongue - Cooldown", -- [37]
				"Frostbrand - Hailstorm", -- [38]
				"Searing Assault", -- [39]
				"Overcharge", -- [40]
				"Crash Lightning", -- [41]
				"Sundering", -- [42]
				"Fury of Air - Active", -- [43]
				"Fury of Air", -- [44]
				"Crashing Storm", -- [45]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["scale"] = 1,
			["authorOptions"] = {
			},
			["border"] = false,
			["borderEdge"] = "None",
			["regionType"] = "group",
			["borderSize"] = 16,
			["anchorFrameType"] = "SCREEN",
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["yOffset"] = -180,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["unit"] = "player",
						["spellIds"] = {
						},
						["buffShowOn"] = "showOnActive",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["anchorPoint"] = "CENTER",
			["internalVersion"] = 15,
			["semver"] = "1.1.4",
			["selfPoint"] = "BOTTOMLEFT",
			["id"] = "Luxthos - Shaman Rotations",
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["desc"] = "Patch 8.1 - Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["borderOffset"] = 5,
			["uid"] = "R620I5Z64sq",
			["version"] = 15,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["borderInset"] = 11,
			["conditions"] = {
			},
			["load"] = {
				["talent2"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = "true",
				["race"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["config"] = {
			},
		},
		["Tidal Waves"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text2"] = "%p",
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = -58,
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_genericShowOn"] = true,
						["matchesShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["auranames"] = {
							"53390", -- [1]
						},
						["rune"] = 0,
						["use_absorbMode"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unit"] = "player",
						["powertype"] = 7,
						["use_runesCount"] = true,
						["debuffType"] = "HELPFUL",
						["power"] = "0",
						["type"] = "aura2",
						["use_powertype"] = true,
						["spellName"] = 5394,
						["power_operator"] = ">",
						["useName"] = true,
						["use_requirePowerType"] = false,
						["unevent"] = "auto",
						["use_showOn"] = true,
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["subeventSuffix"] = "_CAST_START",
						["realSpellName"] = "Healing Stream Totem",
						["use_spellName"] = true,
						["spellIds"] = {
							51564, -- [1]
						},
						["names"] = {
							"Tidal Waves", -- [1]
						},
						["runesCount"] = "2",
						["use_specific_unit"] = false,
						["use_power"] = false,
						["duration"] = "1",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 5394,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = 0,
						["variable"] = "buffed",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "2",
						["variable"] = "stacks",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "ACShine",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 0,
					},
					["changes"] = {
						{
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [3]
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["selfPoint"] = "CENTER",
			["text2Font"] = "Friz Quadrata TT",
			["config"] = {
			},
			["text1Containment"] = "INSIDE",
			["progressPrecision"] = 0,
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 2,
					["multi"] = {
						[5] = true,
						[6] = true,
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["race"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
			},
			["width"] = 55,
			["alpha"] = 1,
			["desaturate"] = false,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Font"] = "Friz Quadrata TT",
			["text2Enabled"] = false,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["semver"] = "1.1.4",
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["icon"] = true,
			["text1"] = "%s",
			["authorOptions"] = {
			},
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glow"] = false,
			["id"] = "Tidal Waves",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["stickyDuration"] = false,
			["uid"] = "Rqi)Q1vVEHW",
			["inverse"] = false,
			["text1Enabled"] = true,
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Ascendance (Restauration)"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownTextDisabled"] = false,
			["cooldownSwipe"] = true,
			["selfPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["cooldownEdge"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["text1Enabled"] = true,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["icon"] = true,
			["internalVersion"] = 15,
			["triggers"] = {
				{
					["trigger"] = {
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["duration"] = "1",
						["unevent"] = "auto",
						["use_showOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Ascendance",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["use_absorbMode"] = true,
						["names"] = {
						},
						["use_track"] = true,
						["spellName"] = 114051,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 114051,
					},
				}, -- [1]
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"114050", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["desaturate"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["load"] = {
				["talent2"] = {
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["talent"] = {
					["single"] = 21,
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_vehicleUi"] = false,
				["use_talent"] = true,
				["use_class"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "3GpKc1K0QCC",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["width"] = 55,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["alpha"] = 1,
			["text1FontFlags"] = "OUTLINE",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["text2"] = "%p",
			["frameStrata"] = 1,
			["text2FontSize"] = 24,
			["auto"] = true,
			["text1"] = " ",
			["text2Font"] = "Friz Quadrata TT",
			["xOffset"] = 116,
			["zoom"] = 0.33,
			["semver"] = "1.1.4",
			["glow"] = false,
			["id"] = "Ascendance (Restauration)",
			["text1Containment"] = "INSIDE",
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["inverse"] = true,
			["stickyDuration"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
		},
		["Fire Elemental 2 - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["xOffset"] = 116,
			["text2"] = "%p",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["text1Enabled"] = true,
			["cooldownSwipe"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.texture = 135790",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["use_totemName"] = true,
						["subeventPrefix"] = "SPELL",
						["use_absorbMode"] = true,
						["spellName"] = 198067,
						["debuffType"] = "HELPFUL",
						["spellIds"] = {
						},
						["custom_hide"] = "timed",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "custom",
						["realSpellName"] = "Fire Elemental",
						["unevent"] = "auto",
						["use_showOn"] = true,
						["names"] = {
						},
						["event"] = "Health",
						["totemName"] = "Greater Fire Elemental",
						["customDuration"] = "function()\n    if aura_env.startTime then\n        return aura_env.duration, aura_env.startTime + aura_env.duration\n    end\nend",
						["use_spellName"] = true,
						["events"] = "PLAYER_TOTEM_UPDATE",
						["custom_type"] = "status",
						["check"] = "event",
						["custom"] = "function(event, arg1)\n    if event == \"PLAYER_TOTEM_UPDATE\" and arg1 then\n        local haveTotem, name, startTime, duration, icon = GetTotemInfo(arg1)\n        if haveTotem and icon == aura_env.texture then\n            aura_env.haveTotem, aura_env.name, aura_env.startTime, aura_env.duration, aura_env.icon = haveTotem, name, startTime, duration, icon\n            aura_env.index = arg1\n            return true\n        elseif aura_env.index == arg1 then\n            aura_env.index = 0\n            aura_env.startTime, aura_env.duration = nil, nil\n        end\n    end\nend",
						["use_genericShowOn"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["custom"] = "function()\n    return aura_env.index == 0\nend",
						["spellName"] = 198067,
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["authorOptions"] = {
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["cooldownEdge"] = false,
			["desaturate"] = false,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["uid"] = "Ca8lC2y11SN",
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 16,
					["multi"] = {
						[16] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["text2Containment"] = "INSIDE",
			["glowType"] = "ACShine",
			["text1Font"] = "Friz Quadrata TT",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Font"] = "Friz Quadrata TT",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["glow"] = true,
			["auto"] = false,
			["text2FontSize"] = 24,
			["zoom"] = 0.33,
			["text1"] = " ",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon"] = true,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["text1FontFlags"] = "OUTLINE",
			["id"] = "Fire Elemental 2 - Active",
			["text1Containment"] = "INSIDE",
			["text2Enabled"] = false,
			["width"] = 55,
			["stickyDuration"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["displayIcon"] = 135790,
			["cooldown"] = true,
			["useglowColor"] = false,
		},
		["Earth Shield (Restoration)"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 17,
			["parent"] = "Luxthos - Shaman Rotations",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Enabled"] = true,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["cooldownSwipe"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"974", -- [1]
						},
						["use_power"] = false,
						["use_runesCount"] = true,
						["spellName"] = 73685,
						["use_debuffClass"] = false,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["rune"] = 0,
						["combineMatches"] = "showLowest",
						["useGroup_count"] = false,
						["use_absorbMode"] = true,
						["subeventPrefix"] = "SPELL",
						["use_tooltip"] = false,
						["powertype"] = 7,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["use_showOn"] = true,
						["useName"] = true,
						["type"] = "aura2",
						["power"] = "0",
						["use_unit"] = true,
						["names"] = {
							"Undulation", -- [1]
						},
						["use_requirePowerType"] = false,
						["matchesShowOn"] = "showAlways",
						["realSpellName"] = "Unleash Life",
						["use_spellName"] = true,
						["spellIds"] = {
							216251, -- [1]
						},
						["unit"] = "group",
						["unevent"] = "auto",
						["runesCount"] = "2",
						["buffShowOn"] = "showOnActive",
						["use_specific_unit"] = false,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 73685,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["customTextUpdate"] = "update",
			["cooldownEdge"] = false,
			["icon"] = true,
			["useglowColor"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "0",
						["variable"] = "unitCount",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["text2Font"] = "Friz Quadrata TT",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["text1Point"] = "CENTER",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["load"] = {
				["use_petbattle"] = false,
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 6,
					["multi"] = {
						[5] = true,
						[6] = true,
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_talent2"] = true,
				["use_name"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 3,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["alpha"] = 1,
			["glow"] = false,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["auto"] = true,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text1"] = "%s",
			["text1Containment"] = "INSIDE",
			["text2"] = "%p",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.1.4",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "Earth Shield (Restoration)",
			["xOffset"] = 58,
			["text2Enabled"] = false,
			["width"] = 55,
			["stickyDuration"] = false,
			["uid"] = "9LjdoW2f2lw",
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
		},
		["Stormkeeper 2 - Active"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["text2"] = "%p",
			["cooldownSwipe"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["customTextUpdate"] = "update",
			["cooldownEdge"] = false,
			["icon"] = true,
			["useglowColor"] = false,
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"191634", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["spellName"] = 191634,
						["unevent"] = "auto",
						["use_showOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["type"] = "aura2",
						["realSpellName"] = "Stormkeeper",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["use_absorbMode"] = true,
						["unit"] = "player",
						["names"] = {
						},
						["duration"] = "1",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 191634,
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["desaturate"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["cooldownTextDisabled"] = false,
			["load"] = {
				["use_petbattle"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["talent"] = {
					["single"] = 20,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_talent2"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["use_vehicleUi"] = false,
				["race"] = {
					["multi"] = {
					},
				},
			},
			["config"] = {
			},
			["text1Font"] = "Friz Quadrata TT",
			["width"] = 55,
			["text2Containment"] = "INSIDE",
			["glowType"] = "ACShine",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["text1Containment"] = "INSIDE",
			["text1FontFlags"] = "OUTLINE",
			["text2FontSize"] = 24,
			["auto"] = true,
			["text1"] = "%s",
			["alpha"] = 1,
			["xOffset"] = 58,
			["zoom"] = 0.33,
			["semver"] = "1.1.4",
			["internalVersion"] = 15,
			["id"] = "Stormkeeper 2 - Active",
			["glow"] = true,
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["text1Enabled"] = true,
			["uid"] = "WkGrQ(JRgI(",
			["inverse"] = false,
			["stickyDuration"] = false,
			["conditions"] = {
			},
			["cooldown"] = true,
			["parent"] = "Luxthos - Shaman Rotations",
		},
		["Healing Stream Totem"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text2"] = "%p",
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["cooldownSwipe"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["ownOnly"] = true,
						["use_showgcd"] = true,
						["use_runesCount"] = true,
						["spellName"] = 5394,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["runesCount"] = "2",
						["use_track"] = true,
						["use_absorbMode"] = true,
						["genericShowOn"] = "showAlways",
						["use_specific_unit"] = false,
						["powertype"] = 7,
						["use_powertype"] = true,
						["debuffType"] = "HARMFUL",
						["use_showOn"] = true,
						["type"] = "status",
						["power"] = "0",
						["unevent"] = "auto",
						["duration"] = "1",
						["unit"] = "target",
						["use_requirePowerType"] = false,
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Healing Stream Totem",
						["use_spellName"] = true,
						["spellIds"] = {
							163057, -- [1]
						},
						["names"] = {
							"Flame Shock", -- [1]
						},
						["use_genericShowOn"] = true,
						["rune"] = 0,
						["use_power"] = false,
						["use_unit"] = true,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 73920,
						["unit"] = "player",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["use_totemName"] = true,
						["event"] = "Totem",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["totemName"] = "5394",
						["use_absorbMode"] = true,
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "0",
						["variable"] = "charges",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = "ACShine",
							["property"] = "glowType",
						}, -- [2]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "cooldownEdge",
						}, -- [1]
					},
				}, -- [3]
			},
			["internalVersion"] = 15,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["xOffset"] = 0,
			["text1Enabled"] = true,
			["config"] = {
			},
			["text1Containment"] = "INSIDE",
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 2,
					["multi"] = {
						[5] = true,
						[6] = true,
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["race"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
			},
			["width"] = 55,
			["alpha"] = 1,
			["frameStrata"] = 2,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["progressPrecision"] = 0,
			["cooldownEdge"] = false,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["auto"] = true,
			["zoom"] = 0.33,
			["text2FontSize"] = 24,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1"] = "%s",
			["text1Font"] = "Friz Quadrata TT",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["desaturate"] = false,
			["id"] = "Healing Stream Totem",
			["stickyDuration"] = false,
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["selfPoint"] = "CENTER",
			["uid"] = "91BdBbJpWYM",
			["inverse"] = true,
			["text2Font"] = "Friz Quadrata TT",
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["glow"] = false,
		},
		["Unleash Life"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["zoom"] = 0.33,
			["useglowColor"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 58,
			["cooldownSwipe"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["use_genericShowOn"] = true,
						["use_showgcd"] = true,
						["use_runesCount"] = true,
						["spellName"] = 73685,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["runesCount"] = "2",
						["use_track"] = true,
						["use_absorbMode"] = true,
						["genericShowOn"] = "showAlways",
						["use_specific_unit"] = false,
						["powertype"] = 7,
						["use_powertype"] = true,
						["debuffType"] = "HARMFUL",
						["use_showOn"] = true,
						["type"] = "status",
						["subeventPrefix"] = "SPELL",
						["power"] = "0",
						["names"] = {
							"Flame Shock", -- [1]
						},
						["ownOnly"] = true,
						["use_requirePowerType"] = false,
						["unevent"] = "auto",
						["realSpellName"] = "Unleash Life",
						["use_spellName"] = true,
						["spellIds"] = {
							163057, -- [1]
						},
						["use_power"] = false,
						["rune"] = 0,
						["duration"] = "1",
						["use_unit"] = true,
						["unit"] = "target",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 73685,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "cooldownEdge",
						}, -- [2]
					},
				}, -- [1]
			},
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["cooldownEdge"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["uid"] = "XyaNjZw5vtD",
			["stickyDuration"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["internalVersion"] = 15,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 3,
					["multi"] = {
						[5] = true,
						[6] = true,
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["use_vehicleUi"] = false,
			},
			["width"] = 55,
			["alpha"] = 1,
			["frameStrata"] = 3,
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["authorOptions"] = {
			},
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["auto"] = true,
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1"] = " ",
			["text1Font"] = "Friz Quadrata TT",
			["desaturate"] = false,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["icon"] = true,
			["id"] = "Unleash Life",
			["progressPrecision"] = 0,
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["text1Containment"] = "INSIDE",
			["config"] = {
			},
			["inverse"] = true,
			["text1Enabled"] = true,
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["glow"] = false,
		},
		["Undulation"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 13,
			["parent"] = "Luxthos - Shaman Rotations",
			["text1FontFlags"] = "OUTLINE",
			["text2Font"] = "Friz Quadrata TT",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["cooldownSwipe"] = true,
			["icon"] = true,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Hkc9ktj4X/15",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [2]
			},
			["text1Enabled"] = true,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["internalVersion"] = 15,
			["xOffset"] = 58,
			["config"] = {
			},
			["stickyDuration"] = false,
			["progressPrecision"] = 0,
			["text1Point"] = "BOTTOMRIGHT",
			["version"] = 15,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 55,
			["cooldownEdge"] = false,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 2,
					["multi"] = {
						[5] = true,
						[6] = true,
					},
				},
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_name"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["use_vehicleUi"] = false,
			},
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text2Containment"] = "INSIDE",
			["glowType"] = "buttonOverlay",
			["text1Font"] = "Friz Quadrata TT",
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"216251", -- [1]
						},
						["use_power"] = false,
						["use_runesCount"] = true,
						["spellName"] = 73685,
						["use_debuffClass"] = false,
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">",
						["runesCount_operator"] = ">=",
						["event"] = "Cooldown Progress (Spell)",
						["runesCount"] = "2",
						["combineMatches"] = "showLowest",
						["useGroup_count"] = false,
						["use_absorbMode"] = true,
						["subeventPrefix"] = "SPELL",
						["powertype"] = 7,
						["use_showOn"] = true,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["useName"] = true,
						["power"] = "0",
						["unevent"] = "auto",
						["use_unit"] = true,
						["matchesShowOn"] = "showAlways",
						["use_requirePowerType"] = false,
						["unit"] = "player",
						["realSpellName"] = "Unleash Life",
						["use_spellName"] = true,
						["spellIds"] = {
							216251, -- [1]
						},
						["use_tooltip"] = false,
						["use_specific_unit"] = false,
						["names"] = {
							"Undulation", -- [1]
						},
						["buffShowOn"] = "showOnActive",
						["rune"] = 0,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 73685,
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["glow"] = false,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["auto"] = true,
			["text2"] = "%p",
			["text2FontSize"] = 24,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1"] = " ",
			["frameStrata"] = 3,
			["zoom"] = 0.33,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.1.4",
			["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
			["id"] = "Undulation",
			["text1Containment"] = "INSIDE",
			["text2Enabled"] = false,
			["width"] = 55,
			["desaturate"] = false,
			["uid"] = "wKRIMiZ9Mgs",
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["displayIcon"] = 458717,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
	},
	["registered"] = {
	},
	["login_squelch_time"] = 10,
	["frame"] = {
		["xOffset"] = -776.0185546875,
		["width"] = 830,
		["height"] = 665.000061035156,
		["yOffset"] = -159.507873535156,
	},
	["editor_theme"] = "Monokai",
}
