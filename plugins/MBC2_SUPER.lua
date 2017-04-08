local function modadd(msg)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '🕹¦ *You are not bot admin* ⚙️'
else
return '🕹¦ _أنـت لـسـت الـمـطـور _ 🚧'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.chat_id_)] then
if not lang then
   return '🕹¦ *Group is already added* ✅'
else
 return '🕹¦ المجموعه بالتأكيد ✅ تم تفعيلها'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.chat_id_)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      settings = {
          lock_link = 'yes',
          lock_tag = 'yes',
          lock_spam = 'yes',
          lock_webpage = 'no',
          lock_markdown = 'no',
          flood = 'yes',
          lock_bots = 'yes',
          welcome = 'yes'
          },
   mutes = {
                  mute_fwd = 'no',
                  mute_audio = 'no',
                  mute_video = 'no',
                  mute_contact = 'no',
                  mute_text = 'no',
                  mute_photos = 'no',
                  mute_gif = 'no',
                  mute_loc = 'no',
                  mute_doc = 'no',
                  mute_sticker = 'no',
                  mute_voice = 'no',
                   mute_all = 'no'
          }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.chat_id_)] = msg.chat_id_
      save_data(_config.moderation.data, data)
    if not lang then
       return '🕹¦ *Group has been added* ✅'
else
return '🕹¦ ✅ تـم تـفـعـيـل الـمـجـمـوعـه ✅'
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '🕹¦ *You are not bot admin* ⚙️'
   else
        return '🕹¦ _أنـت لـسـت الـمـطـور _ 🚧'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.chat_id_
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return '💡¦ *Group is not added* ⚙️'
else
    return '🕹¦ المجموعه بالتأكيد ✅ تم تعطيلها'
   end
  end

  data[tostring(msg.chat_id_)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.chat_id_)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '💡¦ *Group has been removed* ⚙️'
 else
 return '🕹¦ 👁‍🗨تـم تـعـطـيـل الـمـجـمـوعـه👁‍🗨'
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.chat_id_)]['filterlist'] then
    data[tostring(msg.chat_id_)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.chat_id_)]['filterlist'][(word)] then
   if not lang then
         return "💡¦ *Word* _"..word.."_💡¦ *is already filtered ☑️*"
            else
 return  "🕹¦_ الكلمه_ *"..word.."* _هي بالتأكيد من قائمه المنع✅_"
    end
end
   data[tostring(msg.chat_id_)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "💡¦ *Word* _"..word.."_ *added to filtered words list ☑️*"
            else
 return  "🕹¦_ الكلمه_ *"..word.."* _تمت اضافتها الى قائمه المنع ✅_"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.chat_id_)]['filterlist'] then
    data[tostring(msg.chat_id_)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.chat_id_)]['filterlist'][word] then
      data[tostring(msg.chat_id_)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "💡¦ *Word* _"..word.."_ *removed from filtered words list* ☑️"
       elseif lang then
return  "🕹¦_ الكلمه_ *"..word.."* _تم السماح بها ✅_"
     end
      else
       if not lang then
         return "💡¦ *Word* _"..word.."_ *is not filtered ☑️*"
       elseif lang then
      return  "🕹¦_ الكلمه_ *"..word.."* _هي بالتأكيد مسموح بها✅_"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "💡¦ *Group is not added ☑️*"
 else
    return  "🕹¦ _هذه المجموعه ليست من حمايتي ✅_"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.chat_id_)]['mods']) == nil then --fix way
  if not lang then
    return "💡¦* No moderator in this group ☑️*"
else
return  "🕹¦ _لا يوجد ادمن في هذه المجموعه ✅"
  end
end
if not lang then
   message = '💡¦ *List of moderators :*\n'
else
   message = '🕹¦ *قائمه الادمنيه :*\n'
end
  for k,v in pairs(data[tostring(msg.chat_id_)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
if not lang then
    return "💡¦ *Group is not added ⚙️*"
else
return  "🕹¦ _هذه المجموعه ليست من حمايتي ✅_"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.chat_id_)]['owners']) == nil then --fix way
 if not lang then
    return "💡¦ *No owner in this group ⚙️*"
else
return  "🕹¦_ لا يوجد هنا مدير 🚧_"
  end
end
if not lang then
   message = '💡¦ *List of moderators :*\n'
else
   message = '🕹¦ *قائمه المدراء:*\n'
end
  for k,v in pairs(data[tostring(msg.chat_id_)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "💡¦ *Group is not added ⚙️*", 0, "md")
else
return tdcli.sendMessage(data.chat_id_, "", 0, "🕹¦ _هذه المجموعه ليست من حمايتي 🚧_", 0, "md")
     end
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *user* ['..user_name..'] *['..data.id_..']* \n💡¦ *is already a group owner ☑️*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..']\n🕹¦ _ الايدي _*['..data.id_..']*\n🕹¦_ انه بالتأكيد مدير ✅ _', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']* \n💡¦ *is now the group owner* ☑️', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦ _الايدي_ *['..data.id_..']*\n🕹¦_ تمت ترقيته ليصبح مدير ✅_', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦ *is already a moderator*', 0, "md")
else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ العضو ['..user_name..'] \n🕹¦_ الايدي _*['..data.id_..']*\n🕹¦_ انه بالتأكيد ادمن ✅_', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..'] *\n💡¦ *has been promoted ☑️*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ العضو ['..user_name..'] \n🕹¦_ الايدي _*['..data.id_..']*\n🕹¦_ تمت ترقيته ليصبح ادمن ✅_', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦ *is not a group owner ☑️*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦ _الايدي_ *['..data.id_..']*\n🕹¦ _انه بالتأكيد ليس مدير ✅_', 0, "md")
end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦ is no longer a group owner ☑️*', 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦ _الايدي_ *['..data.id_..']*\n🕹¦ _تم تنزيله من الاداره ✅_', 0, "md")
end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦ *is not a moderator ☑️*', 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦_ الايدي _*['..data.id_..']*\n🕹¦ _انه بالتأكيد ليس ادمن ✅_', 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦ *has been demoted ☑️*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦_ الايدي_ *['..data.id_..']*\n🕹¦ _تم تنزيله من الادمنيه ✅_', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *user id* *["..data.id_.."]*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
return tdcli.sendMessage(data.chat_id_, "", 0, "⚠_ لا يوجد _", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "⚠*User Not Found*", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "💡¦ *Group is not added ⚙️*", 0, "md")
else
return tdcli.sendMessage(data.chat_id_, "", 0, "🕹¦ _هذه المجموعه ليست من حمايتي 🚧_", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *user* ['..user_name..'] *['..data.id_..']* \n💡¦ *is already a group owner*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..']\n🕹¦ _ الايدي _*['..data.id_..']*\n🕹¦_ انه بالتأكيد مدير ✅ _', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']* \n💡¦ *is now the group owner* ☑️', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦ _الايدي_ *['..data.id_..']*\n🕹¦_ تمت ترقيته ليصبح مدير ✅_', 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦ *is already a moderator* ☑️', 0, "md")
else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ العضو ['..user_name..'] \n🕹¦_ الايدي _*['..data.id_..']*\n🕹¦_ انه بالتأكيد ادمن ✅_', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *user* ['..user_name..'] *['..data.id_..']* \n💡¦ *has been promoted* ☑️', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ العضو ['..user_name..'] \n🕹¦_ الايدي _*['..data.id_..']*\n🕹¦_ تمت ترقيته ليصبح ادمن ✅_', 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *user* ['..user_name..'] *['..data.id_..']* \n💡¦ *is not a group owner* ☑️', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦ _الايدي_ *['..data.id_..']*\n🕹¦ _انه بالتأكيد ليس مدير ✅_', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦ *is no longer a group owner* ☑️', 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦ _الايدي_ *['..data.id_..']*\n🕹¦ _تم تنزيله من الاداره ✅_', 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦ *is not a moderator ☑️', 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦_ الايدي _*['..data.id_..']*\n🕹¦ _انه بالتأكيد ليس ادمن ✅_', 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦*has been demoted* ☑️', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦_ الايدي_ *['..data.id_..']*\n🕹¦ _تم تنزيله من الادمنيه ✅_', 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *user* *"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "💡¦ *Result for* [ ".. check_markdown(data.type_.user_.username_) .." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
  else
