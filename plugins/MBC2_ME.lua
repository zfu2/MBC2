-- Begin myinfo.lua
local function th3boss(msg, matches)
	if matches[1]:lower() == 'شنو اني' then
		function get_id(arg, data)
			local username
			if data.first_name_ then
				if data.username_ then
					username = '@'..data.username_
				else
					username = '<i>No Username!</i>'
				end
				local telNum
				if data.phone_number_ then
					telNum = '+'..data.phone_number_
				else
					telNum = '----'
				end
				local lastName
				if data.last_name_ then
					lastName = data.last_name_
				else
					lastName = '----'
				end
				local rank
				if is_sudo(msg) then
					rank = 'انـــت الــعــشــق 😍 يــعــنــي الــمـطــور فــديــت ربك😘🙊'
				elseif is_owner(msg) then
					rank = 'مدير المجموعه 😽'
				elseif is_admin(msg) then
					rank = 'ادمن المجموعه 😼'
				elseif is_mod(msg) then
					rank = 'اداري المجموعه 😺'
				else
					rank = 'مجرد عضو 😹'
				end
				local text = '<b>❤️ اهـلا بـك معلوماتك :</b>\n\n<b>🕹 الاسم الاول :</b> <i>'..data.first_name_..'</i>\n\n<b>🕹 الاسم الثاني :</b> <i>'..lastName..'</i>\n\n<b>🕹 المعرف:</b> '..username..'\n\n<b>🕹 الايدي :</b> [ <code>'..data.id_..'</code> ]\n\n<b> 🕹 ايدي الكروب :</b> [ <code>'..arg.chat_id..'</code> ]\n\n<b>🕹 موقعك :</b> <i>'..rank..'</i>\n\n 🕹 مــطــــور الـسـورس : @Cr7rC'
				tdcli.sendMessage(arg.chat_id, msg.id_, 1, text, 1, 'html')
			end
		end
		tdcli_function({ ID = 'GetUser', user_id_ = msg.sender_user_id_, }, get_id, {chat_id=msg.chat_id_, user_id=msg.sendr_user_id_})
	end
end

return { patterns = 
	{ "^(شنو اني)$" }, 
	run = th3boss
	}
