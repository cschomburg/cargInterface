for _, cvars in pairs{
	'deselectOnClick 1 GAMEFIELD_DESELECT_TEXT',
	'autoLootDefault 1 AUTO_LOOT_DEFAULT_TEXT',
	'autoSelfCast 1 AUTO_SELF_CAST_TEXT',
	'autoDismountFlying 1 AUTO_DISMOUNT_FLYING_TEXT',
	'showClock 0 SHOW_CLOCK',
	'threatShowNumeric 1 SHOW_NUMERIC_THREAT',
	'previewTalents 1 PREVIEW_TALENT_CHANGES',
	'showLootSpam 1 SHOW_LOOT_SPAM',
	'questFadingDisable 1 SHOW_QUEST_FADING_TEXT',
	'profanityFilter 0 PROFANITY_FILTER',
	'chatBubbles 0 CHAT_BUBBLES_TEXT',
	'chatBubblesParty 0 PARTY_CHAT_BUBBLES_TEXT',
	'spamFilter 0 DISABLE_SPAM_FILTER',
	'removeChatDelay 1 REMOVE_CHAT_DELAY_TEXT',
	'guildMemberNotify 1 GUILDMEMBER_ALERT',
	'guildRecruitmentChannel 0 AUTO_JOIN_GUILD_CHANNEL',
	'UnitNameOwn 0 UNIT_NAME_OWN',
	'CombatDamage 0 SHOW_DAMAGE_TEXT',
	'CombatHealing 1 SHOW_COMBAT_HEALING',
	'showArenaEnemyFrames 0 SHOW_ARENA_ENEMY_FRAMES_TEXT',
	'cameraDistanceMax 20',
	'cameraDistanceMaxFactor 4',
	'scriptErrors 1 SHOW_LUA_ERRORS',

	'Sound_EnableAllSound 1 ENABLE_SOUND',

	'scriptProfile 1',
	'timingMethod 0',
	'showToolsUI 0',
	'cameraDistanceMoveSpeed 8.33',
	'cameraViewBlendStyle 1',
	'synchronizeSettings 0',
	'processAffinityMask 255',

	'timeMgrAlarmEnabled 0',

} do
	SetCVar((" "):split(cvars))
end