text =  "💡¦ _معلومات_ [ ".. check_markdown(data.type_.user_.username_) .." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
      end
   end
else
    if lang then
return tdcli.sendMessage(data.chat_id_, "", 0, "⚠_ لا يوجد _", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "💡¦ *User Not Found* ⚠", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "💡¦ *Group is not added⚙️ *", 0, "md")
else
return tdcli.sendMessage(data.chat_id_, "", 0, "🕹¦ _هذه المجموعه ليست من حمايتي 🚧_", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *user* ['..user_name..'] *['..data.id_..']* \n💡¦ *is already a group owner*', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..']\n🕹¦ _ الايدي _*['..data.id_..']*\n🕹¦_ انه بالتأكيد مدير ✅ _', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']* \n💡¦ *is now the group owner* ☑️', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦ _الايدي_ *['..data.id_..']*\n🕹¦_ تمت ترقيته ليصبح مدير ✅_', 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦ *is already a moderator* ☑️', 0, "md")
else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ العضو ['..user_name..'] \n🕹¦_ الايدي _*['..data.id_..']*\n🕹¦_ انه بالتأكيد ادمن ✅_', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *user* ['..user_name..'] *['..data.id_..']* \n💡¦ *has been promoted* ☑️', 0, "md")
   else
   return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ العضو ['..user_name..'] \n🕹¦_ الايدي _*['..data.id_..']*\n🕹¦_ تمت ترقيته ليصبح ادمن ✅_', 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *user* ['..user_name..'] *['..data.id_..']* \n💡¦ *is not a group owner* ☑️', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦ _الايدي_ *['..data.id_..']*\n🕹¦ _انه بالتأكيد ليس مدير ✅_', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦ *is no longer a group owner* ☑️', 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦ _الايدي_ *['..data.id_..']*\n🕹¦ _تم تنزيله من الاداره ✅_', 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦ *is not a moderator ☑️', 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦_ الايدي _*['..data.id_..']*\n🕹¦ _انه بالتأكيد ليس ادمن ✅_', 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '💡¦ *User* ['..user_name..'] *['..data.id_..']*\n💡¦*has been demoted* ☑️', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '🕹¦ _العضو_ ['..user_name..'] \n🕹¦_ الايدي_ *['..data.id_..']*\n🕹¦ _تم تنزيله من الادمنيه ✅_', 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = ' *not found*'
 else
username = '_لا يوجد_'
  end
end
     if not lang then
return tdcli.sendMessage(arg.chat_id, 0, 1, '💡¦* Info for* *[ '..data.id_..' ]*:\n💡¦ *UserName* : '..username..'\n💡¦ *Name* : '..data.first_name_, 1)
   else
