do local _ = {
  admins = {},
  disabled_channels = {},
  enabled_plugins = {
    "MBC2_BNHR",
    "MBC2_PLUGINS",
    "MBC2_MGCHS",
    "MBC2_REPLAY",
    "MBC2_TOOLS",
    "MBC2_ME",
    "MBC2_SUPER",
    "MBC2_ADD_REPLAY"
  },
  info_text = "Tele @Cr7rC v1\nAn advanced administration bot based on TG-CLI written in Lua\n\nAdmins\n@Cr7rC [Developer]\n\nSpecial thanks to\nawkward_potato\nSiyanew\ntopkecleon\nVamptacus\n\nOur channels\nhttps://telegram.me/C_R_4",
  moderation = {
    data = "./data/moderation.json"
  },
  sudo_users = {
    60210262,
    164641988
  }
}
return _
end