return tdcli.sendMessage(arg.chat_id, 0, 1, '💡¦_ الايدي_ *[ '..data.id_..' ]* \n💡¦ _المعرف_ : '..username..'\n💡¦ _الاسم_ : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User not founded*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_لا يوجد_", 0, "md")
    end
  end
else
    if lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_لا يوجد_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💡¦ *You're Not Moderator 🚶*"
else
 return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
if not lang then
 return "💡¦ *Link Posting Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الروابط بالتأكيد تم قفلها_ ✅'
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "🕹¦ *Link Posting Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل الروابط_ ✅'
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "💡¦ *Link Posting Is Already unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الروابط بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Link Posting Has Been unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الروابط_ ✅'
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then
if not lang then
return "💡¦ *Tag Posting Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _التاك(#) بالتأكيد تم قفله_ ✅'
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Tag Posting Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل التاك(#)_ ✅'
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then
if not lang then
return "💡¦ *Tag Posting Is Already unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _التاك(#) بالتأكيد تم فتحه_ ✅'
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Tag Posting Has Been unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح التاك(#)_ ✅'
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then
if not lang then
return "💡¦ *Mention Posting Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _التذكير بالتأكيد تم قفله_ ✅'
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then 
return "🕹¦ *Mention Posting Has Been Locked* ✅"
else 
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل التذكير_ ✅'
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then
if not lang then
return "💡¦ *Mention Posting Is Already unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _التذكير بالتأكيد تم فتحه_ ✅'
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Mention Posting Has Been unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح التذكير _✅'
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "yes" then
if not lang then
return "💡¦ *Arabic Posting Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _العربيه بالتأكيد تم قفلها_ ✅'
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Arabic Posting Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل العربيه_ ✅'
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "no" then
if not lang then
return "💡¦ *Arabic Posting Is Already unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _العربيه بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Arabic Posting Has Been unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح العربيه_ ✅'
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then
if not lang then
return "💡¦ *Edit Posting Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _التعديل بالتأكيد تم قفله_ ✅'
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Edit Posting Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل التعديل_ ✅'
end
end
end
local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
if not lang then
return "💡¦ *Edit Posting Is Already Unocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _التعديل بالتأكيد تم فتحه_ ✅'
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Edit Posting Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح التعديل_ ✅'
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then
if not lang then
return "💡¦ *Spam Posting Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الكلايش بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Spam Posting Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل الكلايش_ ✅'
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then
if not lang then
return "💡¦ *Spam Posting Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الكلايش بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "no" save_data(_config.moderation.data, data)
if not lang then 
return "🕹¦ *Spam Posting Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الكلايش_ ✅'
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "yes" then
if not lang then
return "💡¦ *Flood  Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _التكرار بالتأكيد تم قفله_ ✅'
end
else
 data[tostring(target)]["settings"]["flood"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Flood Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل التكرار_ ✅'
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "no" then
if not lang then
return "💡¦ *Flood  Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n💡🕹¦ _التكرار بالتأكيد تم فتحه_ ✅'
end
else 
data[tostring(target)]["settings"]["flood"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Flood Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح التكرار_ ✅'
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
return "💡¦ *Bots Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _البوتات بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Bots Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل البوتات_ ✅'
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
return "💡¦ *Bots Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _البوتات بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Bots Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح البوتات_ ✅'
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then
if not lang then 
return "💡¦ *Markdown Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الماركدوان بالتأكيد تك قفله_ ✅'
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Markdown Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل الماركدوان_ ✅'
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then
if not lang then
return "💡¦ *Markdown  Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الماركدوان بالتأكيد تم فتحه_ ✅'
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Markdown  Has Been unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الماركدوان_ ✅'
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then
if not lang then
return "💡¦ *Webpage Posting Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الاعلانات بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Webpage Posting Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل العلانات_✅'
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then
if not lang then
return "💡¦ *Webpage Posting Is Already Unlockedd ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الاعلانات بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Webpage Posting Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الاعلانات_ ✅'
end
end
end


--------Mutes---------
--------Mute all--------------------------
local function mute_all(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "yes" then 
if not lang then
return "💡¦ *All Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _المحادثه بالتأكيد تم قفلها_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "yes"
 save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *All Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل المحادثه_ ✅'
end
end
end

local function unmute_all(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "no" then 
if not lang then
return "💡¦ *All Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _المحادثه بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *All Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح المحادثه_ ✅'
end 
end
end

---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif == "yes" then
if not lang then
return "💡¦ *Gif Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _المتحركه بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_gif"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
return "🕹¦ *Gif Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل المتحركه_ ✅'
end
end
end

local function unmute_gif(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"]
 if mute_gif == "no" then
if not lang then
return "💡¦ *Gif Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _المتحركه بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_gif"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Gif Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح المتحركه_ ✅'
end
end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game == "yes" then
if not lang then
return "💡¦ *Game Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الالعاب بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_game"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Game Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل الالعاب_ ✅'
end
end
end

local function unmute_game(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end 
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"]
 if mute_game == "no" then
if not lang then
return "💡¦ *Game Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الألعاب بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "🕹¦ *Game Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الألعاب_ ✅'
end
end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline == "yes" then
if not lang then
return "💡¦ *Inline Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _النلاين بالتأكيد تم قفله_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_inline"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Inline Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل النلاين_ ✅'
end
end
end

local function unmute_inline(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"]
 if mute_inline == "no" then
if not lang then
return "💡¦ *Inline Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الانلاين بالتأكيد تم فتحه_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_inline"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Inline Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الانلاين_ ✅'
end
end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text == "yes" then
if not lang then
return "💡¦ *Text Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _النص بالتأكيد تم قفله_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_text"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Text Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل النص_ ✅'
end
end
end

local function unmute_text(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end 
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"]
 if mute_text == "no" then
if not lang then
return "💡¦ *Text Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _النص بالتأكيد تم فتحه_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_text"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Text Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح النص_ ✅'
end
end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_photo = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo == "yes" then
if not lang then
return "💡¦ *Photo Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الصور بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_photo"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Photo Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل الصور_ ✅'
end
end
end

local function unmute_photo(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end
 
local mute_photo = data[tostring(target)]["mutes"]["mute_photo"]
 if mute_photo == "no" then
if not lang then
return "💡¦ *Photo Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الصور بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_photo"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Photo Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الصور_ ✅'
end
end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_video = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video == "yes" then
if not lang then
return "💡¦ *Video Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الفيديو بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_video"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
return "🕹¦ *Video Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل الفيديو_ ✅'
end
end
end

local function unmute_video(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local mute_video = data[tostring(target)]["mutes"]["mute_video"]
 if mute_video == "no" then
if not lang then
return "💡¦ *Video Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الفيديو يالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_video"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Video Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الفيديو_ ✅'
end
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio == "yes" then
if not lang then
return "💡¦ *Audio Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الفيديو بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_audio"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Audio Has Been Locked* ✅"
else 
return '🕹¦ _مرحبا عزيزي_ \n✅¦ _تم قفل البصمات_ ✅'
end
end
end

local function unmute_audio(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"]
 if mute_audio == "no" then
if not lang then
return "💡¦ *Audio Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _البصمات بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "🕹¦ *Audio Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح البصمات_ ✅'
end
end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice == "yes" then
if not lang then
return "💡¦ *Voice Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الصوت بالتأكيد تم قفله_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_voice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Voice Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل الصوت_ ✅'
end
end
end

local function unmute_voice(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"]
 if mute_voice == "no" then
if not lang then
return "💡¦ *Voice Is Already Unlocked* ☑️"
elseif lang then
return '💡¦ _مرحبا عزيزي_ \n💡¦ _الصوت بالتأكيد تم فتحه_ ☑️'
end
else 
data[tostring(target)]["mutes"]["mute_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "💡¦ *Voice Has Been Unlocked* ☑️"
else
return '💡¦ _مرحبا عزيزي_ \n💡¦ _تم فتح الصوت_ ☑️'
end
end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker == "yes" then
if not lang then
return "💡¦ *Sticker Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الملصقات بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_sticker"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Sticker Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل الملصقات_ ✅'
end
end
end

local function unmute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end 
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"]
 if mute_sticker == "no" then
if not lang then
return "💡¦ *Sticker Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الملصقات بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "🕹¦ *Sticker Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الملصقات_ ✅'
end 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact == "yes" then
if not lang then
return "💡¦ *Contact Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _جهات الاتصال بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_contact"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Contact Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل جهات الاتصال_ ✅'
end
end
end

local function unmute_contact(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"]
 if mute_contact == "no" then
if not lang then
return "💡¦ *Contact Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _جهات الاتصال بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_contact"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Contact Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح جهات الاتصال_ ✅'
end
end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward == "yes" then
if not lang then
return "💡¦ *Forward Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _التوجيه بالتأكيد تم قفله_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_forward"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "🕹¦ *Forward Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل التوجيه_ ✅'
end
end
end

local function unmute_forward(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"]
 if mute_forward == "no" then
if not lang then
return "💡¦ *Forward Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _التوجيه بالتأكيد تم فتحها_ ✅'
end 
else 
data[tostring(target)]["mutes"]["mute_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "🕹¦ *Forward Has Been Unlocked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح التوجيه_ ✅'
end
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_location = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location == "yes" then
if not lang then
return "💡¦ *Location Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الموقع بالتأكيد تم قفله_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_location"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then
return "🕹¦ *Location Has Been Locked* ✅"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل الموقع_ ✅'
end
end
end

local function unmute_location(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local mute_location = data[tostring(target)]["mutes"]["mute_location"]
 if mute_location == "no" then
if not lang then
return "💡¦ *Location Is Already Unlocked* ☑️"
elseif lang then
retreturn '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الموقع بالتأكيد تم فتحه_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_location"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "💡¦ *Location Has Been Unlocked* ☑️"
else
returreturn '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الموقع_ ✅'
end
end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_document = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document == "yes" then
if not lang then
return "💡¦ *Document Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الملفات بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_document"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "💡¦ *Document Has Been Locked* ☑️"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل الملفات_ ✅'
end
end
end

local function unmute_document(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end 

local mute_document = data[tostring(target)]["mutes"]["mute_document"]
 if mute_document == "no" then
if not lang then
return "💡¦ *Document Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الملفات بالتأكيد تم فتحها_ ✅'
end
else 
data[tostring(target)]["mutes"]["mute_document"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "💡¦ *Document Has Been Unlocked* ☑️"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الملفات_ ✅'
end
end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"] 
if mute_tgservice == "yes" then
if not lang then
return "💡¦ *TgSevice Is Already Locked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الاشعارات بالتأكيد تم قفلها_ ✅'
end
else
 data[tostring(target)]["mutes"]["mute_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "💡¦ *TgService Has Been Locked* ☑️"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم قفل الاشعارات_ ✅'
end
end
end

local function unmute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
return "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end 
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"]
 if mute_tgservice == "no" then
if not lang then
return "💡¦ *TgService Is Already Unlocked* ☑️"
elseif lang then
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _الاشعارات بالتأكيد تم فتحها_ ✅'
end 
else 
data[tostring(target)]["mutes"]["mute_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "💡¦ *TgSevrice Has Been Unlocked* ☑️"
else
return '🕹¦ _مرحبا عزيزي_ \n🕹¦ _تم فتح الاشعارات_ ✅'
end 
end
end
----------MuteList---------
function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "💡¦ *You're Not Moderator 🚶*"
else
turn "🕹¦ _هذا الامر يخص الادمنيه فقط _ 👁‍🗨"
end
end
local data = load_data(_config.moderation.data)
local target = msg.chat_id_ 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_all"] then			
data[tostring(target)]["settings"]["mute_all"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_gif"] then			
data[tostring(target)]["settings"]["mute_gif"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_text"] then			
data[tostring(target)]["settings"]["mute_text"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_photo"] then			
data[tostring(target)]["settings"]["mute_photo"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_video"] then			
data[tostring(target)]["settings"]["mute_video"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_audio"] then			
data[tostring(target)]["settings"]["mute_audio"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_voice"] then			
data[tostring(target)]["settings"]["mute_voice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_sticker"] then			
data[tostring(target)]["settings"]["mute_sticker"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_contact"] then			
data[tostring(target)]["settings"]["mute_contact"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_forward"] then			
data[tostring(target)]["settings"]["mute_forward"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_location"] then			
data[tostring(target)]["settings"]["mute_location"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_document"] then			
data[tostring(target)]["settings"]["mute_document"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_tgservice"] then			
data[tostring(target)]["settings"]["mute_tgservice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_inline"] then			
data[tostring(target)]["settings"]["mute_inline"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_game"] then			
data[tostring(target)]["settings"]["mute_game"] = "no"		
end
end


if not lang then
local settings = data[tostring(target)]["settings"] 
text = "💡¦ *Group Settings:*\n💡¦ *Lock edit :* "..settings.lock_edit.."\n💡¦ *Lock links :* "..settings.lock_link.."\n💡¦ *Lock tags :* "..settings.lock_tag.."\n💡¦ *Lock flood :* "..settings.flood.."\n💡¦ *Lock spam :* "..settings.lock_spam.."\n💡¦ *Lock mention :* "..settings.lock_mention.."\n💡¦ *Lock arabic :* "..settings.lock_arabic.."\n💡¦ *Lock webpage :* "..settings.lock_webpage.."\n💡¦ *Lock markdown :* "..settings.lock_markdown.."\n💡¦ *Group welcome :* "..settings.welcome.."\n💡¦ *Bots protection :* "..settings.lock_bots.."\n💡¦ *Flood sensitivity :* "..NUM_MSG_MAX.."\n*____________________*\n💡¦ *Lock all : * "..settings.mute_all.."\n💡¦ *Lock gif :* "..settings.mute_gif.."\n💡¦ *Lock text :* "..settings.mute_text.."\n💡¦ *Lock inline :* "..settings.mute_inline.."\n💡¦ *Lock game :* "..settings.mute_game.."\n💡¦ *Lock photo :* "..settings.mute_photo.."\n💡¦ *Lock video :* "..settings.mute_video.."\n💡¦* Lock audio :* "..settings.mute_audio.."\n💡¦ *Lock voice :* "..settings.mute_voice.."\n��¦ *Lock sticker :* "..settings.mute_sticker.."\n💡¦ *Lock contact :* "..settings.mute_contact.."\n💡¦ * forward :* "..settings.mute_forward.."\n💡¦ *Lock location :* "..settings.mute_location.."\n💡¦ *Lock document :* "..settings.mute_document.."\n💡¦ *Lock TgService :* "..settings.mute_tgservice.."\n*____________________*\n💡¦ *Bot channel*: @llDEV1ll\n💡¦ *Bot Dev*: @TH3BOSS\n💡¦ *Group Language* : *EN*"
else

local settings = data[tostring(target)]["settings"]
text = "🕹¦ _اعـدادات الـمـجـمـوعـه_ ☑️\n🕹¦ _قفل التعديل_ ➣ "..settings.lock_edit.."\n🕹¦ _قفل الروابط_ ➣ "..settings.lock_link.."\n🕹¦ _قفل التاك_ ➣  "..settings.lock_tag.."\n🕹¦ _قفل التكرار_ "..settings.flood.."\n🕹¦ _ققل الكلايش_ ➣ "..settings.lock_spam.."\n🕹¦ _قفل التذكير_ ➣ "..settings.lock_mention.."\n🕹¦ _قفل العربيه_ ➣ "..settings.lock_arabic.."\n🕹¦ _قفل الاعلانات_ ➣ "..settings.lock_webpage.."\n🕹¦ _قفل الماركدوان_ ➣ "..settings.lock_markdown.."\n🕹¦ _وضع الترحيب_ ➣ "..settings.welcome.."\n🕹¦ _منع البوتات_ ➣ "..settings.lock_bots.."\n🕹¦ _عدد التكرار_ ➣ "..NUM_MSG_MAX.."\n*____________________*\n🕹¦ _قفل المحادثه_ ➣ *"..settings.mute_all.."*\n🕹¦ _قفل الملصقات_ ➣ *"..settings.mute_gif.."*\n🕹¦ _قفل النص_ ➣ *"..settings.mute_text.."*\n🕹¦ _قفل الانلاين_ ➣ *"..settings.mute_inline.."*\n🕹¦ _قفل الالعاب_ ➣ *"..settings.mute_game.."*\n🕹¦ _قفل الصور_ ➣ *"..settings.mute_photo.."*\n🕹¦ _قفل الفيديو_ ➣ *"..settings.mute_video.."*\n🕹¦ _قفل البصمات_ ➣ *"..settings.mute_audio.."*\n🕹¦ _قفل الصوت_ ➣ *"..settings.mute_voice.."*\n🕹¦ _قفل الملصقات_ ➣ *"..settings.mute_sticker.."*\n🕹¦ _قفل جهات الاتصال_ ➣ *"..settings.mute_contact.."*\n🕹¦ _قفل التوجيه_ ➣ *"..settings.mute_forward.."*\n🕹¦ _ قفل الموقع_ ➣ *"..settings.mute_location.."*\n🕹¦ _قفل الملفات_ ➣ *"..settings.mute_document.."*\n🕹¦ _ قفل الاسعارات_ ➣ *"..settings.mute_tgservice.."*\n*____________________*\n ¦ _اللغه المستخدمه_ ➣ *Ar*"
end
return text
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
   local chat = msg.chat_id_
   local user = msg.sender_user_id_
if matches[1] == "id" or matches[1] == "ايدي" then
if not matches[2] and tonumber(msg.reply_to_message_id_) == 0 then
   if not lang then
return "🕹¦* Chat ID :* *["..chat.."]*\n🕹¦ *User ID :* *["..user.."]*"
   else
return "🕹¦_ ايـدي الـمـجـمـوعـه _: *["..chat.."]*\n🕹¦_ ايـديـك_ :*["..user.."]*"
   end
end
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="id"})
  end
if matches[2] and tonumber(msg.reply_to_message_id_) == 0 then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="id"})
      end
   end
if matches[1] == "pin" or matches[1] == "تثبيت" and is_owner(msg) then
tdcli.pinChannelMessage(msg.chat_id_, msg.reply_to_message_id_, 1)
if not lang then
return "💡¦ *Message Has Been Pinned*"
else
return "🕹¦ _مرحبآ عزيزي_\n🕹¦_ تم تثبيت الرساله_ ✅"
end
end
if matches[1] == 'unpin' or matches[1] == "الغاء التثبيت" and is_mod(msg) then
tdcli.unpinChannelMessage(msg.chat_id_)
if not lang then
return "💡¦ *Pin message has been unpinned*"
else
return "🕹¦ _مرحبآ عزيزي_\n🕹¦_ تم الغاء تثبيت الرساله_ ✅"
end
end
if matches[1] == "add" or matches[1] == "تفعيل" then
return modadd(msg)
end
if matches[1] == "rem" or matches[1] == "تعطيل" then
return modrem(msg)
end
if matches[1] == "setowner" or matches[1] == "رفع المدير" and is_admin(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="setowner"})
      end
   end
if matches[1] == "remowner" or matches[1] == "تنزيل المدير"and is_admin(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="remowner"})
      end
   end
if matches[1] == "promote" or matches[1] == "رفع ادمن" and is_owner(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="promote"})
      end
   end
if matches[1] == "demote" or matches[1] == "تنزيل ادمن" and is_owner(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="demote"})
      end
   end

if matches[1] == "lock" or matches[1] == "قفل" and is_mod(msg) then
local target = msg.chat_id_
if matches[2] == "link" or matches[2] == "الروابط" then
return lock_link(msg, data, target)
end
if matches[2] == "tag" or matches[2] == "التاك" then
return lock_tag(msg, data, target)
end
if matches[2] == "mention" then
return lock_mention(msg, data, target)
end
if matches[2] == "arabic" or matches[2] == "العربيه" then
return lock_arabic(msg, data, target)
end
if matches[2] == "edit" or matches[2] == "التعديل" then
return lock_edit(msg, data, target)
end
if matches[2] == "spam" or matches[2] == "الكلايش" then
return lock_spam(msg, data, target)
end
if matches[2] == "flood" or matches[2] == "التكرار"then
return lock_flood(msg, data, target)
end
if matches[2] == "bots" or matches[2] == "البوتات" then
return lock_bots(msg, data, target)
end
if matches[2] == "markdown" or matches[2] == "الماركدوان" then
return lock_markdown(msg, data, target)
end
if matches[2] == "webpage" or matches[2] == "الاعلانات"then
return lock_webpage(msg, data, target)
end
end

if matches[1] == "unlock" or matches[1] == "فتح" and is_mod(msg) then
local target = msg.chat_id_
if matches[2] == "link" or matches[2] == "الروابط" then
return unlock_link(msg, data, target)
end
if matches[2] == "tag" or matches[2] == "التاك" then
return unlock_tag(msg, data, target)
end
if matches[2] == "mention" then
return unlock_mention(msg, data, target)
end
if matches[2] == "arabic" or matches[2] == "العربيه" then
return unlock_arabic(msg, data, target)
end
if matches[2] == "edit" or matches[2] == "التعديل" then
return unlock_edit(msg, data, target)
end
if matches[2] == "spam" or matches[2] == "الكلايش" then
return unlock_spam(msg, data, target)
end
if matches[2] == "flood" or matches[2] == "التكرار"then
return unlock_flood(msg, data, target)
end
if matches[2] == "bots" or matches[2] == "البوتات" then
return unlock_bots(msg, data, target)
end
if matches[2] == "markdown" or matches[2] == "الماركدوان" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "webpage" or matches[2] == "الاعلانات"then
return unlock_webpage(msg, data, target)
end
end
if matches[1] == "lock" or matches[1] == "قفل" and is_mod(msg) then
local target = msg.chat_id_
if matches[2] == "all" or matches[2] == "المحادثه" then
return mute_all(msg, data, target)
end
if matches[2] == "gif" or matches[2] == "المتحركه" then
return mute_gif(msg, data, target)
end
if matches[2] == "text" or matches[2] == "النص" then
return mute_text(msg ,data, target)
end
if matches[2] == "photo" or matches[2] == "الصور" then
return mute_photo(msg ,data, target)
end
if matches[2] == "video" or matches[2] == "الفيديو" then
return mute_video(msg ,data, target)
end
if matches[2] == "audio" or matches[2] == "الصوت" then
return mute_audio(msg ,data, target)
end
if matches[2] == "voice" or matches[2] == "البصمات" then
return mute_voice(msg ,data, target)
end
if matches[2] == "sticker" or matches[2] == "الملصقات" then
return mute_sticker(msg ,data, target)
end
if matches[2] == "contact" or matches[2] == "الجهات" then
return mute_contact(msg ,data, target)
end
if matches[2] == "forward" or matches[2] == "التوجيه" then
return mute_forward(msg ,data, target)
end
if matches[2] == "location" or matches[2] == "الموقع" then
return mute_location(msg ,data, target)
end
if matches[2] == "document" or matches[2] == "الملفات" then
return mute_document(msg ,data, target)
end
if matches[2] == "tgservice" or matches[2] == "الاشعارات" then
return mute_tgservice(msg ,data, target)
end
if matches[2] == "inline" or matches[2] == "النلاين" then
return mute_inline(msg ,data, target)
end
if matches[2] == "game" or matches[2] == "الالعاب" then
return mute_game(msg ,data, target)
end
end

if matches[1] == "unlock" or matches[1] == "فتح" and is_mod(msg) then
local target = msg.chat_id_
if matches[2] == "all" or matches[2] == "المحادثه" then
return unmute_all(msg, data, target)
end
if matches[2] == "gif" or matches[2] == "المتحركه" then
return unmute_gif(msg, data, target)
end
if matches[2] == "text" or matches[2] == "النص" then
return unmute_text(msg, data, target)
end
if matches[2] == "photo" or matches[2] == "الصور" then
return unmute_photo(msg ,data, target)
end
if matches[2] == "video" or matches[2] == "الفيديو" then
return unmute_video(msg ,data, target)
end
if matches[2] == "audio" or matches[2] == "الصوت" then
return unmute_audio(msg ,data, target)
end
if matches[2] == "voice" or matches[2] == "البصمات" then
return unmute_voice(msg ,data, target)
end
if matches[2] == "sticker" or matches[2] == "الملصقات" then
return unmute_sticker(msg ,data, target)
end
if matches[2] == "contact" or matches[2] == "الجهات" then
return unmute_contact(msg ,data, target)
end
if matches[2] == "forward" or matches[2] == "التوجيه" then
return unmute_forward(msg ,data, target)
end
if matches[2] == "location" or matches[2] == "الموقع" then
return unmute_location(msg ,data, target)
end
if matches[2] == "document" or matches[2] == "الملفات" then
return unmute_document(msg ,data, target)
end
if matches[2] == "tgservice" or matches[2] == "الاشعارات" then
return unmute_tgservice(msg ,data, target)
end
if matches[2] == "inline" or matches[2] == "النلاين" then
return unmute_inline(msg ,data, target)
end
if matches[2] == "game" or matches[2] == "الالعاب" then
return unmute_game(msg ,data, target)
end
end
if matches[1] == "gpinfo" or matches[1] == "معلومات المجموعه" and is_mod(msg) and gp_type(msg.chat_id_) == "channel" then
local function group_info(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not lang then
ginfo = "💡¦ *Group Info :*\n💡¦ *Admin Count :* *["..data.administrator_count_.."]*\n💡¦ *Member Count :* *["..data.member_count_.."]*\n💡¦ *Kicked Count :* *["..data.kicked_count_.."]*\n💡¦ *Group ID :* *["..data.channel_.id_.."]*"
print(serpent.block(data))
elseif lang then
ginfo = "🕹¦ _معلومات المجموعه :_\n🕹¦ _عدد الادمنيه _*["..data.administrator_count_.."]*\n🕹¦ _عدد الاعضاء _*["..data.member_count_.."]*\n🕹¦ _عدد المطرودين_*["..data.kicked_count_.."]*\n🕹¦ _ايـدي الـمـجـمـوعـه_*["..data.channel_.id_.."]*"
print(serpent.block(data))
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.chat_id_, group_info, {chat_id=msg.chat_id_,msg_id=msg.id_})
end
		if matches[1] == 'setlink' or matches[1] == 'ضع رابط' and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
      if not lang then
			return '💡¦ *Please send the new group [link] now* '
    else 
return "🕹¦ _مرحبآ عزيزي_\n🕹¦ _رجائا ارسل الرابط الآن _👁‍🗨"
       end
		end

		if msg.content_.text_ then
   local is_link = msg.content_.text_:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.content_.text_:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.content_.text_
				save_data(_config.moderation.data, data)
            if not lang then
				return "💡¦ *Newlink has been set* ☑️"
           else
return "🕹¦ _شكرأ لك 😻_\n🕹¦ _تم حفظ الرابط بنجاح _✅"
		 	end
       end
		end
    if matches[1] == 'link' or matches[1] == 'الرابط' and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "💡¦ *First set a link for group with using [/setlink] *"
     else
return "🕹¦ _اوبس 😿 لا يوجد هنا رابط_\n🕹¦ _رجائا اكتب [ضع رابط]_👁‍🗨"
      end
      end
     if not lang then
       text = "💡¦ <b>Group Link :</b>\n[ "..linkgp.." ]"
     else
      text = "🕹¦ <i> 👥 رابـط الـمـجـمـوعه</i>🕹¦ [ "..linkgp.."] "
         end
        return tdcli.sendMessage(chat, msg.id_, 1, text, 1, 'html')
     end
  if matches[1] == "setrules" or matches[1] == "ضع قوانين" and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "💡¦ *Group rules has been set* ☑️"
   else 
return '🕹¦ _مرحبآ عزيزي_\n🕹¦ _تم حفظ القوانين بنجاح_✅\n🕹¦ _اكتب(القوانين) لعرضها 💜'
   end
  end
  if matches[1] == "rules" or matches[1] == "القوانين" then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "💡¦ *The Default Rules :*\n💡¦ *1⃣- No Flood.*\n💡¦ *2⃣- No Spam.*\n💡¦ *3⃣- No Advertising.* \n💡¦ *4⃣- Try to stay on topic.*\n💡¦ *5⃣- Forbidden any racist, sexual, homophobic or gore content.*\n➡️ *Repeated failure to comply with these rules will cause ban.*\n@llDEV1ll"
    elseif lang then
     rules = "💲¦ _مرحبأ عزيري_ 👋🏻 _القوانين كلاتي_ 👇🏻\n💲¦ _ممنوع نشر الروابط_ ❌\n💲¦ _ممنوع التكلم او نشر صور اباحيه_ ❌\n💲¦ _ممنوع  اعاده توجيه_ ❌\n💲¦ _ممنوع التكلم بلطائفه_ ❌\n💲¦ _الرجاء احترام المدراء والادمنيه _⚠️"
 end
        else
     rules = "💡¦ *Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if matches[1] == "res" or matches[1] == "القوانين" and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="res"})
  end
if matches[1] == "whois" or matches[1] == "معلومات" and matches[2] and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="whois"})
  end
  if matches[1] == 'setflood' or matches[1] == "ضع تكرار" and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "💡¦ *Wrong number, range is [1-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
    return "💡¦ *Group flood sensitivity has been set to *: *[ "..matches[2].." ]*"
       end
		if matches[1]:lower() == 'clean' or matches[1]:lower() == 'مسح' and is_owner(msg) then
			if matches[2] == 'mods' or matches[2] == 'الادمنيه' then
				if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
					return "💡¦ *No [moderators] in this group* ☑️"
             else
return "💡¦ _اوبس ☹️ هنالك خطأ_ ⚠️\n💡¦ _عذرا لا يوجد ادمنيه ليتم مسحهم_ ✅"
				end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "💡¦ *All [moderators] has been demoted* ☑️"
          else
return "🕹¦ _مرحبآ عزيزي \n🕹¦ _تم حذف الادمنيه بنجاح_ ✅"
			end
         end
			if matches[2] == 'filterlist' or matches[2] == 'قائمه المنع' then 
				if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
					return "💡¦ *[Filtered words] list is empty* ☑️"
         else
					return "💡¦ _اوبس ☹️ هنالك خطأ_ ⚠️\n💡¦ _عذرا لا توجد كلمات ممنوعه ليتم حذفها_ ✅"
             end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
       if not lang then
				return "💡¦ *[Filtered words] list has been cleaned* ☑️"
           else
				return "🕹¦ _مرحبآ عزيزي \n🕹¦ _تم حذف الكلمات الممنوعه بنجاح_ ✅"
           end
			end
			if matches[2] == 'rules' or matches[2] == 'القوانين' then
				if not data[tostring(chat)]['rules'] then
            if not lang then
					return "💡¦ *No [rules] available* ☑️"
             else
return "💡¦ _اوه ☹️ هنالك خطأ_ ⚠️\n💡¦ _عذرا لا يوجد قوانين ليتم مسحه_ ✅"
             end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "💡¦ *Group [rules] has been cleaned* ☑️"
          else
return "🕹¦ _مرحبآ عزيزي \n🕹¦ _تم حذف القوانين بنجاح_ ✅"
			end
       end
			if matches[2] == 'welcome' or matches[2] == 'الترحيب' then
				if not data[tostring(chat)]['setwelcome'] then
            if not lang then
					return "💡¦ *[Welcome] Message not set* ☑️"
             else
return "💡¦ _اوه ☹️ هنالك خطأ_ ⚠️\n💡¦ _عذرا لا يوجد ترحيب ليتم مسحه_ ✅"
             end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "💡¦ *[Welcome] message has been cleaned* ☑️"
          else
return "🕹¦ _مرحبآ عزيزي \n💡🕹¦ _تم حذف الترحيب بنجاح_ ✅"
			end
       end
			if matches[2] == 'about' or matches[2] == 'الوصف' then
        if gp_type(chat) == "chat" then
				if not data[tostring(chat)]['about'] then
            if not lang then
					return "💡¦ *No [description] available* ☑️"
            else
return "💡¦ _اوبس ☹️ هنالك خطأ_ ⚠️\n💡¦ _عذرا لا يوجد وصف ليتم مسحه_ ✅"
          end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif gp_type(chat) == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
             if not lang then
				return "💡¦ *Group [description] has been cleaned* ☑️"
           else
return "🕹¦ _مرحبآ عزيزي \n🕹¦ _تم حذف الوصف بنجاح_ ✅"
             end
		   	end
        end
		if matches[1]:lower() == 'clean' or matches[1]:lower() == 'مسح' and is_admin(msg) then
			if matches[2] == 'owners' then
				if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
					return "💡¦ *No [owners] in this group* ☑️"
            else
return "💡¦ _اوبس ☹️ هنالك خطأ_ ⚠️\n💡¦ _عذرا لا يوجد مدراء ليتم مسحهم_ ✅"
            end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "💡¦ *All [owners] has been demoted* ☑️"
           else
            return "🕹¦ _مرحبآ عزيزي \n🕹¦ _تم حذف المدراء بنجاح_ ✅"
          end
			end
     end
if matches[1] == "setname" or matches[1] == "ضع اسم" and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if matches[1] == "setabout" or matches[1] == "ضع وصف" and matches[2] and is_mod(msg) then
     if gp_type(chat) == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif gp_type(chat) == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "💡¦*Group description has been set ☑️*"
    else
     return "🕹¦ _تم وضع الوصف بنجاح_✅"
      end
  end
  if matches[1] == "about" or matches[1] == "الوصف" and gp_type(chat) == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "💡¦ *no description available ☑️*"
      elseif lang then
      about = "🕹¦ _لا يوجد وصف ليتم عرضه _✅*"
       end
        else
     about = "💡¦ *Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if matches[1] == 'filter' or matches[1] == 'منع' and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if matches[1] == 'unfilter' or matches[1] == 'الغاء منع' and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
if matches[1] == 'filterlist' or matches[1] == 'قائمه المنع' and is_mod(msg) then
    return filter_list(msg)
  end
if matches[1] == "settings" or matches[1] == "الاعدادات" then
return group_settings(msg, target)
end
if matches[1] == "mutelist" then
return mutes(msg, target)
end
if matches[1] == "modlist" or matches[1] == "الادمنيه" then
return modlist(msg)
end
if matches[1] == "ownerlist" or matches[1] == "المدراء" and is_owner(msg) then
return ownerlist(msg)
end

if matches[1] == "setlang" or matches[1] == "ضع لغه" and is_owner(msg) then
   if matches[2] == "en" or matches[2] == "انكلش" then
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 redis:del(hash)
return "🕹¦ *Group Language Set To: EN* ✅"
  elseif matches[2] == "ar" or matches[2] == "عربي" then
redis:set(hash, true)
return "🕹¦ _ تم تغيير اللغه الى : ar_✅"
end
end

if matches[1] == "الاوامر" and is_mod(msg) then
if not lang then
text = [[
💡¦ *setowner* `[username|id|reply]` 
_Set Group Owner(Multi Owner)_
💡¦ *remowner* `[username|id|reply]` 
 _Remove User From Owner List_
💡¦ *promote* `[username|id|reply]` 
_Promote User To Group Admin_
💡¦ *demote* `[username|id|reply]` 
_Demote User From Group Admins List_
💡¦ *setflood* `[1-50]`
_Set Flooding Number_
💡¦ *silent* `[username|id|reply]` 
_Silent User From Group_
💡¦ *unsilent* `[username|id|reply]` 
_Unsilent User From Group_
💡¦ *kick* `[username|id|reply]` 
_Kick User From Group_
💡¦ *ban* `[username|id|reply]` 
_Ban User From Group_
💡¦ *unban* `[username|id|reply]` 
_UnBan User From Group_
💡¦ *res* `[username]`
_Show User ID_
💡¦ *id* `[reply]`
_Show User ID_
💡¦ *whois* `[id]`
_Show User's Username And Name_
💡¦ *lock* `[link | tag | edit | arabic | webpage | bots | spam | flood | markdown | mention|gifs | photo | document | sticker | video | text | forward | location | audio | voice | contact | all]`
_If This Actions Lock, Bot Check Actions And Delete Them_
💡¦ *unlock* `[link | tag | edit | arabic | webpage | bots | spam | flood | markdown | mention|gifs | photo | document | sticker | video | text | forward | location | audio | voice | contact | all]`
_If This Actions Unlock, Bot Not Delete Them_
💡¦ *set*`[rules | name | photo | link | about | welcome]`
_Bot Set Them_
💡¦ *clean* `[bans | mods | bots | rules | about | silentlist | filtelist | welcome]`   
_Bot Clean Them_
💡¦ *filter* `[word]`
_Word filter_
💡¦ *unfilter* `[word]`
_Word unfilter_
💡¦ *pin* `[reply]`
_Pin Your Message_
💡¦ *unpin* 
_Unpin Pinned Message_
💡¦ *settings*
_Show Group Settings_
💡¦ *silentlist*
_Show Silented Users List_
💡¦ *filterlist*
_Show Filtered Words List_
💡¦ *banlist*
_Show Banned Users List_
💡¦ *ownerlist*
_Show Group Owners List_ 
💡¦ *modlist* 
_Show Group Moderators List_
💡¦ *rules*
_Show Group Rules_
💡¦ *about*
_Show Group Description_
💡¦ *id*
_Show Your And Chat ID_
💡¦ *gpinfo*
_Show Group Information_
💡¦ *link*
_Show Group Link_
💡¦ *setwelcome [text]*
_set Welcome Message_
_This Help List Only For_ *Moderators/Owners!*
_Its Means, Only Group_ *Moderators/Owners* _Can Use It!_
*Good luck ;)*]]

elseif lang then

text = [[
🕹¦ رفع المدير :-- لرفع المدير
🕹¦ تنزيل المدير :-- للتنزيل 
🕹¦ رفع ادمن :-- لرفع ادمن
🕹¦ تنزيل الادمن :-- لتنزيله
🕹¦ ضع تكرار [1-50] :-- لوضع حد التكرار
🕹¦ كتم :-- لكتم عضو
🕹¦ الغاء الكتم :-- لرفع كتم 
🕹¦ طرد :-- لطرد عضو
🕹¦ حظر :-- لحظر عضو
🕹¦ الغاء الحظر :-- لرفع الحظر
🕹¦ يوزر➕معرف :-- لعرض اسم / ايدي
🕹¦ ايدي :-- لعرض الايدي
🕹¦ معلومات :-- لعرض معلومات شخص
ا_-_-_-_-_-_-_-_-_-_-_-_-_-_ا
📍¦ قفل :--- للقفل  / 📍¦ فتح :--- للفتح
1/ الروابط  ✔️2/ التاك  ✔️3/ التعديل ✔️4/  العربيه  ✔️5/ الاعلانات  ✔️6/ البوتات ✔️7/ التكرار ✔️8/ الكلايش  ✔️9/ الماركدوان ✔️10/ المتحركه ✔️11/ الصور ✔️12/ الملفات ✔️13/ الملصقات ✔️14/ الفيديو ✔️15/ الصوت  ✔️16/ البصمات ✔️17/ الجهات  ✔️18/ الاشعارات 
🕹¦ ضع قوانين 
🕹¦ ضع اسم
🕹¦ ضع رابط
🕹¦ ضع وصف
🕹¦ ضع ترحيب
🕹¦ ضع لغه
ا_-_-_-_-_-_-_-_-_-_-_-_-_-_ا
✅¦ مسح ➕ ⬇️
المحظورين -- الادمنيه -- القوانين -- البوتات -- الوصف -- الترحيب -- قائمه المنع -- المكتومين 
ا_-_-_-_-_-_-_-_-_-_-_-_-_-_اا
🕹¦ منع➕كلمه 
🕹¦ الغاء منع ➕ كلمه
🕹¦ تثبيت 
🕹¦ الغاء تثبيت 
🕹¦ الاعدادات
🕹¦ المكتومين
🕹¦ قائمه المنع
🕹¦ المحظورين
🕹¦ المدراء
🕹¦ الادمنيه 
🕹¦ القوانين
🕹¦ معلومات المجموعه 
🕹¦ الرابط
🕹¦ ضع ترحيب
]]
end
return text
end
--------------------- Welcome -----------------------
	if matches[1] == "welcome" or matches[1] == "الترحيب" and is_mod(msg) then
		if matches[2] == "on" or matches[2] == "تشغيل" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
       if not lang then
				return "💡¦ *Group welcome is already on* ☑️"
       elseif lang then
				return "🕹¦ _مرحبا عزيزي_\n🕹¦ _تشغيل الترحيب مفعل مسبقاً_ ✅"
           end
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
       if not lang then
				return "💡¦ *Group welcome has been on* ☑️"
       elseif lang then
				return "🕹¦ _مرحبا عزيزي_\n🕹¦ _تم تشغيل الترحيب_ ✅"
          end
			end
		end
		
		if matches[2] == "off" or matches[2] == "اطفاء" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
      if not lang then
				return "💡¦ *Group Welcome is already off* ☑️"
      elseif lang then
				return "🕹¦ _مرحبا عزيزي_\n🕹¦ _الترحيب بالتأكيد معطل_ ✅"
         end
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
      if not lang then
				return "_Group_ *welcome* _has been disabled_"
      elseif lang then
				return "🕹¦ _مرحبا عزيزي\n🕹¦ _تم تعطيل الترحيب_ ✅"
          end
			end
		end
	end
	if matches[1] == "setwelcome" or matches[1] == "ضع ترحيب" and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "💡¦ *Welcome Message Has Been Set To :*\n*"..matches[2].."*\n\n*You can use :*\n_{rules}_ ➣ *Show Group Rules*\n_{name} _➣ *New Member First Name*\n_{username} _➣ *New Member Username*"
       else
		return "🎖¦ _تم وضع الترحيب بنجاح كالأتي 👋🏻_\n*"..matches[2].."*\n\n🎖¦ _ملاحظة_\n🎖¦ _تستطيع اضهار القوانين بواسطة _ ➣ *{rules}*  \n🎖¦ _تستطيع اضهار الاسم بواسطه_ ➣ *{name}*\n🎖¦ _تستطيع اضهار المعرف بواسطة_ ➣ *{username}*"
     end
	end
end
-----------------------------------------
local function pre_process(msg)
   local chat = msg.chat_id_
   local user = msg.sender_user_id_
 local data = load_data(_config.moderation.data)
	local function welcome_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "💡¦ *Welcome Dude* "
    elseif lang then
     welcome = "💡¦ _مرحباً عزيزي\n💡¦ نورت المجموعه "
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "💡¦ *The Default Rules :*\n💡¦ *1⃣- No Flood.*\n💡¦ *2⃣- No Spam.*\n💡¦ *3⃣- No Advertising.* \n💡¦ *4⃣- Try to stay on topic.*\n💡¦ *5⃣- Forbidden any racist, sexual, homophobic or gore content.*\n➡️ *Repeated failure to comply with these rules will cause ban.*\n@lldev1ll"
    elseif lang then
     rules = "💲¦ _مرحبأ عزيري_ 👋🏻 _القوانين كلاتي_ 👇🏻\n💲¦ _ممنوع نشر الروابط_ ❌\n💲¦ _ممنوع التكلم او نشر صور اباحيه_ ❌\n💲¦ _ممنوع  اعاده توجيه_ ❌\n💲¦ _ممنوع التكلم بلطائفه_ ❌\n💲¦ _الرجاء احترام المدراء والادمنيه _🌝"
 end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_))
		local welcome = welcome:gsub("{username}", user_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.chat_id_)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.adduser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id_})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.chat_id_)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id_})
		else
			return false
        end
		end
	end
 end
return {
patterns ={
"^(id)$",
"^(ايدي)$",
"^(id) (.*)$",
"^(ايدي) (.*)$",
"^(pin)$",
"^(تثبيت)$",
"^(unpin)$",
"^(الغاء التثبيت)$",
"^(gpinfo)$",
"^(معلومات المجموعه)$",
"^(test)$",
"^(add)$",
"^(تفعيل)$",
"^(rem)$",
"^(تعطيل)$",
"^(setowner)$",
"^(رفع المدير)$",
"^(setowner) (.*)$",
"^(رفع المدير) (.*)$",
"^(remowner)$",
"^(تنزيل المدير)$",
"^(تنزيل المدير) (.*)$",
"^(remowner) (.*)$",
"^(promote)$",
"^(رفع ادمن)$",
"^(رفع ادمن) (.*)$",
"^(promote) (.*)$",
"^(demote)$",
"^(تنزيل ادمن) (.*)$",
"^(تنزيل ادمن)$",
"^(demote) (.*)$",
"^(modlist)$",
"^(المدراء)$",
"^(الادمنيه)$",
"^(ownerlist)$",
"^(lock) (.*)$",
"^(unlock) (.*)$",
"^(فتح) (.*)$",
"^(قفل) (.*)$",
"^(settings)$",
"^(الاعدادات)$",
"^(mutelist)$",
"^(lock) (.*)$",
"^(unlock) (.*)$",
"^(فتح) (.*)$",
"^(قفل) (.*)$",
"^(link)$",
"^(الرابط)$",
"^(setlink)$",
"^(ضع رابط)$",
"^(rules)$",
"^(القوانين)$",
"^(setrules) (.*)$",
"^(ضع قوانين) (.*)$",
"^(about)$",
"^(الوصف)$",
"^(setabout) (.*)$",
"^(ضع وصف) (.*)$",
"^(setname) (.*)$",
"^(ضع اسم) (.*)$",
"^(clean) (.*)$",
"^(مسح) (.*)$",
"^(setflood) (%d+)$",
"^(ضع تكرار) (%d+)$",
"^(res) (.*)$",
"^(whois) (%d+)$",
"^(معلومات) (%d+)$",
"^(الاوامر)$",
"^(setlang) (.*)$",
"^(ضع لغه) (.*)$",
"^(filter) (.*)$",
"^(منع) (.*)$",
"^(unfilter) (.*)$",
"^(الغاء منع) (.*)$",
"^(filterlist)$",
"^(قائمه المنع)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^(setwelcome) (.*)",
"^(ضع ترحيب) (.*)",
"^(welcome) (.*)$",
"^(الترحيب) (.*)$"

},
run=run,
pre_process = pre_process
}