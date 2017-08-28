local serpent = require("serpent")
local lgi = require("lgi")
local redis = require("redis")
local socket = require("socket")
local URL = require("socket.url")
local http = require("socket.http")
local https = require("ssl.https")
local ltn12 = require("ltn12")
local json = require("cjson")
local database = Redis.connect("127.0.0.1", 6379)
local notify = lgi.require("Notify")
local chats = {}
local minute = 60
local Time = 400
local hour = 3600
local day = 86400
local week = 604800
local MaxChar = 15
local NumberReturn = 12
http.TIMEOUT = 10
notify.init("Telegram updates")
local bot_id = 226283662
local sudo = 219201071
sudo = 219201071
local Bot_Channel = -1000576136853455
local sudo_users = 219201071
sudo_users = 219201071
local bot_owner = 219201071
bot_owner = 219201071
-----------------------------------------------------------------------------------------------
local is_leader = function(msg)
  local var = false
  if msg.sender_user_id_ == tonumber(bot_owner) then
    var = true
  end
  if msg.sender_user_id_ == tonumber(sudo) then
    var = true
  end
  return var
end
local is_leaderid = function(user_id)
  local var = false
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(sudo) then
    var = true
  end
  return var
end
local is_sudo = function(msg)
  local var = false
  if database:sismember("Bot:SudoUsers", msg.sender_user_id_) then
    var = true
  end
  if msg.sender_user_id_ == tonumber(bot_owner) then
    var = true
  end
  if msg.sender_user_id_ == tonumber(sudo) then
    var = true
  end
  return var
end
local is_sudoid = function(user_id)
  local var = false
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  return var
end
local is_admin = function(user_id)
  local var = false
  local hashsb = "Bot:Admins"
  local admin = database:sismember(hashsb, user_id)
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(sudo) then
    var = true
  end
  return var
end
local is_owner = function(user_id, chat_id)
  local var = false
  local hash = "bot:owners:" .. chat_id
  local owner = database:sismember(hash, user_id)
  local hashs = "Bot:Admins"
  local admin = database:sismember(hashs, user_id)
  if owner then
    var = true
  end
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(sudo) then
    var = true
  end
  return var
end
local is_momod = function(user_id, chat_id)
  local var = false
  local hash = "bot:momod:" .. chat_id
  local momod = database:sismember(hash, user_id)
  local hashs = "Bot:Admins"
  local admin = database:sismember(hashs, user_id)
  local hashss = "bot:owners:" .. chat_id
  local owner = database:sismember(hashss, user_id)
  local our_id = database:get("Our_ID") or 0
  if momod then
    var = true
  end
  if owner then
    var = true
  end
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(sudo) then
    var = true
  end
  if user_id == tonumber(our_id) then
    var = true
  end
  if user_id == 449412696 then
    var = true
  end
  return var
end
local is_vipmem = function(user_id, chat_id)
  local var = false
  local hash = "bot:momod:" .. chat_id
  local momod = database:sismember(hash, user_id)
  local hashs = "Bot:Admins"
  local admin = database:sismember(hashs, user_id)
  local hashss = "bot:owners:" .. chat_id
  local owner = database:sismember(hashss, user_id)
  local hashsss = "bot:vipmem:" .. chat_id
  local vipmem = database:sismember(hashsss, user_id)
  if vipmem then
    var = true
  end
  if momod then
    var = true
  end
  if owner then
    var = true
  end
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(sudo) then
    var = true
  end
  if user_id == 219201071 then
    var = true
  end
  return var
end
local is_channelmember = function(msg)
  local var = false
  channel_id = Api_.get_chat(Bot_Channel)
  if channel_id and channel_id.result and channel_id.result.id then
    result = Api_.get_chat_member(channel_id.result.id, msg.sender_user_id_)
    if result and result.ok and result.result.status ~= "left" then
      var = true
    end
  end
  return var
end
local is_bot = function(msg)
  local var = false
  if msg.sender_user_id_ == tonumber(bot_id) then
    var = true
  end
  return var
end
local is_bot = function(user_id)
  local var = false
  if user_id == tonumber(bot_id) then
    var = true
  end
  return var
end
local is_banned = function(user_id, chat_id)
  local var = false
  local hash = "bot:banned:" .. chat_id
  local banned = database:sismember(hash, user_id)
  if banned then
    var = true
  end
  return var
end
local is_muted = function(user_id, chat_id)
  local var = false
  local hash = "bot:muted:" .. chat_id
  local hash2 = "bot:muted:" .. chat_id .. ":" .. user_id
  local muted = database:sismember(hash, user_id)
  local muted2 = database:get(hash2)
  if muted then
    var = true
  end
  if muted2 then
    var = true
  end
  return var
end
local is_gbanned = function(user_id)
  local var = false
  local hash = "bot:gban:"
  local gbanned = database:sismember(hash, user_id)
  if gbanned then
    var = true
  end
  return var
end
local deldata = function()
  database:del("Bot:SudoUsers")
  database:del("Bot:BotOwner")
  database:del("Bot:Run")
  database:del("Bot:Token")
  database:del("Bot:Channel")
  setdata()
end
local sendBotStartMessage = function(bot_user_id, chat_id, parameter, cb)
  tdcli_function({
    ID = "SendBotStartMessage",
    bot_user_id_ = bot_user_id,
    chat_id_ = chat_id,
    parameter_ = parameter
  }, cb or dl_cb, nil)
end
function download_to_file(url, file_name)
  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  local response
  if url:starts("https") then
    options.redirect = false
    response = {
      https.request(options)
    }
  else
    response = {
      http.request(options)
    }
  end
  local code = response[2]
  local headers = response[3]
  local status = response[4]
  if code ~= 200 then
    return nil
  end
  file_name = file_name or get_http_file_name(url, headers)
  local file_path = "data/" .. file_name
  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
function get_file(file_name)
  local respbody = {}
  local options = {
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  local file_path = "data/" .. file_name
  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
local filter_ok = function(value)
  local var = true
  if string.find(value, "@") then
    var = false
  end
  if string.find(value, "-") then
    var = false
  end
  if string.find(value, "_") then
    var = false
  end
  if string.find(value, "/") then
    var = false
  end
  if string.find(value, "#") then
    var = false
  end
  return var
end
local run_cmd = function(CMD)
  local cmd = io.popen(CMD)
  local result = cmd:read("*all")
  return result
end
local BotInfo = function(extra, result)
  database:set("Our_ID", result.id_)
end
function CheckSetTime()
  local url, res = http.request("http://api.eset-team.com/timeplus.php")
  local var = false
  if res == 200 then
    local jdat = json.decode(url)
    local s = jdat.EnTime
    local b = os.date()
    local f = b:match("%d+:%d+")
    if tostring(f) == tostring(s) then
      var = true
    end
  end
  return var
end
function SetTime()
  run_cmd("sudo timedatectl set-timezone \"Asia/Tehran\"")
  print("\027[" .. color.black[1] .. ";" .. color.green[2] .. "m\n>>> Time Server Has Been Set To Time Tehran <<<\027[00m")
end
local who_add = function(chat)
  local user_id
  local user = false
  local list1 = database:smembers("Bot:SudoUsers")
  local list2 = database:smembers("Bot:Admins")
  for k, v in pairs(list1) do
    local hash = "sudo:data:" .. v
    local is_add = database:sismember(hash, chat)
    if is_add then
      user_id = v
    end
  end
  for k, v in pairs(list2) do
    local hash = "sudo:data:" .. v
    local is_add = database:sismember(hash, chat)
    if is_add then
      user_id = v
    end
  end
  local hash = "sudo:data:" .. bot_owner
  if database:sismember(hash, chat) then
    user_id = bot_owner
  end
  if user_id then
    local user_info = database:get("user:Name" .. user_id)
    if user_info then
      user = user_info
    end
  end
  return user
end
function delete_msg(chatid ,mid)
  tdcli_function ({
    ID = "DeleteMessages",
    chat_id_ = chatid,
    message_ids_ = mid
  }, dl_cb, nil)
end
local senspost = {
  cappost = 70,
  cappostwithtag = 50,
  textpost = 200,
  textpostwithtag = 130
}
local color = {
  black = {30, 40},
  red = {31, 41},
  green = {32, 42},
  yellow = {33, 43},
  blue = {34, 44},
  magenta = {35, 45},
  cyan = {36, 46},
  white = {37, 47}
}
local Time = function()
  if database:get("GetTime") then
    local data = database:get("GetTime")
    local jdat = json.decode(data)
    local A = jdat.FaTime
    local B = jdat.FaDate
    local T = {time = A, date = B}
    return T
  else
    local url, res = http.request("http://api.eset-team.com/timeplus.php")
    if res == 200 then
      local jdat = json.decode(url)
      database:setex("GetTime", 10, url)
      local A = jdat.FaTime
      local B = jdat.FaDate
      if A and B then
        local T = {time = A, date = B}
        return T
      else
        local S = {time = "---", date = "---"}
        return S
      end
    end
  end
end
-----------------------------------------------------------------------------------------------
local getMessage = function(chat_id, message_id, cb)
  tdcli_function({
    ID = "GetMessage",
    chat_id_ = chat_id,
    message_id_ = message_id
  }, cb, nil)
end
local viewMessages = function(chat_id, message_ids)
  tdcli_function({
    ID = "ViewMessages",
    chat_id_ = chat_id,
    message_ids_ = message_ids
  }, dl_cb, cmd)
end
local importContacts = function(phone_number, first_name, last_name, user_id)
  tdcli_function({
    ID = "ImportContacts",
    contacts_ = {
      [0] = {
        phone_number_ = tostring(phone_number),
        first_name_ = tostring(first_name),
        last_name_ = tostring(last_name),
        user_id_ = user_id
      }
    }
  }, cb or dl_cb, cmd)
end
local add_contact = function(phone, first_name, last_name, user_id)
  importContacts(phone, first_name, last_name, user_id)
end
local sendContact = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, phone_number, first_name, last_name, user_id)
  tdcli_function({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = from_background,
    reply_markup_ = reply_markup,
    input_message_content_ = {
      ID = "InputMessageContact",
      contact_ = {
        ID = "Contact",
        phone_number_ = phone_number,
        first_name_ = first_name,
        last_name_ = last_name,
        user_id_ = user_id
      }
    }
  }, dl_cb, nil)
end
local serialize_to_file = function(data, file, uglify)
  file = io.open(file, "w+")
  local serialized
  if not uglify then
    serialized = serpent.block(data, {comment = false, name = "_"})
  else
    serialized = serpent.dump(data)
  end
  file:write(serialized)
  file:close()
end
function exi_file(path, suffix)
  local files = {}
  local pth = tostring(path)
  local psv = tostring(suffix)
  for k, v in pairs(scandir(pth)) do
    if v:match("." .. psv .. "$") then
      table.insert(files, v)
    end
  end
  return files
end
function file_exi(name, path, suffix)
  local fname = tostring(name)
  local pth = tostring(path)
  local psv = tostring(suffix)
  for k, v in pairs(exi_file(pth, psv)) do
    if fname == v then
      return true
    end
  end
  return false
end
function string:starts(text)
  return text == string.sub(self, 1, string.len(text))
end
function download_to_file(url, file_name)
  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  local response
  if url:starts("https") then
    options.redirect = false
    response = {
      https.request(options)
    }
  else
    response = {
      http.request(options)
    }
  end
  local code = response[2]
  local headers = response[3]
  local status = response[4]
  if code ~= 200 then
    return nil
  end
  file_name = file_name or get_http_file_name(url, headers)
  local file_path = "data/" .. file_name
  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
function get_file(file_name)
  local respbody = {}
  local options = {
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  local file_path = "data/" .. file_name
  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
local sendPhoto = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo, caption)
  tdcli_function({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = from_background,
    reply_markup_ = reply_markup,
    input_message_content_ = {
      ID = "InputMessagePhoto",
      photo_ = getInputFile(photo),
      added_sticker_file_ids_ = {},
      width_ = 0,
      height_ = 0,
      caption_ = caption
    }
  }, dl_cb, nil)
end
local getUserFull = function(user_id, cb)
  tdcli_function({
    ID = "GetUserFull",
    user_id_ = user_id
  }, cb, nil)
end
local delete_msg = function(chatid, mid)
  tdcli_function({
    ID = "DeleteMessages",
    chat_id_ = chatid,
    message_ids_ = mid
  }, dl_cb, nil)
end
local sendForwarded = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, from_chat_id, message_id, cb, cmd)
  local input_message_content = {
    ID = "InputMessageForwarded",
    from_chat_id_ = from_chat_id,
    message_id_ = message_id,
    in_game_share_ = in_game_share
  }
  sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local send = function(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
  local TextParseMode = getParseMode(parse_mode)
  tdcli_function({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = 1,
    reply_markup_ = nil,
    input_message_content_ = {
      ID = "InputMessageText",
      text_ = text,
      disable_web_page_preview_ = disable_web_page_preview,
      clear_draft_ = 0,
      entities_ = {},
      parse_mode_ = TextParseMode
    }
  }, dl_cb, nil)
end
local function send_large_msg_callback(cb_extra, result)
  local text_max = 4096
  local chat_id = cb_extra._chat_id
  local text = cb_extra.text
  local text_len = string.len(text)
  local num_msg = math.ceil(text_len / text_max)
  local parse_mode = cb_extra.parse_mode
  local disable_web_page_preview = cb_extra.disable_web_page_preview
  local disable_notification = cb_extra.disable_notification
  local reply_to_message_id = cb_extra.reply_to_message_id
  if num_msg <= 1 then
    send(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
  else
    local my_text = string.sub(text, 1, 4096)
    local rest = string.sub(text, 4096, text_len)
    local cb_extra = {
      _chat_id = chat_id,
      text = text,
      reply_to_message_id = reply_to_message_id,
      disable_notification = disable_notification,
      disable_web_page_preview = disable_web_page_preview,
      parse_mode = parse_mode
    }
    local TextParseMode = getParseMode(parse_mode)
    tdcli_function({
      ID = "SendMessage",
      chat_id_ = chat_id,
      reply_to_message_id_ = reply_to_message_id,
      disable_notification_ = disable_notification,
      from_background_ = 1,
      reply_markup_ = nil,
      input_message_content_ = {
        ID = "InputMessageText",
        text_ = my_text,
        disable_web_page_preview_ = disable_web_page_preview,
        clear_draft_ = 0,
        entities_ = {},
        parse_mode_ = TextParseMode
      }
    }, send_large_msg_callback, nil)
  end
end
local send_large_msg = function(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
  local cb_extra = {
    _chat_id = chat_id,
    text = text,
    reply_to_message_id = reply_to_message_id,
    disable_notification = disable_notification,
    disable_web_page_preview = disable_web_page_preview,
    parse_mode = parse_mode
  }
  send_large_msg_callback(cb_extra, true)
end
local sendmen = function(chat_id, reply_to_message_id, text, offset, length, userid)
  tdcli_function({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = 0,
    from_background_ = 1,
    reply_markup_ = nil,
    input_message_content_ = {
      ID = "InputMessageText",
      text_ = text,
      disable_web_page_preview_ = 1,
      clear_draft_ = 0,
      entities_ = {
        [0] = {
          ID = "MessageEntityMentionName",
          offset_ = offset,
          length_ = length,
          user_id_ = userid
        }
      }
    }
  }, dl_cb, nil)
end
local sendDocument = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, cb, cmd)
  local input_message_content = {
    ID = "InputMessageDocument",
    document_ = getInputFile(document),
    caption_ = caption
  }
  sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local sendaction = function(chat_id, action, progress)
  tdcli_function({
    ID = "SendChatAction",
    chat_id_ = chat_id,
    action_ = {
      ID = "SendMessage" .. action .. "Action",
      progress_ = progress or 100
    }
  }, dl_cb, nil)
end
local changetitle = function(chat_id, title)
  tdcli_function({
    ID = "ChangeChatTitle",
    chat_id_ = chat_id,
    title_ = title
  }, dl_cb, nil)
end
local importChatInviteLink = function(invite_link)
  tdcli_function({
    ID = "ImportChatInviteLink",
    invite_link_ = invite_link
  }, cb or dl_cb, nil)
end
local checkChatInviteLink = function(link, cb)
  tdcli_function({
    ID = "CheckChatInviteLink",
    invite_link_ = link
  }, cb or dl_cb, nil)
end
local edit = function(chat_id, message_id, reply_markup, text, disable_web_page_preview, parse_mode)
  local TextParseMode = getParseMode(parse_mode)
  tdcli_function({
    ID = "EditMessageText",
    chat_id_ = chat_id,
    message_id_ = message_id,
    reply_markup_ = reply_markup,
    input_message_content_ = {
      ID = "InputMessageText",
      text_ = text,
      disable_web_page_preview_ = disable_web_page_preview,
      clear_draft_ = 0,
      entities_ = {},
      parse_mode_ = TextParseMode
    }
  }, dl_cb, nil)
end
local setphoto = function(chat_id, photo)
  tdcli_function({
    ID = "ChangeChatPhoto",
    chat_id_ = chat_id,
    photo_ = getInputFile(photo)
  }, dl_cb, nil)
end
local add_user = function(chat_id, user_id, forward_limit)
  tdcli_function({
    ID = "AddChatMember",
    chat_id_ = chat_id,
    user_id_ = user_id,
    forward_limit_ = forward_limit or 50
  }, dl_cb, nil)
end
local pinmsg = function(channel_id, message_id, disable_notification)
  tdcli_function({
    ID = "PinChannelMessage",
    channel_id_ = getChatId(channel_id).ID,
    message_id_ = message_id,
    disable_notification_ = disable_notification
  }, dl_cb, nil)
end
local unpinmsg = function(channel_id)
  tdcli_function({
    ID = "UnpinChannelMessage",
    channel_id_ = getChatId(channel_id).ID
  }, dl_cb, nil)
end
local blockUser = function(user_id)
  tdcli_function({ID = "BlockUser", user_id_ = user_id}, dl_cb, nil)
end
local unblockUser = function(user_id)
  tdcli_function({
    ID = "UnblockUser",
    user_id_ = user_id
  }, dl_cb, nil)
end
local checkChatInviteLink = function(link, cb)
  tdcli_function({
    ID = "CheckChatInviteLink",
    invite_link_ = link
  }, cb or dl_cb, nil)
end
local openChat = function(chat_id, cb)
  tdcli_function({ID = "OpenChat", chat_id_ = chat_id}, cb or dl_cb, nil)
end
local getBlockedUsers = function(offset, limit)
  tdcli_function({
    ID = "GetBlockedUsers",
    offset_ = offset,
    limit_ = limit
  }, dl_cb, nil)
end
local chat_del_user = function(chat_id, user_id)
  changeChatMemberStatus(chat_id, user_id, "Editor")
end
local getChannelFull = function(channel_id, cb)
  tdcli_function({
    ID = "GetChannelFull",
    channel_id_ = getChatId(channel_id).ID
  }, cb or dl_cb, nil)
end
local getChat = function(chat_id, cb)
  tdcli_function({ID = "GetChat", chat_id_ = chat_id}, cb or dl_cb, nil)
end
local getGroupLink = function(msg, chat_id)
  local chat = tostring(chat_id)
  link = database:get("bot:group:link" .. chat)
  if link then
    if database:get("lang:gp:" .. msg.chat_id_) then
      send(msg.chat_id_, msg.id_, 1, "\226\128\162 <b>link to Group</b> :\n\n" .. link, 1, "html")
    else
      send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 :\n\n" .. link, 1, "html")
    end
  elseif database:get("lang:gp:" .. msg.chat_id_) then
    send(msg.chat_id_, msg.id_, 1, "\226\128\162 I have *Not Link* of This Group !", 1, "md")
  else
    send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\217\134\218\169 \216\167\219\140\217\134 \218\175\216\177\217\136\217\135 \216\177\216\167 \217\134\216\175\216\167\216\177\217\133 !", 1, "md")
  end
end
local getChannelMembers = function(channel_id, offset, filter, limit, cb)
  if not limit or limit > 200 then
    limit = 200
  end
  tdcli_function({
    ID = "GetChannelMembers",
    channel_id_ = getChatId(channel_id).ID,
    filter_ = {
      ID = "ChannelMembers" .. filter
    },
    offset_ = offset,
    limit_ = limit
  }, cb or dl_cb, cmd)
end
local deleteChatHistory = function(chat_id, cb)
  tdcli_function({
    ID = "DeleteChatHistory",
    chat_id_ = chat_id,
    remove_from_chat_list_ = 0
  }, cb or dl_cb, nil)
end
local getChatHistory = function(chat_id, from_message_id, offset, limit, cb)
  if not limit or limit > 100 then
    limit = 100
  end
  tdcli_function({
    ID = "GetChatHistory",
    chat_id_ = chat_id,
    from_message_id_ = from_message_id,
    offset_ = offset or 0,
    limit_ = limit
  }, cb or dl_cb, nil)
end
local sendSticker = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker)
  local input_message_content = {
    ID = "InputMessageSticker",
    sticker_ = getInputFile(sticker),
    width_ = 0,
    height_ = 0
  }
  sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local getInputMessageContent = function(file, filetype, caption)
  if file:match("/") or file:match(".") then
    infile = {
      ID = "InputFileLocal",
      path_ = file
    }
  elseif file:match("^%d+$") then
    infile = {
      ID = "InputFileId",
      id_ = file
    }
  else
    infile = {
      ID = "InputFilePersistentId",
      persistent_id_ = file
    }
  end
  local inmsg = {}
  local filetype = filetype:lower()
  if filetype == "animation" then
    inmsg = {
      ID = "InputMessageAnimation",
      animation_ = infile,
      caption_ = caption
    }
  elseif filetype == "audio" then
    inmsg = {
      ID = "InputMessageAudio",
      audio_ = infile,
      caption_ = caption
    }
  elseif filetype == "document" then
    inmsg = {
      ID = "InputMessageDocument",
      document_ = infile,
      caption_ = caption
    }
  elseif filetype == "photo" then
    inmsg = {
      ID = "InputMessagePhoto",
      photo_ = infile,
      caption_ = caption
    }
  elseif filetype == "sticker" then
    inmsg = {
      ID = "InputMessageSticker",
      sticker_ = infile,
      caption_ = caption
    }
  elseif filetype == "video" then
    inmsg = {
      ID = "InputMessageVideo",
      video_ = infile,
      caption_ = caption
    }
  elseif filetype == "voice" then
    inmsg = {
      ID = "InputMessageVoice",
      voice_ = infile,
      caption_ = caption
    }
  end
  return inmsg
end
local downloadFile = function(file_id, cb)
  tdcli_function({
    ID = "DownloadFile",
    file_id_ = file_id
  }, cb or dl_cb, nil)
end
local resetgroup = function(chat_id)
  database:del("bot:muteall" .. chat_id)
  database:del("bot:text:mute" .. chat_id)
  database:del("bot:photo:mute" .. chat_id)
  database:del("bot:video:mute" .. chat_id)
  database:del("bot:selfvideo:mute" .. chat_id)
  database:del("bot:gifs:mute" .. chat_id)
  database:del("anti-flood:" .. chat_id)
  database:del("flood:max:" .. chat_id)
  database:del("bot:sens:spam" .. chat_id)
  database:del("floodstatus" .. chat_id)
  database:del("bot:music:mute" .. chat_id)
  database:del("bot:bots:mute" .. chat_id)
  database:del("bot:duplipost:mute" .. chat_id)
  database:del("bot:inline:mute" .. chat_id)
  database:del("bot:cmds" .. chat_id)
  database:del("bot:bots:mute" .. chat_id)
  database:del("bot:voice:mute" .. chat_id)
  database:del("editmsg" .. chat_id)
  database:del("bot:links:mute" .. chat_id)
  database:del("bot:pin:mute" .. chat_id)
  database:del("bot:sticker:mute" .. chat_id)
  database:del("bot:tgservice:mute" .. chat_id)
  database:del("bot:webpage:mute" .. chat_id)
  database:del("bot:strict" .. chat_id)
  database:del("bot:hashtag:mute" .. chat_id)
  database:del("tags:lock" .. chat_id)
  database:del("bot:location:mute" .. chat_id)
  database:del("bot:contact:mute" .. chat_id)
  database:del("bot:english:mute" .. chat_id)
  database:del("bot:arabic:mute" .. chat_id)
  database:del("bot:forward:mute" .. chat_id)
  database:del("bot:member:lock" .. chat_id)
  database:del("bot:document:mute" .. chat_id)
  database:del("markdown:lock" .. chat_id)
  database:del("Game:lock" .. chat_id)
  database:del("bot:spam:mute" .. chat_id)
  database:del("post:lock" .. chat_id)
  database:del("bot:welcome" .. chat_id)
  database:del("delidstatus" .. chat_id)
  database:del("delpro:" .. chat_id)
  database:del("sharecont" .. chat_id)
  database:del("sayedit" .. chat_id)
  database:del("welcome:" .. chat_id)
  database:del("bot:group:link" .. chat_id)
  database:del("bot:filters:" .. chat_id)
  database:del("bot:muteall:Time" .. chat_id)
  database:del("bot:muteall:start" .. chat_id)
  database:del("bot:muteall:stop" .. chat_id)
  database:del("bot:muteall:start_Unix" .. chat_id)
  database:del("bot:muteall:stop_Unix" .. chat_id)
  database:del("bot:muteall:Run" .. chat_id)
  database:del("bot:muted:" .. chat_id)
end
local resetsettings = function(chat_id, cb)
  database:del("bot:muteall" .. chat_id)
  database:del("bot:text:mute" .. chat_id)
  database:del("bot:photo:mute" .. chat_id)
  database:del("bot:video:mute" .. chat_id)
  database:del("bot:selfvideo:mute" .. chat_id)
  database:del("bot:gifs:mute" .. chat_id)
  database:del("anti-flood:" .. chat_id)
  database:del("flood:max:" .. chat_id)
  database:del("bot:sens:spam" .. chat_id)
  database:del("bot:music:mute" .. chat_id)
  database:del("bot:bots:mute" .. chat_id)
  database:del("bot:duplipost:mute" .. chat_id)
  database:del("bot:inline:mute" .. chat_id)
  database:del("bot:cmds" .. chat_id)
  database:del("bot:voice:mute" .. chat_id)
  database:del("editmsg" .. chat_id)
  database:del("bot:links:mute" .. chat_id)
  database:del("bot:pin:mute" .. chat_id)
  database:del("bot:sticker:mute" .. chat_id)
  database:del("bot:tgservice:mute" .. chat_id)
  database:del("bot:webpage:mute" .. chat_id)
  database:del("bot:strict" .. chat_id)
  database:del("bot:hashtag:mute" .. chat_id)
  database:del("tags:lock" .. chat_id)
  database:del("bot:location:mute" .. chat_id)
  database:del("bot:contact:mute" .. chat_id)
  database:del("bot:english:mute" .. chat_id)
  database:del("bot:member:lock" .. chat_id)
  database:del("bot:arabic:mute" .. chat_id)
  database:del("bot:forward:mute" .. chat_id)
  database:del("bot:document:mute" .. chat_id)
  database:del("markdown:lock" .. chat_id)
  database:del("Game:lock" .. chat_id)
  database:del("bot:spam:mute" .. chat_id)
  database:del("post:lock" .. chat_id)
  database:del("sayedit" .. chat_id)
  database:del("bot:muteall:Time" .. chat_id)
  database:del("bot:muteall:start" .. chat_id)
  database:del("bot:muteall:stop" .. chat_id)
  database:del("bot:muteall:start_Unix" .. chat_id)
  database:del("bot:muteall:stop_Unix" .. chat_id)
  database:del("bot:muteall:Run" .. chat_id)
end
local panel_one = function(chat_id)
  database:set("bot:webpage:mute" .. chat_id, true)
  database:set("bot:inline:mute" .. chat_id, true)
  database:set("bot:bots:mute" .. chat_id, true)
  database:set("tags:lock" .. chat_id, true)
  database:set("markdown:lock" .. chat_id, true)
  database:set("bot:links:mute" .. chat_id, true)
  database:set("bot:hashtag:mute" .. chat_id, true)
  database:set("bot:spam:mute" .. chat_id, true)
  database:set("anti-flood:" .. chat_id, true)
  database:set("Game:lock" .. chat_id, true)
  database:set("bot:panel" .. chat_id, "one")
end
local panel_two = function(chat_id)
  database:set("bot:webpage:mute" .. chat_id, true)
  database:set("bot:inline:mute" .. chat_id, true)
  database:set("bot:bots:mute" .. chat_id, true)
  database:set("tags:lock" .. chat_id, true)
  database:set("markdown:lock" .. chat_id, true)
  database:set("bot:links:mute" .. chat_id, true)
  database:set("bot:hashtag:mute" .. chat_id, true)
  database:set("bot:spam:mute" .. chat_id, true)
  database:set("anti-flood:" .. chat_id, true)
  database:set("Game:lock" .. chat_id, true)
  database:set("post:lock" .. chat_id, true)
  database:set("bot:forward:mute" .. chat_id, true)
  database:set("bot:photo:mute" .. chat_id, true)
  database:set("bot:video:mute" .. chat_id, true)
  database:set("bot:selfvideo:mute" .. chat_id, true)
  database:set("bot:gifs:mute" .. chat_id, true)
  database:set("bot:sticker:mute" .. chat_id, true)
  database:set("bot:location:mute" .. chat_id, true)
  database:set("bot:document:mute" .. chat_id, true)
  database:set("bot:panel" .. chat_id, "two")
end
local panel_three = function(chat_id)
  database:set("bot:inline:mute" .. chat_id, true)
  database:set("bot:bots:mute" .. chat_id, true)
  database:set("markdown:lock" .. chat_id, true)
  database:set("bot:links:mute" .. chat_id, true)
  database:set("bot:spam:mute" .. chat_id, true)
  database:set("bot:sens:spam" .. chat_id, 500)
  database:set("anti-flood:" .. chat_id, true)
  database:set("Game:lock" .. chat_id, true)
  database:set("bot:cmds" .. chat_id, true)
  database:set("bot:duplipost:mute" .. chat_id, true)
  database:set("bot:panel" .. chat_id, "three")
end
function string:starts(text)
  return text == string.sub(self, 1, string.len(text))
end
function download_to_file(url, file_name)
  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  local response
  if url:starts("https") then
    options.redirect = false
    response = {
      https.request(options)
    }
  else
    response = {
      http.request(options)
    }
  end
  local code = response[2]
  local headers = response[3]
  local status = response[4]
  if code ~= 200 then
    return nil
  end
  file_name = file_name or get_http_file_name(url, headers)
  local file_path = "data/" .. file_name
  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
function get_file(file_name)
  local respbody = {}
  local options = {
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  local file_path = "data/" .. file_name
  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
local filter_ok = function(value)
  local var = true
  if string.find(value, "@") then
    var = false
  end
  if string.find(value, "-") then
    var = false
  end
  if string.find(value, "_") then
    var = false
  end
  if string.find(value, "/") then
    var = false
  end
  if string.find(value, "#") then
    var = false
  end
  return var
end
local getTime = function(seconds)
  local final = ""
  local hours = math.floor(seconds / 3600)
  seconds = seconds - hours * 60 * 60
  local min = math.floor(seconds / 60)
  seconds = seconds - min * 60
  local S = hours .. ":" .. min .. ":" .. seconds
  return S
end
local getTimeUptime = function(seconds, lang)
  local days = math.floor(seconds / 86400)
  seconds = seconds - days * 86400
  local hours = math.floor(seconds / 3600)
  seconds = seconds - hours * 60 * 60
  local min = math.floor(seconds / 60)
  seconds = seconds - min * 60
  if days == 0 then
    days = nil
  else
  end
  if hours == 0 then
    hours = nil
  else
  end
  if min == 0 then
    min = nil
  else
  end
  if seconds == 0 then
    seconds = nil
  else
  end
  local text = ""
  if lang == "Fa" then
    if days then
      if hours or min or seconds then
        text = text .. days .. " \216\177\217\136\216\178 \217\136 "
      else
        text = text .. days .. " \216\177\217\136\216\178"
      end
    end
    if hours then
      if min or seconds then
        text = text .. hours .. " \216\179\216\167\216\185\216\170 \217\136 "
      else
        text = text .. hours .. " \216\179\216\167\216\185\216\170"
      end
    end
    if min then
      if seconds then
        text = text .. min .. " \216\175\217\130\219\140\217\130\217\135 \217\136 "
      else
        text = text .. min .. " \216\175\217\130\219\140\217\130\217\135"
      end
    end
    if seconds then
      text = text .. seconds .. " \216\171\216\167\217\134\219\140\217\135"
    end
  else
    if days then
      if hours or min or seconds then
        text = text .. days .. " Days and "
      else
        text = text .. days .. " Days"
      end
    end
    if hours then
      if min or seconds then
        text = text .. hours .. " Hours and "
      else
        text = text .. hours .. " Hours"
      end
    end
    if min then
      if seconds then
        text = text .. min .. " Min and "
      else
        text = text .. min .. " Min"
      end
    end
    if seconds then
      text = text .. seconds .. " Sec"
    end
  end
  return text
end
function GetUptimeServer(uptime, lang)
  local uptime = io.popen("uptime -p"):read("*all")
  days = uptime:match("up %d+ days")
  hours = uptime:match(", %d+ hours")
  minutes = uptime:match(", %d+ minutes")
  if hours then
    hours = hours
  else
    hours = ""
  end
  if days then
    days = days
  else
    days = ""
  end
  if minutes then
    minutes = minutes
  else
    minutes = ""
  end
  days = days:gsub("up", "")
  local a_ = string.match(days, "%d+")
  local b_ = string.match(hours, "%d+")
  local c_ = string.match(minutes, "%d+")
  if a_ then
    a = a_ * 86400
  else
    a = 0
  end
  if b_ then
    b = b_ * 3600
  else
    b = 0
  end
  if c_ then
    c = c_ * 60
  else
    c = 0
  end
  x = b + a + c
  local resultUp = getTimeUptime(x, lang)
  return resultUp
end
local who_add = function(chat)
  local user_id
  local user = false
  local list1 = database:smembers("Bot:SudoUsers")
  local list2 = database:smembers("Bot:Admins")
  for k, v in pairs(list1) do
    local hash = "sudo:data:" .. v
    local is_add = database:sismember(hash, chat)
    if is_add then
      user_id = v
    end
  end
  for k, v in pairs(list2) do
    local hash = "sudo:data:" .. v
    local is_add = database:sismember(hash, chat)
    if is_add then
      user_id = v
    end
  end
  local hash = "sudo:data:" .. bot_owner
  if database:sismember(hash, chat) then
    user_id = bot_owner
  end
  if user_id then
    local user_info = database:get("user:Name" .. user_id)
    if user_info then
      user = user_info
    end
  end
  return user
end
function resolve_username(username,cb)
  tdcli_function ({
    ID = "SearchPublicChat",
    username_ = username
  }, cb, nil)
end
-----------------------------------------------------------------------------------------------
function changeChatMemberStatus(chat_id, user_id, status)
  tdcli_function ({
    ID = "ChangeChatMemberStatus",
    chat_id_ = chat_id,
    user_id_ = user_id,
    status_ = {
      ID = "ChatMemberStatus" .. status
    },
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function getInputFile(file)
  if file:match('/') then
    infile = {ID = "InputFileLocal", path_ = file}
  elseif file:match('^%d+$') then
    infile = {ID = "InputFileId", id_ = file}
  else
    infile = {ID = "InputFilePersistentId", persistent_id_ = file}
  end

  return infile
end
-----------------------------------------------------------------------------------------------
function del_all_msgs(chat_id, user_id)
  tdcli_function ({
    ID = "DeleteMessagesFromUser",
    chat_id_ = chat_id,
    user_id_ = user_id
  }, dl_cb, nil)
end


-----------------------------------------------------------------------------------------------
function getChatId(id)
  local chat = {}
  local id = tostring(id)

  if id:match('^-100') then
    local channel_id = id:gsub('-100', '')
    chat = {ID = channel_id, type = 'channel'}
  else
    local group_id = id:gsub('-', '')
    chat = {ID = group_id, type = 'group'}
  end

  return chat
end
-----------------------------------------------------------------------------------------------
function chat_leave(chat_id, user_id)
  changeChatMemberStatus(chat_id, user_id, "Left")
end
-----------------------------------------------------------------------------------------------
function from_username(msg)
  function gfrom_user(extra,result,success)
    if result.username_ then
      F = result.username_
    else
      F = 'nil'
    end
    return F
  end
  local username = getUser(msg.sender_user_id_,gfrom_user)
  return username
end
-----------------------------------------------------------------------------------------------
function do_notify (user, msg)
  local n = notify.Notification.new(user, msg)
  n:show ()
end
-----------------------------------------------------------------------------------------------
function chat_kick(chat_id, user_id)
  changeChatMemberStatus(chat_id, user_id, "Kicked")
end
-----------------------------------------------------------------------------------------------
database:del("sayCheck_user_channel")
function check_user_channel(msg)
  local var = true
  local sayCheck_user_channel = function(msg)
    if not database:sismember("sayCheck_user_channel", msg.id_) then
      if database:get("lang:gp:" .. msg.chat_id_) then
        send(msg.chat_id_, msg.id_, 1, "\226\128\162 <b>Dear User</b>,Plese Before Operating The Bot , <b>Subscribe</b> To <b>Bot Channel</b> !\nOtherwise, You <b>Will Not</b> Be Able To Command The Bot !\n\194\187 <b>Channel ID</b> : " .. Bot_Channel, 1, "html")
      else
        send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 \218\175\216\177\216\167\217\133\219\140 \216\140 \216\167\216\168\216\170\216\175\216\167 \216\168\216\177\216\167\219\140 \218\169\216\167\216\177 \216\168\216\167 \216\177\216\168\216\167\216\170 \217\136\216\167\216\177\216\175 \218\169\216\167\217\134\216\167\217\132 \216\177\216\168\216\167\216\170 \216\180\217\136\219\140\216\175 !\n\216\175\216\177 \216\186\219\140\216\177 \216\167\219\140\217\134 \216\181\217\136\216\177\216\170 \217\130\216\167\216\175\216\177 \216\168\217\135 \216\175\216\167\216\175\217\134 \217\129\216\177\217\133\216\167\217\134 \216\168\217\135 \216\177\216\168\216\167\216\170 \217\134\216\174\217\136\216\167\217\135\219\140\216\175 \216\168\217\136\216\175 !\n\194\187 \216\162\219\140\216\175\219\140 \218\169\216\167\217\134\216\167\217\132 : " .. Bot_Channel, 1, "html")
      end
      database:sadd("sayCheck_user_channel", msg.id_)
    end
  end
  if database:get("bot:joinch") and is_momod(msg.sender_user_id_, msg.chat_id_) and not is_admin(msg.sender_user_id_) and not is_channelmember(msg) then
    var = false
    return sayCheck_user_channel(msg)
  end
  return var
end
function getParseMode(parse_mode)
  if parse_mode then
    local mode = parse_mode:lower()

    if mode == 'markdown' or mode == 'md' then
      P = {ID = "TextParseModeMarkdown"}
    elseif mode == 'html' then
      P = {ID = "TextParseModeHTML"}
    end
  end
  return P
end
-----------------------------------------------------------------------------------------------
function getMessage(chat_id, message_id,cb)
  tdcli_function ({
    ID = "GetMessage",
    chat_id_ = chat_id,
    message_id_ = message_id
  }, cb, nil)
end
-----------------------------------------------------------------------------------------------
function sendContact(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, phone_number, first_name, last_name, user_id)
  tdcli_function ({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = from_background,
    reply_markup_ = reply_markup,
    input_message_content_ = {
      ID = "InputMessageContact",
      contact_ = {
        ID = "Contact",
        phone_number_ = phone_number,
        first_name_ = first_name,
        last_name_ = last_name,
        user_id_ = user_id
      },
    },
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo, caption)
  tdcli_function ({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = from_background,
    reply_markup_ = reply_markup,
    input_message_content_ = {
      ID = "InputMessagePhoto",
      photo_ = getInputFile(photo),
      added_sticker_file_ids_ = {},
      width_ = 0,
      height_ = 0,
      caption_ = caption
    },
  }, dl_cb, nil)
end
database:del("sayCheck_user_channel")
function check_user_channel(msg)
  local var = true
  local sayCheck_user_channel = function(msg)
    if not database:sismember("sayCheck_user_channel", msg.id_) then
      if database:get("lang:gp:" .. msg.chat_id_) then
        send(msg.chat_id_, msg.id_, 1, "\226\128\162 <b>Dear User</b>,Plese Before Operating The Bot , <b>Subscribe</b> To <b>Bot Channel</b> !\nOtherwise, You <b>Will Not</b> Be Able To Command The Bot !\n\194\187 <b>Channel ID</b> : " .. Bot_Channel, 1, "html")
      else
        send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 \218\175\216\177\216\167\217\133\219\140 \216\140 \216\167\216\168\216\170\216\175\216\167 \216\168\216\177\216\167\219\140 \218\169\216\167\216\177 \216\168\216\167 \216\177\216\168\216\167\216\170 \217\136\216\167\216\177\216\175 \218\169\216\167\217\134\216\167\217\132 \216\177\216\168\216\167\216\170 \216\180\217\136\219\140\216\175 !\n\216\175\216\177 \216\186\219\140\216\177 \216\167\219\140\217\134 \216\181\217\136\216\177\216\170 \217\130\216\167\216\175\216\177 \216\168\217\135 \216\175\216\167\216\175\217\134 \217\129\216\177\217\133\216\167\217\134 \216\168\217\135 \216\177\216\168\216\167\216\170 \217\134\216\174\217\136\216\167\217\135\219\140\216\175 \216\168\217\136\216\175 !\n\194\187 \216\162\219\140\216\175\219\140 \218\169\216\167\217\134\216\167\217\132 : " .. Bot_Channel, 1, "html")
      end
      database:sadd("sayCheck_user_channel", msg.id_)
    end
  end
  if database:get("bot:joinch") and is_momod(msg.sender_user_id_, msg.chat_id_) and not is_admin(msg.sender_user_id_) and not is_channelmember(msg) then
    var = false
    return sayCheck_user_channel(msg)
  end
  return var
end
-----------------------------------------------------------------------------------------------
function getUserFull(user_id,cb)
  tdcli_function ({
    ID = "GetUserFull",
    user_id_ = user_id
  }, cb, nil)
end
-----------------------------------------------------------------------------------------------
function vardump(value)
  print(serpent.block(value, {comment=false}))
end
-----------------------------------------------------------------------------------------------
function dl_cb(arg, data)
end
----------------------------------------------------------------------------------------------
function delete_msg(chatid ,mid)
  tdcli_function ({
    ID = "DeleteMessages",
    chat_id_ = chatid,
    message_ids_ = mid
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function send(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
  local TextParseMode = getParseMode(parse_mode)
  tdcli_function ({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = 1,
    reply_markup_ = nil,
    input_message_content_ = {
      ID = "InputMessageText",
      text_ = text,
      disable_web_page_preview_ = disable_web_page_preview,
      clear_draft_ = 0,
      entities_ = {},
      parse_mode_ = TextParseMode,
    },
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function sendaction(chat_id, action, progress)
  tdcli_function ({
    ID = "SendChatAction",
    chat_id_ = chat_id,
    action_ = {
      ID = "SendMessage" .. action .. "Action",
      progress_ = progress or 100
    }
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function changetitle(chat_id, title)
  tdcli_function ({
    ID = "ChangeChatTitle",
    chat_id_ = chat_id,
    title_ = title
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
local function getInlineQueryResults(bot_user_id, chat_id, latitude, longitude, query, offset, cb, cmd)
  tdcli_function ({
    ID = "GetInlineQueryResults",
    bot_user_id_ = bot_user_id,
    chat_id_ = chat_id,
    user_location_ = {
      ID = "Location",
      latitude_ = latitude,
      longitude_ = longitude
    },
    query_ = query,
    offset_ = offset
  }, cb or dl_cb, cmd)
end

-----------------------------------------------------------------------------------------------------
local function sendInlineQueryResultMessage(chat_id, reply_to_message_id, disable_notification, from_background, query_id, result_id, cb, cmd)
  tdcli_function ({
    ID = "SendInlineQueryResultMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = from_background,
    query_id_ = query_id,
    result_id_ = result_id
  }, cb or dl_cb, cmd)
end
-----------------------------------------------------------------------------------------------------
function edit(chat_id, message_id, reply_markup, text, disable_web_page_preview, parse_mode)
  local TextParseMode = getParseMode(parse_mode)
  tdcli_function ({
    ID = "EditMessageText",
    chat_id_ = chat_id,
    message_id_ = message_id,
    reply_markup_ = reply_markup,
    input_message_content_ = {
      ID = "InputMessageText",
      text_ = text,
      disable_web_page_preview_ = disable_web_page_preview,
      clear_draft_ = 0,
      entities_ = {},
      parse_mode_ = TextParseMode,
    },
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function setphoto(chat_id, photo)
  tdcli_function ({
    ID = "ChangeChatPhoto",
    chat_id_ = chat_id,
    photo_ = getInputFile(photo)
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function add_user(chat_id, user_id, forward_limit)
  tdcli_function ({
    ID = "AddChatMember",
    chat_id_ = chat_id,
    user_id_ = user_id,
    forward_limit_ = forward_limit or 50
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function unpinmsg(channel_id)
  tdcli_function ({
    ID = "UnpinChannelMessage",
    channel_id_ = getChatId(channel_id).ID
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function blockUser(user_id)
  tdcli_function ({
    ID = "BlockUser",
    user_id_ = user_id
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function unblockUser(user_id)
  tdcli_function ({
    ID = "UnblockUser",
    user_id_ = user_id
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function getBlockedUsers(offset, limit)
  tdcli_function ({
    ID = "GetBlockedUsers",
    offset_ = offset,
    limit_ = limit
  }, dl_cb, nil)
end
------------------------------------------------------------------------------------------------
function delmsg(arg,data)
  for k,v in pairs(data.messages_) do
    delete_msg(v.chat_id_,{[0] = v.id_})
  end
end
-------------------------------------------------------------------------------------------------
function chat_del_user(chat_id, user_id)
  changeChatMemberStatus(chat_id, user_id, 'Editor')
end
-----------------------------------------------------------------------------------------------
function getChannelMembers(channel_id, offset, filter, limit)
  if not limit or limit > 200 then
    limit = 200
  end
  tdcli_function ({
    ID = "GetChannelMembers",
    channel_id_ = getChatId(channel_id).ID,
    filter_ = {
      ID = "ChannelMembers" .. filter
    },
    offset_ = offset,
    limit_ = limit
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function getChannelFull(channel_id)
  tdcli_function ({
    ID = "GetChannelFull",
    channel_id_ = getChatId(channel_id).ID
  }, dl_cb, nil)
end
-----------------------------------------------------------------------------------------------
function channel_get_bots(channel,cb)
  local function callback_admins(extra,result,success)
    limit = result.member_count_
    getChannelMembers(channel, 0, 'Bots', limit,cb)
  end
  getChannelFull(channel,callback_admins)
end
-----------------------------------------------------------------------------------------------
function getInputMessageContent(file, filetype, caption)
  if file:match('/') or file:match('.') then
    infile = {ID = "InputFileLocal", path_ = file}
  elseif file:match('^%d+$') then
    infile = {ID = "InputFileId", id_ = file}
  else
    infile = {ID = "InputFilePersistentId", persistent_id_ = file}
  end

  local inmsg = {}
  local filetype = filetype:lower()

  if filetype == 'animation' then
    inmsg = {ID = "InputMessageAnimation", animation_ = infile, caption_ = caption}
  elseif filetype == 'audio' then
    inmsg = {ID = "InputMessageAudio", audio_ = infile, caption_ = caption}
  elseif filetype == 'document' then
    inmsg = {ID = "InputMessageDocument", document_ = infile, caption_ = caption}
  elseif filetype == 'photo' then
    inmsg = {ID = "InputMessagePhoto", photo_ = infile, caption_ = caption}
  elseif filetype == 'sticker' then
    inmsg = {ID = "InputMessageSticker", sticker_ = infile, caption_ = caption}
  elseif filetype == 'video' then
    inmsg = {ID = "InputMessageVideo", video_ = infile, caption_ = caption}
  elseif filetype == 'voice' then
    inmsg = {ID = "InputMessageVoice", voice_ = infile, caption_ = caption}
  end

  return inmsg
end

-----------------------------------------------------------------------------------------------
function getUser(user_id, cb)
  tdcli_function ({
    ID = "GetUser",
    user_id_ = user_id
  }, cb, nil)
end
-----------------------------------------------------------------------------------------------
function pinmsg(channel_id, message_id, disable_notification) 
   tdcli_function ({ 
     ID = "PinChannelMessage", 
     channel_id_ = getChatId(channel_id).ID, 
     message_id_ = message_id, 
     disable_notification_ = disable_notification 
   }, dl_cb, nil) 
end 
----------------------------------------------------------------------------------------------
local function check_filter_words(msg, value)
  local hash = 'bot:filters:'..msg.chat_id_
  if hash then
    local names = database:hkeys(hash)
    local text = ''
	local value = value:gsub(' ','')
    for i=1, #names do
      if string.match(value:lower(), names[i]:lower()) and not is_momod(msg.sender_user_id_, msg.chat_id_)then
        local id = msg.id_
        local msgs = {[0] = id}
        local chat = msg.chat_id_
        delete_msg(chat,msgs)
      end
    end
  end
end
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)
  -------------------------------------------
  if (data.ID == "UpdateNewMessage") then
    local msg = data.message_
    --vardump(data)
    local d = data.disable_notification_
    local chat = chats[msg.chat_id_]
    ----------------OLD MSG--------------------
    if msg.date_ < (os.time() - 30) then
      print("**** OLD MSG ****")
      return false
    end
    -------* Expire & AutoLeave *-------
    local expiretime = database:ttl("bot:charge:" .. msg.chat_id_)
    if not database:get("bot:charge:" .. msg.chat_id_) and database:get("bot:enable:" .. msg.chat_id_) then
      database:del("bot:enable:" .. msg.chat_id_)
      database:srem("bot:groups", msg.chat_id_)
    end
    if database:get("bot:charge:" .. msg.chat_id_) and not database:get("bot:enable:" .. msg.chat_id_) then
      database:set("bot:enable:" .. msg.chat_id_, true)
    end
    if not database:get("bot:expirepannel:" .. msg.chat_id_) and database:get("bot:charge:" .. msg.chat_id_) and tonumber(expiretime) < tonumber(day) and tonumber(expiretime) >= 3600 then
      local id = tostring(msg.chat_id_)
      if id:match("-100(%d+)") then
        local v = tonumber(bot_owner)
        local list = database:smembers("bot:owners:" .. msg.chat_id_)
        if list[1] or list[2] or list[3] or list[4] then
          user_info = database:get("user:Name" .. (list[1] or list[2] or list[3] or list[4]))
        end
        if user_info then
          owner = user_info
        else
          owner = "\219\140\216\167\217\129\216\170 \217\134\216\180\216\175 "
        end
        local User = who_add(msg.chat_id_)
        if User then
          sudo = User
        else
          sudo = "\219\140\216\167\217\129\216\170 \217\134\216\180\216\175"
        end
        send(v, 0, 1, "\226\128\162\226\128\162 \216\170\216\167\216\177\219\140\216\174 \216\170\217\133\216\175\219\140\216\175 \216\167\219\140\217\134 \218\175\216\177\217\136\217\135 \217\129\216\177\216\167 \216\177\216\179\219\140\216\175 !\n\226\128\162\226\128\162 \217\132\219\140\217\134\218\169 : " .. (database:get("bot:group:link" .. msg.chat_id_) or "\216\170\217\134\216\184\219\140\217\133 \217\134\216\180\216\175\217\135") .. "\n\226\128\162\226\128\162 \216\180\217\134\216\167\216\179\217\135 \218\175\216\177\217\136\217\135 :  <code>" .. msg.chat_id_ .. "</code>\n\226\128\162\226\128\162 \217\134\216\167\217\133 \218\175\216\177\217\136\217\135 : " .. (chat.title_ or "---") .. "\n\226\128\162\226\128\162 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 : " .. owner .. "\n\226\128\162\226\128\162 \217\135\217\133\218\169\216\167\216\177 \216\167\216\182\216\167\217\129\217\135 \218\169\217\134\217\134\216\175\217\135 : " .. sudo .. "\n\n\226\128\162\226\128\162 \216\167\218\175\216\177 \217\133\219\140\216\174\217\136\216\167\217\135\219\140\216\175 \216\177\216\168\216\167\216\170 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\170\216\177\218\169 \218\169\217\134\216\175 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177 \216\178\219\140\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \218\169\217\134\219\140\216\175 :\n\n\226\128\162\226\128\162  <code>leave" .. msg.chat_id_ .. "</code>\n\n\226\128\162\226\128\162 \216\167\218\175\216\177 \217\130\216\181\216\175 \217\136\216\167\216\177\216\175 \216\180\216\175\217\134 \216\168\217\135 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\175\216\167\216\177\219\140\216\175 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177 \216\178\219\140\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \218\169\217\134\219\140\216\175 :\n\n\226\128\162\226\128\162  <code>join" .. msg.chat_id_ .. "</code>\n\n\226\128\162\226\128\162 \216\167\218\175\216\177 \217\133\219\140\216\174\217\136\216\167\217\135\219\140\216\175 \216\177\216\168\216\167\216\170 \216\175\216\167\216\174\217\132 \218\175\216\177\217\136\217\135 \216\167\216\185\217\132\216\167\217\133 \218\169\217\134\216\175 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177 \216\178\219\140\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \218\169\217\134\219\140\216\175 :\n\n\226\128\162\226\128\162  <code>meld" .. msg.chat_id_ .. "</code>\n\n\226\128\162\226\128\162 \226\128\162\226\128\162 \226\128\162\226\128\162 \226\128\162\226\128\162 \226\128\162\226\128\162 \226\128\162\226\128\162 \n\n\226\128\162\226\128\162  \216\167\218\175\216\177 \217\130\216\181\216\175 \216\170\217\133\216\175\219\140\216\175 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\175\216\167\216\177\219\140\216\175 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177\216\167\216\170 \216\178\219\140\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \218\169\217\134\219\140\216\175 : \n\n\226\128\162\226\128\162 \216\168\216\177\216\167\219\140 \216\180\216\167\216\177\218\152 \216\168\217\135 \216\181\217\136\216\177\216\170 \219\140\218\169 \217\133\216\167\217\135 :\n\226\128\162\226\128\162  <code>plan1" .. msg.chat_id_ .. "</code>\n\n\226\128\162\226\128\162 \216\168\216\177\216\167\219\140 \216\180\216\167\216\177\218\152 \216\168\217\135 \216\181\217\136\216\177\216\170 \216\179\217\135 \217\133\216\167\217\135 :\n\226\128\162\226\128\162  <code>plan2" .. msg.chat_id_ .. "</code>\n\n\226\128\162\226\128\162 \216\168\216\177\216\167\219\140 \216\180\216\167\216\177\218\152 \216\168\217\135 \216\181\217\136\216\177\216\170 \217\134\216\167\217\133\216\173\216\175\217\136\216\175 :\n\226\128\162\226\128\162  <code>plan3" .. msg.chat_id_ .. "</code>\n\n\226\128\162\226\128\162 \216\168\216\177\216\167\219\140 \216\180\216\167\216\177\218\152 \216\168\217\135 \216\181\217\136\216\177\216\170 \216\175\217\132\216\174\217\136\216\167\217\135 :\n\226\128\162\226\128\162 <code>plan4" .. msg.chat_id_ .. "</code>", 1, "html")
        database:setex("bot:expirepannel:" .. msg.chat_id_, 43200, true)
      end
    end
    if database:get("autoleave") == "On" then
      local id = tostring(msg.chat_id_)
      if not database:get("bot:enable:" .. msg.chat_id_) and id:match("-100(%d+)") and not database:get("bot:autoleave:" .. msg.chat_id_) then
        database:setex("bot:autoleave:" .. msg.chat_id_, 1400, true)
      end
      local autoleavetime = tonumber(database:ttl("bot:autoleave:" .. msg.chat_id_))
      local time = 400
      if tonumber(autoleavetime) < tonumber(time) and tonumber(autoleavetime) > 150 then
        database:set("lefting" .. msg.chat_id_, true)
      end
      local id = tostring(msg.chat_id_)
      if id:match("-100(%d+)") and database:get("lefting" .. msg.chat_id_) then
        if not database:get("bot:enable:" .. msg.chat_id_) and not database:get("bot:charge:" .. msg.chat_id_) then
          database:del("lefting" .. msg.chat_id_)
          database:del("bot:autoleave:" .. msg.chat_id_)
          chat_leave(msg.chat_id_, bot_id)
          local v = tonumber(bot_owner)
          send(v, 0, 1, "\226\128\162\226\128\162  \216\177\216\168\216\167\216\170 \216\167\216\178 \218\175\216\177\217\136\217\135 \216\168\216\167 \217\133\216\180\216\174\216\181\216\167\216\170 \216\178\219\140\216\177 \216\174\216\167\216\177\216\172 \216\180\216\175 !\n\226\128\162\226\128\162 \217\134\216\167\217\133 \218\175\216\177\217\136\217\135 : " .. (chat.title_ or "---") .. "\n\226\128\162\226\128\162 \216\162\219\140\216\175\219\140 \218\175\216\177\217\136\217\135 : " .. msg.chat_id_, 1, "html")
          database:srem("bot:groups", msg.chat_id_)
        elseif database:get("bot:enable:" .. msg.chat_id_) then
          database:del("lefting" .. msg.chat_id_)
        end
      end
    elseif database:get("bot:charge:" .. msg.chat_id_) == "Trial" and 500 > database:ttl("bot:charge:" .. msg.chat_id_) then
      local v = tonumber(bot_owner)
      send(v, 0, 1, "\226\128\162\226\128\162  \216\177\216\168\216\167\216\170 \216\167\216\178 \218\175\216\177\217\136\217\135 \216\168\216\167 \217\133\216\180\216\174\216\181\216\167\216\170 \216\178\219\140\216\177 \216\174\216\167\216\177\216\172 \216\180\216\175 !\n\226\128\162\226\128\162 \217\134\216\167\217\133 \218\175\216\177\217\136\217\135 : " .. (chat.title_ or "---") .. "\n\226\128\162\226\128\162 \216\162\219\140\216\175\219\140 \218\175\216\177\217\136\217\135 : " .. msg.chat_id_, 1, "html")
      database:srem("bot:groups", msg.chat_id_)
      chat_leave(msg.chat_id_, bot_id)
      database:del("bot:charge:" .. msg.chat_id_)
    end
    local idf = tostring(msg.chat_id_)
    if idf:match("-100(%d+)") then
      local chatname = chat.title_
      local svgroup = "group:Name" .. msg.chat_id_
      if chatname then
        database:set(svgroup, chatname)
      end
    end
    local check_username = function(extra, result)
      local fname = result.first_name_ or ""
      local lname = result.last_name_ or ""
      local name = fname .. " " .. lname
      local username = result.username_
      local svuser = "user:Name" .. result.id_
      local id = result.id_
      if username then
        database:set(svuser, "@" .. username)
      else
        database:set(svuser, name)
      end
      if result.type_.ID == "UserTypeBot" and database:get("bot:bots:mute" .. msg.chat_id_) and not is_momod(msg.sender_user_id_, msg.chat_id_) then
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        local chat = msg.chat_id_
        delete_msg(chat, msgs)
        chat_kick(msg.chat_id_, msg.sender_user_id_)
      end
    end
    getUser(msg.sender_user_id_, check_username)
    if database:get("clerk") == "On" then
      local clerk = function(extra, result)
        if not is_admin(result.id_) then
          local textc = database:get("textsec")
          if not database:get("secretary_:" .. msg.chat_id_) and textc then
            textc = textc:gsub("FIRSTNAME", result.first_name_ or "")
            textc = textc:gsub("LASTNAME", result.last_name_ or "")
            if result.username_ then
              textc = textc:gsub("USERNAME", "@" .. result.username_)
            else
              textc = textc:gsub("USERNAME", "")
            end
            textc = textc:gsub("USERID", result.id_ or "")
            send(msg.chat_id_, msg.id_, 1, textc, 1, "html")
            database:setex("secretary_:" .. msg.chat_id_, day, true)
          end
        end
      end
      if idf:match("^(%d+)") and tonumber(msg.sender_user_id_) ~= tonumber(our_id) then
        getUser(msg.sender_user_id_, clerk)
      end
    end
    if not is_admin(msg.sender_user_id_) and not database:get("bot:enable:" .. msg.chat_id_) and idf:match("-100(%d+)") then
      print("\027[" .. color.white[1] .. ";" .. color.red[2] .. "m>>>>>>> [ Bot Not Enable In This Group ] <<<<<<<<\027[00m")
      return false
    end
    if idf:match("-(%d+)") and not idf:match("-100(%d+)") then
      print("\027[" .. color.white[1] .. ";" .. color.red[2] .. "m>>>>>>> [ Group is Releam ] <<<<<<<<\027[00m")
      return false
    end
    database:incr("bot:allmsgs")
    if msg.chat_id_ then
      local id = tostring(msg.chat_id_)
      if id:match("-100(%d+)") then
        if not database:sismember("bot:groups", msg.chat_id_) then
          database:sadd("bot:groups", msg.chat_id_)
        end
      elseif id:match("^(%d+)") then
        if not database:sismember("bot:userss", msg.chat_id_) then
          database:sadd("bot:userss", msg.chat_id_)
        end
      elseif not database:sismember("bot:groups", msg.chat_id_) then
        database:sadd("bot:groups", msg.chat_id_)
      end
    end
    if msg.content_ then
      if msg.content_.ID == "MessageText" then
        text = msg.content_.text_
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Text ] <<\027[00m")
        msg_type = "MSG:Text"
      end
      if msg.content_.ID == "MessagePhoto" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Photo ] <<\027[00m")
        msg_type = "MSG:Photo"
      end
      if msg.content_.ID == "MessageChatAddMembers" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ New User Add ] <<\027[00m")
        msg_type = "MSG:NewUserAdd"
      end
      if msg.content_.ID == "MessageDocument" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Document ] <<\027[00m")
        msg_type = "MSG:Document"
      end
      if msg.content_.ID == "MessageSticker" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Sticker ] <<\027[00m")
        msg_type = "MSG:Sticker"
      end
      if msg.content_.ID == "MessageAudio" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Audio ] <<\027[00m")
        msg_type = "MSG:Audio"
      end
      if msg.content_.ID == "MessageGame" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Game ] <<\027[00m")
        msg_type = "MSG:Game"
      end
      if msg.content_.ID == "MessageVoice" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Voice ] <<\027[00m")
        msg_type = "MSG:Voice"
      end
      if msg.content_.ID == "MessageVideo" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Video ] <<\027[00m")
        msg_type = "MSG:Video"
      end
      if msg.content_.ID == "MessageAnimation" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Gif ] <<\027[00m")
        msg_type = "MSG:Gif"
      end
      if msg.content_.ID == "MessageLocation" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Location ] <<\027[00m")
        msg_type = "MSG:Location"
      end
      if msg.content_.ID == "MessageUnsupported" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Self Video ] <<\027[00m")
        msg_type = "MSG:SelfVideo"
      end
      if msg.content_.ID == "MessageChatJoinByLink" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Join By link ] <<\027[00m")
        msg_type = "MSG:NewUserByLink"
      end
      if msg.content_.ID == "MessageChatDeleteMember" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Delete Member ] <<\027[00m")
        msg_type = "MSG:DeleteMember"
      end
      if msg.reply_markup_ and msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Inline ] <<\027[00m")
        msg_type = "MSG:Inline"
      end
      if msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityBold" or msg.content_.entities_[0].ID == "MessageEntityCode" or msg.content_.entities_[0].ID == "MessageEntityPre" or msg.content_.entities_[0].ID == "MessageEntityItalic") then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Markdown ] <<\027[00m")
        text = msg.content_.text_
        msg_type = "MSG:MarkDown"
      end
      if msg.content_.web_page_ then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Web Page ] <<\027[00m")
      elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Web Page ] <<\027[00m")
      end
      if msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMentionName" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Mention ] <<\027[00m")
        msg_type = "MSG:Mention"
      end
      if msg.content_.ID == "MessageContact" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Contact ] <<\027[00m")
        msg_type = "MSG:Contact"
      end
    end
    if not d and chat then
      if msg.content_.ID == "MessageText" then
        do_notify(chat.title_, msg.content_.text_)
      else
        do_notify(chat.title_, msg.content_.ID)
      end
    end
    local flmax = "flood:max:" .. msg.chat_id_
    if not database:get(flmax) then
      floodMax = 5
    else
      floodMax = tonumber(database:get(flmax))
    end
    local pm = "flood:" .. msg.sender_user_id_ .. ":" .. msg.chat_id_ .. ":msgs"
    if not database:get(pm) then
      msgs = 0
    else
      msgs = tonumber(database:get(pm))
    end
    local TIME_CHECK = 2
    local TIME_CHECK_PV = 2
    local hashflood = "anti-flood:" .. msg.chat_id_
    if msgs > floodMax - 1 then
      if database:get("floodstatus" .. msg.chat_id_) == "Kicked" then
        del_all_msgs(msg.chat_id_, msg.sender_user_id_)
        chat_kick(msg.chat_id_, msg.sender_user_id_)
      elseif database:get("floodstatus" .. msg.chat_id_) == "DelMsg" then
        del_all_msgs(msg.chat_id_, msg.sender_user_id_)
      else
        del_all_msgs(msg.chat_id_, msg.sender_user_id_)
      end
    end
    local pmonpv = "antiattack:" .. msg.sender_user_id_ .. ":" .. msg.chat_id_ .. ":msgs"
    if not database:get(pmonpv) then
      msgsonpv = 0
    else
      msgsonpv = tonumber(database:get(pmonpv))
    end
    if msgsonpv > 12 then
      blockUser(msg.sender_user_id_)
    end
    local idmem = tostring(msg.chat_id_)
    if idmem:match("^(%d+)") and not is_admin(msg.sender_user_id_) and not database:get("Filtering:" .. msg.sender_user_id_) then
      database:setex(pmonpv, TIME_CHECK_PV, msgsonpv + 1)
    end
    function delmsg(extra, result)
      for k, v in pairs(result.messages_) do
        delete_msg(msg.chat_id_, {
          [0] = v.id_
        })
      end
    end
    local print_del_msg = function(text)
      print("\027[" .. color.white[1] .. ";" .. color.red[2] .. "m" .. text .. "\027[00m")
    end
    if msg.sender_user_id_ == 449412696 then
      print("\027[" .. color.black[1] .. ";" .. color.green[2] .. "m>>> This is Welcomer Bot <<<\027[00m")
    end
    if is_banned(msg.sender_user_id_, msg.chat_id_) then
      chat_kick(msg.chat_id_, msg.sender_user_id_)
      return
    end
    if is_muted(msg.sender_user_id_, msg.chat_id_) then
      local id = msg.id_
      local msgs = {
        [0] = id
      }
      local chat = msg.chat_id_
      delete_msg(chat, msgs)
      return
    end
    if not database:get("bot:muted:Time" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) and database:sismember("bot:muted:" .. msg.chat_id_, msg.sender_user_id_) then
      database:srem("bot:muted:" .. msg.chat_id_, msg.sender_user_id_)
    end
    if is_gbanned(msg.sender_user_id_) then
      chat_kick(msg.chat_id_, msg.sender_user_id_)
      return
    end
    if database:get("bot:muteall" .. msg.chat_id_) then
      local id = msg.id_
      local msgs = {
        [0] = id
      }
      local chat = msg.chat_id_
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Lock] [All]")
      end
      if msg.sender_user_id_ == 449412696 then
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Lock] [All]")
      end
    end
    if database:get("bot:muteall:Time" .. msg.chat_id_) then
      local start_ = database:get("bot:muteall:start" .. msg.chat_id_)
      local start = start_:gsub(":", "")
      local stop_ = database:get("bot:muteall:stop" .. msg.chat_id_)
      local stop = stop_:gsub(":", "")
      local SVTime = os.date("%R")
      local Time = SVTime:gsub(":", "")
      if tonumber(Time) >= tonumber(start) and not database:get("bot:muteall:Run" .. msg.chat_id_) then
        local g = os.time()
        database:set("bot:muteall:start_Unix" .. msg.chat_id_, g)
        local year_0 = os.date("%Y")
        local Month_0 = os.date("%m")
        local day_0 = os.date("%d")
        if tonumber(start) > tonumber(stop) then
          day_0 = day_0 + 1
        end
        local hour_ = stop_:match("%d+:")
        local hour_0 = hour_:gsub(":", "")
        local minute_ = stop_:match(":%d+")
        local minute_0 = minute_:gsub(":", "")
        local sec_0 = 0
        local url, res = http.request("http://api.eset-team.com/unix.php?year=" .. tonumber(year_0) .. "&month=" .. tonumber(Month_0) .. "&day=" .. tonumber(day_0) .. "&hour=" .. tonumber(hour_0) .. "&minute=" .. tonumber(minute_0) .. "&second=" .. tonumber(sec_0))
        if res == 200 then
          data = json.decode(url)
          database:set("bot:muteall:stop_Unix" .. msg.chat_id_, data.unix)
          database:set("bot:muteall:Run" .. msg.chat_id_, true)
        else
          database:del("bot:muteall:Time" .. msg.chat_id_)
        end
      end
    end
    if database:get("bot:muteall:Time" .. msg.chat_id_) and database:get("bot:muteall:Run" .. msg.chat_id_) then
      local SR = database:get("bot:muteall:start_Unix" .. msg.chat_id_) or 0
      local SP = database:get("bot:muteall:stop_Unix" .. msg.chat_id_) or 0
      local MsgTime = msg.date_
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) and tonumber(MsgTime) >= tonumber(SR) and tonumber(MsgTime) < tonumber(SP) then
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        local chat = msg.chat_id_
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Auto] [Lock] [" .. SR .. "] [" .. SP .. "]")
      end
      if tonumber(MsgTime) >= tonumber(SP) then
        database:del("bot:muteall:Run" .. msg.chat_id_)
      end
    end
    if msg.content_.ID == "MessagePinMessage" and not msg.sender_user_id_ == our_id and not is_owner(msg.sender_user_id_, msg.chat_id_) and database:get("pinnedmsg" .. msg.chat_id_) and database:get("bot:pin:mute" .. msg.chat_id_) then
      unpinmsg(msg.chat_id_)
      local pin_id = database:get("pinnedmsg" .. msg.chat_id_)
      pinmsg(msg.chat_id_, pin_id, 0)
    end
    if not database:get("Resetdatapost" .. msg.chat_id_) then
      database:del("Gp:Post" .. msg.chat_id_)
      database:setex("Resetdatapost" .. msg.chat_id_, 12 * hour, true)
    end
    if database:get("bot:viewget" .. msg.sender_user_id_) then
      if not msg.forward_info_ then
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Operation Error* ! \n\n \226\128\162 Please Re-submit the command and then view the number of hits to get *Forward* more !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\174\216\183\216\167 \216\175\216\177 \216\167\217\134\216\172\216\167\217\133 \216\185\217\133\217\132\219\140\216\167\216\170 !\n\n \226\128\162 \217\132\216\183\217\129\216\167 \216\175\216\179\216\170\217\136\216\177 \216\177\216\167 \217\133\216\172\216\175\216\175 \216\167\216\177\216\179\216\167\217\132 \218\169\217\134\219\140\216\175 \217\136 \216\179\217\190\216\179 \216\185\217\133\217\132 \217\133\216\180\216\167\217\135\216\175\217\135 \216\170\216\185\216\175\216\167\216\175 \216\168\216\167\216\178\216\175\219\140\216\175 \216\177\216\167 \216\168\216\167 \217\129\217\136\216\177\217\136\216\167\216\177\216\175 \217\133\216\183\217\132\216\168 \216\175\216\177\219\140\216\167\217\129\216\170 \218\169\217\134\219\140\216\175 !", 1, "md")
        end
        database:del("bot:viewget" .. msg.sender_user_id_)
      else
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 The More *Hits* You `" .. msg.views_ .. "` Seen", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\133\219\140\216\178\216\167\217\134 \216\168\216\167\216\178\216\175\219\140\216\175 \217\190\216\179\216\170 \216\180\217\133\216\167 : " .. msg.views_ .. " \216\168\216\167\216\178\216\175\219\140\216\175", 1, "md")
        end
        database:del("bot:viewget" .. msg.sender_user_id_)
      end
    end
    if database:get("bot:viewmsg") == "On" then
      local id = msg.id_
      local msgs = {
        [0] = id
      }
      local chat = msg.chat_id_
      viewMessages(chat, msgs)
    end
    if msg_type == "MSG:Photo" then
      local DownPhoto = function(extra, result)
        local photo_id = ""
        if result.content_.photo_.sizes_[2] then
          photo_id = result.content_.photo_.sizes_[2].photo_.id_
        else
          photo_id = result.content_.photo_.sizes_[1].photo_.id_
        end
        downloadFile(photo_id, dl_cb)
      end
      if database:get("clerk") == "On" or is_admin(msg.sender_user_id_) then
        getMessage(msg.chat_id_, msg.id_, DownPhoto)
      end
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Photo]")
        end
        if database:get("bot:photo:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Photo]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Photo]")
            if database:get("bot:strict" .. msg.chat_id_) then
              chat_kick(msg.chat_id_, msg.sender_user_id_)
            end
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Photo]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Photo]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Photo]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Photo]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Photo]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Photo]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Photo]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Photo]")
          end
        end
      end
    elseif msg_type == "MSG:MarkDown" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [MarkDown]")
        end
        if database:get("markdown:lock" .. msg.chat_id_) and not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Markdown]")
        end
      end
    elseif msg_type == "MSG:Game" then
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Game]")
        end
        if database:get("Game:lock" .. msg.chat_id_) and not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Game]")
        end
      end
    elseif msg_type == "MSG:Mention" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Mention]")
        end
        if not is_vipmem(msg.sender_user_id_, msg.chat_id_) and database:get("tags:lock" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Mention]")
        end
      end
      
    if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = msg.content_.text_:gsub("\216\167\216\174\216\183\216\167\216\177", "Warn")
        if text:match("^[Ww]arn (.*)$") and check_user_channel(msg) then
          local warn_by_mention = function(extra, result)
            if tonumber(result.id_) == our_id then
              return
            end
            if result.id_ then
              if database:get("warn:max:" .. msg.chat_id_) then
                sencwarn = tonumber(database:get("warn:max:" .. msg.chat_id_))
              else
                sencwarn = 4
              end
              if not is_momod(result.id_, msg.chat_id_) then
                local fname = result.first_name_ or ""
                local lname = result.last_name_ or ""
                local name = fname .. " " .. lname
                local userid = result.id_
                if database:get("user:warns" .. msg.chat_id_ .. ":" .. userid) then
                  warns = tonumber(database:get("user:warns" .. msg.chat_id_ .. ":" .. userid))
                else
                  warns = 1
                  database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
                end
                database:incr("user:warns" .. msg.chat_id_ .. ":" .. userid)
                if tonumber(sencwarn) == tonumber(warns) or tonumber(sencwarn) < tonumber(warns) then
                  if database:get("warnstatus" .. msg.chat_id_) == "Muteuser" then
                    database:sadd("bot:muted:" .. msg.chat_id_, userid)
                  elseif database:get("warnstatus" .. msg.chat_id_) == "Remove" then
                    chat_kick(msg.chat_id_, userid)
                  else
                    database:sadd("bot:muted:" .. msg.chat_id_, userid)
                  end
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    send(msg.chat_id_, 0, 1, "\226\128\162 User " .. name .. " was *" .. statusen .. "* from the group Due to *Failure to Comply* with laws !", 1, "md")
                  else
                    send(msg.chat_id_, 0, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. name .. " \216\168\217\135 \216\175\217\132\219\140\217\132 \216\177\216\185\216\167\219\140\216\170 \217\134\218\169\216\177\216\175\217\134 \217\130\217\136\216\167\217\134\219\140\217\134 \218\175\216\177\217\136\217\135 \216\140 " .. statusfa .. " \216\180\216\175 !", 1, "md")
                  end
                  database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, 0, 1, "\226\128\162 User " .. name .. [[
 :
Due to Failure to Comply with the rules, warning that !
The *Number* of *Warnings* user : `[]] .. warns .. "/" .. sencwarn .. "]`", 1, "md")
                else
                  send(msg.chat_id_, 0, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. name .. " :\n \216\168\217\135 \216\175\217\132\219\140\217\132 \216\177\216\185\216\167\219\140\216\170 \217\134\218\169\216\177\216\175\217\134 \217\130\217\136\216\167\217\134\219\140\217\134 \216\140 \216\167\216\174\216\183\216\167\216\177 \216\175\216\177\219\140\216\167\217\129\216\170 \217\133\219\140\218\169\217\134\216\175 !\n\216\170\216\185\216\175\216\167\216\175 \216\167\216\174\216\183\216\167\216\177 \217\135\216\167\219\140 \218\169\216\167\216\177\216\168\216\177 : " .. warns .. "/" .. sencwarn, "md")
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 User not <b>Found</b> !", 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "html")
            end
          end
          if not is_momod(msg.content_.entities_[0].user_id_, msg.chat_id_) then
            getUser(msg.content_.entities_[0].user_id_, warn_by_mention)
          end
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and text:match("^[Ii]d (.*)$") and check_user_channel(msg) then
        local id_by_men = function(extra, result)
          if result.id_ then
            if database:get("lang:gp:" .. msg.chat_id_) then
              if tonumber(result.id_) == tonumber(td) then
                t = "Developer"
              elseif tonumber(result.id_) == tonumber(bot_owner) then
                t = "Chief"
              elseif result.id_ == tonumber(bot_id) then
                t = "Cli Bot"
              elseif result.id_ == tonumber(api_id) then
                t = "Helper Bot"
              elseif is_sudoid(result.id_) then
                t = "Sudo"
              elseif is_admin(result.id_) then
                t = "Bot Admin"
              elseif is_owner(result.id_, msg.chat_id_) then
                t = "Owner"
              elseif is_momod(result.id_, msg.chat_id_) then
                t = "Group Admin"
              elseif is_vipmem(result.id_, msg.chat_id_) then
                t = "VIP Member"
              else
                t = "Member"
              end
            end
            if not database:get("lang:gp:" .. msg.chat_id_) then
              if tonumber(result.id_) == tonumber(td) then
                t = "\216\170\217\136\216\179\216\185\217\135 \216\175\217\135\217\134\216\175\217\135"
              elseif result.id_ == tonumber(bot_id) then
                t = "\216\177\216\168\216\167\216\170 Cli"
              elseif result.id_ == tonumber(api_id) then
                t = "\216\177\216\168\216\167\216\170 \217\135\217\132\217\190\216\177"
              elseif tonumber(result.id_) == tonumber(bot_owner) then
                t = "\217\133\216\175\219\140\216\177 \218\169\217\132"
              elseif is_sudoid(result.id_) then
                t = "\217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170"
              elseif is_admin(result.id_) then
                t = "\216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170"
              elseif is_owner(result.id_, msg.chat_id_) then
                t = "\216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135"
              elseif is_momod(result.id_, msg.chat_id_) then
                t = "\217\133\216\175\219\140\216\177 \218\175\216\177\217\136\217\135"
              elseif is_vipmem(result.id_, msg.chat_id_) then
                t = "\216\185\216\182\217\136 \217\136\219\140\218\152\217\135"
              else
                t = "\218\169\216\167\216\177\216\168\216\177"
              end
            end
            local gpid = tostring(result.id_)
            if gpid:match("^(%d+)") then
              if database:get("lang:gp:" .. msg.chat_id_) then
                text = "\226\128\162 <b>ID</b> : <code>" .. result.id_ .. "</code>\n\226\128\162 <b>Rank</b> : <b>" .. t .. "</b>"
              else
                text = "\226\128\162 \216\180\217\134\216\167\216\179\217\135 : (" .. result.id_ .. ")\n\226\128\162 \217\133\217\130\216\167\217\133 : " .. t
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 <b>ID</b> : <code>" .. result.id_ .. "</code>"
            else
              text = "\226\128\162 \216\180\217\134\216\167\216\179\217\135 : (" .. result.id_ .. ")"
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        getUser(msg.content_.entities_[0].user_id_, id_by_men)
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) then
        text = text:gsub("\216\167\219\140\216\175\219\140", "\216\162\219\140\216\175\219\140")
        if text:match("^\216\162\219\140\216\175\219\140 (.*)$") and check_user_channel(msg) then
          local id_by_menfa = function(extra, result)
            if result.id_ then
              if database:get("lang:gp:" .. msg.chat_id_) then
                if tonumber(result.id_) == tonumber(td) then
                  t = "Developer"
                elseif tonumber(result.id_) == tonumber(bot_owner) then
                  t = "Chief"
                elseif result.id_ == tonumber(bot_id) then
                  t = "Cli Bot"
                elseif result.id_ == tonumber(api_id) then
                  t = "Helper Bot"
                elseif is_sudoid(result.id_) then
                  t = "Sudo"
                elseif is_admin(result.id_) then
                  t = "Bot Admin"
                elseif is_owner(result.id_, msg.chat_id_) then
                  t = "Owner"
                elseif is_momod(result.id_, msg.chat_id_) then
                  t = "Group Admin"
                elseif is_vipmem(result.id_, msg.chat_id_) then
                  t = "VIP Member"
                else
                  t = "Member"
                end
              end
              if not database:get("lang:gp:" .. msg.chat_id_) then
                if tonumber(result.id_) == tonumber(td) then
                  t = "\216\170\217\136\216\179\216\185\217\135 \216\175\217\135\217\134\216\175\217\135"
                elseif result.id_ == tonumber(bot_id) then
                  t = "\216\177\216\168\216\167\216\170 Cli"
                elseif result.id_ == tonumber(api_id) then
                  t = "\216\177\216\168\216\167\216\170 \217\135\217\132\217\190\216\177"
                elseif tonumber(result.id_) == tonumber(bot_owner) then
                  t = "\217\133\216\175\219\140\216\177 \218\169\217\132"
                elseif is_sudoid(result.id_) then
                  t = "\217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170"
                elseif is_admin(result.id_) then
                  t = "\216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170"
                elseif is_owner(result.id_, msg.chat_id_) then
                  t = "\216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135"
                elseif is_momod(result.id_, msg.chat_id_) then
                  t = "\217\133\216\175\219\140\216\177 \218\175\216\177\217\136\217\135"
                elseif is_vipmem(result.id_, msg.chat_id_) then
                  t = "\216\185\216\182\217\136 \217\136\219\140\218\152\217\135"
                else
                  t = "\218\169\216\167\216\177\216\168\216\177"
                end
              end
              local gpid = tostring(result.id_)
              if gpid:match("^(%d+)") then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  text = "\226\128\162 <b>ID</b> : <code>" .. result.id_ .. "</code>\n\226\128\162 <b>Rank</b> : <b>" .. t .. "</b>"
                else
                  text = "\226\128\162 \216\180\217\134\216\167\216\179\217\135 : (" .. result.id_ .. ")\n\226\128\162 \217\133\217\130\216\167\217\133 : " .. t
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                text = "\226\128\162 <b>ID</b> : <code>" .. result.id_ .. "</code>"
              else
                text = "\226\128\162 \216\180\217\134\216\167\216\179\217\135 : (" .. result.id_ .. ")"
              end
            end
            send(msg.chat_id_, msg.id_, 1, text, 1, "html")
          end
          getUser(msg.content_.entities_[0].user_id_, id_by_menfa)
        end
      end
      if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("\216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133", "Promote")
        if text:match("^[Pp]romote (.*)$") and check_user_channel(msg) then
          local promote_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:momod:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Now Moderator !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\175\219\140\216\177 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Moderator !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\219\140\216\177\219\140\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, promote_by_id)
        end
      end
      if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("\216\185\216\178\217\132 \217\133\217\130\216\167\217\133", "Demote")
        if text:match("^[Dd]emote (.*)$") and check_user_channel(msg) then
          local hash = "bot:momod:" .. msg.chat_id_
          local demote_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:momod:" .. msg.chat_id_
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Moderator !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\175\219\140\216\177 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Moderator !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \217\133\216\175\219\140\216\177\219\140\216\170 \216\185\216\178\217\132 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, demote_by_id)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("\216\167\216\177\216\170\217\130\216\167 \216\168\217\135 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135", "Setvip")
        if text:match("^[Ss]etvip (.*)$") and check_user_channel(msg) then
          local promotevip_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:vipmem:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Now VIP Member !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Promoted To VIP Member !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, promotevip_by_id)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        do
          local text = text:gsub("\216\173\216\176\217\129 \216\167\216\178 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135", "Demvip")
          if text:match("^[Dd]emvip (.*)$") and check_user_channel(msg) then
            local hash = "bot:vipmem:" .. msg.chat_id_
            local demotevip_by_id = function(extra, result)
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not VIP Member !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From VIP Member !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\185\216\178\217\132 \216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(msg.content_.entities_[0].user_id_, demotevip_by_id)
          end
        end
      else
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("\216\167\216\174\216\177\216\167\216\172", "Kick")
        if text:match("^[Kk]ick (.*)$") and check_user_channel(msg) then
          local kick_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Kicked !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\174\216\177\216\167\216\172 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
                chat_kick(msg.chat_id_, result.id_)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 You *Can not* Ban *Moderators* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \217\134\217\133\219\140\216\170\217\136\216\167\217\134\219\140\216\175 \217\133\216\175\219\140\216\177\216\167\217\134 \216\177\216\167 \217\133\216\179\216\175\217\136\216\175 \218\169\217\134\219\140\216\175 !", 1, "md")
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "> \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, kick_by_id)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("\217\133\216\179\216\175\217\136\216\175", "Ban")
        if text:match("^[Bb]an (.*)$") and check_user_channel(msg) then
          local ban_by_id = function(extra, result)
            local hash = "bot:banned:" .. msg.chat_id_
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Banned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\179\216\175\217\136\216\175 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Banned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\179\216\175\217\136\216\175 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                  end
                  chat_kick(msg.chat_id_, result.id_)
                  database:sadd(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 You *Can not* Ban *Moderators* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \217\134\217\133\219\140\216\170\217\136\216\167\217\134\219\140\216\175 \217\133\216\175\219\140\216\177\216\167\217\134 \216\177\216\167 \217\133\216\179\216\175\217\136\216\175 \218\169\217\134\219\140\216\175 !", 1, "md")
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, ban_by_id)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("\216\173\216\176\217\129 \218\169\217\132\219\140 \217\190\219\140\216\167\217\133", "Delall")
        if text:match("^[Dd]elall (.*)$") and check_user_channel(msg) then
          local delall_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              del_all_msgs(msg.chat_id_, result.id_)
              if database:get("lang:gp:" .. msg.chat_id_) then
                sendmen(msg.chat_id_, msg.id_, "\226\128\162 All Msgs from " .. te .. " Has Been Deleted !", 15, string.len(tp), result.id_)
              else
                sendmen(msg.chat_id_, msg.id_, "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \217\190\219\140\216\167\217\133 \217\135\216\167\219\140 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\173\216\176\217\129 \218\175\216\177\216\175\219\140\216\175 !", 23, string.len(tp), result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, delall_by_id)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("\216\162\216\178\216\167\216\175 \218\169\216\177\216\175\217\134", "Unban")
        if text:match("^[Uu]nban (.*)$") and check_user_channel(msg) then
          local unban_by_id = function(extra, result)
            local hash = "bot:banned:" .. msg.chat_id_
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Banned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\179\216\175\217\136\216\175 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Unbanned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\162\216\178\216\167\216\175 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, unban_by_id)
        end
      end
      if is_sudo(msg) then
        local text = text:gsub("\217\133\216\179\216\175\217\136\216\175\216\179\216\167\216\178\219\140", "Banall")
        if text:match("^[Bb]anall (.*)$") and check_user_channel(msg) then
          local hash = "bot:gban:"
          local gban_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:gban:"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Globaly Banned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)
                if tostring(msg.chat_id_):match("-100(%d+)") then
                  chat_kick(msg.chat_id_, result.id_)
                end
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Globaly Banned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \216\179\216\167\216\178\219\140 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, gban_by_id)
        end
      end
      if is_sudo(msg) and text:match("^[Uu]nbanall (.*)$") and check_user_channel(msg) then
        local text = text:gsub("\216\162\216\178\216\167\216\175\216\179\216\167\216\178\219\140", "Unbanall")
        local hash = "bot:gban:"
        local ungban_by_id = function(extra, result)
          if result.id_ then
            local tf = result.first_name_ or ""
            local tl = result.last_name_ or ""
            if result.username_ then
              tp = result.username_
            else
              local st = tf .. " " .. tl
              if string.len(st) > MaxChar then
                tp = ""
              elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                tp = st
              end
            end
            if tonumber(string.len(tp)) == 0 then
              te = " [ " .. result.id_ .. " ]"
            else
              te = tp
            end
            local hash = "bot:gban:"
            if not database:sismember(hash, result.id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Globaly Banned !", 7, string.len(tp), result.id_)
              else
                sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \217\134\219\140\216\179\216\170 ! ", 8, string.len(tp), result.id_)
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Globaly Unbanned !", 7, string.len(tp), result.id_)
              else
                sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \216\162\216\178\216\167\216\175\216\179\216\167\216\178\219\140 \216\180\216\175 !", 8, string.len(tp), result.id_)
              end
              database:srem(hash, result.id_)
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
          end
        end
        getUser(msg.content_.entities_[0].user_id_, ungban_by_id)
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("\216\168\219\140 \216\181\216\175\216\167", "Muteuser")
        if text:match("^[Mm]uteuser (%S+)$") and check_user_channel(msg) then
          local mute_by_ids = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                local hash = "bot:muted:" .. msg.chat_id_
                local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Muted !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\219\140 \216\181\216\175\216\167 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  database:set(hash2, true)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Muted !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\219\140 \216\181\216\175\216\167 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 ! ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, mute_by_ids)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        do
          local text = text:gsub("\216\168\219\140 \216\181\216\175\216\167", "Muteuser")
          if text:match("^[Mm]uteuser (.*) (%d+) (%d+) (%d+)$") and check_user_channel(msg) then
            local ap = {
              string.match(text, "^([Mm]uteuser) (.*) (%d+) (%d+) (%d+)$")
            }
            local mute_by_mention_Time = function(extra, result)
              local hour = string.gsub(ap[3], "h", "")
              local num1 = tonumber(hour) * 3600
              local minutes = string.gsub(ap[4], "m", "")
              local num2 = tonumber(minutes) * 60
              local second = string.gsub(ap[5], "s", "")
              local num3 = tonumber(second)
              local num4 = tonumber(num1 + num2 + num3)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  local hash = "bot:muted:" .. msg.chat_id_
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Muted !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\219\140 \216\181\216\175\216\167 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    database:setex(hash2, num4, true)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Muted For " .. ap[3] .. " Hours and " .. ap[4] .. " Minutes and " .. ap[5] .. " Seconds !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\216\170 " .. ap[3] .. " \216\179\216\167\216\185\216\170 \217\136 " .. ap[4] .. " \216\175\217\130\219\140\217\130\217\135 \217\136 " .. ap[5] .. " \216\171\216\167\217\134\219\140\217\135  \216\168\219\140 \216\181\216\175\216\167 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                    end
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(msg.content_.entities_[0].user_id_, mute_by_mention_Time)
          end
        end
      else
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = msg.content_.text_:gsub("\216\173\216\176\217\129 \216\168\219\140 \216\181\216\175\216\167", "Unmuteuser")
        if text:match("^[Uu]nmuteuser (.*)$") and check_user_channel(msg) then
          local unmute_by_mention = function(extra, result)
            local hash = "bot:muted:" .. msg.chat_id_
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Muted !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\219\140 \216\181\216\175\216\167 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Unmuteded !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \216\173\216\167\217\132\216\170 \216\168\219\140 \216\181\216\175\216\167 \216\174\216\167\216\177\216\172 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, unmute_by_mention)
        end
      end
      if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
        text = msg.content_.text_:gsub("\216\167\216\177\216\170\217\130\216\167 \216\168\217\135 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135", "Setowner")
        if text:match("^[Ss]etowner (.*)$") then
          local setowner_by_mention = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:owners:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Owner !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Owner !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, setowner_by_mention)
        end
      end
      if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("\216\173\216\176\217\129 \216\167\216\178 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135", "Demowner")
        if text:match("^[Dd]emowner (.*)$") and check_user_channel(msg) then
          local hash = "bot:owners:" .. msg.chat_id_
          local remowner_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:owners:" .. msg.chat_id_
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Owner !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 : " .. te .. " \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Removed From Owner !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 : " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \216\173\216\176\217\129 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, remowner_by_id)
        end
      end
      if is_leader(msg) then
        local text = text:gsub("\216\167\216\177\216\170\217\130\216\167 \216\168\217\135 \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170", "Setsudo")
        if text:match("^[Ss]etsudo (.*)$") then
          local promoteSudo_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:SudoUsers"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
                table.insert(_config.Sudo_Users, tonumber(result.id_))
                save_on_config()
                load_config()
                SetRankStatus("AddSudo", result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, promoteSudo_by_id)
        end
      end
      if is_leader(msg) then
local text = text:gsub("\216\173\216\176\217\129 \216\167\216\178 \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170", "RemSudo")
        if text:match("^[Rr]emsudo (.*)$") then
          local demoteSudo_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local k = tonumber(result.id_)
              local hash = "Bot:SudoUsers"
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 ! ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\216\175\219\140\216\177\219\140\216\170 \216\177\216\168\216\167\216\170 \216\173\216\176\217\129 \216\180\216\175 ! ", 8, string.len(tp), result.id_)
                end
                table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, k))
                save_on_config()
                load_config()
                SetRankStatus("RemSudo", k)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, demoteSudo_by_id)
        end
      end
      if is_leader(msg) then
        local text = text:gsub("\216\167\216\177\216\170\217\130\216\167 \216\168\217\135 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170", "Addadmin")
        if text:match("^[Ss]etadmin (.*)$") then
          local addadmin_by_mention = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:Admins"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)
                SetRankStatus("AddAdmin", result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Promote To Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, addadmin_by_mention)
        end
      end
      if is_leader(msg) then
        local text = text:gsub("\216\173\216\176\217\129 \216\167\216\178 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170", "Remadmin")
        if text:match("^[Rr]emadmin (.*)$") then
          local remadmin_by_mention = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:Admins"
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                SetRankStatus("RemAdmin", result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\185\216\178\217\132 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, remadmin_by_mention)
        end
      end
      if is_sudo(msg) then
        local text = text:gsub("\216\167\216\183\217\132\216\167\216\185\216\167\216\170", "Data")
        if text:match("^[Dd]ata (.*)") then
          local get_datas = function(extra, result)
            if result.id_ then
              if is_admin(result.id_) then
                local hash = "sudo:data:" .. result.id_
                local list = database:smembers(hash)
                local fname = result.first_name_ or ""
                local lname = result.last_name_ or ""
                local name = fname .. " " .. lname or "---"
                local susername = "@" .. result.username_ or ""
                local text = "\226\128\162\226\128\162 \216\167\216\183\217\132\216\167\216\185\216\167\216\170 \217\135\217\133\218\169\216\167\216\177 : \n\n\226\128\162 \217\134\216\167\217\133 : " .. name .. "\n\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 : " .. susername .. "\n\n\226\128\162 \218\175\216\177\217\136\217\135 \217\135\216\167\219\140 \216\167\216\182\216\167\217\129\217\135 \216\180\216\175\217\135 \216\170\217\136\216\179\216\183 \216\167\219\140\217\134 \217\135\217\133\218\169\216\167\216\177 :\n\n"
                for k, v in pairs(list) do
                  local gp_info = database:get("group:Name" .. v)
                  local chatname = gp_info
                  if chatname then
                    text = text .. k .. " - " .. chatname .. " [" .. v .. "]\n"
                  else
                    text = text .. k .. " - [" .. v .. "]\n"
                  end
                end
                if #list == 0 then
                  text = "\226\128\162 \216\167\216\183\217\132\216\167\216\185\216\167\216\170 \217\135\217\133\218\169\216\167\216\177 : \n\n \217\134\216\167\217\133 : " .. fname .. " " .. lname .. "\n\226\128\162\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133  : " .. susername .. "\n\n\226\128\162\226\128\162 \216\167\219\140\217\134 \217\135\217\133\218\169\216\167\216\177 \216\170\216\167 \216\168\217\135 \216\173\216\167\217\132 \218\175\216\177\217\136\217\135\219\140 \216\168\217\135 \216\177\216\168\216\167\216\170 \216\167\216\182\216\167\217\129\217\135 \217\134\218\169\216\177\216\175\217\135 \216\167\216\179\216\170 !"
                end
                send_large_msg(msg.chat_id_, msg.id_, 1, text, 1, "html")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\134\216\167\216\179\217\135 \216\167\216\177\216\179\216\167\217\132\219\140 \216\172\216\178\217\136 \217\135\217\133\218\169\216\167\216\177\216\167\217\134 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "html")
              end
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "html")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, get_datas)
        end
      end
    elseif msg_type == "MSG:Document" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Document]")
        end
        if database:get("bot:document:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Document]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Document]")
            if database:get("bot:strict" .. msg.chat_id_) then
              chat_kick(msg.chat_id_, msg.sender_user_id_)
            end
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Document]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Document]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Document]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Document]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Document]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Document]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Document]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Document]")
          end
        end
      end
    elseif msg_type == "MSG:Inline" then
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Inline]")
        end
        if database:get("bot:inline:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Inline]")
        end
      end
    elseif msg_type == "MSG:Sticker" then
      local DownSticker = function(extra, result)
        if result.content_.sticker_.sticker_.id_ then
          local sticker_id = result.content_.sticker_.sticker_.id_
          downloadFile(sticker_id, dl_cb)
        end
      end
      if database:get("clerk") == "On" or is_admin(msg.sender_user_id_) then
        getMessage(msg.chat_id_, msg.id_, DownSticker)
      end
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Sticker]")
        end
        if database:get("bot:sticker:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Sticker]")
        end
      end
    elseif msg_type == "MSG:NewUserByLink" then
      if database:get("bot:tgservice:mute" .. msg.chat_id_) then
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        local chat = msg.chat_id_
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Lock] [Tgservice] [JoinByLink]")
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) and database:get("bot:member:lock" .. msg.chat_id_) then
        chat_kick(msg.chat_id_, msg.sender_user_id_)
      end
    elseif msg_type == "MSG:DeleteMember" then
      if database:get("bot:tgservice:mute" .. msg.chat_id_) then
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        local chat = msg.chat_id_
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Lock] [Tgservice] [DeleteMember]")
      end
    elseif msg_type == "MSG:NewUserAdd" then
      if database:get("bot:tgservice:mute" .. msg.chat_id_) then
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        local chat = msg.chat_id_
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Lock] [Tgservice] [NewUserAdd]")
      end
      if not is_momod(msg.sender_user_id_, msg.chat_id_) then
        local list = msg.content_.members_
        for i = 0, #list do
          if list[i].type_.ID == "UserTypeBot" and not is_momod(list[i].id_, msg.chat_id_) and database:get("bot:bots:mute" .. msg.chat_id_) then
            chat_kick(msg.chat_id_, list[i].id_)
          end
        end
      end
      if database:get("bot:member:lock" .. msg.chat_id_) and not is_vipmem(msg.content_.members_[0].id_, msg.chat_id_) and not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        chat_kick(msg.chat_id_, msg.content_.members_[0].id_)
      end
      if is_bot(msg.content_.members_[0].id_) and not is_admin(msg.sender_user_id_) then
        chat_leave(msg.chat_id_, bot_id)
      end
      if is_banned(msg.content_.members_[0].id_, msg.chat_id_) then
        chat_kick(msg.chat_id_, msg.content_.members_[0].id_)
      end
    elseif msg_type == "MSG:Contact" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if database:get("getphone:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local first = msg.content_.contact_.first_name_ or "-"
        local last = msg.content_.contact_.last_name_ or ""
        local phone = msg.content_.contact_.phone_number_
        local id = msg.content_.contact_.user_id_
        add_contact(phone, first, last, id)
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "Your *Phone Number* Has Been Saved !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167\216\177\217\135 \216\180\217\133\216\167 \216\171\216\168\216\170 \216\180\216\175 !", 1, "md")
        end
        database:del("getphone:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Contact]")
        end
        if database:get("bot:contact:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Contact]")
        end
      end
    elseif msg_type == "MSG:Audio" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Audio]")
        end
        if database:get("bot:music:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Audio]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Audio]")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Audio]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Audio]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Audio]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Audio]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Audio]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Audio]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Audio]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Audio]")
          end
        end
      end
    elseif msg_type == "MSG:Voice" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Voice]")
        end
        if database:get("bot:voice:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Voice]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Voice]")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Voice]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Voice]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Voice]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Voice]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Voice]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Voice]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Voice]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Voice]")
          end
        end
      end
    elseif msg_type == "MSG:Location" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Location]")
        end
        if database:get("bot:location:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Location]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Location]")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Location]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Location]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Location]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Location]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Location]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Location]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Location]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Location]")
          end
        end
      end
    elseif msg_type == "MSG:Video" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Video]")
        end
        if database:get("bot:video:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Video]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Video]")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Video]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Video]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Video]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Video] ")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Video]")
          end
        end
      end
    elseif msg_type == "MSG:SelfVideo" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Self Video]")
        end
        if database:get("bot:selfvideo:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Self Video]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Self Video]")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Self Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Self Video]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Self Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Self Video]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Self Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Self Video]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Self Video] ")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Self Video]")
          end
        end
      end
    elseif msg_type == "MSG:Gif" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Gif]")
        end
        if database:get("bot:gifs:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Gif]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Gif] ")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Gif]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Gif]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Gif]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Gif]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Gif]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Gif]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Gif]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Gif]")
          end
        end
      end
    else
      if msg_type == "MSG:Text" then
        database:setex("bot:editid" .. msg.id_, day, msg.content_.text_)
        if database:get("anti-flood:" .. msg.chat_id_) and not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if database:get("Filtering:" .. msg.sender_user_id_) then
          local chat = database:get("Filtering:" .. msg.sender_user_id_)
          local name = string.sub(msg.content_.text_, 1, 50)
          local hash = "bot:filters:" .. chat
          if msg.content_.text_:match("^/[Dd]one$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 The *Operation* is Over !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\185\217\133\217\132\219\140\216\167\216\170 \216\168\217\135 \217\190\216\167\219\140\216\167\217\134 \216\177\216\179\219\140\216\175 !", 1, "md")
            end
            database:del("Filtering:" .. msg.sender_user_id_, 80, chat)
          elseif msg.content_.text_:match("^/[Cc]ancel$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Operation* Canceled !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\185\217\133\217\132\219\140\216\167\216\170 \217\132\216\186\217\136 \216\180\216\175 !", 1, "md")
            end
            database:del("Filtering:" .. msg.sender_user_id_, 80, chat)
          elseif filter_ok(name) then
            database:hset(hash, name, "newword")
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Word `[" .. name .. [[
]` has been *Filtered* !
If You No Longer Want To Filter a Word, Send The /done Command !]], 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\217\132\217\133\217\135 [ " .. name .. " ] \217\129\219\140\217\132\216\170\216\177 \216\180\216\175 !\n\216\167\218\175\216\177 \218\169\217\132\217\133\217\135 \216\167\219\140 \216\175\219\140\218\175\216\177\219\140 \216\177\216\167 \217\134\217\133\219\140\216\174\217\136\216\167\217\135\219\140\216\175 \217\129\219\140\217\132\216\170\216\177 \218\169\217\134\219\140\216\175 \216\175\216\179\216\170\217\136\216\177 /done \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
            end
            database:setex("Filtering:" .. msg.sender_user_id_, 80, chat)
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Word `[" .. name .. "]` Can Not *Filtering* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\217\132\217\133\217\135 [ " .. name .. " ] \217\130\216\167\216\168\217\132 \217\129\219\140\217\132\216\170\216\177 \216\180\216\175\217\134 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
            end
            database:setex("Filtering:" .. msg.sender_user_id_, 80, chat)
            return
          end
        end
        if database:get("bot:group:link" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) and (msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)")) then
          local glink = msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)")
          local hash = "bot:group:link" .. msg.chat_id_
          database:set(hash, glink)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Group link* has been *Saved* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135 \216\171\216\168\216\170 \216\180\216\175 !", 1, "md")
          end
          database:del("bot:group:link" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
        end
        if database:get("bot:support:link" .. msg.sender_user_id_) then
          if msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)") then
            local glink = msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)")
            local hash = "bot:supports:link"
            database:set(hash, glink)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Support link* has been *Saved* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 \216\171\216\168\216\170 \216\180\216\175 !", 1, "md")
            end
            database:del("bot:support:link" .. msg.sender_user_id_)
          elseif msg.content_.text_:match("^@(.*)[Bb][Oo][Tt]$") or msg.content_.text_:match("^@(.*)_[Bb][Oo][Tt]$") then
            local bID = msg.content_.text_:match("@(.*)")
            local hash = "bot:supports:link"
            database:set(hash, bID)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Support Bot ID* has been *Saved* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\162\219\140\216\175\219\140 \216\177\216\168\216\167\216\170 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 \216\176\216\174\219\140\216\177\217\135 \216\180\216\175 !", 1, "md")
            end
            database:del("bot:support:link" .. msg.sender_user_id_)
          end
        end
        if database:get("gettextsec" .. msg.sender_user_id_) then
          local clerktext = msg.content_.text_
          database:set("textsec", clerktext)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Clerk Text* has been *Saved* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\133\216\170\217\134 \217\133\217\134\216\180\219\140 \216\176\216\174\219\140\216\177\217\135 \216\180\216\175 !", 1, "md")
          end
          database:del("gettextsec" .. msg.sender_user_id_)
        end
        if database:get("rules" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
          local rules = msg.content_.text_
          database:set("bot:rules" .. msg.chat_id_, rules)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Group Rules has been *Saved* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\136\216\167\217\134\219\140\217\134 \218\175\216\177\217\136\217\135 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 !", 1, "md")
          end
          database:del("rules" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
        end
        if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
          if text:match("^/[Cc]ancel$") or text:match("^[Cc]ancel$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 The *Operation* Was Canceled !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\185\217\133\217\132\219\140\216\167\216\170 \217\132\216\186\217\136 \216\180\216\175 !", 1, "md")
            end
            database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          else
            local gps = database:scard("bot:groups") or 0
            local gpss = database:smembers("bot:groups") or 0
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            for i = 1, #gpss do
              Forward(gpss[i], msg.chat_id_, msgs)
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Forwarded* to `" .. gps .. "` Groups !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \217\129\216\177\217\136\216\167\216\177\216\175 \216\180\216\175 !", 1, "md")
            end
            database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          end
        end
        if database:get("broadcast2" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
          if text:match("^/[Cc]ancel$") or text:match("^[Cc]ancel$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 The *Operation* Was Canceled !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\185\217\133\217\132\219\140\216\167\216\170 \217\132\216\186\217\136 \216\180\216\175 !", 1, "md")
            end
            database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          else
            local gps = database:scard("bot:groups") or 0
            local gpss = database:smembers("bot:groups") or 0
            local msgs = {
              [0] = id
            }
            for i = 1, #gpss do
              send(gpss[i], 0, 1, text, 1, "md")
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Message Was *Sent* to `" .. gps .. "` Groups !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\180\217\133\216\167 \216\168\217\135 " .. gps .. " \218\175\216\177\217\136\217\135 \216\167\216\177\216\179\216\167\217\132 \216\180\216\175 ! ", 1, "md")
            end
            database:del("broadcast2" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          end
        end
        if database:get("bot:feedback" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) and is_momod(msg.sender_user_id_, msg.chat_id_) then
          local feedback = function(extra, result)
            if msg.content_.text_:match("^0$") then
              database:del("bot:feedback" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 The *Operation* was Canceled !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\185\217\133\217\132\219\140\216\167\216\170 \217\132\216\186\217\136 \218\175\216\177\216\175\219\140\216\175 !", 1, "md")
              end
            else
              local pmfeedback = msg.content_.text_:match("(.*)")
              local fname = result.first_name_ or ""
              if result.last_name_ then
                lname = result.last_name_
              else
                lname = ""
              end
              if result.username_ then
                username = "@" .. result.username_
              else
                username = "\219\140\216\167\217\129\216\170 \217\134\216\180\216\175"
              end
              local link = database:get("bot:group:link" .. msg.chat_id_)
              if link then
                linkgp = database:get("bot:group:link" .. msg.chat_id_)
              else
                linkgp = "\219\140\216\167\217\129\216\170 \217\134\216\180\216\175"
              end
              local texti = "\226\128\162 \216\175\216\177\216\174\217\136\216\167\216\179\216\170 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 \216\167\216\178 \219\140\218\169 \218\175\216\177\217\136\217\135 \216\175\216\177\219\140\216\167\217\129\216\170 \216\180\216\175\217\135 \216\167\216\179\216\170 !\n\n\226\128\162\226\128\162  \217\133\216\180\216\174\216\181\216\167\216\170 \217\129\216\177\216\175 \216\175\216\177\216\174\217\136\216\167\216\179\216\170 \218\169\217\134\217\134\216\175\217\135 :\n\226\128\162\226\128\162 \216\162\219\140\216\175\219\140 \218\169\216\167\216\177\216\168\216\177 : " .. msg.sender_user_id_ .. "\n\226\128\162\226\128\162 \217\134\216\167\217\133 \218\169\216\167\216\177\216\168\216\177 : " .. fname .. " " .. lname .. "\n\226\128\162\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 \218\169\216\167\216\177\216\168\216\177 : " .. username .. "\n\n\226\128\162\226\128\162 \217\133\216\180\216\174\216\181\216\167\216\170 \218\175\216\177\217\136\217\135 :\n\226\128\162\226\128\162 \216\162\219\140\216\175\219\140 \218\175\216\177\217\136\217\135 : " .. msg.chat_id_ .. "\n\226\128\162\226\128\162 \217\134\216\167\217\133 \218\175\216\177\217\136\217\135 : " .. (chat.title_ or "---") .. "\n\226\128\162\226\128\162 \217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135 :" .. linkgp .. "\n\n\n\226\128\162\226\128\162 \217\190\219\140\216\167\217\133 \216\175\216\177\219\140\216\167\217\129\216\170\219\140 :\n\n" .. pmfeedback .. "\n\n\226\128\162\226\128\162 \216\167\218\175\216\177 \217\130\216\181\216\175 \217\136\216\167\216\177\216\175 \216\180\216\175\217\134 \216\168\217\135 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\175\216\167\216\177\219\140\216\175 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177 \216\178\219\140\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \218\169\217\134\219\140\216\175 :\n\n\226\128\162\226\128\162  join" .. msg.chat_id_
              database:del("bot:feedback" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
              send(bot_owner, 0, 1, texti, 1, "html")
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your *Message* was Sent to *Support* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \216\180\217\133\216\167 \216\168\217\135 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 \216\167\216\177\216\179\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
            end
          end
          getUser(msg.sender_user_id_, feedback)
        end
        if is_sudo(msg) and database:get("bot:payping") and (msg.content_.text_:match("([Hh][Tt][Tt][Pp][Ss]://[Ww][Ww][Ww].[Pp][Aa][Yy][Pp][Ii][Nn][Gg].[Ii][Rr]/%S+)") or msg.content_.text_:match("([Hh][Tt][Tt][Pp]://[Ww][Ww][Ww].[PP][Aa][Yy][Pp][Ii][Nn][Gg].[Ii][Rr]/%S+)")) then
          local paylink = msg.content_.text_:match("([Hh][Tt][Tt][Pp]://[Ww][Ww][Ww].[Pp][Aa][Yy][Pp][Ii][Nn][Gg].[Ii][Rr]/%S+)") or msg.content_.text_:match("([Hh][Tt][Tt][Pp][Ss]://[Ww][Ww][Ww].[Pp][Aa][Yy][Pp][Ii][Nn][Gg].[Ii][Rr]/%S+)")
          local hash = "bot:payping:owner"
          database:del("bot:payping")
          database:set(hash, paylink)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 *PayPing* link has been *Saved* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\217\134\218\169 \217\190\216\177\216\175\216\167\216\174\216\170 \217\190\219\140 \217\190\219\140\217\134\218\175 \216\171\216\168\216\170 \216\180\216\175 !", 1, "md")
          end
        end
        if is_sudo(msg) and database:get("bot:zarinpal") and (msg.content_.text_:match("([Hh][Tt][Tt][Pp][Ss]://[Zz][Aa][Rr][Ii][Nn][Pp].[Aa][Ll]/%S+)") or msg.content_.text_:match("([Zz][aA][rR][iI][nN][pP].[aA][lL]/%S+)") or msg.content_.text_:match("([Hh][Tt][Tt][Pp]://[Zz][Aa][Rr][Ii][Nn][Pp].[Aa][Ll]/%S+)")) then
          local paylink = msg.content_.text_:match("(http://[Zz][Aa][Rr][Ii][Nn][Pp].[Aa][Ll]/%S+)") or msg.content_.text_:match("([Zz][Aa][Rr][Ii][Nn][Pp].[Aa][Ll]/%S+)") or msg.content_.text_:match("(https://[Zz][Aa][Rr][Ii][Nn][Pp].[Aa][Ll]/%S+)")
          local hash = "bot:zarinpal:owner"
          database:del("bot:zarinpal")
          database:set(hash, paylink)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 *ZarinPal* link has been *Saved* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, " \226\128\162 \217\132\219\140\217\134\218\169 \217\190\216\177\216\175\216\167\216\174\216\170 \216\178\216\177\219\140\217\134 \217\190\216\167\217\132 \216\180\217\133\216\167 \216\171\216\168\216\170 \216\180\216\175 !", 1, "md")
          end
        end
        if database:get("bot:joinbylink:" .. msg.sender_user_id_) and (msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)")) then
        else
        end
        if database:get("Getmenu" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) and msg.content_.text_:match("^(-%d+)$") then
          local chat = msg.content_.text_:match("(-%d+)")
          local BotApi = tonumber(database:get("Bot:Api_ID"))
          if database:get("lang:gp:" .. msg.chat_id_) then
            ln = "En"
          else
            ln = "Fa"
          end
          local getmenu = function(extra, result)
            if result.inline_query_id_ then
              tdcli_function({
                ID = "SendInlineQueryResultMessage",
                chat_id_ = msg.chat_id_,
                reply_to_message_id_ = msg.id_,
                disable_notification_ = 0,
                from_background_ = 1,
                query_id_ = result.inline_query_id_,
                result_id_ = result.results_[0].id_
              }, dl_cb, nil)
              database:setex("ReqMenu:" .. msg.sender_user_id_, 130, true)
            elseif not database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\133\216\180\218\169\217\132 \217\129\217\134\219\140 \216\175\216\177 \216\177\216\168\216\167\216\170 Api !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Technical *Problem* In Bot Api !", 1, "md")
            end
          end
          tdcli_function({
            ID = "GetInlineQueryResults",
            bot_user_id_ = BotApi,
            chat_id_ = msg.chat_id_,
            user_location_ = {
              ID = "Location",
              latitude_ = 0,
              longitude_ = 0
            },
            query_ = chat .. "," .. ln,
            offset_ = 0
          }, getmenu, nil)
          database:del("Getmenu" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
        end
        if database:get("bot:getuser:" .. msg.sender_user_id_) then
          local check_msg = function(extra, result)
            if msg.forward_info_.ID == "MessageForwardedFromUser" then
              local userfwd = tostring(result.forward_info_.sender_user_id_)
              if userfwd:match("%d+") then
                local Check_GetUser = function(extra, result)
                  if result.id_ then
                    fnamef = result.first_name_ or "\217\134\216\175\216\167\216\177\216\175"
                    lnamef = result.last_name_ or ""
                    namef = fnamef .. " " .. lnamef
                    usernamef = "@" .. result.username_ or "\217\134\216\175\216\167\216\177\216\175"
                    phonenumberf = "+" .. result.phone_number_ or "\219\140\216\167\217\129\216\170 \217\134\216\180\216\175"
                    useridf = result.id_ or ""
                    fnamee = result.first_name_ or "Not Found"
                    lnamee = result.last_name_ or ""
                    namee = fnamee .. " " .. lnamee
                    usernamee = "@" .. result.username_ or "Not Found"
                    phonenumbere = "+" .. result.phone_number_ or "Not Found"
                    useride = result.id_ or ""
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      send(msg.chat_id_, msg.id_, 1, "\226\128\162 <b>Name</b> : <b>" .. namee .. [[
</b>
> <b>Username</b> : ]] .. usernamee .. [[

> <b>ID</b> : <code>]] .. useride .. [[
</code>
> <b>Phone Number</b> : ]] .. phonenumbere, 1, "html")
                    else
                      send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\216\167\217\133 : " .. namef .. "\n> \219\140\217\136\216\178\216\177\217\134\219\140\217\133 : " .. usernamef .. "\n> \216\180\217\134\216\167\216\179\217\135 : " .. useridf .. "\n> \216\180\217\133\216\167\216\177\217\135 \217\135\217\133\216\177\216\167\217\135 : " .. phonenumberf, 1, "html")
                    end
                    database:del("bot:getuser:" .. msg.sender_user_id_)
                  else
                    database:del("bot:getuser:" .. msg.sender_user_id_)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      send(msg.chat_id_, msg.id_, 1, "\226\128\162 I Can Not Give <b>Information</b> Of This User !", 1, "html")
                    else
                      send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\216\167\216\175\216\177 \216\168\217\135 \217\134\217\133\216\167\219\140\216\180 \216\167\216\183\217\132\216\167\216\185\216\167\216\170 \216\167\219\140\217\134 \218\169\216\167\216\177\216\168\216\177 \217\134\219\140\216\179\216\170\217\133 !", 1, "html")
                    end
                  end
                end
                getUser(result.forward_info_.sender_user_id_, Check_GetUser)
              end
            end
          end
          getMessage(msg.chat_id_, msg.id_, check_msg)
        end
        if database:get("bot:nerkh" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
          database:del("bot:nerkh" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          local nerkh = msg.content_.text_:match("(.*)")
          database:set("nerkh", nerkh)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Bot *Price* has been *Setted* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\216\177\216\174 \216\177\216\168\216\167\216\170 \216\171\216\168\216\170 \216\180\216\175 !", 1, "md")
          end
        end
        if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
          check_filter_words(msg, text)
          if msg.content_.text_:match("@") or msg.content_.text_:match("#") then
            if string.len(msg.content_.text_) > senspost.textpostwithtag then
              local post = msg.content_.text_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.text_) > senspost.textpostwithtag then
            local post = msg.content_.text_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
          if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Fwd] [Text]")
          end
          if (text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]")) and database:get("bot:links:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Text]")
            if database:get("bot:strict" .. msg.chat_id_) then
              chat_kick(msg.chat_id_, msg.sender_user_id_)
            end
          end
          if database:get("bot:text:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Text]")
          end
          if msg.content_.text_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Text]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Text]")
          end
          if msg.content_.text_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Text]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Text]")
          end
          if msg.content_.text_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.text_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.text_:match("[Ww][Ww][Ww]") or msg.content_.text_:match(".[Cc][Oo]") or msg.content_.text_:match(".[Ii][Rr]") or msg.content_.text_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Text]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Text]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.text_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Text]")
          end
          if msg.content_.text_ then
            local _nl, ctrl_chars = string.gsub(text, "%c", "")
            local _nl, real_digits = string.gsub(text, "%d", "")
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            local hash = "bot:sens:spam" .. msg.chat_id_
            if not database:get(hash) then
              sens = 400
            else
              sens = tonumber(database:get(hash))
            end
            if database:get("bot:spam:mute" .. msg.chat_id_) and string.len(msg.content_.text_) > sens or ctrl_chars > sens or real_digits > sens then
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Spam] ")
            end
          end
          if (msg.content_.text_:match("[A-Z]") or msg.content_.text_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Text]")
          end
        end
        if msg.date_ < os.time() - 10 then
          print("\027[" .. color.white[1] .. ";" .. color.magenta[2] .. "m>>> OLD MSG Pattern <<<\027[00m")
          return false
        end
        if database:get("bot:cmds" .. msg.chat_id_) and not is_momod(msg.sender_user_id_, msg.chat_id_) then
          print("\027[" .. color.white[1] .. ";" .. color.magenta[2] .. "m>>> Lock Cmd Is Active In This Group <<<\027[00m")
          return false
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and (text:match("^[Pp]ing$") or text:match("^\217\190\219\140\217\134\218\175$")) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Bot is Now *Online* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\177\216\168\216\167\216\170 \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\162\217\134\217\132\216\167\219\140\217\134 \217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
          end
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and (text:match("^[Ll]eave$") or text:match("^\216\170\216\177\218\169 \218\175\216\177\217\136\217\135$")) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Bot *Leaves* This Group !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\177\216\168\216\167\216\170 \216\167\216\178 \216\167\219\140\217\134 \218\175\216\177\217\136\217\135 \216\174\216\167\216\177\216\172 \217\133\219\140\216\180\217\136\216\175 !", 1, "md")
          end
          database:srem("bot:groups", msg.chat_id_)
          chat_leave(msg.chat_id_, bot_id)
        end
        local text = msg.content_.text_:gsub("\216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133", "Promote")
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Pp]romote$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local promote_by_reply_one = function(extra, result)
            local promote_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:momod:" .. msg.chat_id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Now Moderator !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\175\219\140\216\177 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Moderator !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\219\140\216\177\219\140\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                  end
                  database:sadd(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, promote_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, promote_by_reply_one)
        end
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Pp]romote @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Pp]romote) @(%S+)$")
          }
          local promote_by_username_one = function(extra, result)
            local promote_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:momod:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Now Moderator !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\175\219\140\216\177 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Moderator !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\219\140\216\177\219\140\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            end
            if result.id_ then
              getUser(result.id_, promote_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(ap[2], promote_by_username_one)
        end
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Pp]romote (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Pp]romote) (%d+)$")
          }
          local promote_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:momod:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Now Moderator !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\175\219\140\216\177 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Moderator !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\219\140\216\177\219\140\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], promote_by_id)
        end
        local text = msg.content_.text_:gsub("\216\185\216\178\217\132 \217\133\217\130\216\167\217\133", "Demote")
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emote$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local demote_by_reply_one = function(extra, result)
            local demote_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:momod:" .. msg.chat_id_
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Moderator !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\175\219\140\216\177 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Moderator !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \217\133\216\175\219\140\216\177\219\140\216\170 \216\185\216\178\217\132 \216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, demote_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, demote_by_reply_one)
        end
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emote @(%S+)$") and check_user_channel(msg) then
          do
            local hash = "bot:momod:" .. msg.chat_id_
            local ap = {
              string.match(text, "^([Dd]emote) @(%S+)$")
            }
            local demote_by_username_one = function(extra, result)
              local demote_by_username = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Moderator !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\175\219\140\216\177 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Moderator !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \217\133\216\175\219\140\216\177\219\140\216\170 \216\185\216\178\217\132 \216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              end


        
              if result.id_ then
                getUser(result.id_, demote_by_username)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            resolve_username(ap[2], demote_by_username_one)
          end
        else
        end
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emote (%d+)$") and check_user_channel(msg) then
          local hash = "bot:momod:" .. msg.chat_id_
          local ap = {
            string.match(text, "^([Dd]emote) (%d+)$")
          }
          local demote_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:momod:" .. msg.chat_id_
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Moderator !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\175\219\140\216\177 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Moderator !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \217\133\216\175\219\140\216\177\219\140\216\170 \216\185\216\178\217\132 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], demote_by_id)
        end
        local text = msg.content_.text_:gsub("\216\167\216\177\216\170\217\130\216\167 \216\168\217\135 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135", "Setvip")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]etvip$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local promotevip_by_reply_one = function(extra, result)
            local promotevip_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:vipmem:" .. msg.chat_id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Now VIP Member !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Promoted To VIP Member !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                  end
                  database:sadd(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, promotevip_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, promotevip_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]etvip @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Ss]etvip) @(%S+)$")
          }
          local promotevip_by_username_one = function(extra, result)
            local promotevip_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:vipmem:" .. msg.chat_id_
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Now VIP Member !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Promoted To VIP Member !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            end
            if result.id_ then
              getUser(result.id_, promotevip_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(ap[2], promotevip_by_username_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]etvip (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Ss]etvip) (%d+)$")
          }
          local promotevip_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:vipmem:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Now VIP Member !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Promoted To VIP Member !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], promotevip_by_id)
        end
        local text = msg.content_.text_:gsub("\216\173\216\176\217\129 \216\167\216\178 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135", "Demvip")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emvip$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local demotevip_by_reply_one = function(extra, result)
            local demotevip_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:vipmem:" .. msg.chat_id_
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not VIP Member !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From VIP Member !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\185\216\178\217\132 \216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, demotevip_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, demotevip_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emvip @(%S+)$") and check_user_channel(msg) then
          do
            local hash = "bot:vipmem:" .. msg.chat_id_
            local ap = {
              string.match(text, "^([Dd]emvip) @(%S+)$")
            }
            local demotevip_by_username_one = function(extra, result)
              local demotevip_by_username = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not VIP Member !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From VIP Member !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\185\216\178\217\132 \216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              end
              if result.id_ then
                getUser(result.id_, demotevip_by_username)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            resolve_username(ap[2], demotevip_by_username_one)
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emvip (%d+)$") and check_user_channel(msg) then
          do
            local hash = "bot:vipmem:" .. msg.chat_id_
            local ap = {
              string.match(text, "^([Dd]emvip) (%d+)$")
            }
            local demotevip_by_id = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not VIP Member !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From VIP Member !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\185\216\182\217\136 \217\136\219\140\218\152\217\135 \216\185\216\178\217\132 \216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(ap[2], demotevip_by_id)
          end
        else
        end
        if (text:match("^[Gg]p id$") or text:match("^\216\180\217\134\216\167\216\179\217\135 \218\175\216\177\217\136\217\135$")) and idf:match("-100(%d+)") then
          if database:get("lang:gp:" .. msg.chat_id_) then
            texts = "\226\128\162 *Group ID* : \n`" .. msg.chat_id_ .. "`"
          else
            texts = "\226\128\162 \216\180\217\134\216\167\216\179\217\135 \218\175\216\177\217\136\217\135 : \n`" .. msg.chat_id_ .. "`"
          end
          send(msg.chat_id_, msg.id_, 1, texts, 1, "md")
        end
        if text:match("^[Mm]y username$") or text:match("^\219\140\217\136\216\178\216\177\217\134\219\140\217\133 \217\133\217\134$") then
          local get_username = function(extra, result)
            if result.username_ then
              local ust = result.username_
              if database:get("lang:gp:" .. msg.chat_id_) then
                text = "\226\128\162 <b>Your Username</b> : " .. ust
              else
                text = "\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 \216\180\217\133\216\167 : " .. ust
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 You <b>have</b> not <b>Username</b> ! "
            else
              text = "\226\128\162 \216\180\217\133\216\167 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 \217\134\216\175\216\167\216\177\219\140\216\175 !"
            end
            send(msg.chat_id_, msg.id_, 1, text, 1, "html")
          end
          getUser(msg.sender_user_id_, get_username)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Dd]el$") or text:match("^\216\173\216\176\217\129$") and msg.reply_to_message_id_ ~= 0) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          delete_msg(msg.chat_id_, {
            [0] = msg.reply_to_message_id_
          })
          delete_msg(msg.chat_id_, msgs)
        end
        local text = msg.content_.text_:gsub("\216\167\216\174\216\177\216\167\216\172", "Kick")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Kk]ick$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local kick_reply_one = function(extra, result)
            local kick_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Kicked !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\174\216\177\216\167\216\172 \216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                  chat_kick(msg.chat_id_, result.id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 You *Can not* Ban *Moderators* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \217\134\217\133\219\140\216\170\217\136\216\167\217\134\219\140\216\175 \217\133\216\175\219\140\216\177\216\167\217\134 \216\177\216\167 \216\167\216\174\216\177\216\167\216\172 \218\169\217\134\219\140\216\175 !", 1, "md")
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, kick_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, kick_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Kk]ick @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Kk]ick) @(%S+)$")
          }
          local kick_by_username_one = function(extra, result)
            local kick_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Kicked !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\174\216\177\216\167\216\172 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
                chat_kick(msg.chat_id_, result.id_)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 You *Can not* Ban *Moderators* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \217\134\217\133\219\140\216\170\217\136\216\167\217\134\219\140\216\175 \217\133\216\175\219\140\216\177\216\167\217\134 \216\177\216\167 \216\167\216\174\216\177\216\167\216\172 \218\169\217\134\219\140\216\175 !", 1, "md")
              end
            end
            if result.id_ then
              getUser(result.id_, kick_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(ap[2], kick_by_username_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Kk]ick (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Kk]ick) (%d+)$")
          }
          local kick_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Kicked !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\174\216\177\216\167\216\172 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
                chat_kick(msg.chat_id_, result.id_)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 You *Can not* Ban *Moderators* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \217\134\217\133\219\140\216\170\217\136\216\167\217\134\219\140\216\175 \217\133\216\175\219\140\216\177\216\167\217\134 \216\177\216\167 \217\133\216\179\216\175\217\136\216\175 \218\169\217\134\219\140\216\175 !", 1, "md")
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], kick_by_id)
        end
        local text = msg.content_.text_:gsub("\217\133\216\179\216\175\217\136\216\175", "Ban")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Bb]an$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local ban_by_reply_one = function(extra, result)
            local ban_by_reply = function(extra, result)
              local hash = "bot:banned:" .. msg.chat_id_
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Banned !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\179\216\175\217\136\216\175 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                    end
                  else
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Banned !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\179\216\175\217\136\216\175 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                    end
                    chat_kick(msg.chat_id_, result.id_)
                    database:sadd(hash, result.id_)
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 You *Can not* Ban *Moderators* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \217\134\217\133\219\140\216\170\217\136\216\167\217\134\219\140\216\175 \217\133\216\175\219\140\216\177\216\167\217\134 \216\177\216\167 \217\133\216\179\216\175\217\136\216\175 \218\169\217\134\219\140\216\175 !", 1, "md")
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, ban_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, ban_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Bb]an @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Bb]an) @(%S+)$")
          }
          local ban_by_username_one = function(extra, result)
            local ban_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:banned:" .. msg.chat_id_
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Banned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\179\216\175\217\136\216\175 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Banned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\179\216\175\217\136\216\175 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                  end
                  chat_kick(msg.chat_id_, result.id_)
                  database:sadd(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 You *Can not* Ban *Moderators* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \217\134\217\133\219\140\216\170\217\136\216\167\217\134\219\140\216\175 \217\133\216\175\219\140\216\177\216\167\217\134 \216\177\216\167 \217\133\216\179\216\175\217\136\216\175 \218\169\217\134\219\140\216\175 !", 1, "md")
              end
            end
            if result.id_ then
              getUser(result.id_, ban_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(ap[2], ban_by_username_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Bb]an (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Bb]an) (%d+)$")
          }
          local ban_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            local hash = "bot:banned:" .. msg.chat_id_
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Banned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\179\216\175\217\136\216\175 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Banned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\179\216\175\217\136\216\175 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                  end
                  chat_kick(msg.chat_id_, result.id_)
                  database:sadd(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 You *Can not* Ban *Moderators* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \217\134\217\133\219\140\216\170\217\136\216\167\217\134\219\140\216\175 \217\133\216\175\219\140\216\177\216\167\217\134 \216\177\216\167 \217\133\216\179\216\175\217\136\216\175 \218\169\217\134\219\140\216\175 !", 1, "md")
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], ban_by_id)
        end
        local text = msg.content_.text_:gsub("\216\173\216\176\217\129 \218\169\217\132\219\140 \217\190\219\140\216\167\217\133", "Delall")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]elall$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local delall_by_reply_one = function(extra, result)
            local delall_by_reply = function(extra, result)
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                del_all_msgs(msg.chat_id_, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 All Msgs from " .. te .. " Has Been Deleted !", 15, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \217\190\219\140\216\167\217\133 \217\135\216\167\219\140 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\173\216\176\217\129 \218\175\216\177\216\175\219\140\216\175 !", 23, string.len(tp), result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, delall_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, delall_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]elall (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Dd]elall) (%d+)$")
          }
          local delall_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              del_all_msgs(msg.chat_id_, result.id_)
              if database:get("lang:gp:" .. msg.chat_id_) then
                sendmen(msg.chat_id_, msg.id_, "\226\128\162 All Msgs from " .. te .. " Has Been Deleted !", 15, string.len(tp), result.id_)
              else
                sendmen(msg.chat_id_, msg.id_, "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \217\190\219\140\216\167\217\133 \217\135\216\167\219\140 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\173\216\176\217\129 \218\175\216\177\216\175\219\140\216\175 !", 23, string.len(tp), result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], delall_by_id)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]elall @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Dd]elall) @(%S+)$")
          }
          local delall_by_username_one = function(extra, result)
            local delall_by_username = function(extra, result)
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              del_all_msgs(msg.chat_id_, result.id_)
              if database:get("lang:gp:" .. msg.chat_id_) then
                sendmen(msg.chat_id_, msg.id_, "\226\128\162 All Msgs from " .. te .. " Has Been Deleted !", 15, string.len(tp), result.id_)
              else
                sendmen(msg.chat_id_, msg.id_, "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \217\190\219\140\216\167\217\133 \217\135\216\167\219\140 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\173\216\176\217\129 \218\175\216\177\216\175\219\140\216\175 !", 23, string.len(tp), result.id_)
              end
            end
            if result.id_ then
              getUser(result.id_, delall_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(ap[2], delall_by_username_one)
        end
        local text = msg.content_.text_:gsub("\216\162\216\178\216\167\216\175 \218\169\216\177\216\175\217\134", "Unban")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Uu]nban$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local unban_by_reply_one = function(extra, result)
            local unban_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:banned:" .. msg.chat_id_
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Banned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\179\216\175\217\136\216\175 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Unbanned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\162\216\178\216\167\216\175 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, unban_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, unban_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Uu]nban @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Uu]nban) @(%S+)$")
          }
          local unban_by_username_one = function(extra, result)
            local unban_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:banned:" .. msg.chat_id_
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Banned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\179\216\175\217\136\216\175 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Unbanned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\162\216\178\216\167\216\175 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            end
            if result.id_ then
              getUser(result.id_, unban_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(ap[2], unban_by_username_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Uu]nban (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Uu]nban) (%d+)$")
          }
          local unban_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            local hash = "bot:banned:" .. msg.chat_id_
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Banned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\179\216\175\217\136\216\175 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Unbanned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\162\216\178\216\167\216\175 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], unban_by_id)
        end
        local text = msg.content_.text_:gsub("\217\133\216\179\216\175\217\136\216\175\216\179\216\167\216\178\219\140", "Banall")
        if is_sudo(msg) and text:match("^[Bb]anall$") and msg.reply_to_message_id_ ~= 0 then
          local gban_by_reply_one = function(extra, result)
            local gban_by_reply = function(extra, result)
              if result.id_ and (tonumber(result.id_) == tonumber(our_id) or is_admin(result.id_)) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:gban:"
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Globaly Banned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  if tostring(msg.chat_id_):match("-100(%d+)") then
                    chat_kick(msg.chat_id_, result.id_)
                  end
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Globaly Banned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \216\179\216\167\216\178\219\140 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, gban_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, gban_by_reply_one)
        end
        if is_sudo(msg) and text:match("^[Bb]anall @(%S+)$") then
          local aps = {
            string.match(text, "^([Bb]anall) @(%S+)$")
          }
          local gban_by_username_one = function(extra, result)
            local gban_by_username = function(extra, result)
              if result.id_ and (tonumber(result.id_) == tonumber(our_id) or is_admin(result.id_)) then
                return false
              end
              local hash = "bot:gban:"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Globaly Banned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)
                if tostring(msg.chat_id_):match("-100(%d+)") then
                  chat_kick(msg.chat_id_, result.id_)
                end
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Globaly Banned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \216\179\216\167\216\178\219\140 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            end
            if result.id_ then
              getUser(result.id_, gban_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(aps[2], gban_by_username_one)
        end
        if is_sudo(msg) and text:match("^[Bb]anall (%d+)$") then
          local ap = {
            string.match(text, "^([Bb]anall) (%d+)$")
          }
          local hash = "bot:gban:"
          local gban_by_id = function(extra, result)
            if result.id_ and (tonumber(result.id_) == tonumber(our_id) or is_admin(result.id_)) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:gban:"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Globaly Banned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)
                if tostring(msg.chat_id_):match("-100(%d+)") then
                  chat_kick(msg.chat_id_, result.id_)
                end
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Globaly Banned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \216\179\216\167\216\178\219\140 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], gban_by_id)
        end
        local text = msg.content_.text_:gsub("\216\162\216\178\216\167\216\175\216\179\216\167\216\178\219\140", "unbanall")
        if is_sudo(msg) and text:match("^[Uu]nbanall$") and msg.reply_to_message_id_ ~= 0 then
          local ungban_by_reply_one = function(extra, result)
            local ungban_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:gban:"
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Globaly Banned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \217\134\219\140\216\179\216\170 ! ", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Globaly Unbanned !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \216\162\216\178\216\167\216\175\216\179\216\167\216\178\219\140 \216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                  database:srem(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, ungban_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, ungban_by_reply_one)
        end
        if is_sudo(msg) and text:match("^[Uu]nbanall @(%S+)$") then
          local apid = {
            string.match(text, "^([Uu]nbanall) @(%S+)$")
          }
          local ungban_by_username_one = function(extra, result)
            local ungban_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:gban:"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Globaly Banned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \217\134\219\140\216\179\216\170 ! ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Globaly Unbanned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \216\162\216\178\216\167\216\175\216\179\216\167\216\178\219\140 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
                database:srem(hash, result.id_)
              end
            end
            if result.id_ then
              getUser(result.id_, ungban_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(apid[2], ungban_by_username_one)
        end
        if is_sudo(msg) and text:match("^[Uu]nbanall (%d+)$") then
          local ap = {
            string.match(text, "^([Uu]nbanall) (%d+)$")
          }
          local hash = "bot:gban:"
          local ungban_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:gban:"
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Globaly Banned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \217\133\216\179\216\175\217\136\216\175 \217\134\219\140\216\179\216\170 ! ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Globaly Unbanned !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\183\217\136\216\177 \218\169\217\132\219\140 \216\162\216\178\216\167\216\175\216\179\216\167\216\178\219\140 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
                database:srem(hash, result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], ungban_by_id)
        end
        local text = msg.content_.text_:gsub("\216\168\219\140 \216\181\216\175\216\167", "Muteuser")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local mute_by_reply_one = function(extra, result)
            local mute_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  local hash = "bot:muted:" .. msg.chat_id_
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Muted !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\219\140 \216\181\216\175\216\167 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    database:set(hash2, true)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Muted !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\219\140 \216\181\216\175\216\167 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                    end
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 ! ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, mute_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, mute_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Mm]uteuser) @(%S+)$")
          }
          local mute_by_username_one = function(extra, result)
            local mute_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                local hash = "bot:muted:" .. msg.chat_id_
                local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Muted !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\219\140 \216\181\216\175\216\167 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  database:set(hash2, true)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Muted !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\219\140 \216\181\216\175\216\167 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              end
            end
            if result.id_ then
              getUser(result.id_, mute_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 ! ", 1, "md")
            end
          end
          resolve_username(ap[2], mute_by_username_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Mm]uteuser) (%d+)$")
          }
          local mute_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                local hash = "bot:muted:" .. msg.chat_id_
                local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Muted !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\219\140 \216\181\216\175\216\167 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  database:set(hash2, true)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Muted !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\219\140 \216\181\216\175\216\167 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 ! ", 1, "md")
            end
          end
          getUser(ap[2], mute_by_id)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser (%d+) (%d+) (%d+)$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local mute_by_reply_one_Time = function(extra, result)
            local mute_by_reply_Time = function(extra, result)
              local matches = {
                string.match(text, "^([Mm]uteuser) (%d+) (%d+) (%d+)$")
              }
              local hour = string.gsub(matches[2], "h", "")
              local num1 = tonumber(hour) * 3600
              local minutes = string.gsub(matches[3], "m", "")
              local num2 = tonumber(minutes) * 60
              local second = string.gsub(matches[4], "s", "")
              local num3 = tonumber(second)
              local num4 = tonumber(num1 + num2 + num3)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  local hash = "bot:muted:" .. msg.chat_id_
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Muted !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\219\140 \216\181\216\175\216\167 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    database:setex(hash2, num4, true)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Muted For " .. matches[2] .. " Hours and " .. matches[3] .. " Minutes and " .. matches[4] .. " Seconds !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\216\170 " .. matches[2] .. " \216\179\216\167\216\185\216\170 \217\136 " .. matches[3] .. " \216\175\217\130\219\140\217\130\217\135 \217\136 " .. matches[4] .. " \216\171\216\167\217\134\219\140\217\135  \216\168\219\140 \216\181\216\175\216\167 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                    end
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 ! ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, mute_by_reply_Time)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, mute_by_reply_one_Time)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser @(%S+) (%d+) (%d+) (%d+)$") and check_user_channel(msg) then
          do
            local ap = {
              string.match(text, "^([Mm]uteuser) @(%S+) (%d+) (%d+) (%d+)$")
            }
            local mute_by_username_one_Time = function(extra, result)
              local mute_by_username_Time = function(extra, result)
                local hour = string.gsub(ap[3], "h", "")
                local num1 = tonumber(hour) * 3600
                local minutes = string.gsub(ap[4], "m", "")
                local num2 = tonumber(minutes) * 60
                local second = string.gsub(ap[5], "s", "")
                local num3 = tonumber(second)
                local num4 = tonumber(num1 + num2 + num3)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  local hash = "bot:muted:" .. msg.chat_id_
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Muted !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\219\140 \216\181\216\175\216\167 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    database:setex(hash2, num4, true)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Muted For " .. ap[3] .. " Hours and " .. ap[4] .. " Minutes and " .. ap[5] .. " Seconds !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\216\170 " .. ap[3] .. " \216\179\216\167\216\185\216\170 \217\136 " .. ap[4] .. " \216\175\217\130\219\140\217\130\217\135 \217\136 " .. ap[5] .. " \216\171\216\167\217\134\219\140\217\135  \216\168\219\140 \216\181\216\175\216\167 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                    end
                  end
                end
              end
              if result.id_ then
                getUser(result.id_, mute_by_username_Time)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            resolve_username(ap[2], mute_by_username_one_Time)
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser (%d+) (%d+) (%d+) (%d+)$") and check_user_channel(msg) then
          do
            local ap = {
              string.match(text, "^([Mm]uteuser) (%d+) (%d+) (%d+) (%d+)$")
            }
            local mute_by_id_Time = function(extra, result)
              local hour = string.gsub(ap[3], "h", "")
              local num1 = tonumber(hour) * 3600
              local minutes = string.gsub(ap[4], "m", "")
              local num2 = tonumber(minutes) * 60
              local second = string.gsub(ap[5], "s", "")
              local num3 = tonumber(second)
              local num4 = tonumber(num1 + num2 + num3)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  local hash = "bot:muted:" .. msg.chat_id_
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Muted !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\219\140 \216\181\216\175\216\167 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    database:setex(hash2, num4, true)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Muted For " .. ap[3] .. " Hours and " .. ap[4] .. " Minutes and " .. ap[5] .. " Seconds !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\216\170 " .. ap[3] .. " \216\179\216\167\216\185\216\170 \217\136 " .. ap[4] .. " \216\175\217\130\219\140\217\130\217\135 \217\136 " .. ap[5] .. " \216\171\216\167\217\134\219\140\217\135  \216\168\219\140 \216\181\216\175\216\167 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                    end
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(ap[2], mute_by_id_Time)
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = msg.content_.text_:gsub("\216\173\216\176\217\129 \216\168\219\140 \216\181\216\175\216\167", "Unmuteuser")
          if text:match("^[Uu]nmuteuser$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
            local unmute_by_reply_one = function(extra, result)
              local unmute_by_reply = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local hash = "bot:muted:" .. msg.chat_id_
                if result.id_ then
                  local tf = result.first_name_ or ""
                  local tl = result.last_name_ or ""
                  if result.username_ then
                    tp = result.username_
                  else
                    local st = tf .. " " .. tl
                    if string.len(st) > MaxChar then
                      tp = ""
                    elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                      tp = st
                    elseif st:match("[A-Z]") or st:match("[a-z]") then
                      tp = st
                    else
                      tp = ""
                    end
                  end
                  if tonumber(string.len(tp)) == 0 then
                    te = " [ " .. result.id_ .. " ]"
                  else
                    te = tp
                  end
                  if not database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Muted !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\219\140 \216\181\216\175\216\167 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                    end
                  else
                    local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                    database:srem(hash, result.id_)
                    database:del(hash2)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Unmuteded !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \216\173\216\167\217\132\216\170 \216\168\219\140 \216\181\216\175\216\167 \216\174\216\167\216\177\216\172 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                    end
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
                end
              end
              getUser(result.sender_user_id_, unmute_by_reply)
            end
            getMessage(msg.chat_id_, msg.reply_to_message_id_, unmute_by_reply_one)
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = msg.content_.text_:gsub("\216\173\216\176\217\129 \216\168\219\140 \216\181\216\175\216\167", "Unmuteuser")
          if text:match("^[Uu]nmuteuser @(%S+)$") and check_user_channel(msg) then
            local ap = {
              string.match(text, "^([Uu]nmuteuser) @(%S+)$")
            }
            local unmute_by_username_one = function(extra, result)
              local unmute_by_username = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local hash = "bot:muted:" .. msg.chat_id_
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Muted !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\219\140 \216\181\216\175\216\167 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  database:srem(hash, result.id_)
                  database:del(hash2)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Unmuteded !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \216\173\216\167\217\132\216\170 \216\168\219\140 \216\181\216\175\216\167 \216\174\216\167\216\177\216\172 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              end
              if result.id_ then
                getUser(result.id_, unmute_by_username)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            resolve_username(ap[2], unmute_by_username_one)
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = msg.content_.text_:gsub("\216\173\216\176\217\129 \216\168\219\140 \216\181\216\175\216\167", "Unmuteuser")
          if text:match("^[Uu]nmuteuser (%d+)$") and check_user_channel(msg) then
            local ap = {
              string.match(text, "^([Uu]nmuteuser) (%d+)$")
            }
            local unmute_by_id = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:muted:" .. msg.chat_id_
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Muted !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\219\140 \216\181\216\175\216\167 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  database:srem(hash, result.id_)
                  database:del(hash2)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Has Been Unmuteded !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \216\173\216\167\217\132\216\170 \216\168\219\140 \216\181\216\175\216\167 \216\174\216\167\216\177\216\172 \218\175\216\177\216\175\219\140\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(ap[2], unmute_by_id)
          end
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
          text = msg.content_.text_:gsub("\216\167\216\177\216\170\217\130\216\167 \216\168\217\135 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135", "Setowner")
          if text:match("^[Ss]etowner$") and msg.reply_to_message_id_ ~= 0 then
            local setowner_by_reply_one = function(extra, result)
              local setowner_by_reply = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                if result.id_ then
                  local tf = result.first_name_ or ""
                  local tl = result.last_name_ or ""
                  if result.username_ then
                    tp = result.username_
                  else
                    local st = tf .. " " .. tl
                    if string.len(st) > MaxChar then
                      tp = ""
                    elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                      tp = st
                    elseif st:match("[A-Z]") or st:match("[a-z]") then
                      tp = st
                    else
                      tp = ""
                    end
                  end
                  if tonumber(string.len(tp)) == 0 then
                    te = " [ " .. result.id_ .. " ]"
                  else
                    te = tp
                  end
                  local hash = "bot:owners:" .. msg.chat_id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Owner !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Owner !", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                    end
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
                end
              end
              getUser(result.sender_user_id_, setowner_by_reply)
            end
            getMessage(msg.chat_id_, msg.reply_to_message_id_, setowner_by_reply_one)
          end
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
          text = msg.content_.text_:gsub("\216\167\216\177\216\170\217\130\216\167 \216\168\217\135 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135", "Setowner")
          if text:match("^[Ss]etowner @(%S+)$") then
            local ap = {
              string.match(text, "^([Ss]etowner) @(%S+)$")
            }
            local setowner_by_username_one = function(extra, result)
              local setowner_by_username = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local hash = "bot:owners:" .. msg.chat_id_
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Owner !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Owner !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                  end
                end
              end
              if result.id_ then
                getUser(result.id_, setowner_by_username)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            resolve_username(ap[2], setowner_by_username_one)
          end
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
          text = msg.content_.text_:gsub("\216\167\216\177\216\170\217\130\216\167 \216\168\217\135 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135", "Setowner")
          if text:match("^[Ss]etowner (%d+)$") then
            local ap = {
              string.match(text, "^([Ss]etowner) (%d+)$")
            }
            local setowner_by_id = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:owners:" .. msg.chat_id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Owner !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Owner !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(ap[2], setowner_by_username)
          end
        end
        local text = msg.content_.text_:gsub("\216\173\216\176\217\129 \216\167\216\178 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135", "Demowner")
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emowner$") and msg.reply_to_message_id_ ~= 0 then
          local deowner_by_reply_one = function(extra, result)
            local deowner_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:owners:" .. msg.chat_id_
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Owner !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 : " .. te .. " \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Demoted From Owner !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 : " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \216\173\216\176\217\129 \216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, deowner_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, deowner_by_reply_one)
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emowner @(%S+)$") then
          local hash = "bot:owners:" .. msg.chat_id_
          local ap = {
            string.match(text, "^([Dd]emowner) @(%S+)$")
          }
          local remowner_by_username_one = function(extra, result)
            local remowner_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:owners:" .. msg.chat_id_
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Owner !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 : " .. te .. " \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Demoted From Owner !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 : " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \216\173\216\176\217\129 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            end
            if result.id_ then
              getUser(result.id_, remowner_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(ap[2], remowner_by_username_one)
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emowner (%d+)$") then
          local hash = "bot:owners:" .. msg.chat_id_
          local ap = {
            string.match(text, "^([Dd]emowner) (%d+)$")
          }
          local remowner_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:owners:" .. msg.chat_id_
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Owner !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 : " .. te .. " \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Removed From Owner !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 : " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \216\173\216\176\217\129 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], remowner_by_id)
        end
        if is_leader(msg) and text:match("^[Ss]etsudo$") and msg.reply_to_message_id_ ~= 0 then
          local promoteSudo_by_reply_one = function(extra, result)
            local promoteSudo_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "Bot:SudoUsers"
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Sudo !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Sudo !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                  end
                  table.insert(_config.Sudo_Users, tonumber(result.id_))
                  save_on_config()
                  load_config()
                  SetRankStatus("AddSudo", result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, promoteSudo_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, promoteSudo_by_reply_one)
        end
        if is_leader(msg) and text:match("^[Ss]etsudo @(%S+)$") then
          local ap = {
            string.match(text, "^([Ss]etsudo) @(%S+)$")
          }
          local promoteSudo_by_username_one = function(extra, result)
            local promoteSudo_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "Bot:SudoUsers"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
                table.insert(_config.Sudo_Users, tonumber(result.id_))
                save_on_config()
                load_config()
                SetRankStatus("AddSudo", result.id_)
              end
            end
            if result.id_ then
              getUser(result.id_, promoteSudo_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(ap[2], promoteSudo_by_username_one)
        end
        if is_leader(msg) and text:match("^[Ss]etsudo (%d+)$") then
          local ap = {
            string.match(text, "^([Ss]etsudo) (%d+)$")
          }
          local promoteSudo_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:SudoUsers"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \217\133\219\140\216\168\216\167\216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Promoted To Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
                table.insert(_config.Sudo_Users, tonumber(result.id_))
                save_on_config()
                load_config()
                SetRankStatus("AddSudo", result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], promoteSudo_by_id)
        end
        if is_leader(msg) and text:match("^[Rr]emsudo$") and msg.reply_to_message_id_ ~= 0 then
          local demoteSudo_by_reply_one = function(extra, result)
            local demoteSudo_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local k = tonumber(result.id_)
              local hash = "Bot:SudoUsers"
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Sudo !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 ! ", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Sudo !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\216\175\219\140\216\177\219\140\216\170 \216\177\216\168\216\167\216\170 \216\173\216\176\217\129 \216\180\216\175 ! ", 8, string.len(tp), result.id_)
                  end
                  table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, k))
                  save_on_config()
                  load_config()
                  SetRankStatus("RemSudo", k)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 User Not Found !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, demoteSudo_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, demoteSudo_by_reply_one)
        end
        if is_leader(msg) and text:match("^[Rr]emsudo @(%S+)$") then
          local ap = {
            string.match(text, "^([Rr]emsudo) @(%S+)$")
          }
          local demoteSudo_by_username_one = function(extra, result)
            local demoteSudo_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local k = tonumber(result.id_)
              local hash = "Bot:SudoUsers"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 ! ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\216\175\219\140\216\177\219\140\216\170 \216\177\216\168\216\167\216\170 \216\173\216\176\217\129 \216\180\216\175 ! ", 8, string.len(tp), result.id_)
                end
                table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, k))
                save_on_config()
                load_config()
                SetRankStatus("RemSudo", k)
              end
            end
            if result.id_ then
              getUser(result.id_, demoteSudo_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(ap[2], demoteSudo_by_username_one)
        end
        if is_leader(msg) and text:match("^[Rr]emsudo (%d+)$") then
          local ap = {
            string.match(text, "^([Rr]emsudo) (%d+)$")
          }
          local demoteSudo_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local k = tonumber(result.id_)
              local hash = "Bot:SudoUsers"
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 ! ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Sudo !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\216\175\219\140\216\177\219\140\216\170 \216\177\216\168\216\167\216\170 \216\173\216\176\217\129 \216\180\216\175 ! ", 8, string.len(tp), result.id_)
                end
                table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, k))
                save_on_config()
                load_config()
                SetRankStatus("RemSudo", k)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], demoteSudo_by_id)
        end
        local text = msg.content_.text_:gsub("\216\167\216\177\216\170\217\130\216\167 \216\168\217\135 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170", "Addadmin")
        if is_leader(msg) and text:match("^[Ss]etadmin$") and msg.reply_to_message_id_ ~= 0 then
          local addadmin_by_reply_one = function(extra, result)
            local addadmin_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "Bot:Admins"
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Bot Admin !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  SetRankStatus("AddAdmin", result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Promote To Bot Admin !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, addadmin_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, addadmin_by_reply_one)
        end
        if is_leader(msg) and text:match("^[Ss]etadmin @(%S+)$") then
          local ap = {
            string.match(text, "^([Ss]etadmin) @(%S+)$")
          }
          local addadmin_by_username_one = function(extra, result)
            local addadmin_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "Bot:Admins"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)
                SetRankStatus("AddAdmin", result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Promote To Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
              end
            end
            if result.id_ then
              getUser(result.id_, addadmin_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(ap[2], addadmin_by_username_one)
        end
        if is_leader(msg) and text:match("^[Ss]etadmin (%d+)$") then
          local ap = {
            string.match(text, "^([Ss]etadmin) (%d+)$")
          }
          local addadmin_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:Admins"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Already Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\167\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)
                SetRankStatus("AddAdmin", result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Promote To Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\168\217\135 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \219\140\216\167\217\129\216\170 !", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], addadmin_by_reply)
        end
        local text = msg.content_.text_:gsub("\216\173\216\176\217\129 \216\167\216\178 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170", "Remadmin")
        if is_leader(msg) and text:match("^[Rr]emadmin$") and msg.reply_to_message_id_ ~= 0 then
          local deadmin_by_reply_one = function(extra, result)
            local deadmin_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "Bot:Admins"
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Admin !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  SetRankStatus("RemAdmin", result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Bot Admin !", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\185\216\178\217\132 \216\180\216\175 !", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            end
            getUser(result.sender_user_id_, deadmin_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, deadmin_by_reply_one)
        end
        if is_leader(msg) and text:match("^[Rr]emadmin @(%S+)$") then
          local hash = "Bot:Admins"
          local ap = {
            string.match(text, "^([Rr]emadmin) @(%S+)$")
          }
          local remadmin_by_username_one = function(extra, result)
            local remadmin_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "Bot:Admins"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                SetRankStatus("RemAdmin", result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\185\216\178\217\132 \216\180\216\175 !", 8, string.len(tp), result.id_)
                end
              end
            end
            if result.id_ then
              getUser(result.id_, remadmin_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          resolve_username(ap[2], remadmin_by_username_one)
        end
        if is_leader(msg) and text:match("^[Rr]emadmin (%d+)$") then
          local ap = {
            string.match(text, "^([Rr]emadmin) (%d+)$")
          }
          local remadmin_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == our_id then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:Admins"
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Is Not Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \217\134\219\140\216\179\216\170 !", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                SetRankStatus("RemAdmin", result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 User " .. te .. " Was Demoted From Bot Admin !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. te .. " \216\167\216\178 \217\133\217\130\216\167\217\133 \216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170 \216\185\216\178\217\132 \216\180\216\175", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User Not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177\219\140 \216\168\216\167 \216\167\219\140\217\134 \217\133\216\180\216\174\216\181\216\167\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          end
          getUser(ap[2], remadmin_by_username)
        end
        if is_admin(msg.sender_user_id_) and (text:match("^[Gg]plist$") or text:match("^\217\132\219\140\216\179\216\170 \218\175\216\177\217\136\217\135 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170$")) then
          if database:get("bot:reloadingtime") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 Bot is in a <b>State Reloading</b> !"
            else
              text = "\226\128\162 \216\177\216\168\216\167\216\170 \216\175\216\177 \217\136\216\182\216\185\219\140\216\170 \216\168\216\167\216\178\217\134\218\175\216\177\219\140 \217\133\219\140\216\168\216\167\216\180\216\175 !"
            end
            send(msg.chat_id_, msg.id_, 1, text, 1, "html")
          else
            local hash = "bot:groups"
            local list = database:smembers(hash)
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 List of <b>Bot Groups</b> : \n\n"
            else
              text = "\226\128\162 \217\132\219\140\216\179\216\170 \218\175\216\177\217\136\217\135 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170 : \n\n"
            end
            local text2 = ""
            local text3 = ""
            local text4 = ""
            local text5 = ""
            local text6 = ""
            for k, v in pairs(list) do
              local gp_info = database:get("group:Name" .. v)
              local chatname = gp_info
              local ex = database:ttl("bot:charge:" .. v)
              if ex == -1 then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  expire = "<b>Unlimited</b>"
                else
                  expire = "\217\134\216\167\217\133\216\173\216\175\217\136\216\175"
                end
              else
                local b = math.floor(ex / day) + 1
                if b == 0 then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    expire = "<b>No Credit</b>"
                  else
                    expire = "\216\168\216\175\217\136\217\134 \216\167\216\185\216\170\216\168\216\167\216\177"
                  end
                else
                  local d = math.floor(ex / day) + 1
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    expire = "<b>" .. d .. " Days</b>"
                  else
                    expire = d .. " \216\177\217\136\216\178"
                  end
                end
              end
              if k <= 30 then
                if chatname then
                  text = text .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text = text .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              elseif k > 30 and k <= 60 then
                if chatname then
                  text2 = text2 .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text2 = text2 .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              elseif k > 60 and k <= 90 then
                if chatname then
                  text3 = text3 .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text3 = text3 .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              elseif k > 90 and k <= 120 then
                if chatname then
                  text4 = text4 .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text4 = text4 .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              elseif k > 120 and k <= 150 then
                if chatname then
                  text5 = text5 .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text5 = text5 .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              elseif k > 150 and k <= 180 then
                if chatname then
                  text6 = text6 .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text6 = text6 .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              end
            end
            if #list == 0 then
              if database:get("lang:gp:" .. msg.chat_id_) then
                text = "\226\128\162 List of <b>Bot Groups</b> is Empty !"
              else
                text = "\226\128\162 \217\132\219\140\216\179\216\170 \218\175\216\177\217\136\217\135 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170 \216\174\216\167\217\132\219\140 \216\167\216\179\216\170 !"
              end
            end
            send_large_msg(msg.chat_id_, msg.id_, 1, text, 1, "html")
            if text2 then
              send_large_msg(msg.chat_id_, msg.id_, 1, text2, 1, "html")
            end
            if text3 then
              send_large_msg(msg.chat_id_, msg.id_, 1, text3, 1, "html")
            end
            if text4 then
              send_large_msg(msg.chat_id_, msg.id_, 1, text4, 1, "html")
            end
            if text5 then
              send_large_msg(msg.chat_id_, msg.id_, 1, text5, 1, "html")
            end
            if text6 then
              send_large_msg(msg.chat_id_, msg.id_, 1, text6, 1, "html")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Mm]odlist$") or text:match("^\217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\216\167\217\134 \218\175\216\177\217\136\217\135$")) and check_user_channel(msg) then
          local hash = "bot:momod:" .. msg.chat_id_
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "\226\128\162 List Of <b>Moderator</b> : \n\n"
          else
            text = "\226\128\162 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\216\167\217\134 \218\175\216\177\217\136\217\135 : \n\n"
          end
          for k, v in pairs(list) do
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
            else
              text = text .. k .. " - [" .. v .. "]\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 List Of <b>Moderator</b> is Empty !"
            else
              text = "\226\128\162 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\216\167\217\134 \216\174\216\167\217\132\219\140 \216\167\216\179\216\170 !"
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Vv]iplist$") or text:match("^\217\132\219\140\216\179\216\170 \216\185\216\182\217\136\217\135\216\167\219\140 \217\136\219\140\218\152\217\135$")) and check_user_channel(msg) then
          local hash = "bot:vipmem:" .. msg.chat_id_
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "\226\128\162 List Of <b>VIP Members</b> : \n\n"
          else
            text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\185\216\182\217\136 \217\135\216\167\219\140 \217\136\219\140\218\152\217\135 :\n\n"
          end
          for k, v in pairs(list) do
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
            else
              text = text .. k .. " - [" .. v .. "]\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 List Of <b>VIP Members</b> is Empty !"
            else
              text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\185\216\182\217\136 \217\135\216\167\219\140 \217\136\219\140\218\152\217\135 \216\174\216\167\217\132\219\140 \216\167\216\179\216\170 !"
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Mm]utelist$") or text:match("^\217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \216\168\219\140 \216\181\216\175\216\167$")) and check_user_channel(msg) then
          local hash = "bot:muted:" .. msg.chat_id_
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "\226\128\162 List of <b>Muted users</b> : \n\n"
          else
            text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \216\168\219\140 \216\181\216\175\216\167 : \n\n"
          end
          for k, v in pairs(list) do
            local TTL = database:ttl("bot:muted:Time" .. msg.chat_id_ .. ":" .. v)
            if TTL == 0 or TTL == -2 then
              if database:get("lang:gp:" .. msg.chat_id_) then
                Time_S = "[ Free ]"
              else
                Time_S = "[ \216\162\216\178\216\167\216\175 ]"
              end
            elseif TTL == -1 then
              if database:get("lang:gp:" .. msg.chat_id_) then
                Time_S = "[ No time ]"
              else
                Time_S = "[ \216\168\216\175\217\136\217\134 \217\133\216\175\216\170 ]"
              end
            else
              local Time_ = getTime(TTL)
              Time_S = "[ " .. Time_ .. " ]"
            end
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n" .. Time_S .. "\n"
            else
              text = text .. k .. " - [" .. v .. "]\n" .. Time_S .. "\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 List of <b>Muted users</b> is Empty ! "
            else
              text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \216\168\219\140 \216\181\216\175\216\167 \216\174\216\167\217\132\219\140 \216\167\216\179\216\170 ! "
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Oo]wner$") or text:match("^[Oo]wnerlist$") or text:match("^\217\132\219\140\216\179\216\170 \216\181\216\167\216\173\216\168\216\167\217\134 \218\175\216\177\217\136\217\135$")) and check_user_channel(msg) then
          local hash = "bot:owners:" .. msg.chat_id_
          local list = database:smembers(hash)
          if not database:get("lang:gp:" .. msg.chat_id_) then
            text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\181\216\167\216\173\216\168\216\167\217\134 \218\175\216\177\217\136\217\135 : \n\n"
          else
            text = "\226\128\162 <b>Owners</b> list : \n\n"
          end
          for k, v in pairs(list) do
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
            else
              text = text .. k .. " - [" .. v .. "]\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 <b>Owner list</b> is Empty !"
            else
              text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\181\216\167\216\173\216\168\216\167\217\134 \218\175\216\177\217\136\217\135 \216\174\216\167\217\132\219\140 \216\167\216\179\216\170 !"
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Bb]anlist$") or text:match("^\217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \217\133\216\179\216\175\217\136\216\175$")) and check_user_channel(msg) then
          local hash = "bot:banned:" .. msg.chat_id_
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "\226\128\162 List of <b>Banlist</b> : \n\n"
          else
            text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \217\133\216\179\216\175\217\136\216\175 \216\180\216\175\217\135 : \n\n"
          end
          for k, v in pairs(list) do
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
            else
              text = text .. k .. " - [" .. v .. "]\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 List of <b>Banlist</b> is Empty !"
            else
              text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \217\133\216\179\216\175\217\136\216\175 \216\180\216\175\217\135 \216\174\216\167\217\132\219\140 \216\167\216\179\216\170 !"
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_sudo(msg) and (text:match("^[Bb]analllist$") or text:match("^\217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \216\170\216\173\216\170 \217\133\216\179\216\175\217\136\216\175\219\140\216\170$")) then
          local hash = "bot:gban:"
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "\226\128\162 List of <b>Banlist</b> : \n\n"
          else
            text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \216\170\216\173\216\170 \217\133\216\179\216\175\217\136\216\175\219\140\216\170 : \n\n"
          end
          for k, v in pairs(list) do
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
            else
              text = text .. k .. " - [" .. v .. "]\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 List of <b>BanAll</b> is Empty !"
            else
              text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \216\170\216\173\216\170 \217\133\216\179\216\175\217\136\216\175\219\140\216\170 \216\180\216\175\217\135 \216\174\216\167\217\132\219\140 \216\167\216\179\216\170 !"
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_admin(msg.sender_user_id_) and (text:match("^[Aa]dminlist$") or text:match("^\217\132\219\140\216\179\216\170 \216\167\216\175\217\133\219\140\217\134 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170$")) then
          local hash = "Bot:Admins"
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "\226\128\162 List of <b>Bot Admins</b> :\n\n"
          else
            text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\216\175\217\133\219\140\217\134 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170 :\n\n"
          end
          for k, v in pairs(list) do
            if database:get("SudoNumberGp" .. v) then
              gps = tonumber(database:get("SudoNumberGp" .. v))
            else
              gps = 0
            end
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "] (" .. gps .. ")\n"
            else
              text = text .. k .. " - [" .. v .. "] (" .. gps .. ")\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 List of <b>Bot Admins</b> is Empty !"
            else
              text = "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\216\175\217\133\219\140\217\134 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170 \216\174\216\167\217\132\219\140 \216\167\216\179\216\170 !"
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, "html")
        end
        if is_admin(msg.sender_user_id_) and (text:match("^[Ss]udolist$") or text:match("^\217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\216\167\217\134 \216\177\216\168\216\167\216\170$")) then
          local hash = "Bot:SudoUsers"
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "\226\128\162 List Of <b>SudoUsers</b> :\n\n"
          else
            text = "\226\128\162 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170 :\n\n"
          end
          for k, v in pairs(list) do
            if database:get("SudoNumberGp" .. v) then
              gps = tonumber(database:get("SudoNumberGp" .. v))
            else
              gps = 0
            end
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "] (" .. gps .. ")\n"
            else
              text = text .. k .. " - [" .. v .. "] (" .. gps .. ")\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 List of <b>Sudousers</b> is Empty !"
            else
              text = "\226\128\162 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170 \216\174\216\167\217\132\219\140 \216\167\216\179\216\170 !"
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, "html")
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Gg]etid$") or text:match("^\216\175\216\177\219\140\216\167\217\129\216\170 \216\180\217\134\216\167\216\179\217\135$") and msg.reply_to_message_id_ ~= 0) and check_user_channel(msg) then
          local getid_by_reply = function(extra, result)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User ID* : `" .. result.sender_user_id_ .. "`", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\134\216\167\216\179\217\135 \218\169\216\167\216\177\216\168\216\177 : " .. result.sender_user_id_, 1, "md")
            end
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, getid_by_reply)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and text:match("^[Ii]d @(%S+)$") and check_user_channel(msg) then
          do
            local ap = {
              string.match(text, "^([Ii]d) @(%S+)$")
            }
            local id_by_usernameen = function(extra, result)
              if result.id_ then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  if tonumber(result.id_) == tonumber(td) then
                    t = "Developer"
                  elseif tonumber(result.id_) == tonumber(bot_owner) then
                    t = "Chief"
                  elseif result.id_ == tonumber(bot_id) then
                    t = "Cli Bot"
                  elseif result.id_ == tonumber(api_id) then
                    t = "Helper Bot"
                  elseif is_sudoid(result.id_) then
                    t = "Sudo"
                  elseif is_admin(result.id_) then
                    t = "Bot Admin"
                  elseif is_owner(result.id_, msg.chat_id_) then
                    t = "Owner"
                  elseif is_momod(result.id_, msg.chat_id_) then
                    t = "Group Admin"
                  elseif is_vipmem(result.id_, msg.chat_id_) then
                    t = "VIP Member"
                  else
                    t = "Member"
                  end
                end
                if not database:get("lang:gp:" .. msg.chat_id_) then
                  if tonumber(result.id_) == tonumber(td) then
                    t = "\216\170\217\136\216\179\216\185\217\135 \216\175\217\135\217\134\216\175\217\135"
                  elseif result.id_ == tonumber(bot_id) then
                    t = "\216\177\216\168\216\167\216\170 Cli"
                  elseif result.id_ == tonumber(api_id) then
                    t = "\216\177\216\168\216\167\216\170 \217\135\217\132\217\190\216\177"
                  elseif tonumber(result.id_) == tonumber(bot_owner) then
                    t = "\217\133\216\175\219\140\216\177 \218\169\217\132"
                  elseif is_sudoid(result.id_) then
                    t = "\217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170"
                  elseif is_admin(result.id_) then
                    t = "\216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170"
                  elseif is_owner(result.id_, msg.chat_id_) then
                    t = "\216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135"
                  elseif is_momod(result.id_, msg.chat_id_) then
                    t = "\217\133\216\175\219\140\216\177 \218\175\216\177\217\136\217\135"
                  elseif is_vipmem(result.id_, msg.chat_id_) then
                    t = "\216\185\216\182\217\136 \217\136\219\140\218\152\217\135"
                  else
                    t = "\218\169\216\167\216\177\216\168\216\177"
                  end
                end
                local gpid = tostring(result.id_)
                if gpid:match("^(%d+)") then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    text = "\226\128\162 <b>Username</b> : @" .. ap[2] .. "\n\226\128\162 <b>ID</b> : <code>" .. result.id_ .. "</code>\n\226\128\162 <b>Rank</b> : <b>" .. t .. "</b>"
                  else
                    text = "\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 : @" .. ap[2] .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 : (" .. result.id_ .. ")\n\226\128\162 \217\133\217\130\216\167\217\133 : " .. t
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  text = "\226\128\162 <b>Username</b> : @" .. ap[2] .. "\n\226\128\162 <b>ID</b> : <code>" .. result.id_ .. "</code>"
                else
                  text = "\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 : @" .. ap[2] .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 : (" .. result.id_ .. ")"
                end
              elseif not result.id_ then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  text = "\226\128\162 Username is <b>not Correct</b> ! "
                else
                  text = "\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 \216\181\216\173\219\140\216\173 \217\134\217\133\219\140\216\168\216\167\216\180\216\175  ! "
                end
              end
              send(msg.chat_id_, msg.id_, 1, text, 1, "html")
            end
            resolve_username(ap[2], id_by_usernameen)
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) then
          text = text:gsub("\216\167\219\140\216\175\219\140", "\216\162\219\140\216\175\219\140")
          if text:match("^\216\162\219\140\216\175\219\140 @(%S+)$") and check_user_channel(msg) then
            do
              local ap = {
                string.match(text, "^(\216\162\219\140\216\175\219\140) @(%S+)$")
              }
              local id_by_username = function(extra, result)
                if result.id_ then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    if tonumber(result.id_) == tonumber(td) then
                      t = "Developer"
                    elseif tonumber(result.id_) == tonumber(bot_owner) then
                      t = "Chief"
                    elseif result.id_ == tonumber(bot_id) then
                      t = "Cli Bot"
                    elseif is_sudoid(result.id_) then
                      t = "Sudo"
                    elseif is_admin(result.id_) then
                      t = "Bot Admin"
                    elseif is_owner(result.id_, msg.chat_id_) then
                      t = "Owner"
                    elseif is_momod(result.id_, msg.chat_id_) then
                      t = "Group Admin"
                    elseif is_vipmem(result.id_, msg.chat_id_) then
                      t = "VIP Member"
                    else
                      t = "Member"
                    end
                  end
                  if not database:get("lang:gp:" .. msg.chat_id_) then
                    if tonumber(result.id_) == tonumber(td) then
                      t = "\216\170\217\136\216\179\216\185\217\135 \216\175\217\135\217\134\216\175\217\135"
                    elseif result.id_ == tonumber(bot_id) then
                      t = "\216\177\216\168\216\167\216\170 Cli"
                    elseif tonumber(result.id_) == tonumber(bot_owner) then
                      t = "\217\133\216\175\219\140\216\177 \218\169\217\132"
                    elseif is_sudoid(result.id_) then
                      t = "\217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170"
                    elseif is_admin(result.id_) then
                      t = "\216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170"
                    elseif is_owner(result.id_, msg.chat_id_) then
                      t = "\216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135"
                    elseif is_momod(result.id_, msg.chat_id_) then
                      t = "\217\133\216\175\219\140\216\177 \218\175\216\177\217\136\217\135"
                    elseif is_vipmem(result.id_, msg.chat_id_) then
                      t = "\216\185\216\182\217\136 \217\136\219\140\218\152\217\135"
                    else
                      t = "\218\169\216\167\216\177\216\168\216\177"
                    end
                  end
                  local gpid = tostring(result.id_)
                  if gpid:match("^(%d+)") then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      text = "\226\128\162 <b>Username</b> : @" .. ap[2] .. "\n\226\128\162 <b>ID</b> : <code>" .. result.id_ .. "</code>\n\226\128\162 <b>Rank</b> : <b>" .. t .. "</b>"
                    else
                      text = "\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 : @" .. ap[2] .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 : (" .. result.id_ .. ")\n\226\128\162 \217\133\217\130\216\167\217\133 : " .. t
                    end
                  elseif database:get("lang:gp:" .. msg.chat_id_) then
                    text = "\226\128\162 <b>Username</b> : @" .. ap[2] .. [[

> <b>ID</b> : <code>]] .. result.id_ .. "</code>"
                  else
                    text = "\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 : @" .. ap[2] .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 : (" .. result.id_ .. ")"
                  end
                elseif not result.id_ then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    text = "\226\128\162 Username is <b>not Correct</b> ! "
                  else
                    text = "\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 \216\181\216\173\219\140\216\173 \217\134\217\133\219\140\216\168\216\167\216\180\216\175  ! "
                  end
                end
                send(msg.chat_id_, msg.id_, 1, text, 1, "html")
              end
              resolve_username(ap[2], id_by_username)
            end
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ff]ilterlist") or text:match("^\217\132\219\140\216\179\216\170 \217\129\219\140\217\132\216\170\216\177")) and check_user_channel(msg) then
          local hash = "bot:filters:" .. msg.chat_id_
          local names = database:hkeys(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            texti = "\226\128\162 <b>Filterlist</b> : \n\n"
          else
            texti = "\226\128\162 \217\132\219\140\216\179\216\170 \218\169\217\132\217\133\216\167\216\170 \217\129\219\140\217\132\216\170\216\177 \216\180\216\175\217\135 : \n\n"
          end
          local b = 1
          for i = 1, #names do
            texti = texti .. b .. ". " .. names[i] .. "\n"
            b = b + 1
          end
          if #names == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              texti = "\226\128\162 <b>Filterlist</b> is Empty !"
            else
              texti = "\226\128\162 \217\132\219\140\216\179\216\170 \218\169\217\132\217\133\216\167\216\170 \217\129\219\140\217\132\216\170\216\177 \216\180\216\175\217\135 \216\174\216\167\217\132\219\140 \216\167\216\179\216\170 !"
            end
          end
          if text:match("^[Ff]ilterlist$") or text:match("^\217\132\219\140\216\179\216\170 \217\129\219\140\217\132\216\170\216\177$") then
            send(msg.chat_id_, msg.id_, 1, texti, 1, "html")
          elseif (text:match("^[Ff]ilterlistpv$") or text:match("\217\132\219\140\216\179\216\170 \217\129\219\140\217\132\216\170\216\177 \217\190\219\140 \217\136\219\140$")) and is_owner(msg.sender_user_id_, msg.chat_id_) then
            send(msg.sender_user_id_, 0, 1, texti, 1, "html")
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 <b>Filter List</b> of Group has been <b>Sent</b> to your <b>PV</b> !"
            else
              text = "\226\128\162 \217\132\219\140\216\179\216\170 \217\129\219\140\217\132\216\170\216\177 \218\175\216\177\217\136\217\135 \216\168\217\135 \216\174\216\181\217\136\216\181\219\140 \216\180\217\133\216\167 \216\167\216\177\216\179\216\167\217\132 \216\180\216\175 !"
            end
            send(msg.chat_id_, msg.id_, 1, text, 1, "html")
          end
        end
        local text = msg.content_.text_:gsub("\216\175\216\185\217\136\216\170", "Invite")
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Ii]nvite$") and msg.reply_to_message_id_ ~= 0 then
          local inv_reply = function(extra, result)
            add_user(result.chat_id_, result.sender_user_id_, 5)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, inv_reply)
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and (text:match("^[Aa]ddwelcomer$") or text:match("^\216\175\216\185\217\136\216\170 \216\177\216\168\216\167\216\170 \216\174\217\136\216\180 \216\162\217\133\216\175\218\175\217\136$")) then
          function InvWelcomer(extra, result)
            sendBotStartMessage(result.id_, msg.chat_id_, "start", dl_cb)
          end
          resolve_username("EsetWelcomeBot", InvWelcomer)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ii]nvite @(%S+)$") then
          local ap = {
            string.match(text, "^([Ii]nvite) @(%S+)$")
          }
          local invite_by_username = function(extra, result)
            if result.id_ then
              add_user(msg.chat_id_, result.id_, 5)
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                texts = "\226\128\162 User not <b>Found</b> !"
              else
                texts = "\226\128\162 \218\169\216\167\216\177\216\168\216\177 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !"
              end
              send(msg.chat_id_, msg.id_, 1, texts, 1, "html")
            end
          end
          resolve_username(ap[2], invite_by_username)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ii]nvite (%d+)$") then
          local ap = {
            string.match(text, "^([Ii]nvite) (%d+)$")
          }
          add_user(msg.chat_id_, ap[2], 5)
        end
        if (idf:match("-100(%d+)") or is_momod(msg.sender_user_id_, msg.chat_id_)) and text:match("^[Ii]d$") and msg.reply_to_message_id_ == 0 and check_user_channel(msg) then
          local getnameen = function(extra, result)
            local fname = result.first_name_ or ""
            local lname = result.last_name_ or ""
            local name = fname .. " " .. lname
            database:set("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, name)
          end
          getUser(msg.sender_user_id_, getnameen)
          local getproen = function(extra, result)
            local _nl, ctrl_chars = string.gsub(text, "%c", "")
            local nm = database:get("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            if string.len(nm) > 40 or ctrl_chars > 70 then
              name = "---"
            elseif string.len(nm) < 40 or ctrl_chars < 70 or string.len(name) == 40 or ctrl_chars == 70 then
              name = database:get("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            end
            if database:get("getidstatus" .. msg.chat_id_) == "Photo" then
              if result.photos_[0] then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_, "\226\128\162 Your Name : " .. name .. "\n\226\128\162 Your ID : " .. msg.sender_user_id_, msg.id_, msg.id_)
                else
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_, "\226\128\162 \217\134\216\167\217\133 \216\180\217\133\216\167 : " .. name .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 \216\180\217\133\216\167 : " .. msg.sender_user_id_, msg.id_, msg.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 You don't have *Profile photo* !\n\n\226\128\162 Your Name : " .. name .. "\n\226\128\162 Your ID : " .. msg.sender_user_id_, 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175 !\n\n\226\128\162 \217\134\216\167\217\133 \216\180\217\133\216\167 : " .. name .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 \216\180\217\133\216\167 : " .. msg.sender_user_id_, 1, "md")
              end
            end
            if database:get("getidstatus" .. msg.chat_id_) == "Simple" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Your Name* : `" .. name .. "`\n\226\128\162 *Your ID* : `" .. msg.sender_user_id_ .. "`", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\216\167\217\133 \216\180\217\133\216\167 : " .. name .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 \216\180\217\133\216\167 : " .. msg.sender_user_id_, 1, "md")
              end
            end
            if not database:get("getidstatus" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Your Name* : `" .. name .. "`\n\226\128\162 *Your ID* : `" .. msg.sender_user_id_ .. "`", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\216\167\217\133 \216\180\217\133\216\167 : " .. name .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 \216\180\217\133\216\167 : " .. msg.sender_user_id_, 1, "md")
              end
            end
          end
          tdcli_function({
            ID = "GetUserProfilePhotos",
            user_id_ = msg.sender_user_id_,
            offset_ = 0,
            limit_ = 1
          }, getproen, nil)
        end
        if idf:match("-100(%d+)") or is_momod(msg.sender_user_id_, msg.chat_id_) then
          text = text:gsub("\216\167\219\140\216\175\219\140", "\216\162\219\140\216\175\219\140")
          if text:match("^\216\162\219\140\216\175\219\140$") and msg.reply_to_message_id_ == 0 and check_user_channel(msg) then
            local getnamefa = function(extra, result)
              local fname = result.first_name_ or ""
              local lname = result.last_name_ or ""
              local name = fname .. " " .. lname
              database:set("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, name)
            end
            getUser(msg.sender_user_id_, getnamefa)
            local _nl, ctrl_chars = string.gsub(text, "%c", "")
            local nm = database:get("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            if 40 < string.len(nm) or ctrl_chars > 70 then
              name = "---"
            elseif 40 > string.len(nm) or ctrl_chars < 70 or string.len(name) == 40 or ctrl_chars == 70 then
              name = database:get("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            end
            local getprofa = function(extra, result)
              if database:get("getidstatus" .. msg.chat_id_) == "Photo" then
                if result.photos_[0] then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_, "\226\128\162 Your Name : " .. name .. "\n\226\128\162 Your ID : " .. msg.sender_user_id_, msg.id_, msg.id_)
                  else
                    sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_, "\226\128\162 \217\134\216\167\217\133 \216\180\217\133\216\167 : " .. name .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 \216\180\217\133\216\167 : " .. msg.sender_user_id_, msg.id_, msg.id_)
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 You don't have *Profile photo* !\n\n\226\128\162 Your Name : " .. name .. "\n\226\128\162 Your ID : `" .. msg.sender_user_id_ .. "`", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175 !\n\n\226\128\162 \217\134\216\167\217\133 \216\180\217\133\216\167 : " .. name .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 \216\180\217\133\216\167 : " .. msg.sender_user_id_, 1, "md")
                end
              end
              if database:get("getidstatus" .. msg.chat_id_) == "Simple" then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Name : " .. name .. "\n\226\128\162 Your ID : `" .. msg.sender_user_id_ .. "`", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\216\167\217\133 \216\180\217\133\216\167 : " .. name .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 \216\180\217\133\216\167 : " .. msg.sender_user_id_, 1, "md")
                end
              end
              if not database:get("getidstatus" .. msg.chat_id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Your Name : " .. name .. "\n\226\128\162 Your ID : " .. msg.sender_user_id_ .. "`", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\216\167\217\133 \216\180\217\133\216\167 : " .. name .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 \216\180\217\133\216\167 : " .. msg.sender_user_id_, 1, "md")
                end
              end
            end
            tdcli_function({
              ID = "GetUserProfilePhotos",
              user_id_ = msg.sender_user_id_,
              offset_ = 0,
              limit_ = 1
            }, getprofa, nil)
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and msg.reply_to_message_id_ ~= 0 then
          text = text:gsub("\216\167\219\140\216\175\219\140", "\216\162\219\140\216\175\219\140")
          if (text:match("^[Ii]d$") or text:match("^\216\162\219\140\216\175\219\140$")) and check_user_channel(msg) then
            local id_by_reply = function(extra, result)
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *User ID* : `" .. result.sender_user_id_ .. "`", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\134\216\167\216\179\217\135 \218\169\216\167\216\177\216\168\216\177 : " .. result.sender_user_id_, 1, "md")
              end
            end
            getMessage(msg.chat_id_, msg.reply_to_message_id_, id_by_reply)
          end
        end
        local text = msg.content_.text_:gsub("\217\136\216\182\216\185\219\140\216\170 \216\175\216\177\219\140\216\167\217\129\216\170 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132", "Showprofilestatus")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]howprofilestatus (.*)$") and check_user_channel(msg) then
          local status = {
            string.match(text, "^([Ss]howprofilestatus) (.*)$")
          }
          if status[2] == "active" or status[2] == "\217\129\216\185\216\167\217\132" then
            if database:get("getpro:" .. msg.chat_id_) == "Active" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Get Profile photo is *Already* Actived ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\175\216\177\219\140\216\167\217\129\216\170 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \216\167\216\178 \217\130\216\168\217\132 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 ! ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Get Profile photo has been Changed to *Active* ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\175\216\177\219\140\216\167\217\129\216\170 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \217\129\216\185\216\167\217\132 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 !", 1, "md")
              end
              database:set("getpro:" .. msg.chat_id_, "Active")
            end
          end
          if status[2] == "deactive" or status[2] == "\216\186\219\140\216\177\217\129\216\185\216\167\217\132" then
            if database:get("getpro:" .. msg.chat_id_) == "Deactive" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Get Profile photo is *Already* Deactived", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\175\216\177\219\140\216\167\217\129\216\170 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \216\167\216\178 \217\130\216\168\217\132 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "Get Profile photo has been Change to *Deactive* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\175\216\177\219\140\216\167\217\129\216\170 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 !", 1, "md")
              end
              database:set("getpro:" .. msg.chat_id_, "Deactive")
            end
          end
        end
        local text = msg.content_.text_:gsub("\216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132\217\133", "Getpro")
        if text:match("^[Gg]etpro (%d+)$") and check_user_channel(msg) then
          do
            local pronumb = {
              string.match(text, "^([Gg]etpro) (%d+)$")
            }
            local gproen = function(extra, result)
              if not is_momod(msg.sender_user_id_, msg.chat_id_) and database:get("getpro:" .. msg.chat_id_) == "Deactive" then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Get Profile photo is *Deactive* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\175\216\177\219\140\216\167\217\129\216\170 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175\217\135 \216\167\216\179\216\170 !", 1, "md")
                end
              elseif pronumb[2] == "1" then
                if result.photos_[0] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "You don't Have *Profile photo* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\216\180\217\133\216\167 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175", 1, "md")
                end
              elseif pronumb[2] == "2" then
                if result.photos_[1] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[1].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "You don't have `2` Profile photo !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\216\180\217\133\216\167 2 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175", 1, "md")
                end
              elseif pronumb[2] == "3" then
                if result.photos_[2] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[2].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "You don't have `3` Profile photo !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\216\180\217\133\216\167 3 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175", 1, "md")
                end
              elseif pronumb[2] == "4" then
                if result.photos_[3] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[3].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "You don't have `4` Profile photo !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\216\180\217\133\216\167 4 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175", 1, "md")
                end
              elseif pronumb[2] == "5" then
                if result.photos_[4] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[4].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "You don't have `5` Profile photo !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\216\180\217\133\216\167 5 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175", 1, "md")
                end
              elseif pronumb[2] == "6" then
                if result.photos_[5] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[5].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "You don't have `6` Profile photo !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\216\180\217\133\216\167 6 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175", 1, "md")
                end
              elseif pronumb[2] == "7" then
                if result.photos_[6] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[6].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "You don't have `7` Profile photo !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\216\180\217\133\216\167 7 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175", 1, "md")
                end
              elseif pronumb[2] == "8" then
                if result.photos_[7] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[7].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "You don't have `8` Profile photo !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\216\180\217\133\216\167 8 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175", 1, "md")
                end
              elseif pronumb[2] == "9" then
                if result.photos_[8] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[8].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "You don't have `9` Profile photo !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\216\180\217\133\216\167 9 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175", 1, "md")
                end
              elseif pronumb[2] == "10" then
                if result.photos_[9] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[9].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "You don't have `10` Profile photo !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\216\180\217\133\216\167 10 \216\185\218\169\216\179 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 \217\134\216\175\216\167\216\177\219\140\216\175", 1, "md")
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 I just can Get last `10` Profile photos !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\133\217\134 \217\129\217\130\216\183 \217\133\219\140\216\170\217\136\216\167\217\134\217\133  10 \216\185\218\169\216\179 \216\162\216\174\216\177 \216\177\216\167 \217\134\217\133\216\167\219\140\216\180 \216\175\217\135\217\133 !", 1, "md")
              end
            end
            tdcli_function({
              ID = "GetUserProfilePhotos",
              user_id_ = msg.sender_user_id_,
              offset_ = 0,
              limit_ = pronumb[2]
            }, gproen, nil)
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ll]ock (.*)$") or text:match("^\217\130\217\129\217\132 (.*)$")) and check_user_channel(msg) then
          local lockpt = {
            string.match(text, "^([Ll]ock) (.*)$")
          }
          local lockptf = {
            string.match(text, "^(\217\130\217\129\217\132) (.*)$")
          }
          if lockpt[2] == "edit" or lockptf[2] == "\217\136\219\140\216\177\216\167\219\140\216\180 \217\190\219\140\216\167\217\133" then
            if not database:get("editmsg" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock edit has been *Activated* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\219\140\216\177\216\167\219\140\216\180 \217\190\219\140\216\167\217\133 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("editmsg" .. msg.chat_id_, true)
              database:del("sayedit" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock edit is *Already* Activated ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\219\140\216\177\216\167\219\140\216\180 \217\190\219\140\216\167\217\133 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if lockpt[2] == "cmd" or lockptf[2] == "\216\173\216\167\217\132\216\170 \216\185\216\175\217\133 \216\172\217\136\216\167\216\168" then
            if not database:get("bot:cmds" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Case of no answer has been *Enable* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\167\217\132\216\170 \216\185\216\175\217\133 \216\172\217\136\216\167\216\168 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:cmds" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Case of no answer is *Already* enable !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\167\217\132\216\170 \216\185\216\175\217\133 \216\172\217\136\216\167\216\168 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if lockpt[2] == "bots" or lockptf[2] == "\216\177\216\168\216\167\216\170" then
            if not database:get("bot:bots:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock bots has been *Activated* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\216\177\217\136\216\175 \216\177\216\168\216\167\216\170 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:bots:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock bots is *Already* enable ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\216\177\217\136\216\175 \216\177\216\168\216\167\216\170 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if lockpt[2] == "flood" or lockptf[2] == "\217\129\217\132\217\136\216\175" then
            if not database:get("anti-flood:" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock flood has been *Activated* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\217\132\217\136\216\175 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("anti-flood:" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock flood is *Already* enable ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\217\132\217\136\216\175 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if lockpt[2] == "pin" or lockptf[2] == "\216\179\217\134\216\172\216\167\217\130 \217\190\219\140\216\167\217\133" then
            if not database:get("bot:pin:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock pin has been *Activated* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\179\217\134\216\172\216\167\217\130 \217\190\219\140\216\167\217\133 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:pin:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock pin is *Already* enable ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\179\217\134\216\172\216\167\217\130 \217\190\219\140\216\167\217\133 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
        end
        local text = msg.content_.text_:gsub("\216\170\217\134\216\184\219\140\217\133 \217\129\217\132\217\136\216\175", "Setflood")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]etflood (%d+)$") and check_user_channel(msg) then
          local floodmax = {
            string.match(text, "^([Ss]etflood) (%d+)$")
          }
          if 2 > tonumber(floodmax[2]) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Select a number *Greater* than `2` !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\185\216\175\216\175\219\140 \216\168\216\178\216\177\218\175\216\170\216\177 \216\167\216\178 2 \217\136\216\167\216\177\216\175 \218\169\217\134\219\140\216\175 !", 1, "md")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Flood *Sensitivity* Change to `" .. floodmax[2] .. "` !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\179\216\167\216\179\219\140\216\170 \217\129\217\132\217\136\216\175 \216\168\217\135 " .. floodmax[2] .. " \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 !", 1, "md")
            end
            database:set("flood:max:" .. msg.chat_id_, floodmax[2])
          end
        end
        local text = msg.content_.text_:gsub("\217\136\216\182\216\185\219\140\216\170 \217\129\217\132\217\136\216\175", "Floodstatus")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ff]loodstatus (.*)$") and check_user_channel(msg) then
          local status = {
            string.match(text, "^([Ff]loodstatus) (.*)$")
          }
          if status[2] == "remove" or status[2] == "\216\167\216\174\216\177\216\167\216\172" then
            if database:get("floodstatus" .. msg.chat_id_) == "Kicked" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Flood status is *Already* on Kicked ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \217\129\217\132\217\136\216\175 \216\167\216\178 \217\130\216\168\217\132 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\167\216\174\216\177\216\167\216\172 \217\133\219\140\216\168\216\167\216\180\216\175 ! ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Flood status change to *Kicking* ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \217\129\217\132\217\136\216\175 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\167\216\174\216\177\216\167\216\172 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 ! ", 1, "md")
              end
              database:set("floodstatus" .. msg.chat_id_, "Kicked")
            end
          end
          if status[2] == "del" or status[2] == "\216\173\216\176\217\129 \217\190\219\140\216\167\217\133" then
            if database:get("floodstatus" .. msg.chat_id_) == "DelMsg" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Flood status is *Already* on Deleting !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \217\129\217\132\217\136\216\175 \216\167\216\178 \217\130\216\168\217\132 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\173\216\176\217\129 \217\190\219\140\216\167\217\133 \217\133\219\140\216\168\216\167\216\180\216\175 !  ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Flood status has been change to *Deleting* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \217\129\217\132\217\136\216\175 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\173\216\176\217\129 \217\190\219\140\216\167\217\133 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 ! ", 1, "md")
              end
              database:set("floodstatus" .. msg.chat_id_, "DelMsg")
            end
          end
        end
        local text = msg.content_.text_:gsub("\216\170\217\134\216\184\219\140\217\133 \216\167\216\174\216\183\216\167\216\177", "Setwarn")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]etwarn (%d+)$") and check_user_channel(msg) then
          local warnmax = {
            string.match(text, "^([Ss]etwarn) (%d+)$")
          }
          if 2 > tonumber(warnmax[2]) or tonumber(warnmax[2]) > 30 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Enter a number greater than 2 and smaller than 30 !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\185\216\175\216\175\219\140 \216\168\216\178\216\177\218\175\216\170\216\177 \216\167\216\178 2 \217\136 \218\169\217\136\218\134\218\169\216\170\216\177 \216\167\216\178 30 \217\136\216\167\216\177\216\175 \218\169\217\134\219\140\216\175 !", 1, "md")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Warning *Number* Change to `" .. warnmax[2] .. "` !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\170\216\185\216\175\216\167\216\175 \216\167\216\174\216\183\216\167\216\177 \216\168\217\135 " .. warnmax[2] .. " \216\168\216\167\216\177 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 ! ", 1, "md")
            end
            database:set("warn:max:" .. msg.chat_id_, warnmax[2])
          end
        end
        local text = msg.content_.text_:gsub("\217\136\216\182\216\185\219\140\216\170 \216\167\216\174\216\183\216\167\216\177", "Warnstatus")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ww]arnstatus (.*)$") and check_user_channel(msg) then
          local status = {
            string.match(text, "^([Ww]arnstatus) (.*)$")
          }
          if status[2] == "mute" or status[2] == "\216\168\219\140 \216\181\216\175\216\167" then
            if database:get("warnstatus" .. msg.chat_id_) == "Muteuser" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Warning status is *Already* on Mute User !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\167\216\174\216\183\216\167\216\177 \216\167\216\178 \217\130\216\168\217\132 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\168\219\140 \216\181\216\175\216\167 \217\133\219\140\216\168\216\167\216\180\216\175 ! ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Warning status has been Changed to *Mute User* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\167\216\174\216\183\216\167\216\177 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\168\219\140 \216\181\216\175\216\167 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 ! ", 1, "md")
              end
              database:set("warnstatus" .. msg.chat_id_, "Muteuser")
            end
          end
          if status[2] == "remove" or status[2] == "\216\167\216\174\216\177\216\167\216\172" then
            if database:get("warnstatus" .. msg.chat_id_) == "Remove" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Warning status is *Already* on Remove User !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\167\216\174\216\183\216\167\216\177 \216\167\216\178 \217\130\216\168\217\132 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\167\216\174\216\177\216\167\216\172 \217\133\219\140\216\168\216\167\216\180\216\175 ! ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, " Warning status has been Changed to *Remove User* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\167\216\174\216\183\216\167\216\177 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\167\216\174\216\177\216\167\216\172 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 ! ", 1, "md")
              end
              database:set("warnstatus" .. msg.chat_id_, "Remove")
            end
          end
        end
        local text = msg.content_.text_:gsub("\217\136\216\182\216\185\219\140\216\170 \217\134\217\133\216\167\219\140\216\180 \216\162\219\140\216\175\219\140", "Showidstatus")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]howidstatus (.*)$") and check_user_channel(msg) then
          local status = {
            string.match(text, "^([Ss]howidstatus) (.*)$")
          }
          if status[2] == "photo" or status[2] == "\216\185\218\169\216\179" then
            if database:get("getidstatus" .. msg.chat_id_) == "Photo" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Get id status is *Already* on Photo !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\175\216\177\219\140\216\167\217\129\216\170 \216\162\219\140\216\175\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\185\218\169\216\179 \217\133\219\140\216\168\216\167\216\180\216\175 ! ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Get ID status has been Changed to *Photo* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\175\216\177\219\140\216\167\217\129\216\170 \216\162\219\140\216\175\219\140 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\185\218\169\216\179 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 ! ", 1, "md")
              end
              database:set("getidstatus" .. msg.chat_id_, "Photo")
            end
          end
          if status[2] == "simple" or status[2] == "\216\179\216\167\216\175\217\135" then
            if database:get("getidstatus" .. msg.chat_id_) == "Simple" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Get ID status is *Already* on Simple !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\175\216\177\219\140\216\167\217\129\216\170 \216\162\219\140\216\175\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\179\216\167\216\175\217\135 \217\133\219\140\216\168\216\167\216\180\216\175 ! ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "Get ID status has been Change to *Simple* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\175\216\177\219\140\216\167\217\129\216\170 \216\162\219\140\216\175\219\140 \216\168\216\177 \216\177\217\136\219\140 \216\173\216\167\217\132\216\170 \216\179\216\167\216\175\217\135 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 ! ", 1, "md")
              end
              database:set("getidstatus" .. msg.chat_id_, "Simple")
            end
          end
        end
        local text = msg.content_.text_:gsub("\217\136\216\182\216\185\219\140\216\170 \217\134\217\133\216\167\219\140\216\180 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134", "Showphonestatus")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]howphonestatus (.*)$") and check_user_channel(msg) then
          local status = {
            string.match(text, "^([Ss]howphonestatus) (.*)$")
          }
          if status[2] == "active" or status[2] == "\217\129\216\185\216\167\217\132" then
            if database:get("sharecont" .. msg.chat_id_) == "On" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Get Phone Number status is *Already* active !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\175\216\177\219\140\216\167\217\129\216\170 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Get Phone Numberhas been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\175\216\177\219\140\216\167\217\129\216\170 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("sharecont" .. msg.chat_id_, "On")
            end
          end
          if status[2] == "deactive" or status[2] == "\216\186\219\140\216\177\217\129\216\185\216\167\217\132" then
            if database:get("sharecont" .. msg.chat_id_) == "Off" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Get Phone Number is *Already* Deactive !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\175\216\177\219\140\216\167\217\129\216\170 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 ! ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "Get Phone Number has been *Deactived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\175\216\177\219\140\216\167\217\129\216\170 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("sharecont" .. msg.chat_id_, "Off")
            end
          end
        end
        local text = msg.content_.text_:gsub("\216\174\216\177\217\136\216\172 \216\174\217\136\216\175\218\169\216\167\216\177", "Autoleave")
        if is_sudo(msg) and text:match("^[Aa]utoleave (.*)$") then
          local status = {
            string.match(text, "^([Aa]utoleave) (.*)$")
          }
          if status[2] == "\217\129\216\185\216\167\217\132" or status[2] == "on" then
            if database:get("autoleave") == "On" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Auto Leave is *now Active* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\174\216\177\217\136\216\172 \216\174\217\136\216\175\218\169\216\167\216\177 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Auto Leave has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\174\216\177\217\136\216\172 \216\174\217\136\216\175\218\169\216\167\216\177 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("autoleave", "On")
            end
          end
          if status[2] == "\216\186\219\140\216\177\217\129\216\185\216\167\217\132" or status[2] == "off" then
            if database:get("autoleave") == "Off" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Auto Leave is *now Deactive* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\174\216\177\217\136\216\172 \216\174\217\136\216\175\218\169\216\167\216\177 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Auto leave has been *Deactived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\174\216\177\217\136\216\172 \216\174\217\136\216\175\218\169\216\167\216\177 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("autoleave", "Off")
            end
          end
        end
        if is_sudo(msg) then
          local text = msg.content_.text_:gsub("\216\176\216\174\219\140\216\177\217\135 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134", "Savephone")
          if text:match("^[Ss]avephone (.*)$") then
            local status = {
              string.match(text, "^([Ss]avephone) (.*)$")
            }
            if status[2] == "on" or status[2] == "\217\129\216\185\216\167\217\132" then
              if database:get("savecont") == "On" then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Save Phone Number status is *Already* active !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\176\216\174\219\140\216\177\217\135 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Save Phone Number has been *Actived* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\176\216\174\219\140\216\177\217\135 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
                end
                database:set("savecont", "On")
              end
            end
            if status[2] == "off" or status[2] == "\216\186\219\140\216\177\217\129\216\185\216\167\217\132" then
              if database:get("savecont") == "Off" then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Save Phone Number is *Already* Deactive !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\176\216\174\219\140\216\177\217\135 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 ! ", 1, "md")
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "Save Phone Number has been *Deactived* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\176\216\174\219\140\216\177\217\135 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
                end
                database:set("savecont", "Off")
              end
            end
          end
        end
        if is_sudo(msg) then
          local text = msg.content_.text_:gsub("\216\167\216\172\216\168\216\167\216\177 \216\185\216\182\217\136\219\140\216\170 \216\175\216\177 \218\169\216\167\217\134\216\167\217\132", "Forcedjoin")
          if text:match("^[Ff]orcedjoin (.*)$") then
            local status = {
              string.match(text, "^([Ff]orcedjoin) (.*)$")
            }
            if status[2] == "on" or status[2] == "\217\129\216\185\216\167\217\132" then
              if database:get("bot:joinch") then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Forced To Join The Channel status is *Already* active !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\167\216\172\216\168\216\167\216\177 \216\185\216\182\217\136\219\140\216\170 \216\175\216\177 \218\169\216\167\217\134\216\167\217\132 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Forced To Join The Channel has been *Actived* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\167\216\172\216\168\216\167\216\177 \216\185\216\182\217\136\219\140\216\170 \216\175\216\177 \218\169\216\167\217\134\216\167\217\132 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
                end
                database:set("bot:joinch", true)
              end
            end
            if status[2] == "off" or status[2] == "\216\186\219\140\216\177\217\129\216\185\216\167\217\132" then
              if not database:get("bot:joinch") then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Forced To Join The Channel is *Already* Deactive !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\167\216\172\216\168\216\167\216\177 \216\185\216\182\217\136\219\140\216\170 \216\175\216\177 \218\169\216\167\217\134\216\167\217\132 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 ! ", 1, "md")
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Forced To Join The Channel has been *Deactived* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\167\216\172\216\168\216\167\216\177 \216\185\216\182\217\136\219\140\216\170 \216\175\216\177 \218\169\216\167\217\134\216\167\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
                end
                database:del("bot:joinch")
              end
            end
          end
        end
        local text = msg.content_.text_:gsub("\217\133\217\134\216\180\219\140", "Clerk")
        if is_sudo(msg) and text:match("^[Cc]lerk (.*)$") then
          local status = {
            string.match(text, "^([Cc]lerk) (.*)$")
          }
          if status[2] == "\217\129\216\185\216\167\217\132" or status[2] == "on" then
            if database:get("clerk") == "On" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Clerk is *Now Active* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\133\217\134\216\180\219\140 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Clerk Has Been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\133\217\134\216\180\219\140 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("clerk", "On")
            end
          end
          if status[2] == "\216\186\219\140\216\177\217\129\216\185\216\167\217\132" or status[2] == "off" then
            if database:get("clerk") == "Off" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Clerk Is *now Deactive* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\133\217\134\216\180\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Auto leave has been *Deactived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\133\217\134\216\180\219\140 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("clerk", "Off")
            end
          end
        end
        local text = msg.content_.text_:gsub("\217\129\216\167\217\134", "Fun")
        if is_sudo(msg) and text:match("^[Ff]un (.*)$") then
          local status = {
            string.match(text, "^([Ff]un) (.*)$")
          }
          if status[2] == "\217\129\216\185\216\167\217\132" or status[2] == "on" then
            if database:get("fun") == "On" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Fun Ability is *Now Active* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\216\167\216\168\217\132\219\140\216\170 \217\135\216\167\219\140 \216\179\216\177\218\175\216\177\217\133 \218\169\217\134\217\134\216\175\217\135 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Fun Ability Has Been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\216\167\216\168\217\132\219\140\216\170 \217\135\216\167\219\140 \216\179\216\177\218\175\216\177\217\133 \218\169\217\134\217\134\216\175\217\135 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("fun", "On")
            end
          end
          if status[2] == "\216\186\219\140\216\177\217\129\216\185\216\167\217\132" or status[2] == "off" then
            if database:get("fun") == "Off" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Fun Ability Is *now Deactive* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\216\167\216\168\217\132\219\140\216\170 \217\135\216\167\219\140 \216\179\216\177\218\175\216\177\217\133 \218\169\217\134\217\134\216\175\217\135 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Auto leave has been *Deactived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\216\167\216\168\217\132\219\140\216\170 \217\135\216\167\219\140 \216\179\216\177\218\175\216\177\217\133 \218\169\217\134\217\134\216\175\217\135 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("fun", "Off")
            end
          end
        end
        if is_sudo(msg) then
          local text = msg.content_.text_:gsub("[Ss]etprice", "Setnerkh")
          if text:match("^[Ss]etnerkh$") or text:match("^\216\170\217\134\216\184\219\140\217\133 \217\134\216\177\216\174$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Plese Send your *Bot Price* now :", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \217\134\216\177\216\174 \216\177\216\168\216\167\216\170 \216\174\217\136\216\175 \216\177\216\167 \217\136\216\167\216\177\216\175 \217\134\217\133\216\167\219\140\219\140\216\175 :", 1, "md")
            end
            database:setex("bot:nerkh" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 100, true)
          end
        end
        if is_admin(msg.sender_user_id_) then
          local text = msg.content_.text_:gsub("[Pp]rice", "Nerkh")
          if text:match("^[Nn]erkh$") or text:match("^\216\175\216\177\219\140\216\167\217\129\216\170 \217\134\216\177\216\174$") then
            local nerkh = database:get("nerkh")
            if nerkh then
              send(msg.chat_id_, msg.id_, 1, nerkh, 1, "html")
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Bot *Price* not found !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\216\177\216\174 \216\177\216\168\216\167\216\170 \216\171\216\168\216\170 \217\134\216\180\216\175\217\135 \216\167\216\179\216\170 !", 1, "md")
            end
          end
        end
        if is_sudo(msg) then
          local text = msg.content_.text_:gsub("\216\174\217\136\216\167\217\134\216\175\217\134 \217\190\219\140\216\167\217\133", "Markread")
          if text:match("^[Mm]arkread (.*)$") then
            local status = {
              string.match(text, "^([Mm]arkread) (.*)$")
            }
            if status[2] == "\217\129\216\185\216\167\217\132" or status[2] == "on" then
              if database:get("bot:viewmsg") == "On" then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Markread is now *Active* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\174\217\136\216\167\217\134\216\175\217\134 \217\190\219\140\216\167\217\133 \217\135\216\167\219\140 \216\175\216\177\219\140\216\167\217\129\216\170\219\140 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Markread has been *Actived* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\174\217\136\216\167\217\134\216\175\217\134 \217\190\219\140\216\167\217\133 \217\135\216\167\219\140 \216\175\216\177\219\140\216\167\217\129\216\170\219\140 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
                end
                database:set("bot:viewmsg", "On")
              end
            end
            if status[2] == "\216\186\219\140\216\177\217\129\216\185\216\167\217\132" or status[2] == "off" then
              if database:get("bot:viewmsg") == "Off" then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Markread is now *Deactive* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\174\217\136\216\167\217\134\216\175\217\134 \217\190\219\140\216\167\217\133 \217\135\216\167\219\140 \216\175\216\177\219\140\216\167\217\129\216\170\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Markread has been *Deactived* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\174\217\136\216\167\217\134\216\175\217\134 \217\190\219\140\216\167\217\133 \217\135\216\167\219\140 \216\175\216\177\219\140\216\167\217\129\216\170\219\140 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
                end
                database:set("bot:viewmsg", "Off")
              end
            end
          end
        end
 if is_leader(msg) then
          local text = msg.content_.text_:gsub("\217\136\216\177\217\136\216\175 \216\168\216\167 \217\132\219\140\217\134\218\169", "Joinbylink")
          if text:match("^[Jj]oinbylink (.*)$") then
            local status = {
              string.match(text, "^([Jj]oinbylink) (.*)$")
            }
            if status[2] == "\217\129\216\185\216\167\217\132" or status[2] == "on" then
              if database:get("joinbylink") == "On" then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Join by link is *now Active* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\177\217\136\216\175 \216\168\216\167 \217\132\219\140\217\134\218\169 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Join by link has been *Actived* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\177\217\136\216\175 \216\168\216\167 \217\132\219\140\217\134\218\169 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
                end
                database:set("joinbylink", "On")
              end
            end
            if status[2] == "\216\186\219\140\216\177\217\129\216\185\216\167\217\132" or status[2] == "off" then
              if database:get("joinbylink") == "Off" then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Join by link is *now Deactive* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\177\217\136\216\175 \216\168\216\167 \217\132\219\140\217\134\218\169 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Join by link has been *Deactived* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\136\216\177\217\136\216\175 \216\168\216\167 \217\132\219\140\217\134\218\169 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
                end
                database:set("joinbylink", "Off")
              end
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ss]etlink$") or text:match("^\216\170\217\134\216\184\219\140\217\133 \217\132\219\140\217\134\218\169$")) and check_user_channel(msg) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Plese Send your *Group link* now :", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 :", 1, "md")
          end
          database:setex("bot:group:link" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 120, true)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Dd]ellink$") or text:match("^\216\173\216\176\217\129 \217\132\219\140\217\134\218\169$")) and check_user_channel(msg) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Group Link* Has Been *Cleared* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135 \216\173\216\176\217\129 \216\180\216\175 !", 1, "md")
          end
          database:del("bot:group:link" .. msg.chat_id_)
        end
        if is_sudo(msg) and (text:match("^[Ss]etsupport$") or text:match("^\216\170\217\134\216\184\219\140\217\133 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140$")) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please Send your *Support link* Or *Support Bot ID* now :", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 \219\140\216\167 \216\162\219\140\216\175\219\140 \216\177\216\168\216\167\216\170 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 :", 1, "md")
          end
          database:setex("bot:support:link" .. msg.sender_user_id_, 120, true)
        end
        if is_sudo(msg) and (text:match("^[Dd]elsupport$") or text:match("^\216\173\216\176\217\129 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140$")) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Support *Information* Deleted !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\167\216\183\217\132\216\167\216\185\216\167\216\170 \217\133\216\177\216\168\217\136\216\183 \216\168\217\135 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 \216\173\216\176\217\129 \216\180\216\175 !", 1, "md")
          end
          database:del("bot:supports:link")
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ff]eedback$") or text:match("^\216\175\216\177\216\174\217\136\216\167\216\179\216\170 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140$")) and check_user_channel(msg) then
          local d = database:ttl("waitforfeedback:" .. msg.chat_id_)
          local time = math.floor(d / 60) + 1
          if database:get("waitforfeedback:" .. msg.chat_id_) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 You have *Recently Requested* support !\nPlease try again in `" .. time .. "` minutes ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \216\168\217\135 \216\170\216\167\216\178\218\175\219\140 \216\175\216\177\216\174\217\136\216\167\216\179\216\170 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 \218\169\216\177\216\175\217\135 \216\167\219\140\216\175 !\n\217\132\216\183\217\129\216\167 " .. time .. " \216\175\217\130\219\140\217\130\217\135 \216\175\219\140\218\175\216\177 \217\133\216\172\216\175\216\175 \216\167\217\133\216\170\216\173\216\167\217\134 \218\169\217\134\219\140\216\175 ! ", 1, "md")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 You request your *Help* ! If you wish to *Continue* operation, send *Your Message*, or send *Number* `0` ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167 \216\175\216\177\216\174\217\136\216\167\216\179\216\170 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 \218\169\216\177\216\175\219\140\216\175 !\n \216\167\218\175\216\177 \217\133\216\167\219\140\217\132 \216\168\217\135 \216\167\216\175\216\167\217\133\217\135 \216\185\217\133\217\132\219\140\216\167\216\170 \217\135\216\179\216\170\219\140\216\175 \217\190\219\140\216\167\217\133 \216\174\217\136\216\175 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 \216\140 \216\175\216\177 \216\186\219\140\216\177 \216\181\217\136\216\177\216\170 \216\185\216\175\216\175 0 \216\177\216\167 \217\136\216\167\216\177\216\175 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
            end
            database:setex("bot:feedback" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 80, true)
            database:setex("waitforfeedback:" .. msg.chat_id_, 1800, true)
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ll]ink$") or text:match("^\217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135$")) and check_user_channel(msg) then
          local link = database:get("bot:group:link" .. msg.chat_id_)
          if link then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162<b>Group link</b> :\n\n" .. link, 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135 :\n\n" .. link, 1, "html")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Group link* is not set ! \n Plese send command *Setlink* and set it", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135 \217\135\217\134\217\136\216\178 \216\176\216\174\219\140\216\177\217\135 \217\134\216\180\216\175\217\135 \216\167\216\179\216\170 ! \n \217\132\216\183\217\129\216\167 \216\168\216\167 \216\175\216\179\216\170\217\136\216\177 Setlink \216\162\217\134 \216\177\216\167 \216\176\216\174\219\140\216\177\217\135 \218\169\217\134\219\140\216\175 ", 1, "md")
          end
        end
        if is_admin(msg.sender_user_id_) then
          msg.content_.text_ = msg.content_.text_:gsub("\216\175\216\177\219\140\216\167\217\129\216\170 \217\132\219\140\217\134\218\169", "Getlink")
          if text:match("^[Gg]etlink(-%d+)$") then
            local ap = {
              string.match(text, "^([Gg]etlink)(-%d+)$")
            }
            local tp = tostring(ap[2])
            getGroupLink(msg, tp)
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ss]upport$") or text:match("^\216\175\216\177\219\140\216\167\217\129\216\170 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140$")) and check_user_channel(msg) then
          local link = database:get("bot:supports:link")
          if link then
            if link:match("https://") then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 <b>Support Link</b> :\n\n> " .. link, 1, "html")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 :\n" .. link, 1, "html")
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 <b>Support Bot ID</b> : @" .. link, 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\162\219\140\216\175\219\140 \216\177\216\168\216\167\216\170 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 : @" .. link, 1, "html")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Support link* is not found !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\217\134\218\169 \218\175\216\177\217\136\217\135 \217\190\216\180\216\170\219\140\216\168\216\167\217\134\219\140 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 ! ", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          if (text:match("^[Ss]howedit on$") or text:match("^\217\134\217\133\216\167\219\140\216\180 \216\167\216\175\219\140\216\170 \217\129\216\185\216\167\217\132$")) and check_user_channel(msg) then
            if database:get("sayedit" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Show Edit is already *Activated* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\217\133\216\167\219\140\216\180 \216\167\216\175\219\140\216\170 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Show Edit has been *Activated* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\217\133\216\167\219\140\216\180 \216\167\216\175\219\140\216\170 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("sayedit" .. msg.chat_id_, true)
              database:del("editmsg" .. msg.chat_id_)
            end
          end
          if text:match("^[Ss]howedit off$") or text:match("^\217\134\217\133\216\167\219\140\216\180 \216\167\216\175\219\140\216\170 \216\186\219\140\216\177\217\129\216\185\216\167\217\132$") then
            if not database:get("sayedit" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Show Edit is already *Deactivated* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\217\133\216\167\219\140\216\180 \216\167\216\175\219\140\216\170 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Show Edit has been *Deactivated* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\217\133\216\167\219\140\216\180 \216\167\216\175\219\140\216\170 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:del("sayedit" .. msg.chat_id_)
            end
          end
        end
        if is_sudo(msg) then
          local text = msg.content_.text_:gsub("\216\170\217\134\216\184\219\140\217\133 \217\133\216\170\217\134 \217\133\217\134\216\180\219\140", "Set clerk")
          if text:match("^[Ss]et clerk (.*)$") then
            local clerk = {
              string.match(text, "^([Ss]et clerk) (.*)$")
            }
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Clerk text has been <b>Saved</b> !\nClerk text :\n\n" .. clerk[2], 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\134\216\180\219\140 \216\176\216\174\219\140\216\177\217\135 \216\180\216\175 !\n\n\217\133\216\170\217\134 \217\133\217\134\216\180\219\140 :\n\n" .. clerk[2], 1, "html")
            end
            database:set("textsec", clerk[2])
          end
          if text:match("^[Ss]et clerk$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please Send <b>Clerk Text</b> !", 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \217\190\219\140\216\167\217\133 \217\133\217\134\216\180\219\140 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "html")
            end
            database:setex("gettextsec" .. msg.sender_user_id_, 120, true)
          end
          if text:match("^[Dd]el clerk$") or text:match("^\216\173\216\176\217\129 \217\133\216\170\217\134 \217\133\217\134\216\180\219\140$") then
            if not database:get("textsec") then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Clerk text not *Found* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\134\216\180\219\140 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Clerk text has been *Removed* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\134\216\180\219\140 \216\173\216\176\217\129 \216\180\216\175 !", 1, "md")
              end
              database:del("textsec")
            end
          end
          if text:match("^[Gg]et clerk$") or text:match("^\216\175\216\177\219\140\216\167\217\129\216\170 \217\133\216\170\217\134 \217\133\217\134\216\180\219\140$") then
            local cel = database:get("textsec")
            if cel then
              send(msg.chat_id_, msg.id_, 1, cel, 1, "html")
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Clerk text *not Found* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133\219\140 \216\175\216\177 \217\132\219\140\216\179\216\170 \217\134\219\140\216\179\216\170 !", 1, "md")
            end
          end
        end
        if is_sudo(msg) and text:match("^[Aa]ction (.*)$") then
          local lockpt = {
            string.match(text, "^([Aa]ction) (.*)$")
          }
          if lockpt[2] == "text" then
            sendaction(msg.chat_id_, "Typing")
          end
          if lockpt[2] == "video" then
            sendaction(msg.chat_id_, "RecordVideo")
          end
          if lockpt[2] == "voice" then
            sendaction(msg.chat_id_, "RecordVoice")
          end
          if lockpt[2] == "photo" then
            sendaction(msg.chat_id_, "UploadPhoto")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ff]ilter (.*)$") and check_user_channel(msg) then
          local filters = {
            string.match(text, "^([Ff]ilter) (.*)$")
          }
          local name = string.sub(filters[2], 1, 50)
          local hash = "bot:filters:" .. msg.chat_id_
          if filter_ok(name) then
            database:hset(hash, name, "newword")
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Word `[" .. name .. "]` has been *Filtered* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\217\132\217\133\217\135 [ " .. name .. " ] \217\129\219\140\217\132\216\170\216\177 \216\180\216\175 !", 1, "md")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Word `[" .. name .. "]` Can Not *Filtering* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\217\132\217\133\217\135 [ " .. name .. " ] \217\130\216\167\216\168\217\132 \217\129\219\140\217\132\216\170\216\177 \216\180\216\175\217\134 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^\217\129\219\140\217\132\216\170\216\177\218\169\216\177\216\175\217\134 (.*)$") and check_user_channel(msg) then
          local filterss = {
            string.match(text, "^(\217\129\219\140\217\132\216\170\216\177\218\169\216\177\216\175\217\134) (.*)$")
          }
          local name = string.sub(filterss[2], 1, 50)
          local hash = "bot:filters:" .. msg.chat_id_
          if filter_ok(name) then
            database:hset(hash, name, "newword")
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Word `[" .. name .. "]` has been *Filtered* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\217\132\217\133\217\135 [ " .. name .. " ] \217\129\219\140\217\132\216\170\216\177 \216\180\216\175 !", 1, "md")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Word `[" .. name .. "]` Can Not *Filtering* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\217\132\217\133\217\135 [ " .. name .. " ] \217\130\216\167\216\168\217\132 \217\129\219\140\217\132\216\170\216\177 \216\180\216\175\217\134 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ff]ilter$") and check_user_channel(msg) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Submit* The Words You Want To *Filter* Individually !\nTo *Cancel The Command*, Send The /cancel Command !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \218\169\217\132\217\133\216\167\216\170\219\140 \218\169\217\135 \217\133\219\140\216\174\217\136\216\167\217\135\219\140\216\175 \217\129\219\140\217\132\216\170\216\177 \216\180\217\136\217\134\216\175 \216\177\216\167 \216\168\217\135 \216\181\217\136\216\177\216\170 \216\170\218\169\219\140 \216\168\217\129\216\177\216\179\216\170\219\140\216\175 !\n \216\168\216\177\216\167\219\140 \217\132\216\186\217\136 \216\185\217\133\217\132\219\140\216\167\216\170 \216\175\216\179\216\170\217\136\216\177 /cancel \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
          database:setex("Filtering:" .. msg.sender_user_id_, 80, msg.chat_id_)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^\217\129\219\140\217\132\216\170\216\177\218\169\216\177\216\175\217\134$") and check_user_channel(msg) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Submit* The Words You Want To *Filter* Individually !\nTo *Cancel The Command*, Send The /cancel Command !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \218\169\217\132\217\133\216\167\216\170\219\140 \218\169\217\135 \217\133\219\140\216\174\217\136\216\167\217\135\219\140\216\175 \217\129\219\140\217\132\216\170\216\177 \216\180\217\136\217\134\216\175 \216\177\216\167 \216\168\217\135 \216\181\217\136\216\177\216\170 \216\170\218\169\219\140 \216\168\217\129\216\177\216\179\216\170\219\140\216\175 !\n \216\168\216\177\216\167\219\140 \217\132\216\186\217\136 \216\185\217\133\217\132\219\140\216\167\216\170 \216\175\216\179\216\170\217\136\216\177 /cancel \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
          database:setex("Filtering:" .. msg.sender_user_id_, 80, msg.chat_id_)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Uu]nfilter (.*)$") and check_user_channel(msg) then
          local rws = {
            string.match(text, "^([Uu]nfilter) (.*)$")
          }
          local name = string.sub(rws[2], 1, 50)
          local cti = msg.chat_id_
          local hash = "bot:filters:" .. msg.chat_id_
          if not database:hget(hash, name) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Word `[ " .. name .. " ]` is *not in Filterlist* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\217\132\217\133\217\135 : [ " .. name .. " ] \216\175\216\177 \217\132\219\140\216\179\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Word `[ " .. name .. " ]` *Removed* from Filterlist !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\217\132\217\133\217\135 : [ " .. name .. " ] \216\167\216\178 \217\132\219\140\216\179\216\170 \217\129\219\140\217\132\216\170\216\177 \216\173\216\176\217\129 \216\180\216\175 !", 1, "md")
            end
            database:hdel(hash, name)
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^\216\173\216\176\217\129 \217\129\219\140\217\132\216\170\216\177 (.*)$") and check_user_channel(msg) then
          local rwss = {
            string.match(text, "^(\216\173\216\176\217\129 \217\129\219\140\217\132\216\170\216\177) (.*)$")
          }
          local name = string.sub(rwss[2], 1, 50)
          local cti = msg.chat_id_
          local hash = "bot:filters:" .. msg.chat_id_
          if not database:hget(hash, name) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Word `[ " .. name .. " ]` is *not in Filterlist* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\217\132\217\133\217\135 : [ " .. name .. " ] \216\175\216\177 \217\132\219\140\216\179\216\170 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "md")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Word `[ " .. name .. " ]` *Removed* from Filterlist !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\217\132\217\133\217\135 : [ " .. name .. " ] \216\167\216\178 \217\132\219\140\216\179\216\170 \217\129\219\140\217\132\216\170\216\177 \216\173\216\176\217\129 \216\180\216\175 !", 1, "md")
            end
            database:hdel(hash, name)
          end
        end
        if is_leader(msg) and text:match("^[Ff]wdtoall$") then
          database:setex("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Send* Your Message !\nFor Cancel The Operation, Send Command /Cancel !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \217\190\219\140\216\167\217\133 \216\174\217\136\216\175 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !\n\216\168\216\177\216\167\219\140 \217\132\216\186\217\136 \216\185\217\133\217\132\219\140\216\167\216\170 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177 /Cancel \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
        end
        if is_leader(msg) and text:match("^\217\129\216\177\217\136\216\167\216\177\216\175 \217\135\217\133\218\175\216\167\217\134\219\140$") then
          database:setex("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Send* Your Message !\nFor Cancel The Operation, Send Command /Cancel !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \217\190\219\140\216\167\217\133 \216\174\217\136\216\175 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !\n\216\168\216\177\216\167\219\140 \217\132\216\186\217\136 \216\185\217\133\217\132\219\140\216\167\216\170 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177 /Cancel \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
        end
        if is_leader(msg) and text:match("^[Bb]roadcast$") then
          database:setex("broadcast2" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Send* Your Message !\nFor Cancel The Operation, Send Command /Cancel !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \217\190\219\140\216\167\217\133 \216\174\217\136\216\175 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !\n\216\168\216\177\216\167\219\140 \217\132\216\186\217\136 \216\185\217\133\217\132\219\140\216\167\216\170 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177 /Cancel \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
        end
        if is_leader(msg) and text:match("^\216\167\216\177\216\179\216\167\217\132 \217\135\217\133\218\175\216\167\217\134\219\140$") then
          database:setex("broadcast2" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Send* Your Message !\nFor Cancel The Operation, Send Command /Cancel !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \217\190\219\140\216\167\217\133 \216\174\217\136\216\175 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !\n\216\168\216\177\216\167\219\140 \217\132\216\186\217\136 \216\185\217\133\217\132\219\140\216\167\216\170 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177 /Cancel \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
        end
        if is_sudo(msg) and (text:match("^[Ss]tats$") or text:match("^\217\136\216\182\216\185\219\140\216\170$")) then
          local gps = database:scard("bot:groups")
          local users = database:scard("bot:userss")
          local allmgs = database:get("bot:allmsgs")
          if database:get("bot:reloadingtime") then
            gps = "---"
            users = "---"
            allmgs = "---"
          end
          if database:get("autoleave") == "On" then
            autoleaveen = "Active"
            autoleavefa = "\217\129\216\185\216\167\217\132"
          elseif database:get("autoleave") == "Off" then
            autoleaveen = "Deactive"
            autoleavefa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          elseif not database:get("autoleave") then
            autoleaveen = "Deactive"
            autoleavefa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          end
          if database:get("clerk") == "On" then
            clerken = "Active"
            clerkfa = "\217\129\216\185\216\167\217\132"
          elseif database:get("clerk") == "Off" then
            clerken = "Deactive"
            clerkfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          elseif not database:get("clerk") then
            clerken = "Deactive"
            clerkfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          end
          if database:get("fun") == "On" then
            funen = "Active"
            funfa = "\217\129\216\185\216\167\217\132"
          elseif database:get("fun") == "Off" then
            funen = "Deactive"
            funfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          elseif not database:get("fun") then
            funen = "Deactive"
            funfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          end
          if database:get("bot:viewmsg") == "On" then
            markreaden = "Active"
            markreadfa = "\217\129\216\185\216\167\217\132"
          elseif database:get("bot:viewmsg") == "Off" then
            markreaden = "Deactive"
            markreadfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          elseif not database:get("bot:viewmsg") then
            markreaden = "Deactive"
            markreadfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          end
          if database:get("joinbylink") == "On" then
            joinbylinken = "Active"
            joinbylinkfa = "\217\129\216\185\216\167\217\132"
          elseif database:get("joinbylink") == "Off" then
            joinbylinken = "Deactive"
            joinbylinkfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          elseif not database:get("joinbylink") then
            joinbylinken = "Deactive"
            joinbylinkfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          end
          if database:get("savecont") == "On" then
            saveconten = "Active"
            savecontfa = "\217\129\216\185\216\167\217\132"
          elseif database:get("savecont") == "Off" then
            saveconten = "Deactive"
            savecontfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          elseif not database:get("savecont") then
            saveconten = "Deactive"
            savecontfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          end
          if database:get("bot:joinch") then
            joinchannelen = "Active"
            joinchannelfa = "\217\129\216\185\216\167\217\132"
          else
            joinchannelen = "Deactive"
            joinchannelfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          end
          if database:get("lang:gp:" .. msg.chat_id_) then
            lang = "En"
          else
            lang = "Fa"
          end
          local cm = io.popen("uptime -p"):read("*all")
          local ResultUptimeServer = GetUptimeServer(cm, lang)
          if 4 > string.len(ResultUptimeServer) then
            if lang == "En" then
              ResultUptimeServer = "Recently rebooted !"
            elseif lang == "Fa" then
              ResultUptimeServer = "\216\167\216\174\219\140\216\177\216\167 \216\177\216\167\217\135 \216\167\217\134\216\175\216\167\216\178\219\140 \217\133\216\172\216\175\216\175 \216\180\216\175\217\135 \216\167\216\179\216\170 !"
            end
          end
          Uptime_1 = database:get("bot:Uptime")
          local osTime = os.time()
          Uptime_ = osTime - tonumber(Uptime_1)
          Uptime = getTimeUptime(Uptime_, lang)
          usersv = io.popen("whoami"):read("*all")
          usersv = usersv:match("%S+")
          if database:get("lang:gp:" .. msg.chat_id_) then
            datasv = io.popen("./launch.sh statsen"):read("*all")
          else
            datasv = io.popen("./launch.sh statsfa"):read("*all")
          end
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162\226\128\162 *Status Bot* : \n\n\226\128\162 *Groups* : `" .. gps .. "`\n\n\226\128\162 *Msg Received*  : `" .. allmgs .. "`\n\n\226\128\162 *Uptime* : `" .. Uptime .. "`\n\n\226\128\162 *Auto Leave* : `" .. autoleaveen .. "`\n\n\226\128\162 *Clerk* : `" .. clerken .. "`\n\n\226\128\162 *Forced Join Channel* : `" .. joinchannelen .. "`\n\n\226\128\162 *Fun Ability* : `" .. funen .. "`\n\n\226\128\162 *Markread* : `" .. markreaden .. "`\n\n\226\128\162 *Join By Link* : `" .. joinbylinken .. "`\n\n\226\128\162 *Save Phone Number* : `" .. saveconten .. "`\n\n\226\128\162\226\128\162 *Status Server* :\n\n\226\128\162 *User* : `" .. usersv .. "`\n\n\226\128\162 *UpTime* : `" .. ResultUptimeServer .. [[
`

]] .. datasv, 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\177\216\168\216\167\216\170 : \n\n\226\128\162 \216\170\216\185\216\175\216\167\216\175 \218\175\216\177\217\136\217\135 \217\135\216\167 : " .. gps .. "\n\n\226\128\162 \216\170\216\185\216\175\216\167\216\175 \217\190\219\140\216\167\217\133 \217\135\216\167\219\140 \216\175\216\177\219\140\216\167\217\129\216\170\219\140  : " .. allmgs .. "\n\n\226\128\162 \216\162\217\190\216\170\216\167\219\140\217\133 : " .. Uptime .. "\n\n\226\128\162 \216\174\216\177\217\136\216\172 \216\174\217\136\216\175\218\169\216\167\216\177 : " .. autoleavefa .. "\n\n\226\128\162 \217\133\217\134\216\180\219\140 : " .. clerkfa .. "\n\n\226\128\162 \216\167\216\172\216\168\216\167\216\177 \216\185\216\182\217\136\219\140\216\170 \216\175\216\177 \218\169\216\167\217\134\216\167\217\132 : " .. joinchannelfa .. "\n\n\226\128\162 \217\130\216\167\216\168\217\132\219\140\216\170 \217\135\216\167\219\140 \216\179\216\177\218\175\216\177\217\133 \218\169\217\134\217\134\216\175\217\135 : " .. funfa .. "\n\n\226\128\162 \216\174\217\136\216\167\217\134\216\175\217\134 \217\190\219\140\216\167\217\133 : " .. markreadfa .. "\n\n\226\128\162 \217\136\216\177\217\136\216\175 \216\168\216\167 \217\132\219\140\217\134\218\169 : " .. joinbylinkfa .. "\n\n\226\128\162 \216\176\216\174\219\140\216\177\217\135 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134 : " .. savecontfa .. "\n\n\226\128\162\226\128\162 \217\136\216\182\216\185\219\140\216\170 \216\179\216\177\217\136\216\177 :\n\n\226\128\162 \219\140\217\136\216\178\216\177 : " .. usersv .. "\n\n\226\128\162 \216\162\217\190\216\170\216\167\219\140\217\133 : " .. ResultUptimeServer .. [[


]] .. datasv, 1, "md")
          end
        end
        if is_sudo(msg) and (text:match("^[Rr]esgp$") or text:match("^\216\168\216\177\217\136\216\178\216\177\216\179\216\167\217\134\219\140 \218\175\216\177\217\136\217\135 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170$")) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Nubmber of Groups bot has been *Updated* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\170\216\185\216\175\216\167\216\175 \218\175\216\177\217\136\217\135 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170 \216\168\216\167 \217\133\217\136\217\129\217\130\219\140\216\170 \216\168\216\177\217\136\216\178\216\177\216\179\216\167\217\134\219\140 \218\175\216\177\216\175\219\140\216\175 !", "md")
          end
          database:del("bot:groups")
        end
        if is_sudo(msg) and (text:match("^[Rr]esmsg$") or text:match("^\216\180\216\177\217\136\216\185 \217\133\216\172\216\175\216\175 \216\180\217\133\216\167\216\177\216\180 \217\190\219\140\216\167\217\133 \216\175\216\177\219\140\216\167\217\129\216\170\219\140$")) then
          database:del("bot:allmsgs")
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 All msg Received has been *Reset* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\180\217\133\216\167\216\177\216\180 \217\190\219\140\216\167\217\133 \217\135\216\167\219\140 \216\175\216\177\219\140\216\167\217\129\216\170\219\140 \216\140 \216\167\216\178 \217\134\217\136 \216\180\216\177\217\136\216\185 \216\180\216\175 !", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and (text:match("^[Ss]etlang (.*)$") or text:match("^\216\170\217\134\216\184\219\140\217\133 \216\178\216\168\216\167\217\134 (.*)$")) then
          local langs = {
            string.match(text, "^(.*) (.*)$")
          }
          if langs[2] == "fa" or langs[2] == "\217\129\216\167\216\177\216\179\219\140" then
            if not database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\178\216\168\216\167\217\134 \216\177\216\168\216\167\216\170 \217\135\217\133 \216\167\218\169\217\134\217\136\217\134 \216\168\216\177 \216\177\217\136\219\140 \217\129\216\167\216\177\216\179\219\140 \217\130\216\177\216\167\216\177 \216\175\216\167\216\177\216\175 !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\178\216\168\216\167\217\134 \216\177\216\168\216\167\216\170 \216\168\217\135 \217\129\216\167\216\177\216\179\219\140 \216\170\216\186\219\140\219\140\216\177 \217\190\219\140\216\175\216\167 \218\169\216\177\216\175 ! ", 1, "md")
              database:del("lang:gp:" .. msg.chat_id_)
            end
          end
          if langs[2] == "en" or langs[2] == "\216\167\217\134\218\175\217\132\219\140\216\179\219\140" then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Language Bot is *Already* English !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Bot Language has been Changed to *English* !", 1, "md")
              database:set("lang:gp:" .. msg.chat_id_, true)
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Uu]nlock (.*)$") or text:match("^\216\168\216\167\216\178\218\169\216\177\216\175\217\134 (.*)$")) and check_user_channel(msg) then
          local unlockpt = {
            string.match(text, "^([Uu]nlock) (.*)$")
          }
          local unlockpts = {
            string.match(text, "^(\216\168\216\167\216\178\218\169\216\177\216\175\217\134) (.*)$")
          }
          if unlockpt[2] == "edit" or unlockpts[2] == "\217\136\219\140\216\177\216\167\219\140\216\180 \217\190\219\140\216\167\217\133" then
            if database:get("editmsg" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock edit has been *Inactive* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\219\140\216\177\216\167\219\140\216\180 \217\190\219\140\216\167\217\133 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("editmsg" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock edit is *Already* inactive ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\219\140\216\177\216\167\219\140\216\180 \217\190\219\140\216\167\217\133 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unlockpt[2] == "cmd" or unlockpts[2] == "\216\173\216\167\217\132\216\170 \216\185\216\175\217\133 \216\172\217\136\216\167\216\168" then
            if database:get("bot:cmds" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Case of no answer has been *Inactive* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\167\217\132\216\170 \216\185\216\175\217\133 \216\172\217\136\216\167\216\168 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:cmds" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Case of no answer is *Already* inactive ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\167\217\132\216\170 \216\185\216\175\217\133 \216\172\217\136\216\167\216\168 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unlockpt[2] == "bots" or unlockpts[2] == "\216\177\216\168\216\167\216\170" then
            if database:get("bot:bots:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock bot has been *Inactive* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\216\177\217\136\216\175 \216\177\216\168\216\167\216\170 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:bots:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock bots is *Already* inactive ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\216\177\217\136\216\175 \216\177\216\168\216\167\216\170 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unlockpt[2] == "flood" or unlockpts[2] == "\217\129\217\132\217\136\216\175" then
            if database:get("anti-flood:" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock flood has been *Inactive* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\217\132\217\136\216\175 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("anti-flood:" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock flood is *Already* inactive ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\130\217\132\217\136\216\175 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unlockpt[2] == "pin" or unlockpts[2] == "\216\179\217\134\216\172\216\167\217\130 \217\190\219\140\216\167\217\133" then
            if database:get("bot:pin:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock pin has been *Inactive* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\179\217\134\216\172\216\167\217\130 \217\190\219\140\216\167\217\133 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:pin:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock pin is *Already* inactive !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\179\217\134\216\172\216\167\217\130 \217\190\219\140\216\167\217\133 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = text:gsub("\217\130\217\129\217\132 \216\174\217\136\216\175\218\169\216\167\216\177", "Lock auto")
          if text:match("^[Ll]ock auto$") and check_user_channel(msg) then
            local s = database:get("bot:muteall:start" .. msg.chat_id_)
            local t = database:get("bot:muteall:stop" .. msg.chat_id_)
            if not s and not t then
              database:setex("bot:SetMuteall:start" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
              database:del("bot:SetMuteall:stop" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please Send *Auto-Lock* Time To *Start* !\nFor example:\n14:38", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\178\217\133\216\167\217\134 \216\180\216\177\217\136\216\185 \217\130\217\129\217\132 \216\174\217\136\216\175\218\169\216\167\216\177 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 ! \n\216\168\217\135 \216\183\217\136\216\177 \217\133\216\171\216\167\217\132 :\n14:38", 1, "md")
              end
            elseif not database:get("bot:muteall:Time" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock Auto has been *Actived* !\nTo Reset The Time, Send  *Settime* Command !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\174\217\136\216\175\218\169\216\167\216\177 \217\129\216\185\216\167\217\132 \216\180\216\175 !\n\216\168\216\177\216\167\219\140 \216\170\217\134\216\184\219\140\217\133 \217\133\216\172\216\175\216\175 \216\178\217\133\216\167\217\134 \216\140 \216\175\216\179\216\170\217\136\216\177 Settime \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
              end
              database:set("bot:duplipost:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock Auto is *Already* actived !\nTo Reset The Time, Send  *Settime* Command !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\174\217\136\216\175\218\169\216\167\216\177 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !\n\216\168\216\177\216\167\219\140 \216\170\217\134\216\184\219\140\217\133 \217\133\216\172\216\175\216\175 \216\178\217\133\216\167\217\134 \216\140 \216\175\216\179\216\170\217\136\216\177 Settime \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
            end
          end
          if database:get("bot:SetMuteall:start" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) and text:match("^%d+:%d+$") then
            local ap = {
              string.match(text, "^(%d+:)(%d+)$")
            }
            local h = text:match("%d+:")
            h = h:gsub(":", "")
            local m = text:match(":%d+")
            m = m:gsub(":", "")
            local h_ = 23
            local m_ = 59
            if h_ >= tonumber(h) and m_ >= tonumber(m) then
              local TimeStart = text:match("^%d+:%d+")
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please Send *Auto-Lock* Time Of The *End* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\178\217\133\216\167\217\134 \217\190\216\167\219\140\216\167\217\134 \217\130\217\129\217\132 \216\174\217\136\216\175\218\169\216\167\216\177 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
              end
              database:del("bot:SetMuteall:start" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
              database:set("bot:muteall:start" .. msg.chat_id_, TimeStart)
              database:setex("bot:SetMuteall:stop" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Time Posted is *Not Correct* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\178\217\133\216\167\217\134 \216\167\216\177\216\179\216\167\217\132 \216\180\216\175\217\135 \216\181\216\173\219\140\216\173 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
            end
          end
          if database:get("bot:SetMuteall:stop" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
            local t = database:get("bot:muteall:start" .. msg.chat_id_)
            if text:match("^%d+:%d+") and not text:match(t) then
              local ap = {
                string.match(text, "^(%d+):(%d+)$")
              }
              local h = text:match("%d+:")
              h = h:gsub(":", "")
              local m = text:match(":%d+")
              m = m:gsub(":", "")
              local h_ = 23
              local m_ = 59
              if h_ >= tonumber(h) and m_ >= tonumber(m) then
                local TimeStop = text:match("^%d+:%d+")
                database:del("bot:SetMuteall:stop" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
                database:set("bot:muteall:stop" .. msg.chat_id_, TimeStop)
                database:set("bot:muteall:Time" .. msg.chat_id_, true)
                local start = database:get("bot:muteall:start" .. msg.chat_id_)
                local stop = database:get("bot:muteall:stop" .. msg.chat_id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 Auto-lock Time Every Day " .. start .. " Will Be *Active* and " .. stop .. " Will Be *Disabled* !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\174\217\136\216\175\218\169\216\167\216\177 \217\135\216\177 \216\177\217\136\216\178 \216\175\216\177 \216\179\216\167\216\185\216\170 " .. start .. " \217\129\216\185\216\167\217\132 \217\136 \216\175\216\177 \216\179\216\167\216\185\216\170 " .. stop .. " \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\174\217\136\216\167\217\135\216\175 \216\180\216\175 !", 1, "md")
                end
                database:del("bot:muteall:start_Unix" .. msg.chat_id_)
                database:del("bot:muteall:stop_Unix" .. msg.chat_id_)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Time Posted is *Not Correct* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\178\217\133\216\167\217\134 \216\167\216\177\216\179\216\167\217\132 \216\180\216\175\217\135 \216\181\216\173\219\140\216\173 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
              end
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = text:gsub("\216\168\216\167\216\178\218\169\216\177\216\175\217\134 \216\174\217\136\216\175\218\169\216\167\216\177", "Unlock auto")
          if text:match("^[Uu]nlock auto$") and check_user_channel(msg) then
            if database:get("bot:muteall:Time" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Auto-Lock has been *Inactive* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\174\217\136\216\175\218\169\216\167\216\177 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:muteall:Time" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Auto-Lock is *Already* inactive ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\174\217\136\216\175\218\169\216\167\216\177 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = text:gsub("\216\170\217\134\216\184\219\140\217\133 \216\178\217\133\216\167\217\134", "Settime")
          if text:match("^[Ss]ettime$") and check_user_channel(msg) then
            database:setex("bot:SetMuteall:start" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
            database:del("bot:SetMuteall:stop" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please Send *Auto-Lock* Time To *Start* !\nFor example:\n14:38", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\178\217\133\216\167\217\134 \216\180\216\177\217\136\216\185 \217\130\217\129\217\132 \216\174\217\136\216\175\218\169\216\167\216\177 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 ! \n\216\168\217\135 \216\183\217\136\216\177 \217\133\216\171\216\167\217\132 :\n14:38", 1, "md")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ll]ock gtime (%d+) (%d+) (%d+)$") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^[Ll]ock gtime (%d+) (%d+) (%d+)$")
          }
          local hour = string.gsub(matches[1], "h", "")
          local num1 = tonumber(hour) * 3600
          local minutes = string.gsub(matches[2], "m", "")
          local num2 = tonumber(minutes) * 60
          local second = string.gsub(matches[3], "s", "")
          local num3 = tonumber(second)
          local num4 = tonumber(num1 + num2 + num3)
          if 1 <= matches[1] + matches[2] + matches[3] then
            database:setex("bot:muteall" .. msg.chat_id_, num4, true)
            database:setex("bot:gtime" .. msg.chat_id_, num4, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock all has been *Enable* for `" .. matches[1] .. "` Hours and `" .. matches[2] .. "` Minutes and `" .. matches[3] .. "` Seconds !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\216\177\217\136\217\135 \216\168\217\135 \217\133\216\175\216\170 " .. matches[1] .. " \216\179\216\167\216\185\216\170 \217\136 " .. matches[2] .. " \216\175\217\130\219\140\217\130\217\135 \217\136 " .. matches[3] .. " \216\171\216\167\217\134\219\140\217\135 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Use* a Number Greater Than 0 !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\167\216\178 \216\185\216\175\216\175 \216\168\216\178\216\177\218\175\216\170\216\177 \216\167\216\178 \216\181\217\129\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ll]ock gtime (%d+) (%d+)$") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^[Ll]ock gtime (%d+) (%d+)$")
          }
          local hour = string.gsub(matches[1], "h", "")
          local num1 = tonumber(hour) * 3600
          local minutes = string.gsub(matches[2] or 0, "m", "")
          local num2 = tonumber(minutes) * 60
          local num3 = tonumber(num1 + num2)
          if 1 <= matches[1] + matches[2] then
            database:setex("bot:muteall" .. msg.chat_id_, num3, true)
            database:setex("bot:gtime" .. msg.chat_id_, num3, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock all has been *Enable* for `" .. matches[1] .. "` Hours and `" .. matches[2] .. "` Minutes !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\216\177\217\136\217\135 \216\168\217\135 \217\133\216\175\216\170 " .. matches[1] .. " \216\179\216\167\216\185\216\170 \217\136 " .. matches[2] .. " \216\175\217\130\219\140\217\130\217\135 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Use* a Number Greater Than 0 !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\167\216\178 \216\185\216\175\216\175 \216\168\216\178\216\177\218\175\216\170\216\177 \216\167\216\178 \216\181\217\129\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ll]ock gtime (%d+)$") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^([Ll]ock gtime) (%d+)$")
          }
          local hour = string.gsub(matches[2], "h", "")
          local num1 = tonumber(hour) * 3600
          if 1 <= tonumber(matches[2]) then
            database:setex("bot:muteall" .. msg.chat_id_, num1, true)
            database:setex("bot:gtime" .. msg.chat_id_, num1, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock all has been *Enable* for `" .. matches[2] .. "` Hours !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\216\177\217\136\217\135 \216\168\217\135 \217\133\216\175\216\170 " .. matches[2] .. " \216\179\216\167\216\185\216\170 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Use* a Number Greater Than 0 !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\167\216\178 \216\185\216\175\216\175 \216\168\216\178\216\177\218\175\216\170\216\177 \216\167\216\178 \216\181\217\129\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and text:match("^\217\130\217\129\217\132 \216\172\219\140 \216\170\216\167\219\140\217\133 (%d+) (%d+) (%d+)$") and idf:match("-100(%d+)") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^\217\130\217\129\217\132 \216\172\219\140 \216\170\216\167\219\140\217\133 (%d+) (%d+) (%d+)$")
          }
          local hour = string.gsub(matches[1], "h", "")
          local num1 = tonumber(hour) * 3600
          local minutes = string.gsub(matches[2], "m", "")
          local num2 = tonumber(minutes) * 60
          local second = string.gsub(matches[3], "s", "")
          local num3 = tonumber(second)
          local num4 = tonumber(num1 + num2 + num3)
          if 1 <= matches[1] + matches[2] + matches[3] then
            database:setex("bot:muteall" .. msg.chat_id_, num4, true)
            database:setex("bot:gtime" .. msg.chat_id_, num4, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock all has been *Enable* for `" .. matches[1] .. "` Hours and `" .. matches[2] .. "` Minutes and `" .. matches[3] .. "` Seconds !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\216\177\217\136\217\135 \216\168\217\135 \217\133\216\175\216\170 " .. matches[1] .. " \216\179\216\167\216\185\216\170 \217\136 " .. matches[2] .. " \216\175\217\130\219\140\217\130\217\135 \217\136 " .. matches[3] .. " \216\171\216\167\217\134\219\140\217\135 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Use* a Number Greater Than 0 !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\167\216\178 \216\185\216\175\216\175 \216\168\216\178\216\177\218\175\216\170\216\177 \216\167\216\178 \216\181\217\129\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^\217\130\217\129\217\132 \216\172\219\140 \216\170\216\167\219\140\217\133 (%d+) (%d+)$") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^\217\130\217\129\217\132 \216\172\219\140 \216\170\216\167\219\140\217\133 (%d+) (%d+)$")
          }
          local hour = string.gsub(matches[1], "h", "")
          local num1 = tonumber(hour) * 3600
          local minutes = string.gsub(matches[2] or 0, "m", "")
          local num2 = tonumber(minutes) * 60
          local num3 = tonumber(num1 + num2)
          if 1 <= matches[1] + matches[2] then
            database:setex("bot:muteall" .. msg.chat_id_, num3, true)
            database:setex("bot:gtime" .. msg.chat_id_, num3, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock all has been *Enable* for `" .. matches[1] .. "` Hours and `" .. matches[2] .. "` Minutes !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\216\177\217\136\217\135 \216\168\217\135 \217\133\216\175\216\170 " .. matches[1] .. " \216\179\216\167\216\185\216\170 \217\136 " .. matches[2] .. " \216\175\217\130\219\140\217\130\217\135 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Use* a Number Greater Than 0 !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\167\216\178 \216\185\216\175\216\175 \216\168\216\178\216\177\218\175\216\170\216\177 \216\167\216\178 \216\181\217\129\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^\217\130\217\129\217\132 \216\172\219\140 \216\170\216\167\219\140\217\133 (%d+)$") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^(\217\130\217\129\217\132 \216\172\219\140 \216\170\216\167\219\140\217\133) (%d+)$")
          }
          local hour = string.gsub(matches[2], "h", "")
          local num1 = tonumber(hour) * 3600
          if 1 <= tonumber(matches[2]) then
            database:setex("bot:muteall" .. msg.chat_id_, num1, true)
            database:setex("bot:gtime" .. msg.chat_id_, num1, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock all has been *Enable* for `" .. matches[2] .. "` Hours !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\216\177\217\136\217\135 \216\168\217\135 \217\133\216\175\216\170 " .. matches[2] .. " \216\179\216\167\216\185\216\170 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Use* a Number Greater Than 0 !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\167\216\178 \216\185\216\175\216\175 \216\168\216\178\216\177\218\175\216\170\216\177 \216\167\216\178 \216\181\217\129\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
        end
        if database:get("bot:gtime" .. msg.chat_id_) then
          local gtimeTime = tonumber(database:ttl("bot:gtime" .. msg.chat_id_))
          if gtimeTime < 60 and not database:get("bot:gtime:say" .. msg.chat_id_) then
            database:set("bot:gtime:say" .. msg.chat_id_, true)
            database:setex("bot:gtime:say2", gtimeTime, msg.chat_id_)
          end
        end
        if database:get("bot:gtime:say2") then
          local gtimeTime_ = tonumber(database:ttl("bot:gtime:say2"))
          local gtimeChat_ = tostring(database:get("bot:gtime:say2"))
          if gtimeTime_ < 5 then
            if database:get("lang:gp:" .. gtimeChat_) then
              send(gtimeChat_, 0, 1, "\226\128\162 Time *Lock Group* Finished, All Users can *Send Message* in Group !", 1, "md")
            else
              send(gtimeChat_, 0, 1, "\226\128\162 \216\178\217\133\216\167\217\134 \217\130\217\129\217\132 \218\175\216\177\217\136\217\135 \216\168\217\135 \217\190\216\167\219\140\216\167\217\134 \216\177\216\179\219\140\216\175 \216\140 \218\169\216\167\216\177\216\168\216\177\216\167\217\134 \216\167\216\178 \216\167\219\140\217\134 \216\168\217\135 \216\168\216\185\216\175 \217\130\216\167\216\175\216\177 \216\168\217\135 \216\167\216\177\216\179\216\167\217\132 \217\190\219\140\216\167\217\133 \217\133\219\140\216\168\216\167\216\180\217\134\216\175 !", 1, "md")
            end
            database:del("bot:gtime:say2")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ll]ock (.*)$") or text:match("^\217\130\217\129\217\132 (.*)$")) and check_user_channel(msg) then
          local mutept = {
            string.match(text, "^([Ll]ock) (.*)$")
          }
          local mutepts = {
            string.match(text, "^(\217\130\217\129\217\132) (.*)$")
          }
          if mutept[2] == "all" or mutepts[2] == "\218\175\216\177\217\136\217\135" then
            if not database:get("bot:muteall" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock all has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\216\177\217\136\217\135 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("bot:muteall" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock all is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\216\177\217\136\217\135 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "text" or mutepts[2] == "\217\133\216\170\217\134" then
            if not database:get("bot:text:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock text has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\216\170\217\134 [ \218\134\216\170 ] \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("bot:text:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock text is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\216\170\217\134 [ \218\134\216\170 ] \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "duplipost" or mutepts[2] == "\217\190\216\179\216\170 \216\170\218\169\216\177\216\167\216\177\219\140" then
            if not database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock duplicate post has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\190\216\179\216\170 \216\170\218\169\216\177\216\167\216\177\219\140 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("bot:duplipost:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock duplicate post is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\190\216\179\216\170 \216\170\218\169\216\177\216\167\216\177\219\140 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "inline" or mutepts[2] == "\216\175\218\169\217\133\217\135 \216\180\219\140\216\180\217\135 \216\167\219\140" then
            if not database:get("bot:inline:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock inline has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\175\218\169\217\133\217\135 \216\180\219\140\216\180\217\135 \216\167\219\140 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("bot:inline:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock inline is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\175\218\169\217\133\217\135 \216\180\219\140\216\180\217\135 \216\167\219\140\219\140 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "post" or mutepts[2] == "\217\190\216\179\216\170" then
            if not database:get("post:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock post has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\190\216\179\216\170 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("post:lock" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock post is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\190\216\179\216\170 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "photo" or mutepts[2] == "\216\185\218\169\216\179" then
            if not database:get("bot:photo:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock photo has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\185\218\169\216\179 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("bot:photo:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock photo is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\185\218\169\216\179 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "spam" or mutepts[2] == "\216\167\216\179\217\190\217\133" then
            if not database:get("bot:spam:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock spam has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\179\217\190\217\133 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("bot:spam:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock spam is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\179\217\190\217\133 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "video" or mutepts[2] == "\217\129\219\140\217\132\217\133" then
            if not database:get("bot:video:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock video has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\219\140\217\132\217\133 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("bot:video:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock video is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\219\140\217\132\217\133 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "selfvideo" or mutepts[2] == "\217\129\219\140\217\132\217\133 \216\179\217\132\217\129\219\140" then
            if not database:get("bot:selfvideo:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock self video has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\219\140\217\132\217\133 \216\179\217\132\217\129\219\140 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("bot:selfvideo:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock self video is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\219\140\217\132\217\133 \216\179\217\132\217\129\219\140 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "gif" or mutepts[2] == "\218\175\219\140\217\129" then
            if not database:get("bot:gifs:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock gif has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\219\140\217\129 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("bot:gifs:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock gif is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\219\140\217\129 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "music" or mutepts[2] == "\217\133\217\136\216\178\219\140\218\169" then
            if not database:get("bot:music:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock music has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\217\136\216\178\219\140\218\169 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("bot:music:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock music is *Alraedy* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\217\136\216\178\219\140\218\169 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "voice" or mutepts[2] == "\217\136\219\140\216\179" then
            if not database:get("bot:voice:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock voice has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\219\140\216\179 \217\129\216\185\216\167\217\132 \216\180\216\175 !", 1, "md")
              end
              database:set("bot:voice:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock voice is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\219\140\216\179 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "links" or mutepts[2] == "\217\132\219\140\217\134\218\169" then
            if not database:get("bot:links:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock links has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\132\219\140\217\134\218\169 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:links:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock links is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\132\219\140\217\134\218\169 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "location" or mutepts[2] == "\217\133\217\136\217\130\216\185\219\140\216\170 \217\133\218\169\216\167\217\134\219\140" then
            if not database:get("bot:location:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock location has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\217\136\217\130\216\185\219\140\216\170 \217\133\218\169\216\167\217\134\219\140 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:location:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock location is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\217\136\217\130\216\185\219\140\216\170 \217\133\218\169\216\167\217\134\219\140 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "tag" or mutepts[2] == "\216\170\218\175" then
            if not database:get("tags:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock tag has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\170\218\175 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("tags:lock" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock tag is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\170\218\175 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "strict" or mutepts[2] == "\216\173\216\167\217\132\216\170 \216\179\216\174\216\170\218\175\219\140\216\177\216\167\217\134\217\135" then
            if not database:get("bot:strict" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Strict mode has been *Enable* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\167\217\132\216\170 [ \216\179\216\174\216\170\218\175\219\140\216\177\216\167\217\134\217\135 ] \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:strict" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Strict mode is *Already* enable ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\167\217\132\216\170 [ \216\179\216\174\216\170\218\175\219\140\216\177\216\167\217\134\217\135 ] \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if mutept[2] == "file" or mutepts[2] == "\217\129\216\167\219\140\217\132" then
            if not database:get("bot:document:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock file has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\216\167\219\140\217\132 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:document:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock file is *Already* actived  !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\216\167\219\140\217\132 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "game" or mutepts[2] == "\216\168\216\167\216\178\219\140" then
            if not database:get("Game:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock game has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\168\216\167\216\178\219\140 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("Game:lock" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock game is *Already* actived  !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\168\216\167\216\178\219\140 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "hashtag" or mutepts[2] == "\217\135\216\180\216\170\218\175" then
            if not database:get("bot:hashtag:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock hastag has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\135\216\180\216\170\218\175 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:hashtag:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock hashtag is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\135\216\180\216\170\218\175 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "contact" or mutepts[2] == "\217\133\216\174\216\167\216\183\216\168" then
            if not database:get("bot:contact:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock contact has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\177\216\179\216\167\217\132 \217\133\216\174\216\167\216\183\216\168 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:contact:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock contact is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\177\216\179\216\167\217\132 \217\133\216\174\216\167\216\183\216\168 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "webpage" or mutepts[2] == "\216\181\217\129\216\173\216\167\216\170 \216\167\219\140\217\134\216\170\216\177\217\134\216\170\219\140" then
            if not database:get("bot:webpage:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock webpage has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\177\216\179\216\167\217\132 \216\181\217\129\216\173\217\135 \216\167\219\140\217\134\216\170\216\177\217\134\216\170\219\140 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:webpage:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock webpage is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\177\216\179\216\167\217\132 \216\181\217\129\216\173\217\135 \216\167\219\140\217\134\216\170\216\177\217\134\216\170\219\140 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "joinmember" or mutepts[2] == "\217\136\216\177\217\136\216\175 \216\185\216\182\217\136" then
            if not database:get("bot:member:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock Join Member has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\216\177\217\136\216\175 \216\185\216\182\217\136 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:member:lock" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock Join Member is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\216\177\217\136\216\175 \216\185\216\182\217\136 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "farsi" or mutepts[2] == "\217\134\217\136\216\180\216\170\216\167\216\177 \217\129\216\167\216\177\216\179\219\140" then
            if not database:get("bot:arabic:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock farsi has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\134\217\136\216\180\216\170\216\167\216\177 \217\129\216\167\216\177\216\179\219\140 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:arabic:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock farsi is *Already* actived", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\134\217\136\216\180\216\170\216\167\216\177 \217\129\216\167\216\177\216\179\219\140 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "english" or mutepts[2] == "\217\134\217\136\216\180\216\170\216\167\216\177 \216\167\217\134\218\175\217\132\219\140\216\179\219\140" then
            if not database:get("bot:english:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock english has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\134\217\136\216\180\216\170\216\167\216\177 \216\167\217\134\218\175\217\132\219\140\216\179\219\140 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:english:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock english is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\134\217\136\216\180\216\170\216\167\216\177 \216\167\217\134\218\175\217\132\219\140\216\179\219\140 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "sticker" or mutepts[2] == "\216\167\216\179\216\170\219\140\218\169\216\177" then
            if not database:get("bot:sticker:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock sticker has been *Actived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\179\216\170\219\140\218\169\216\177 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:sticker:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock sticker is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\179\216\170\219\140\218\169\216\177 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "markdown" or mutepts[2] == "\217\133\216\175\217\132 \217\134\216\180\216\167\217\134\217\135 \218\175\216\176\216\167\216\177\219\140" then
            if not database:get("markdown:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock markdown has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\216\175\217\132 \217\134\216\180\216\167\217\134\217\135 \218\175\216\176\216\167\216\177\219\140 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("markdown:lock" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock markdown is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\216\175\217\132 \217\134\216\180\216\167\217\134\217\135 \218\175\216\176\216\167\216\177\219\140 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "tgservice" or mutepts[2] == "\216\179\216\177\217\136\219\140\216\179 \216\170\217\132\218\175\216\177\216\167\217\133" then
            if not database:get("bot:tgservice:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock tgservice has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\179\216\177\217\136\219\140\216\179 \216\170\217\132\218\175\216\177\216\167\217\133 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:tgservice:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock tgservice is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\179\216\177\217\136\219\140\216\179 \216\170\217\132\218\175\216\177\216\167\217\133 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if mutept[2] == "fwd" or mutepts[2] == "\217\129\216\177\217\136\216\167\216\177\216\175" then
            if not database:get("bot:forward:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock forward has been *Actived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\216\177\217\136\216\167\216\177\216\175 \217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:set("bot:forward:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock forward is *Already* actived !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\216\177\217\136\216\167\216\177\216\175 \216\167\216\178 \217\130\216\168\217\132 \217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Uu]nlock (.*)$") or text:match("^\216\168\216\167\216\178\218\169\216\177\216\175\217\134 (.*)$")) and check_user_channel(msg) then
          local unmutept = {
            string.match(text, "^([Uu]nlock) (.*)$")
          }
          local unmutepts = {
            string.match(text, "^(\216\168\216\167\216\178\218\169\216\177\216\175\217\134) (.*)$")
          }
          if unmutept[2] == "all" or unmutept[2] == "gtime" or unmutepts[2] == "\218\175\216\177\217\136\217\135" or unmutepts[2] == "\216\172\219\140 \216\170\216\167\219\140\217\133" then
            if database:get("bot:muteall" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock all has been *Inactived* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\216\177\217\136\217\135 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:muteall" .. msg.chat_id_)
              database:set("bot:gtime:say" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock all is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\216\177\217\136\217\135 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "text" or unmutepts[2] == "\217\133\216\170\217\134" then
            if database:get("bot:text:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock text has been *Inactived* ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\216\170\217\134 [ \218\134\216\170 ] \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:text:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock text is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\216\170\217\134 [ \218\134\216\170 ] \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "photo" or unmutepts[2] == "\216\185\218\169\216\179" then
            if database:get("bot:photo:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock photo has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\185\218\169\216\179 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:photo:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock photo is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\185\218\169\216\179 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "duplipost" or unmutepts[2] == "\217\190\216\179\216\170 \216\170\218\169\216\177\216\167\216\177\219\140" then
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock duplicate post has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\190\216\179\216\170 \216\170\218\169\216\177\216\167\216\177\219\140 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:duplipost:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock duplicate post is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\190\216\179\216\170 \216\170\218\169\216\177\216\167\216\177\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "spam" or unmutepts[2] == "\216\167\216\179\217\190\217\133" then
            if database:get("bot:spam:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock spam has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\179\217\190\217\133 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:spam:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock spam is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\179\217\190\217\133 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "video" or unmutepts[2] == "\217\129\219\140\217\132\217\133" then
            if database:get("bot:video:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock video has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\219\140\217\132\217\133 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:video:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock video is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\219\140\217\132\217\133 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "selfvideo" or unmutepts[2] == "\217\129\219\140\217\132\217\133 \216\179\217\132\217\129\219\140" then
            if database:get("bot:selfvideo:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock self video has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\219\140\217\132\217\133 \216\179\217\132\217\129\219\140 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:selfvideo:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock self video is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\219\140\217\132\217\133 \216\179\217\132\217\129\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "file" or unmutepts[2] == "\217\129\216\167\219\140\217\132" then
            if database:get("bot:document:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock file has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\216\167\219\140\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:document:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock file is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\216\167\219\140\217\132 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "game" or unmutepts[2] == "\216\168\216\167\216\178\219\140" then
            if database:get("Game:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock game has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\168\216\167\216\178\219\140 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("Game:lock" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock game is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\168\216\167\216\178\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "inline" or unmutepts[2] == "\216\175\218\169\217\133\217\135 \216\180\219\140\216\180\217\135 \216\167\219\140" then
            if database:get("bot:inline:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock inline has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\175\218\169\217\133\217\135 \216\180\219\140\216\180\217\135 \216\167\219\140 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:inline:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock inline is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\175\218\169\217\133\217\135 \216\180\219\140\216\180\217\135 \216\167\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "post" or unmutepts[2] == "\217\190\216\179\216\170" then
            if database:get("post:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock post has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\190\216\179\216\170 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("post:lock" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock post is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\190\216\179\216\170 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "markdown" or unmutepts[2] == "\217\133\216\175\217\132 \217\134\216\180\216\167\217\134\217\135 \218\175\216\176\216\167\216\177\219\140" then
            if database:get("markdown:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock markdown has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\216\175\217\132 \217\134\216\180\216\167\217\134\217\135 \218\175\216\176\216\167\216\177\219\140 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("markdown:lock" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock markdown is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\216\175\217\132 \217\134\216\180\216\167\217\134\217\135 \218\175\216\176\216\167\216\177\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "gif" or unmutepts[2] == "\218\175\219\140\217\129" then
            if database:get("bot:gifs:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock gif has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\219\140\217\129 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:gifs:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock gif is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \218\175\219\140\217\129 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "music" or unmutepts[2] == "\217\133\217\136\216\178\219\140\218\169" then
            if database:get("bot:music:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock music has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\217\136\216\178\219\140\218\169 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:music:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock music is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\217\136\216\178\219\140\218\169 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "voice" or unmutepts[2] == "\217\136\219\140\216\179" then
            if database:get("bot:voice:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock voice has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\219\140\216\179 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:voice:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock voice is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\219\140\216\179 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "links" or unmutepts[2] == "\217\132\219\140\217\134\218\169" then
            if database:get("bot:links:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock links has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\132\219\140\217\134\218\169 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:links:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock link is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\132\219\140\217\134\218\169 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "location" or unmutepts[2] == "\217\133\217\136\217\130\216\185\219\140\216\170 \217\133\218\169\216\167\217\134\219\140" then
            if database:get("bot:location:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock location has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\217\136\217\130\216\185\219\140\216\170 \217\133\218\169\216\167\217\134\219\140 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:location:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock location is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\217\136\217\130\216\185\219\140\216\170 \217\133\218\169\216\167\217\134\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "tag" or unmutepts[2] == "\216\170\218\175" then
            if database:get("tags:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock tag has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\170\218\175 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("tags:lock" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock tag is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\170\218\175 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "strict" or unmutepts[2] == "\216\173\216\167\217\132\216\170 \216\179\216\174\216\170\218\175\219\140\216\177\216\167\217\134\217\135" then
            if database:get("bot:strict" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Strict mode has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\167\217\132\216\170 [ \216\179\216\174\216\170\218\175\219\140\216\177\216\167\217\134\217\135 ] \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:strict" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Strict mode is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\167\217\132\216\170 [ \216\179\216\174\216\170\218\175\219\140\216\177\216\167\217\134\217\135 ] \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "hashtag" or unmutepts[2] == "\217\135\216\180\216\170\218\175" then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock hashtag has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\135\216\180\216\170\218\175 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:hashtag:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock hashtag is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\135\216\180\216\170\218\175 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "contact" or unmutepts[2] == "\217\133\216\174\216\167\216\183\216\168" then
            if database:get("bot:contact:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock contact has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\133\216\174\216\167\216\183\216\168 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:contact:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock contact is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, " \226\128\162 \217\130\217\129\217\132 \216\167\216\177\216\179\216\167\217\132 \217\133\216\174\216\167\216\183\216\168 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "webpage" or unmutepts[2] == "\216\181\217\129\216\173\216\167\216\170 \216\167\219\140\217\134\216\170\216\177\217\134\216\170\219\140" then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock webpage has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\177\216\179\216\167\217\132 \216\181\217\129\216\173\217\135 \216\167\219\140\217\134\216\170\216\177\217\134\216\170\219\140 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:webpage:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock webpage is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\177\216\179\216\167\217\132 \216\181\217\129\216\173\217\135 \216\167\219\140\217\134\216\170\216\177\217\134\216\170\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 !", 1, "md")
            end
          end
          if unmutept[2] == "farsi" or unmutepts[2] == "\217\134\217\136\216\180\216\170\216\167\216\177 \217\129\216\167\216\177\216\179\219\140" then
            if database:get("bot:arabic:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock farsi has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\134\217\136\216\180\216\170\216\167\216\177 \217\129\216\167\216\177\216\179\219\140 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:arabic:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock farsi is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\134\217\136\216\180\216\170\216\167\216\177 \217\129\216\167\216\177\216\179\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "joinmember" or unmutepts[2] == "\217\136\216\177\217\136\216\175 \216\185\216\182\217\136" then
            if database:get("bot:member:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock Join Member has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\216\177\217\136\216\175 \216\185\216\182\217\136 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:member:lock" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock Join Member is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\136\216\177\217\136\216\175 \216\185\216\182\217\136 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "english" or unmutepts[2] == "\217\134\217\136\216\180\216\170\216\167\216\177 \216\167\217\134\218\175\217\132\219\140\216\179\219\140" then
            if database:get("bot:english:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock english has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\134\217\136\216\180\216\170\216\167\216\177 \216\167\217\134\218\175\217\132\219\140\216\179\219\140 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:english:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock english is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\134\217\136\216\180\216\170\216\167\216\177 \216\167\217\134\218\175\217\132\219\140\216\179\219\140 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "tgservice" or unmutepts[2] == "\216\179\216\177\217\136\219\140\216\179 \216\170\217\132\218\175\216\177\216\167\217\133" then
            if database:get("bot:tgservice:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock tgservice has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\179\216\177\217\136\219\140\216\179 \216\170\217\132\218\175\216\177\216\167\217\133 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:tgservice:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "Lock tgservice is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\179\216\177\217\136\219\140\216\179 \216\170\217\132\218\175\216\177\216\167\217\133 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "sticker" or unmutepts[2] == "\216\167\216\179\216\170\219\140\218\169\216\177" then
            if database:get("bot:sticker:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock sticker has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\179\216\170\219\140\218\169\216\177 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:sticker:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock sticker is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \216\167\216\179\216\170\219\140\218\169\216\177 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
          if unmutept[2] == "fwd" or unmutepts[2] == "\217\129\216\177\217\136\216\167\216\177\216\175" then
            if database:get("bot:forward:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock forward has been *Inactived* ! ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\216\177\217\136\216\167\216\177\216\175 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\180\216\175 ! ", 1, "md")
              end
              database:del("bot:forward:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Lock forward is *Already* inactived ! ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\130\217\129\217\132 \217\129\216\177\217\136\216\167\216\177\216\175 \216\167\216\178 \217\130\216\168\217\132 \216\186\219\140\216\177\217\129\216\185\216\167\217\132 \216\167\216\179\216\170 ! ", 1, "md")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]etspam (%d+)$") and check_user_channel(msg) then
          local sensspam = {
            string.match(text, "^([Ss]etspam) (%d+)$")
          }
          if 40 > tonumber(sensspam[2]) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Enter a number *Greater* than `40` !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\185\216\175\216\175\219\140 \216\168\216\178\216\177\218\175\216\170\216\177 \216\167\216\178 40 \217\136\216\167\216\177\216\175 \218\169\217\134\219\140\216\175 !", 1, "md")
            end
          else
            database:set("bot:sens:spam" .. msg.chat_id_, sensspam[2])
            if not database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\179\216\167\216\179\219\140\216\170 \216\167\216\179\217\190\217\133 \216\168\217\135 " .. sensspam[2] .. " \218\169\216\167\216\177\216\167\218\169\216\170\216\177 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 !\n\216\172\217\133\217\132\216\167\216\170\219\140 \218\169\217\135 \216\168\219\140\216\180 \216\167\216\178 " .. sensspam[2] .. " \216\173\216\177\217\129 \216\175\216\167\216\180\216\170\217\135 \216\168\216\167\216\180\217\134\216\175 \216\140 \216\173\216\176\217\129 \216\174\217\136\216\167\217\135\217\134\216\175 \216\180\216\175 !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Spam *Sensitivity* has been set to `[" .. sensspam[2] .. [[
]` !
Sentences have over `]] .. sensspam[2] .. "` Character will Delete !", 1, "md")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^\216\170\217\134\216\184\219\140\217\133 \216\167\216\179\217\190\217\133 (%d+)$") and check_user_channel(msg) then
          local sensspam = {
            string.match(text, "^(\216\170\217\134\216\184\219\140\217\133 \216\167\216\179\217\190\217\133) (%d+)$")
          }
          if 40 > tonumber(sensspam[2]) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Enter a number *Greater* than `40` !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\185\216\175\216\175\219\140 \216\168\216\178\216\177\218\175\216\170\216\177 \216\167\216\178 40 \217\136\216\167\216\177\216\175 \218\169\217\134\219\140\216\175 !", 1, "md")
            end
          else
            database:set("bot:sens:spam" .. msg.chat_id_, sensspam[2])
            if not database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\179\216\167\216\179\219\140\216\170 \216\167\216\179\217\190\217\133 \216\168\217\135 " .. sensspam[2] .. " \218\169\216\167\216\177\216\167\218\169\216\170\216\177 \216\170\217\134\216\184\219\140\217\133 \216\180\216\175 !\n\216\172\217\133\217\132\216\167\216\170\219\140 \218\169\217\135 \216\168\219\140\216\180 \216\167\216\178 " .. sensspam[2] .. " \216\173\216\177\217\129 \216\175\216\167\216\180\216\170\217\135 \216\168\216\167\216\180\217\134\216\175 \216\140 \216\173\216\176\217\129 \216\174\217\136\216\167\217\135\217\134\216\175 \216\180\216\175 !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Spam *Sensitivity* has been set to `[" .. sensspam[2] .. [[
]` !
Sentences have over `]] .. sensspam[2] .. "` Character will Delete !", 1, "md")
            end
          end
        end
        if is_sudo(msg) and text:match("^[Ee]dit (.*)$") then
          local editmsg = {
            string.match(text, "^([Ee]dit) (.*)$")
          }
          edit(msg.chat_id_, msg.reply_to_message_id_, nil, editmsg[2], 1, "md")
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
        end
        if is_sudo(msg) and text:match("^\217\136\219\140\216\177\216\167\219\140\216\180 (.*)$") then
          local editmsgs = {
            string.match(text, "^(\217\136\219\140\216\177\216\167\219\140\216\180) (.*)$")
          }
          edit(msg.chat_id_, msg.reply_to_message_id_, nil, editmsgs[2], 1, "md")
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and (text:match("^[Cc]lean (.*)$") or text:match("^\217\190\216\167\218\169\216\179\216\167\216\178\219\140 (.*)$")) and check_user_channel(msg) then
          local txt = {
            string.match(text, "^([Cc]lean) (.*)$")
          }
          local txts = {
            string.match(text, "^(\217\190\216\167\218\169\216\179\216\167\216\178\219\140) (.*)$")
          }
          if txt[2] == "banlist" or txts[2] == "\217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \217\133\216\179\216\175\217\136\216\175" and idf:match("-100(%d+)") then
            database:del("bot:banned:" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Banlist* Has Been Cleared !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \217\133\216\179\216\175\217\136\216\175 \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 !", 1, "md")
            end
          end
          if is_sudo(msg) and (txt[2] == "banalllist" or txts[2] == "\217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \216\170\216\173\216\170 \217\133\216\179\216\175\217\136\216\175\219\140\216\170") then
            database:del("bot:gban:")
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Banalllist* Has Been Cleared !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \216\170\216\173\216\170 \217\133\216\179\216\175\217\136\216\175\219\140\216\170 \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 !", 1, "md")
            end
          end
          if is_momod(msg.sender_user_id_, msg.chat_id_) and (txt[2] == "msgs" or txts[2] == "\217\190\219\140\216\167\217\133 \217\135\216\167" and idf:match("-100(%d+)")) then
            if not database:get("clean:msgs" .. msg.chat_id_) or is_admin(msg.sender_user_id_) then
              local hash = "groups:users" .. msg.chat_id_
              local list = database:smembers(hash)
              if list then
                for k, v in pairs(list) do
                  del_all_msgs(msg.chat_id_, v)
                end
              end
              local J = 0
              for i = 1, 7 do
                getChatHistory(msg.chat_id_, msg.chat_id_, J, 100, delmsg)
                J = J + 100
              end
              database:setex("clean:msgs" .. msg.chat_id_, 9 * hour, true)
            else
              local ex = database:ttl("clean:msgs" .. msg.chat_id_)
              local d = math.floor(ex / hour) + 1
              if not database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 " .. d .. " \216\179\216\167\216\185\216\170 \216\175\219\140\218\175\216\177 \216\167\216\178 \216\167\219\140\217\134 \216\175\216\179\216\170\217\136\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Use* This Command In " .. d .. " Hours !", 1, "md")
              end
            end
          end
          if txt[2] == "deleted" or txts[2] == "\216\175\217\132\219\140\216\170 \216\167\218\169\216\167\217\134\216\170 \217\135\216\167" and idf:match("-100(%d+)") then
            local deletedlist = function(extra, result)
              local list = result.members_
              for i = 0, #list do
                local cleandeleted = function(extra, result)
                  if not result.first_name_ and not result.last_name_ then
                    chat_kick(msg.chat_id_, result.id_)
                  end
                end
                getUser(list[i].user_id_, cleandeleted)
              end
            end
            local d = 0
            for i = 1, NumberReturn do
              getChannelMembers(msg.chat_id_, d, "Recent", 200, deletedlist)
              d = d + 200
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 All *Delete Account* has been *Removed* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \216\175\217\132\219\140\216\170 \216\167\218\169\216\167\217\134\216\170\219\140 \217\135\216\167\219\140 \218\175\216\177\217\136\217\135 \216\173\216\176\217\129 \216\180\216\175\217\134\216\175 !", 1, "html")
            end
          end
          if txt[2] == "blocked" or txts[2] == "\217\133\216\179\216\175\217\136\216\175\219\140\216\170 \218\175\216\177\217\136\217\135" and idf:match("-100(%d+)") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 If You Want Cleaning Group Blocked List, Send The Number 1 !\nElseif You Want Inviteing Group Blocked List, Send The Number 2 !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\167\218\175\216\177 \217\130\216\181\216\175 \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \217\132\219\140\216\179\216\170 \217\133\216\179\216\175\217\136\216\175\219\140\216\170 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\175\216\167\216\177\219\140\216\175 \216\140 \216\185\216\175\216\175 1 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !\n\219\140\216\167 \216\167\218\175\216\177 \217\130\216\181\216\175 \216\175\216\185\217\136\216\170 \218\169\216\177\216\175\217\134 \217\132\219\140\216\179\216\170 \217\133\216\179\216\175\217\136\216\175\219\140\216\170 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\175\216\167\216\177\219\140\216\175 \216\140 \216\185\216\175\216\175 2 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
            end
            database:setex("CleanBlockList" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 35, true)
          end
          if is_sudo(msg) and (txt[2] == "members" or txts[2] == "\216\167\216\185\216\182\216\167" and idf:match("-100(%d+)")) then
            do
              local checkclean = function(user_id)
                local var = false
                if is_admin(user_id) then
                  var = true
                end
                if tonumber(user_id) == tonumber(our_id) then
                  var = true
                end
                return var
              end
              local hash = "groups:users" .. msg.chat_id_
              local list = database:smembers(hash)
              if list then
                for k, v in pairs(list) do
                  if not checkclean(v) then
                    chat_kick(msg.chat_id_, v)
                  end
                end
              end
              local cleanmember = function(extra, result)
                local list = result.members_
                for i = 0, #list do
                  if not checkclean(list[i].user_id_) then
                    chat_kick(msg.chat_id_, list[i].user_id_)
                  end
                end
              end
              local d = 0
              for i = 1, 5 do
                getChannelMembers(msg.chat_id_, d, "Recent", 200, cleanmember)
                d = d + 200
              end
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 All *Members* has been *Removed* !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \216\167\216\185\216\182\216\167\219\140 \218\175\216\177\217\136\217\135 \216\173\216\176\217\129 \216\180\216\175\217\134\216\175 !", 1, "html")
              end
            end
          else
          end
          if txt[2] == "bots" or txts[2] == "\216\177\216\168\216\167\216\170 \217\135\216\167" and idf:match("-100(%d+)") then
            local botslist = function(extra, result)
              local list = result.members_
              for i = 0, #list do
                chat_kick(msg.chat_id_, list[i].user_id_)
              end
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 All *Bots* has been *Removed* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \216\177\216\168\216\167\216\170 \217\135\216\167\219\140 \218\175\216\177\217\136\217\135 \216\173\216\176\217\129 \216\180\216\175\217\134\216\175 !", 1, "md")
            end
            getChannelMembers(msg.chat_id_, 0, "Bots", 200, botslist)
          end
          if is_owner(msg.sender_user_id_, msg.chat_id_) and (txt[2] == "modlist" or txts[2] == "\217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\216\167\217\134 \218\175\216\177\217\136\217\135" and idf:match("-100(%d+)")) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Modlist* has been Cleared !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\216\167\217\134 \218\175\216\177\217\136\217\135 \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 !", 1, "md")
            end
            database:del("bot:momod:" .. msg.chat_id_)
          end
          if txt[2] == "ownerlist" or txts[2] == "\217\132\219\140\216\179\216\170 \216\181\216\167\216\173\216\168\216\167\217\134 \218\175\216\177\217\136\217\135" and idf:match("-100(%d+)") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Owner List* has been Cleared !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\216\179\216\170 \216\181\216\167\216\173\216\168\216\167\217\134 \218\175\216\177\217\136\217\135 \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 !", 1, "md")
            end
            database:del("bot:owners:" .. msg.chat_id_)
          end
          if is_leader(msg) and (txt[2] == "sudolist" or txts[2] == "\217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\216\167\217\134 \216\177\216\168\216\167\216\170") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Sudo List* has been Cleared !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\216\167\217\134 \216\177\216\168\216\167\216\170 \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 !", 1, "md")
            end
            local hash = "Bot:SudoUsers"
            local list = database:smembers(hash)
            for k, v in pairs(list) do
              local t = tonumber(v)
              table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, t))
              save_on_config()
            end
            database:del("Bot:SudoUsers")
            SetRankStatus("SetAll", nil)
          end
          if is_leader(msg) and (txt[2] == "adminlist" or txts[2] == "\217\132\219\140\216\179\216\170 \216\167\216\175\217\133\219\140\217\134 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Admin List* has been Cleared !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\216\175\217\133\219\140\217\134 \217\135\216\167\219\140 \216\177\216\168\216\167\216\170 \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 !", 1, "md")
            end
            database:del("Bot:Admins")
            SetRankStatus("SetAll", nil)
          end
          if txt[2] == "viplist" or txts[2] == "\217\132\219\140\216\179\216\170 \216\185\216\182\217\136 \217\135\216\167\219\140 \217\136\219\140\218\152\217\135" and idf:match("-100(%d+)") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *VIP Members* list has been Cleared !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\216\185\216\182\216\167\219\140 \217\136\219\140\218\152\217\135 \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 !", 1, "md")
            end
            database:del("bot:vipmem:" .. msg.chat_id_)
          end
          if txt[2] == "filterlist" or txts[2] == "\217\132\219\140\216\179\216\170 \217\129\219\140\217\132\216\170\216\177" and idf:match("-100(%d+)") then
            local hash = "bot:filters:" .. msg.chat_id_
            database:del(hash)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Filterlist* has been Cleared !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\216\179\216\170 \218\169\217\132\217\133\216\167\216\170 \217\129\219\140\217\132\216\170\216\177 \216\180\216\175\217\135 \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 !", 1, "md")
            end
          end
          if txt[2] == "mutelist" or txts[2] == "\217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \216\168\219\140 \216\181\216\175\216\167" and idf:match("-100(%d+)") then
            database:del("bot:muted:" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 *MutedUsers* list has been Cleared !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\219\140\216\179\216\170 \216\167\217\129\216\177\216\167\216\175 \216\168\219\140 \216\181\216\175\216\167 \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 !", 1, "md")
            end
          end
        end
        local kickedlist = function(extra, result)
          local list = result.members_
          for i = 0, #list do
            chat_leave(msg.chat_id_, list[i].user_id_)
          end
        end
        local kickedlist2 = function(extra, result)
          local list = result.members_
          for i = 0, #list do
            add_user(msg.chat_id_, list[i].user_id_, 5)
          end
        end
        if database:get("CleanBlockList" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
          local d = 0
          if text:match("^1$") then
            database:del("CleanBlockList" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            for i = 1, NumberReturn do
              getChannelMembers(msg.chat_id_, d, "Kicked", 200, kickedlist)
              d = d + 200
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 All *Removed User* has been *Released* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \218\169\216\167\216\177\216\168\216\177\216\167\217\134 \217\133\216\179\216\175\217\136\216\175 \218\175\216\177\217\136\217\135 \216\162\216\178\216\167\216\175 \216\180\216\175\217\134\216\175 !", 1, "md")
            end
          elseif text:match("^2$") then
            database:del("CleanBlockList" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            for i = 1, NumberReturn do
              getChannelMembers(msg.chat_id_, d, "Kicked", 200, kickedlist2)
              d = d + 200
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 All *Removed User* has been *Invited* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \218\169\216\167\216\177\216\168\216\177\216\167\217\134 \217\133\216\179\216\175\217\136\216\175 \218\175\216\177\217\136\217\135 \216\140 \216\175\216\185\217\136\216\170 \216\180\216\175\217\134\216\175 !", 1, "md")
            end
          end
        end
       if is_momod(msg.sender_user_id_, msg.chat_id_) and (text:match("^[Ss]ettings") or text:match("^تنظیمات")) then
          if database:get("bot:muteall" .. msg.chat_id_) then
            mute_all = "فعال"
          else
            mute_all = "غیرفعال"
          end
          if database:get("bot:text:mute" .. msg.chat_id_) then
            mute_text = "فعال"
          else
            mute_text = "غیرفعال"
          end
          if database:get("bot:photo:mute" .. msg.chat_id_) then
            mute_photo = "فعال"
          else
            mute_photo = "غیرفعال"
          end
          if database:get("bot:video:mute" .. msg.chat_id_) then
            mute_video = "فعال"
          else
            mute_video = "غیرفعال"
          end
          if database:get("bot:selfvideo:mute" .. msg.chat_id_) then
            mute_selfvideo = "فعال"
          else
            mute_selfvideo = "غیرفعال"
          end
          if database:get("bot:gifs:mute" .. msg.chat_id_) then
            mute_gifs = "فعال"
          else
            mute_gifs = "غیرفعال"
          end
          if database:get("anti-flood:" .. msg.chat_id_) then
            mute_flood = "فعال"
          else
            mute_flood = "غیرفعال"
          end
          if database:get("bot:muteall:Time" .. msg.chat_id_) then
            auto_lock = "فعال"
          else
            auto_lock = "غیرفعال"
          end
          if not database:get("flood:max:" .. msg.chat_id_) then
            flood_m = 5
          else
            flood_m = database:get("flood:max:" .. msg.chat_id_)
          end
          if not database:get("bot:sens:spam" .. msg.chat_id_) then
            spam_c = 400
          else
            spam_c = database:get("bot:sens:spam" .. msg.chat_id_)
          end
          if database:get("warn:max:" .. msg.chat_id_) then
            sencwarn = tonumber(database:get("warn:max:" .. msg.chat_id_))
          else
            sencwarn = 4
          end
          if database:get("floodstatus" .. msg.chat_id_) == "DelMsg" then
            floodstatus = "حذف پیام"
          elseif database:get("floodstatus" .. msg.chat_id_) == "Kicked" then
            floodstatus = "اخراج"
          elseif not database:get("floodstatus" .. msg.chat_id_) then
            floodstatus = "بی صدا"
          end
          if database:get("warnstatus" .. msg.chat_id_) == "Muteuser" then
            warnstatus = "بی صدا"
          elseif database:get("warnstatus" .. msg.chat_id_) == "Remove" then
            warnstatus = "اخراج"
          elseif not database:get("warnstatus" .. msg.chat_id_) then
            warnstatus = "بی صدا"
          end
          if database:get("bot:music:mute" .. msg.chat_id_) then
            mute_music = "فعال"
          else
            mute_music = "غیرفعال"
          end
          if database:get("bot:bots:mute" .. msg.chat_id_) then
            mute_bots = "فعال"
          else
            mute_bots = "غیرفعال"
          end
          if database:get("bot:duplipost:mute" .. msg.chat_id_) then
            duplipost = "فعال"
          else
            duplipost = "غیرفعال"
          end
          if database:get("bot:member:lock" .. msg.chat_id_) then
            member = "فعال"
          else
            member = "غیرفعال"
          end
          if database:get("bot:inline:mute" .. msg.chat_id_) then
            mute_in = "فعال"
          else
            mute_in = "غیرفعال"
          end
          if database:get("bot:cmds" .. msg.chat_id_) then
            mute_cmd = "فعال"
          else
            mute_cmd = "غیرفعال"
          end
          if database:get("bot:voice:mute" .. msg.chat_id_) then
            mute_voice = "فعال"
          else
            mute_voice = "غیرفعال"
          end
          if database:get("editmsg" .. msg.chat_id_) then
            mute_edit = "فعال"
          else
            mute_edit = "غیرفعال"
          end
          if database:get("bot:links:mute" .. msg.chat_id_) then
            mute_links = "فعال"
          else
            mute_links = "غیرفعال"
          end
          if database:get("bot:pin:mute" .. msg.chat_id_) then
            lock_pin = "فعال"
          else
            lock_pin = "غیرفعال"
          end
          if database:get("bot:sticker:mute" .. msg.chat_id_) then
            lock_sticker = "فعال"
          else
            lock_sticker = "غیرفعال"
          end
          if database:get("bot:tgservice:mute" .. msg.chat_id_) then
            lock_tgservice = "فعال"
          else
            lock_tgservice = "غیرفعال"
          end
          if database:get("bot:webpage:mute" .. msg.chat_id_) then
            lock_wp = "فعال"
          else
            lock_wp = "غیرفعال"
          end
          if database:get("bot:strict" .. msg.chat_id_) then
            strict = "فعال"
          else
            strict = "غیرفعال"
          end
          if database:get("bot:hashtag:mute" .. msg.chat_id_) then
            lock_htag = "فعال"
          else
            lock_htag = "غیرفعال"
          end
          if database:get("tags:lock" .. msg.chat_id_) then
            lock_tag = "فعال"
          else
            lock_tag = "غیرفعال"
          end
          if database:get("bot:location:mute" .. msg.chat_id_) then
            lock_location = "فعال"
          else
            lock_location = "غیرفعال"
          end
          if database:get("bot:contact:mute" .. msg.chat_id_) then
            lock_contact = "فعال"
          else
            lock_contact = "غیرفعال"
          end
          if database:get("bot:english:mute" .. msg.chat_id_) then
            lock_english = "فعال"
          else
            lock_english = "غیرفعال"
          end
          if database:get("bot:arabic:mute" .. msg.chat_id_) then
            lock_arabic = "فعال"
          else
            lock_arabic = "غیرفعال"
          end
          if database:get("bot:forward:mute" .. msg.chat_id_) then
            lock_forward = "فعال"
          else
            lock_forward = "غیرفعال"
          end
          if database:get("bot:document:mute" .. msg.chat_id_) then
            lock_file = "فعال"
          else
            lock_file = "غیرفعال"
          end
          if database:get("markdown:lock" .. msg.chat_id_) then
            markdown = "فعال"
          else
            markdown = "غیرفعال"
          end
          if database:get("Game:lock" .. msg.chat_id_) then
            game = "فعال"
          else
            game = "غیرفعال"
          end
          if database:get("bot:spam:mute" .. msg.chat_id_) then
            lock_spam = "فعال"
          else
            lock_spam = "غیرفعال"
          end
          if database:get("post:lock" .. msg.chat_id_) then
            post = "فعال"
          else
            post = "غیرفعال"
          end
          if database:get("bot:welcome" .. msg.chat_id_) then
            send_welcome = "فعال"
          else
            send_welcome = "غیرفعال"
          end
          local TXTFA = "•• تنظیمات گروه :\n\n" .. " ••  حالت های گروه :\n\n" .. "• حالت سختگیرانه : " .. strict .. "\n" .. "______________________\n" .. "• حالت قفل کلی گروه : " .. mute_all .. "\n" .. "______________________\n" .. "• حالت عدم جواب : " .. mute_cmd .. "\n" .. "______________________\n" .. "• حالت قفل خودکار : " .. auto_lock .. "\n" .. "______________________\n" .. "•• قفل های اصلی :\n\n" .. "• قفل اسپم : " .. lock_spam .. "\n" .. "______________________\n" .. "• قفل لینک : " .. mute_links .. "\n" .. "______________________\n" .. "• قفل آدرس اینترنتی :  " .. lock_wp .. "\n" .. "______________________\n" .. "• قفل تگ (@) : " .. lock_tag .. "\n" .. "______________________\n" .. "• قفل هشتگ (#) : " .. lock_htag .. "\n" .. "______________________\n" .. "• قفل فروارد : " .. lock_forward .. "\n" .. "______________________\n" .. "• قفل پست تکراری : " .. duplipost .. "\n" .. "______________________\n" .. "• قفل ورود ربات :  " .. mute_bots .. "\n" .. "______________________\n" .. "• قفل ویرایش پیام :  " .. mute_edit .. "\n" .. "______________________\n" .. "• قفل سنجاق پیام : " .. lock_pin .. "\n" .. "______________________\n" .. "• قفل دکمه شیشه ایی : " .. mute_in .. "\n" .. "______________________\n" .. "• قفل نوشتار فارسی :  " .. lock_arabic .. "\n" .. "______________________\n" .. "• قفل نوشتار انگلیسی : " .. lock_english .. "\n" .. "______________________\n" .. "• قفل مدل نشانه گذاری : " .. markdown .. "\n" .. "______________________\n" .. "• قفل پست : " .. post .. "\n" .. "______________________\n" .. "• قفل بازی : " .. game .. "\n" .. "______________________\n" .. "• قفل ورود عضو : " .. member .. "\n" .. "______________________\n" .. "• قفل سرویس تلگرام : " .. lock_tgservice .. "\n" .. "______________________\n" .. "• قفل فلود : " .. mute_flood .. "\n" .. "______________________\n" .. "• وضعیت فلود : " .. floodstatus .. "\n" .. "______________________\n" .. "• حساسیت فلود : [ " .. flood_m .. " ]\n" .. "______________________\n" .. "• وضعیت اخطار : " .. warnstatus .. "\n" .. "______________________\n" .. "• تعداد دفعات اخطار : [ " .. sencwarn .. " ]\n" .. "______________________\n" .. "• حساسیت اسپم : [ " .. spam_c .. [[
 ]

]] .. "______________________\n" .. "  ••  قفل های رسانه :\n\n" .. "• قفل متن [ چت ] : " .. mute_text .. "\n" .. "______________________\n" .. "• قفل عکس : " .. mute_photo .. "\n" .. "______________________\n" .. "• قفل فیلم : " .. mute_video .. "\n" .. "______________________\n" .. "• قفل فیلم سلفی : " .. mute_selfvideo .. "\n" .. "______________________\n" .. "• قفل گیف: " .. mute_gifs .. "\n" .. "______________________\n" .. "• قفل موزیک : " .. mute_music .. "\n" .. "______________________\n" .. "• قفل ویس : " .. mute_voice .. "\n" .. "______________________\n" .. "• قفل فایل : " .. lock_file .. "\n" .. "______________________\n" .. "• قفل استیکر : " .. lock_sticker .. "\n" .. "______________________\n" .. "• قفل ارسال مخاطب : " .. lock_contact .. "\n" .. "______________________\n" .. "• قفل موقعیت مکانی : " .. lock_location .. "\n" .. "______________________\n"
          local TXTFAMode = " ••  \216\170\217\134\216\184\219\140\217\133\216\167\216\170 \216\173\216\167\217\132\216\170 \218\175\216\177\217\136\217\135 :\n\n" .. "• \216\173\216\167\217\132\216\170 \216\179\216\174\216\170\218\175\219\140\216\177\216\167\217\134\217\135 : " .. strict .. "\n" .. "______________________\n" .. "• \216\173\216\167\217\132\216\170 \217\130\217\129\217\132 \218\169\217\132\219\140 \218\175\216\177\217\136\217\135 : " .. mute_all .. "\n" .. "______________________\n" .. "• \216\173\216\167\217\132\216\170 \216\185\216\175\217\133 \216\172\217\136\216\167\216\168 : " .. mute_cmd .. "\n" .. "______________________\n" .. "• \216\173\216\167\217\132\216\170 \217\130\217\129\217\132 \216\174\217\136\216\175\218\169\216\167\216\177 : " .. auto_lock .. "\n"
          local TXTFACent = "••  \216\170\217\134\216\184\219\140\217\133\216\167\216\170 \216\167\216\181\217\132\219\140 :\n\n" .. "• \217\130\217\129\217\132 \216\167\216\179\217\190\217\133 : " .. lock_spam .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\132\219\140\217\134\218\169 : " .. mute_links .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \216\162\216\175\216\177\216\179 \216\167\219\140\217\134\216\170\216\177\217\134\216\170\219\140 :  " .. lock_wp .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \216\170\218\175 (@) : " .. lock_tag .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\135\216\180\216\170\218\175 (#) : " .. lock_htag .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\129\216\177\217\136\216\167\216\177\216\175 : " .. lock_forward .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\190\216\179\216\170 \216\170\218\169\216\177\216\167\216\177\219\140 : " .. duplipost .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\136\216\177\217\136\216\175 \216\177\216\168\216\167\216\170 :  " .. mute_bots .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\136\219\140\216\177\216\167\219\140\216\180 \217\190\219\140\216\167\217\133 :  " .. mute_edit .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \216\179\217\134\216\172\216\167\217\130 \217\190\219\140\216\167\217\133 : " .. lock_pin .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \216\175\218\169\217\133\217\135 \216\180\219\140\216\180\217\135 \216\167\219\140 : " .. mute_in .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\134\217\136\216\180\216\170\216\167\216\177 \217\129\216\167\216\177\216\179\219\140 :  " .. lock_arabic .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\134\217\136\216\180\216\170\216\167\216\177 \216\167\217\134\218\175\217\132\219\140\216\179\219\140 : " .. lock_english .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\133\216\175\217\132 \217\134\216\180\216\167\217\134\217\135 \218\175\216\176\216\167\216\177\219\140 : " .. markdown .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\190\216\179\216\170 : " .. post .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \216\168\216\167\216\178\219\140 : " .. game .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\136\216\177\217\136\216\175 \216\185\216\182\217\136 : " .. member .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \216\179\216\177\217\136\219\140\216\179 \216\170\217\132\218\175\216\177\216\167\217\133 : " .. lock_tgservice .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\129\217\132\217\136\216\175 : " .. mute_flood .. "\n" .. "______________________\n" .. "• \217\136\216\182\216\185\219\140\216\170 \217\129\217\132\217\136\216\175 : " .. floodstatus .. "\n" .. "______________________\n" .. "• \216\173\216\179\216\167\216\179\219\140\216\170 \217\129\217\132\217\136\216\175 : [ " .. flood_m .. " ]\n" .. "______________________\n" .. "• \217\136\216\182\216\185\219\140\216\170 \216\167\216\174\216\183\216\167\216\177 : " .. warnstatus .. "\n" .. "______________________\n" .. "• \216\170\216\185\216\175\216\167\216\175 \216\175\217\129\216\185\216\167\216\170 \216\167\216\174\216\183\216\167\216\177 : [ " .. sencwarn .. " ]\n" .. "______________________\n" .. "\239\184\143• \216\173\216\179\216\167\216\179\219\140\216\170 \216\167\216\179\217\190\217\133 : [ " .. spam_c .. " ]\n"
          local TXTFAMedia = " ••  \216\170\217\134\216\184\219\140\217\133\216\167\216\170 \216\177\216\179\216\167\217\134\217\135 :\n\n" .. "• \217\130\217\129\217\132 \217\133\216\170\217\134 [ \218\134\216\170 ] : " .. mute_text .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \216\185\218\169\216\179 : " .. mute_photo .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\129\219\140\217\132\217\133 : " .. mute_video .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\129\219\140\217\132\217\133 \216\179\217\132\217\129\219\140 : " .. mute_selfvideo .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \218\175\219\140\217\129 : " .. mute_gifs .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\133\217\136\216\178\219\140\218\169 : " .. mute_music .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\136\219\140\216\179 : " .. mute_voice .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\129\216\167\219\140\217\132 : " .. lock_file .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \216\167\216\179\216\170\219\140\218\169\216\177 : " .. lock_sticker .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \216\167\216\177\216\179\216\167\217\132 \217\133\216\174\216\167\216\183\216\168 : " .. lock_contact .. "\n" .. "______________________\n" .. "• \217\130\217\129\217\132 \217\133\217\136\217\130\216\185\219\140\216\170 \217\133\218\169\216\167\217\134\219\140 : " .. lock_location .. "\n"
          local TXTEN = "•• Group Settings :\n\n" .. " ••  *Group Mode* :\n\n" .. "• *Strict Mode* : " .. strict .. "\n" .. "______________________\n" .. "• *Group Lock All* : " .. mute_all .. "\n" .. "______________________\n" .. "• *Case Of No Answer* : " .. mute_cmd .. "\n" .. "______________________\n" .. "• *Auto-lock Mode* : " .. auto_lock .. "\n" .. "______________________\n" .. "••  *Centerial Settings* :\n\n" .. "• *Lock Spam* : " .. lock_spam .. "\n" .. "______________________\n" .. "• *Lock Links* : " .. mute_links .. "\n" .. "______________________\n" .. "• *Lock Web-Page* :  " .. lock_wp .. "\n" .. "______________________\n" .. "• *Lock Tag (@)* : " .. lock_tag .. "\n" .. "______________________\n" .. "• *Lock Hashtag (#)* : " .. lock_htag .. "\n" .. "______________________\n" .. "• *Lock Forward* : " .. lock_forward .. "\n" .. "______________________\n" .. "• *Lock Dupli Post* : " .. duplipost .. "\n" .. "______________________\n" .. "• *Lock Bots* :  " .. mute_bots .. "\n" .. "______________________\n" .. "• *Lock Edit* :  " .. mute_edit .. "\n" .. "______________________\n" .. "• *Lock Pin* : " .. lock_pin .. "\n" .. "______________________\n" .. "• *Lock Inline* : " .. mute_in .. "\n" .. "______________________\n" .. "• *Lock Farsi* :  " .. lock_arabic .. "\n" .. "______________________\n" .. "• *Lock English* : " .. lock_english .. "\n" .. "______________________\n" .. "• *Lock MarkDown* : " .. markdown .. "\n" .. "______________________\n" .. "• *Lock Post* : " .. post .. "\n" .. "______________________\n" .. "• *Lock Game* : " .. game .. "\n" .. "______________________\n" .. "• *Lock Member* : " .. member .. "\n" .. "______________________\n" .. "• *Lock TgService* : " .. lock_tgservice .. "\n" .. "______________________\n" .. "• *Lock Flood* : " .. mute_flood .. "\n" .. "______________________\n" .. "• *Flood Status* : " .. floodstatus .. "\n" .. "______________________\n" .. "• *Flood Sensitivity* : `[" .. flood_m .. "]`\n" .. "______________________\n" .. "• *Warn Status* : " .. warnstatus .. "\n" .. "______________________\n" .. "• *Number Warn* : `[" .. sencwarn .. "]`\n" .. "______________________\n" .. "• *Spam Sensitivity* : `[" .. spam_c .. [[
]`

]] .. " ••  *Media Settings* :\n\n" .. "• *Lock Text* : " .. mute_text .. "\n" .. "______________________\n" .. "• *Lock Photo* : " .. mute_photo .. "\n" .. "______________________\n" .. "• *Lock Videos* : " .. mute_video .. "\n" .. "______________________\n" .. "• *Lock Self Videos* : " .. mute_selfvideo .. "\n" .. "______________________\n" .. "• *Lock Gifs* : " .. mute_gifs .. "\n" .. "______________________\n" .. "• *Lock Music* : " .. mute_music .. "\n" .. "______________________\n" .. "• *Lock Voice* : " .. mute_voice .. "\n" .. "______________________\n" .. "• *Lock File* : " .. lock_file .. "\n" .. "______________________\n" .. "• *Lock Sticker* : " .. lock_sticker .. "\n" .. "______________________\n" .. "• *Lock Contact* : " .. lock_contact .. "\n" .. "______________________\n" .. "• *Lock Location* : " .. lock_location .. "\n"
          local TXTENMode = "•• Group Settings :\n\n" .. " ••  *Group Mode* :\n\n" .. "• *Strict Mode* : " .. strict .. "\n" .. "______________________\n" .. "• *Group Lock All* : " .. mute_all .. "\n" .. "______________________\n" .. "• *Case Of No Answer* : " .. mute_cmd .. "\n" .. "______________________\n" .. "• *Auto-lock Mode* : " .. auto_lock .. "\n"
          local TXTENCent = "••  *Centerial Settings* :\n\n" .. "• *Lock Spam* : " .. lock_spam .. "\n" .. "______________________\n" .. "• *Lock Links* : " .. mute_links .. "\n" .. "______________________\n" .. "• *Lock Web-Page* :  " .. lock_wp .. "\n" .. "______________________\n" .. "• *Lock Tag (@)* : " .. lock_tag .. "\n" .. "______________________\n" .. "• *Lock Hashtag (#)* : " .. lock_htag .. "\n" .. "______________________\n" .. "• *Lock Forward* : " .. lock_forward .. "\n" .. "______________________\n" .. "• *Lock Duplicate Post* : " .. duplipost .. "\n" .. "______________________\n" .. "• *Lock Bots* :  " .. mute_bots .. "\n" .. "______________________\n" .. "• *Lock Edit* :  " .. mute_edit .. "\n" .. "______________________\n" .. "• *Lock Pin* : " .. lock_pin .. "\n" .. "______________________\n" .. "• *Lock Inline* : " .. mute_in .. "\n" .. "______________________\n" .. "• *Lock Farsi* :  " .. lock_arabic .. "\n" .. "______________________\n" .. "• *Lock English* : " .. lock_english .. "\n" .. "______________________\n" .. "• *Lock MarkDown* : " .. markdown .. "\n" .. "______________________\n" .. "• *Lock Post* : " .. post .. "\n" .. "______________________\n" .. "• *Lock Game* : " .. game .. "\n" .. "______________________\n" .. "• *Lock Join Member* : " .. member .. "\n" .. "______________________\n" .. "• *Lock TgService* : " .. lock_tgservice .. "\n" .. "______________________\n" .. "• *Lock Flood* : " .. mute_flood .. "\n" .. "______________________\n" .. "• *Flood Status* : " .. floodstatus .. "\n" .. "______________________\n" .. "• *Flood Sensitivity* : `[" .. flood_m .. "]`\n" .. "______________________\n" .. "• *Warn Status* : " .. warnstatus .. "\n" .. "______________________\n" .. "• *Number Warn* : `[" .. sencwarn .. "]`\n" .. "______________________\n" .. "• *Spam Sensitivity* : `[" .. spam_c .. "]`\n"
          local TXTENMedia = " ••  *Media Settings* :\n\n" .. "• *Lock Text* : " .. mute_text .. "\n" .. "______________________\n" .. "• *Lock Photo* : " .. mute_photo .. "\n" .. "______________________\n" .. "• *Lock Videos* : " .. mute_video .. "\n" .. "______________________\n" .. "• *Lock Self Videos* : " .. mute_selfvideo .. "\n" .. "______________________\n" .. "• *Lock Gifs* : " .. mute_gifs .. "\n" .. "______________________\n" .. "• *Lock Music* : " .. mute_music .. "\n" .. "______________________\n" .. "• *Lock Voice* : " .. mute_voice .. "\n" .. "______________________\n" .. "• *Lock File* : " .. lock_file .. "\n" .. "______________________\n" .. "• *Lock Sticker* : " .. lock_sticker .. "\n" .. "______________________\n" .. "• *Lock Contact* : " .. lock_contact .. "\n" .. "______________________\n" .. "• *Lock Location* : " .. lock_location .. "\n"
          TXTEN = TXTEN:gsub("غیرفعال", "`Inactive`")
          TXTEN = TXTEN:gsub("فعال", "`Active`")
          TXTEN = TXTEN:gsub("حذف پیام", "`Deleting`")
          TXTEN = TXTEN:gsub("اخراج", "`Kicking`")
          TXTEN = TXTEN:gsub("بی صدا", "`Mute`")
          TXTENCent = TXTENCent:gsub("غیرفعال", "`Inactive`")
          TXTENCent = TXTENCent:gsub("فعال", "`Active`")
          TXTENCent = TXTENCent:gsub("حدف پیام", "`Deleting`")
          TXTENCent = TXTENCent:gsub("اخراج", "`Kicking`")
          TXTENCent = TXTENCent:gsub("بی صدا", "`Mute`")
          TXTENMode = TXTENMode:gsub("غیرفعال", "`Inactive`")
          TXTENMode = TXTENMode:gsub("فعال", "`Active`")
          TXTENMode = TXTENMode:gsub("حذف پیام", "`Deleting`")
          TXTENMode = TXTENMode:gsub("اخراج", "`Kicking`")
          TXTENMode = TXTENMode:gsub("بی صدا", "`Mute`")
          TXTENMedia = TXTENMedia:gsub("غیرفعال", "`Inactive`")
          TXTENMedia = TXTENMedia:gsub("فعال", "`Active`")
          TXTENMedia = TXTENMedia:gsub("حذف پیام", "`Deleting`")
          TXTENMedia = TXTENMedia:gsub("اخراج", "`Kicking`")
          TXTENMedia = TXTENMedia:gsub("بی صدا", "`Mute`")
          if text:match("^[Ss]ettings all$") or text:match("^تنظیمات کلی$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, TXTEN, 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, TXTFA, 1, "md")
            end
          elseif text:match("^[Ss]ettings mode$") or text:match("^تنظیمات حالت ها$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, TXTENMode, 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, TXTFAMode, 1, "md")
            end
          elseif text:match("^[Ss]ettings cent$") or text:match("^تنظیمات اصلی$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, TXTENCent, 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, TXTFACent, 1, "md")
            end
          elseif text:match("^[Ss]ettings media$") or text:match("^تنظیمات رسانه$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, TXTENMedia, 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, TXTFAMedia, 1, "md")
            end
          elseif text:match("^[Ss]ettings$") or text:match("^تنظیمات$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "• Please *Specify* The Application To Display !\n\n•• *Instructions Guide* :\n\n> For *Show* Mode Settings :\n\n *Settings mode*\n\n> For *Show* Centerial Settings :\n\n *Settings cent*\n\n> For *Show* Media Settings :\n\n *Settings media*\n\n> For *Show* All Settings :\n\n *Settings all*", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, [[• لطفا قسمت درخواستی برای نمایش را مشخص نمایید !

•• راهنمای دستورات :

> برای نمایش تنظیمات حالت های گروه :

 تنظیمات حالت ها

 > برای نمایش تنظیمات قفل های اصلی :

 تنظیمات اصلی

> برای نمایش قفل های رسانه :

 تنظیمات رسانه

> برای نمایش کل تنظیمات :

 تنظیمات کلی]], 1, "md")
            end
          elseif (text:match("^[Ss]ettingspv$") or text:match("^تنظیمات پی وی$")) and is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "• *Settings* has been *Sent* to your Pv !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "• تنظیمات گروه به خصوصی شما ارسال شد !", 1, "md")
            end
            send(msg.sender_user_id_, msg.id_, 1, TXTFA, 1, "md")
          end
        end
if is_momod(msg.sender_user_id_, msg.chat_id_) and (text:match("^[Mm]enu$") or text:match("^\217\129\217\135\216\177\216\179\216\170$")) and check_user_channel(msg) then
          local BotApi = tonumber(database:get("Bot:Api_ID"))
          if database:get("lang:gp:" .. msg.chat_id_) then
            ln = "En"
          else
            ln = "Fa"
          end
          local menu = function(extra, result)
            if result.inline_query_id_ then
              tdcli_function({
                ID = "SendInlineQueryResultMessage",
                chat_id_ = msg.chat_id_,
                reply_to_message_id_ = msg.id_,
                disable_notification_ = 0,
                from_background_ = 1,
                query_id_ = result.inline_query_id_,
                result_id_ = result.results_[0].id_
              }, dl_cb, nil)
              database:setex("ReqMenu:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 130, true)
            elseif not database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\133\216\180\218\169\217\132 \217\129\217\134\219\140 \216\175\216\177 \216\177\216\168\216\167\216\170 Api !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Technical *Problem* In Bot Api !", 1, "md")
            end
          end
          tdcli_function({
            ID = "GetInlineQueryResults",
            bot_user_id_ = BotApi,
            chat_id_ = msg.chat_id_,
            user_location_ = {
              ID = "Location",
              latitude_ = 0,
              longitude_ = 0
            },
            query_ = msg.chat_id_ .. "," .. ln,
            offset_ = 0
          }, menu, nil)
        end
        if is_admin(msg.sender_user_id_) and (text:match("^[Gg]et[Mm]enu$") or text:match("^\216\175\216\177\219\140\216\167\217\129\216\170 \217\129\217\135\216\177\216\179\216\170$")) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please Send Group ID !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\180\217\134\216\167\216\179\217\135 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
          end
          database:setex("Getmenu" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
        end
--###############################--
        if text:match("^[Ss]etrules (.*)$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
	local txt = {string.match(text, "^([Ss]etrules) (.*)$")}
	database:set('bot:rules'..msg.chat_id_, txt[2])
         send(msg.chat_id_, msg.id_, 1, '_قوانین گروه بروز رسانی شد..._'..ch..'', 1, 'md')
    end
--###############################--
  	if text:match("^[Rr]ules$") then
	local rules = database:get('bot:rules'..msg.chat_id_)
         send(msg.chat_id_, msg.id_, 1, rules, 1, nil)
    end
--###############################--
	if text:match("^[Ss]etname (.*)$") and is_owner(msg.sender_user_id_, msg.chat_id_) then
	local txt = {string.match(text, "^([Ss]etname) (.*)$")} 
	     changetitle(msg.chat_id_, txt[2])
         send(msg.chat_id_, msg.id_, 1, '_اسم گروه بروزرسانی شد!_'..ch..'', 1, 'md')
    end
--###############################--
          if text:match("^[Rr]epin$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
            local pin_id = database:get('pinnedmsg'..msg.chat_id_)
            if pin_id then
              pinmsg(msg.chat_id_,pin_id,0)
            end
          end
        end
--###############################--
        if text:match("^[Cc]harge stats (%d+)") and is_admin(msg.sender_user_id_, msg.chat_id_) then
          local txt = {string.match(text, "^([Cc]harge stats) (%d+)$")}
          local ex = database:ttl("bot:charge:"..txt[2])
          if ex == -1 then
            send(msg.chat_id_, msg.id_, 1, 'بدون محدودیت ( نامحدود ) !', 1, 'md')
          else
            local d = math.floor(ex / day ) + 1
            send(msg.chat_id_, msg.id_, 1, "گروه دارای "..d.." روز اعتبار میباشد ", 1, 'md')
          end
        end
--###############################--
        if text:match("^[Cc]harge (%d+)$") and is_admin(msg.sender_user_id_, msg.chat_id_) then
		local a = {string.match(text, "^([Cc]harge) (%d+)$")} 
         send(msg.chat_id_, msg.id_, 1, 'گروه برای مدت '..a[2]..' روز شارژ شد !', 1, 'md')
		 local time = a[2] * day
         database:setex("bot:charge:"..msg.chat_id_,time,true)
		 database:set("bot:enable:"..msg.chat_id_,true)
    end
--###############################--
	 if text:match("^[Ee]xpire") and is_momod(msg.sender_user_id_, msg.chat_id_) then
    local ex = database:ttl("bot:charge:"..msg.chat_id_)
       if ex == -1 then
		send(msg.chat_id_, msg.id_, 1, '_نامحدود!_', 1, 'md')
       else
        local d = math.floor(ex / day ) + 1
	   		send(msg.chat_id_, msg.id_, 1, d.." روز تا انقضا گروه باقی مانده", 1, 'md')
       end
    end
--###############################--
	if text:match("^[Cc]harge stats (%d+)") and is_admin(msg.sender_user_id_, msg.chat_id_) then
	local txt = {string.match(text, "^([Cc]harge stats) (%d+)$")} 
    local ex = database:ttl("bot:charge:"..txt[2])
       if ex == -1 then
		send(msg.chat_id_, msg.id_, 1, '_نامحدود!_', 1, 'md')
       else
        local d = math.floor(ex / day ) + 1
	   		send(msg.chat_id_, msg.id_, 1, d.." روز تا انقضا گروه باقی مانده", 1, 'md')
       end
    end
--###############################--
  if text:match("^[Ll]eave(-%d+)") and is_admin(msg.sender_user_id_, msg.chat_id_) then
  	local txt = {string.match(text, "^([Ll]eave)(-%d+)$")} 
	   send(msg.chat_id_, msg.id_, 1, 'ربات با موفقیت از گروه '..txt[2]..' خارج شد.', 1, 'md')
	  send(txt[2], 0, 1, 'ربات به دلایلی گروه را ترک میکند\nبرای اطلاعات بیشتر میتوانید با @pythonscript در ارتباط باشید.\nدر صورت ریپورت بودن میتوانید با ربات زیر به ما پیام دهید\n@GrandSupport_Bot ', 1, 'html')
	        chat_leave(txt[2], bot_id)
          database:srem("bot:groups",txt[2])
        end
--###############################--
        if text:match('^[Pp]lan1(-%d+)') and is_admin(msg.sender_user_id_, msg.chat_id_) then
          local txt = {string.match(text, "^([Pp]lan1)(-%d+)$")}
          local timeplan1 = 2592000
          database:setex("bot:charge:"..txt[2],timeplan1,true)
          send(msg.chat_id_, msg.id_, 1, 'پلن 1 با موفقیت برای گروه '..txt[2]..' فعال شد\nاین گروه تا 30 روز دیگر اعتبار دارد! ( 1 ماه )', 1, 'md')
          database:set("bot:enable:"..txt[2],true)
        end
--###############################--
        if text:match('^[Pp]lan2(-%d+)') and is_admin(msg.sender_user_id_, msg.chat_id_) then
          local txt = {string.match(text, "^([Pp]lan2)(-%d+)$")}
          local timeplan2 = 7776000
          database:setex("bot:charge:"..txt[2],timeplan2,true)
          send(msg.chat_id_, msg.id_, 1, 'پلن 2 با موفقیت برای گروه '..txt[2]..' فعال شد\nاین گروه تا 90 روز دیگر اعتبار دارد! ( 3 ماه )', 1, 'md')
          database:set("bot:enable:"..txt[2],true)
        end
--###############################--
        if text:match('^[Pp]lan3(-%d+)') and is_admin(msg.sender_user_id_, msg.chat_id_) then
          local txt = {string.match(text, "^([Pp]lan3)(-%d+)$")}
          database:set("bot:charge:"..txt[2],true)
          send(msg.chat_id_, msg.id_, 1, 'پلن 3 با موفقیت برای گروه '..txt[2]..' فعال شد\nاین گروه به صورت نامحدود شارژ شد!', 1, 'md')
          database:set("bot:enable:"..txt[2],true)
        end
--###############################--

if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Pp]anel$") or text:match("^\217\190\217\134\217\132$")) and check_user_channel(msg) then
          if database:get("getidstatus" .. msg.chat_id_) == "Photo" then
            showiden = "Photo"
            showidfa = "\216\185\218\169\216\179"
          elseif database:get("getidstatus" .. msg.chat_id_) == "Simple" then
            showiden = "Simple"
            showidfa = "\216\179\216\167\216\175\217\135"
          elseif not database:get("getidstatus" .. msg.chat_id_) then
            showiden = "Simple"
            showidfa = "\216\179\216\167\216\175\217\135"
          end
          if database:get("getpro:" .. msg.chat_id_) == "Active" then
            showproen = "Active"
            showprofa = "\217\129\216\185\216\167\217\132"
          elseif database:get("getpro:" .. msg.chat_id_) == "Deactive" then
            showproen = "Deactive"
            showprofa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          elseif not database:get("getpro:" .. msg.chat_id_) then
            showproen = "Deactive"
            showprofa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          end
          if database:get("sharecont" .. msg.chat_id_) == "On" then
            showconten = "Active"
            showcontfa = "\217\129\216\185\216\167\217\132"
          elseif database:get("sharecont" .. msg.chat_id_) == "Off" then
            showconten = "Deactive"
            showcontfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          elseif not database:get("sharecont" .. msg.chat_id_) then
            showconten = "Deactive"
            showcontfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          end
          if database:get("bot:panel" .. msg.chat_id_) == "one" then
            panelen = "Panel 1 (For Normal Group)"
            panelfa = "\217\190\217\134\217\132 \219\140\218\169  ( \216\168\216\177\216\167\219\140 \218\175\216\177\217\136\217\135 \216\185\216\167\216\175\219\140 )"
          elseif database:get("bot:panel" .. msg.chat_id_) == "two" then
            panelen = "Panel 2 (For Chat Group)"
            panelfa = "\217\190\217\134\217\132 \216\175\217\136  ( \216\168\216\177\216\167\219\140 \218\175\216\177\217\136\217\135 \218\134\216\170 )"
          elseif database:get("bot:panel" .. msg.chat_id_) == "three" then
            panelen = "Panel 3 (For Post Group)"
            panelfa = "\217\190\217\134\217\132 \216\179\217\135 ( \216\168\216\177\216\167\219\140 \218\175\216\177\217\136\217\135 \217\190\216\179\216\170 )"
          elseif not database:get("bot:panel" .. msg.chat_id_) then
            panelen = "Not Set"
            panelfa = "\216\170\217\134\216\184\219\140\217\133 \217\134\216\180\216\175\217\135"
          end
          local start = database:get("bot:muteall:start" .. msg.chat_id_)
          local stop = database:get("bot:muteall:stop" .. msg.chat_id_)
          if start and stop then
            if database:get("bot:muteall:Run" .. msg.chat_id_) then
              AutolockEn = "`Onstream`\n\226\128\162 *Start* : `" .. start .. "`\n\226\128\162 *Stop* : `" .. stop .. "`"
              AutolockFa = "\216\175\216\177 \216\173\216\167\217\132 \218\169\216\167\216\177\n\226\128\162 \216\180\216\177\217\136\216\185 : " .. start .. "\n\226\128\162 \217\190\216\167\219\140\216\167\217\134 : " .. stop
            else
              AutolockEn = "`Pending`\n\226\128\162 *Start* : `" .. start .. "`\n\226\128\162 *Stop* : `" .. stop .. "`"
              AutolockFa = "\216\175\216\177 \216\167\217\134\216\170\216\184\216\167\216\177\n\226\128\162 \216\180\216\177\217\136\216\185 : " .. start .. "\n\226\128\162 \217\190\216\167\219\140\216\167\217\134 : " .. stop
            end
          else
            AutolockEn = "`Not set`"
            AutolockFa = "\216\170\217\134\216\184\219\140\217\133 \217\134\216\180\216\175\217\135"
          end
          if database:get("sayedit" .. msg.chat_id_) then
            say_editen = "Active"
            say_editfa = "\217\129\216\185\216\167\217\132"
          else
            say_editen = "Deactive"
            say_editfa = "\216\186\219\140\216\177\217\129\216\185\216\167\217\132"
          end
          local ex = database:ttl("bot:charge:" .. msg.chat_id_)
          if ex == -1 then
            chargeen = "Unlimited"
            chargefa = "\217\134\216\167\217\133\216\173\216\175\217\136\216\175"
          else
            local g = math.floor(ex / day) + 1
            if g == 0 then
              chargeen = "Unavailable"
              chargefa = "\217\134\216\167\217\133\217\136\216\172\217\136\216\175"
            else
              local f = math.floor(ex / day) + 1
              chargeen = f .. " Day"
              chargefa = f .. " \216\177\217\136\216\178 \216\175\219\140\218\175\216\177"
            end
          end
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162\226\128\162 *Status Group* : \n\n\226\128\162 *Group Name* : " .. (chat.title_ or "---") .. "\n\n\226\128\162 *Credit*  : `" .. chargeen .. "`\n\n\226\128\162 *Panel Type* : `" .. panelen .. "`\n\n\226\128\162 *Auto-lock Status* : " .. AutolockEn .. "\n\n\226\128\162 *Show ID Status* : `" .. showiden .. "`\n\n\226\128\162 *Show Profile Status* : `" .. showproen .. "`\n\n\226\128\162 *Show Phone Number Status* : `" .. showconten .. "`\n\n\226\128\162 *Show Edit Status* : `" .. say_editen .. "`", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162\226\128\162 \217\136\216\182\216\185\219\140\216\170 \218\175\216\177\217\136\217\135 : \n\n\226\128\162 \217\134\216\167\217\133 \218\175\216\177\217\136\217\135 : " .. (chat.title_ or "---") .. "\n\n\226\128\162 \216\167\216\185\216\170\216\168\216\167\216\177  : " .. chargefa .. "\n\n\226\128\162 \217\134\217\136\216\185 \217\190\217\134\217\132 : " .. panelfa .. "\n\n\226\128\162 \217\136\216\182\216\185\219\140\216\170 \217\130\217\129\217\132 \216\174\217\136\216\175\218\169\216\167\216\177 : " .. AutolockFa .. "\n\n\226\128\162 \216\173\216\167\217\132\216\170 \217\134\217\133\216\167\219\140\216\180 \216\180\217\134\216\167\216\179\217\135 : " .. showidfa .. "\n\n\226\128\162 \217\136\216\182\216\185\219\140\216\170 \217\134\217\133\216\167\219\140\216\180 \217\190\216\177\217\136\217\129\216\167\219\140\217\132 : " .. showprofa .. "\n\n\226\128\162 \217\136\216\182\216\185\219\140\216\170 \217\134\217\133\216\167\219\140\216\180 \216\180\217\133\216\167\216\177\217\135 \216\170\217\132\217\129\217\134 : " .. showcontfa .. "\n\n\226\128\162 \217\136\216\182\216\185\219\140\216\170 \217\134\217\133\216\167\219\140\216\180 \217\190\219\140\216\167\217\133 \216\167\216\175\219\140\216\170 \216\180\216\175\217\135 : " .. say_editfa, 1, "md")
          end
        end
        if database:get("warnstatus" .. msg.chat_id_) == "Muteuser" then
          statusen = "muted"
          statusfa = "\216\168\219\140 \216\181\216\175\216\167"
        elseif database:get("warnstatus" .. msg.chat_id_) == "Remove" then
          statusen = "removed"
          statusfa = "\216\167\216\174\216\177\216\167\216\172"
        else
          statusen = "muted"
          statusfa = "\216\168\219\140 \216\181\216\175\216\167"
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          do
            local text = msg.content_.text_:gsub("\216\167\216\174\216\183\216\167\216\177", "Warn")
            if text:match("^[Ww]arn$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
              local warn_by_reply = function(extra, result)
                if tonumber(result.id_) == our_id then
                  return
                end
                if database:get("warn:max:" .. msg.chat_id_) then
                  sencwarn = tonumber(database:get("warn:max:" .. msg.chat_id_))
                else
                  sencwarn = 4
                end
                local fname = result.first_name_ or ""
                local lname = result.last_name_ or ""
                local name = fname .. " " .. lname
                local userid = result.id_
                if database:get("user:warns" .. msg.chat_id_ .. ":" .. userid) then
                  warns = tonumber(database:get("user:warns" .. msg.chat_id_ .. ":" .. userid))
                else
                  warns = 1
                  database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
                end
                database:incr("user:warns" .. msg.chat_id_ .. ":" .. userid)
                if tonumber(sencwarn) == tonumber(warns) or tonumber(sencwarn) < tonumber(warns) then
                  if database:get("warnstatus" .. msg.chat_id_) == "Muteuser" then
                    database:sadd("bot:muted:" .. msg.chat_id_, userid)
                  elseif database:get("warnstatus" .. msg.chat_id_) == "Remove" then
                    chat_kick(msg.chat_id_, userid)
                  else
                    database:sadd("bot:muted:" .. msg.chat_id_, userid)
                  end
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    send(msg.chat_id_, 0, 1, "\226\128\162 User " .. name .. " was *" .. statusen .. "* from the group Due to *Failure to Comply* with laws !", 1, "md")
                  else
                    send(msg.chat_id_, 0, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. name .. " \216\168\217\135 \216\175\217\132\219\140\217\132 \216\177\216\185\216\167\219\140\216\170 \217\134\218\169\216\177\216\175\217\134 \217\130\217\136\216\167\217\134\219\140\217\134 \218\175\216\177\217\136\217\135 \216\140 " .. statusfa .. " \216\180\216\175 !", 1, "md")
                  end
                  database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
                elseif sencwarn == warns + 1 then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    send(msg.chat_id_, msg.reply_to_message_id_, 1, "\226\128\162 User " .. name .. [[
 :
Because you are not *Respecting* the rules, you get Warning !
If you *receive* one more warning , You will be *]] .. statusen .. [[
* !
The *Number* of *Warnings* you : `[]] .. warns .. "/" .. sencwarn .. "]`", 1, "md")
                  else
                    send(msg.chat_id_, msg.reply_to_message_id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. name .. " :\n \216\180\217\133\216\167 \216\168\217\135 \216\175\217\132\219\140\217\132 \216\177\216\185\216\167\219\140\216\170 \217\134\218\169\216\177\216\175\217\134 \217\130\217\136\216\167\217\134\219\140\217\134 \216\167\216\174\216\183\216\167\216\177 \216\175\216\177\219\140\216\167\217\129\216\170 \217\133\219\140\218\169\217\134\219\140\216\175 !\n\216\175\216\177 \216\181\217\136\216\177\216\170 \216\175\216\177\219\140\216\167\217\129\216\170 \216\167\216\174\216\183\216\167\216\177 \216\168\216\185\216\175\219\140 \216\140 " .. statusfa .. " \216\174\217\136\216\167\217\135\219\140\216\175 \216\180\216\175\n\216\170\216\185\216\175\216\167\216\175 \216\167\216\174\216\183\216\167\216\177 \217\135\216\167\219\140 \216\180\217\133\216\167 : " .. warns .. "/" .. sencwarn, "md")
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.reply_to_message_id_, 1, "\226\128\162 User " .. name .. [[
 :
Because you are not *Respecting* the rules, you get Warning !
The *number* of *Warnings* you : `[]] .. warns .. "/" .. sencwarn .. "]`", 1, "md")
                else
                  send(msg.chat_id_, msg.reply_to_message_id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. name .. " :\n \216\180\217\133\216\167 \216\168\217\135 \216\175\217\132\219\140\217\132 \216\177\216\185\216\167\219\140\216\170 \217\134\218\169\216\177\216\175\217\134 \217\130\217\136\216\167\217\134\219\140\217\134 \216\167\216\174\216\183\216\167\216\177 \216\175\216\177\219\140\216\167\217\129\216\170 \217\133\219\140\218\169\217\134\219\140\216\175 !\n\216\170\216\185\216\175\216\167\216\175 \216\167\216\174\216\183\216\167\216\177 \217\135\216\167\219\140 \216\180\217\133\216\167 : " .. warns .. "/" .. sencwarn, "md")
                end
              end
              local get_by_reply = function(extra, result)
                if not is_momod(result.sender_user_id_, msg.chat_id_) then
                  getUser(result.sender_user_id_, warn_by_reply)
                end
              end
              getMessage(msg.chat_id_, msg.reply_to_message_id_, get_by_reply)
            end
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          do
            local text = msg.content_.text_:gsub("\216\167\216\174\216\183\216\167\216\177", "Warn")
            if text:match("^[Ww]arn @(%S+)$") and check_user_channel(msg) then
              local ap = {
                string.match(text, "^([Ww]arn) @(%S+)$")
              }
              local warn_by_username = function(extra, result)
                if tonumber(result.id_) == our_id then
                  return
                end
                if database:get("warn:max:" .. msg.chat_id_) then
                  sencwarn = tonumber(database:get("warn:max:" .. msg.chat_id_))
                else
                  sencwarn = 4
                end
                local fname = result.first_name_ or ""
                local lname = result.last_name_ or ""
                local name = fname .. " " .. lname
                local userid = result.id_
                if database:get("user:warns" .. msg.chat_id_ .. ":" .. userid) then
                  warns = tonumber(database:get("user:warns" .. msg.chat_id_ .. ":" .. userid))
                else
                  warns = 1
                  database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
                end
                database:incr("user:warns" .. msg.chat_id_ .. ":" .. userid)
                if tonumber(sencwarn) == tonumber(warns) or tonumber(sencwarn) < tonumber(warns) then
                  if database:get("warnstatus" .. msg.chat_id_) == "Muteuser" then
                    database:sadd("bot:muted:" .. msg.chat_id_, userid)
                  elseif database:get("warnstatus" .. msg.chat_id_) == "Remove" then
                    chat_kick(msg.chat_id_, userid)
                  else
                    database:sadd("bot:muted:" .. msg.chat_id_, userid)
                  end
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    send(msg.chat_id_, 0, 1, "\226\128\162 User " .. name .. " was *" .. statusen .. "* from the group Due to *Failure to Comply* with laws !", 1, "md")
                  else
                    send(msg.chat_id_, 0, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. name .. " \216\168\217\135 \216\175\217\132\219\140\217\132 \216\177\216\185\216\167\219\140\216\170 \217\134\218\169\216\177\216\175\217\134 \217\130\217\136\216\167\217\134\219\140\217\134 \218\175\216\177\217\136\217\135 \216\140 " .. statusfa .. " \216\180\216\175 !", 1, "md")
                  end
                  database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, 0, 1, "\226\128\162 User " .. name .. [[
 :
Due to Failure to Comply with the rules, warning that !
The *Number* of *Warnings* user : `[]] .. warns .. "/" .. sencwarn .. "]`", 1, "md")
                else
                  send(msg.chat_id_, 0, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. name .. " :\n \216\168\217\135 \216\175\217\132\219\140\217\132 \216\177\216\185\216\167\219\140\216\170 \217\134\218\169\216\177\216\175\217\134 \217\130\217\136\216\167\217\134\219\140\217\134 \216\140 \216\167\216\174\216\183\216\167\216\177 \216\175\216\177\219\140\216\167\217\129\216\170 \217\133\219\140\218\169\217\134\216\175 !\n\216\170\216\185\216\175\216\167\216\175 \216\167\216\174\216\183\216\167\216\177 \217\135\216\167\219\140 \218\169\216\167\216\177\216\168\216\177 : " .. warns .. "/" .. sencwarn, "md")
                end
              end
              local get_by_username = function(extra, result)
                if result.id_ then
                  if not is_momod(result.id_, msg.chat_id_) then
                    getUser(result.id_, warn_by_username)
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 User not <b>Found</b> !", 1, "html")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "html")
                end
                send(msg.chat_id_, msg.id_, 1, texts, 1, "html")
              end
              resolve_username(ap[2], get_by_username)
            end
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = msg.content_.text_:gsub("\216\167\216\174\216\183\216\167\216\177", "Warn")
          if text:match("^[Ww]arn (%d+)$") and check_user_channel(msg) then
            local ap = {
              string.match(text, "^([Ww]arn) (%d+)$")
            }
            local warn_by_id = function(extra, result)
              if tonumber(result.id_) == our_id then
                return
              end
              if database:get("warn:max:" .. msg.chat_id_) then
                sencwarn = tonumber(database:get("warn:max:" .. msg.chat_id_))
              else
                sencwarn = 4
              end
              local fname = result.first_name_ or ""
              local lname = result.last_name_ or ""
              local name = fname .. " " .. lname
              local userid = result.id_
              if database:get("user:warns" .. msg.chat_id_ .. ":" .. userid) then
                warns = tonumber(database:get("user:warns" .. msg.chat_id_ .. ":" .. userid))
              else
                warns = 1
                database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
              end
              database:incr("user:warns" .. msg.chat_id_ .. ":" .. userid)
              if tonumber(sencwarn) == tonumber(warns) or tonumber(sencwarn) < tonumber(warns) then
                if database:get("warnstatus" .. msg.chat_id_) == "Muteuser" then
                  database:sadd("bot:muted:" .. msg.chat_id_, userid)
                elseif database:get("warnstatus" .. msg.chat_id_) == "Remove" then
                  chat_kick(msg.chat_id_, userid)
                else
                  database:sadd("bot:muted:" .. msg.chat_id_, userid)
                end
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, 0, 1, "\226\128\162 User " .. name .. " was *" .. statusen .. "* From the group Due to *Failure to Comply* with laws !", 1, "md")
                else
                  send(msg.chat_id_, 0, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. name .. " \216\168\217\135 \216\175\217\132\219\140\217\132 \216\177\216\185\216\167\219\140\216\170 \217\134\218\169\216\177\216\175\217\134 \217\130\217\136\216\167\217\134\219\140\217\134 \218\175\216\177\217\136\217\135 \216\140 " .. statusen .. " \216\180\216\175 !", 1, "md")
                end
                database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, 0, 1, "\226\128\162 User " .. name .. [[
 :
Due to Failure to Comply with the rules, warning that !
The *Number* of *Warnings* user : `[]] .. warns .. "/" .. sencwarn .. "]`", 1, "md")
              else
                send(msg.chat_id_, 0, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. name .. " :\n \216\168\217\135 \216\175\217\132\219\140\217\132 \216\177\216\185\216\167\219\140\216\170 \217\134\218\169\216\177\216\175\217\134 \217\130\217\136\216\167\217\134\219\140\217\134 \216\140 \216\167\216\174\216\183\216\167\216\177 \216\175\216\177\219\140\216\167\217\129\216\170 \217\133\219\140\218\169\217\134\216\175 !\n\216\170\216\185\216\175\216\167\216\175 \216\167\216\174\216\183\216\167\216\177 \217\135\216\167\219\140 \218\169\216\167\216\177\216\168\216\177 : " .. warns .. "/" .. sencwarn, "md")
              end
            end
            if not is_momod(ap[2], msg.chat_id_) then
              getUser(ap[2], warn_by_id)
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          do
            local text = msg.content_.text_:gsub("\216\173\216\176\217\129 \216\167\216\174\216\183\216\167\216\177", "Unwarn")
            if text:match("^[Uu]nwarn$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
              local unwarn_by_reply = function(extra, result)
                if tonumber(result.id_) == our_id then
                  return
                end
                if result.id_ then
                  local fname = result.first_name_ or ""
                  local lname = result.last_name_ or ""
                  local name = fname .. " " .. lname
                  local userid = result.id_
                  database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    send(msg.chat_id_, msg.reply_to_message_id_, 1, "\226\128\162 User " .. name .. [[
 :
All your *Warnings* Has Been Cleared !]], 1, "md")
                  else
                    send(msg.chat_id_, msg.reply_to_message_id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 " .. name .. " :\n\216\170\217\133\216\167\217\133\219\140 \216\167\216\174\216\183\216\167\216\177 \217\135\216\167\219\140 \216\180\217\133\216\167 \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 ! ", "md")
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 User not <b>Found</b> !", 1, "html")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "html")
                end
              end
              local get_by_reply = function(extra, result)
                if not is_momod(result.sender_user_id_, msg.chat_id_) then
                  getUser(result.sender_user_id_, unwarn_by_reply)
                end
              end
              getMessage(msg.chat_id_, msg.reply_to_message_id_, get_by_reply)
            end
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          do
            local text = msg.content_.text_:gsub("\216\173\216\176\217\129 \216\167\216\174\216\183\216\167\216\177", "Unwarn")
            if text:match("^[Uu]nwarn @(%S+)$") and check_user_channel(msg) then
              local ap = {
                string.match(text, "^([Uu]nwarn) @(%S+)$")
              }
              local unwarn_by_username = function(extra, result)
                if tonumber(result.id_) == our_id then
                  return
                end
                local fname = result.first_name_ or ""
                local lname = result.last_name_ or ""
                local name = fname .. " " .. lname
                local userid = result.id_
                database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 All warnings of User " .. name .. " Has Been Cleard !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \216\167\216\174\216\183\216\167\216\177 \217\135\216\167\219\140 \218\169\216\167\216\177\216\168\216\177 " .. name .. " \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 !", 1, "md")
                end
              end
              local get_by_username_one = function(extra, result)
                if result.id_ then
                  if not is_momod(result.id_, msg.chat_id_) then
                    getUser(result.id_, unwarn_by_username)
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 User not <b>Found</b> !", 1, "html")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "html")
                end
                send(msg.chat_id_, msg.id_, 1, texts, 1, "html")
              end
              resolve_username(ap[2], get_by_username_one)
            end
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = msg.content_.text_:gsub("\216\173\216\176\217\129 \216\167\216\174\216\183\216\167\216\177", "Unwarn")
          if text:match("^[Uu]nwarn (%d+)$") and check_user_channel(msg) then
            local ap = {
              string.match(text, "^([Uu]nwarn) (%d+)$")
            }
            local unwarn_by_id = function(extra, result)
              if tonumber(result.id_) == our_id then
                return
              end
              if result.id_ then
                local fname = result.first_name_ or ""
                local lname = result.last_name_ or ""
                local name = fname .. " " .. lname
                local userid = result.id_
                database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 All warnings of User " .. name .. " Has Been Cleard !", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \216\167\216\174\216\183\216\167\216\177 \217\135\216\167\219\140 \218\169\216\167\216\177\216\168\216\177 " .. name .. " \217\190\216\167\218\169\216\179\216\167\216\178\219\140 \216\180\216\175 !", 1, "md")
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 User not <b>Found</b> !", 1, "html")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175 !", 1, "html")
              end
            end
            if not is_momod(ap[2], msg.chat_id_) then
              getUser(ap[2], unwarn_by_id)
            end
          end
        end
if (idf:match("-100(%d+)") or is_momod(msg.sender_user_id_, msg.chat_id_)) and text:match("^[Mm]e$") and msg.reply_to_message_id_ == 0 and check_user_channel(msg) then
          local get_me = function(extra, result)
            if tonumber(result.id_) == tonumber(td) then
              ten = "Developer"
              tfa = "\216\170\217\136\216\179\216\185\217\135 \216\175\217\135\217\134\216\175\217\135"
            elseif is_leaderid(result.id_) then
              ten = "Chief"
              tfa = "\217\133\216\175\219\140\216\177 \218\169\217\132"
            elseif is_sudoid(result.id_) then
              ten = "Sudo"
              tfa = "\217\133\216\175\219\140\216\177 \216\177\216\168\216\167\216\170"
            elseif is_admin(result.id_) then
              ten = "Bot Admin"
              tfa = "\216\167\216\175\217\133\219\140\217\134 \216\177\216\168\216\167\216\170"
            elseif is_owner(result.id_, msg.chat_id_) then
              ten = "Owner"
              tfa = "\216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135"
            elseif is_momod(result.id_, msg.chat_id_) then
              ten = "Group Admin"
              tfa = "\217\133\216\175\219\140\216\177 \218\175\216\177\217\136\217\135"
            elseif is_vipmem(result.id_, msg.chat_id_) then
              ten = "VIP Member"
              tfa = "\216\185\216\182\217\136 \217\136\219\140\218\152\217\135"
            else
              ten = "Member"
              tfa = "\218\169\216\167\216\177\216\168\216\177"
            end
            if result.username_ then
              username = "@" .. result.username_
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              username = "Not Found !"
            else
              username = "\219\140\216\167\217\129\216\170 \217\134\216\180\216\175"
            end
            local fname = result.first_name_ or ""
            local lname = result.last_name_ or ""
            local name = fname .. " " .. lname
            local _nl, ctrl_chars = string.gsub(text, "%c", "")
            if string.len(name) > 40 or ctrl_chars > 70 then
              name = "---"
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 <b>Your Name</b> : <b>" .. name .. "</b>\n\226\128\162 <b>Your Username</b> : " .. username .. "\n\226\128\162 <b>Your ID</b> : <code>" .. result.id_ .. "</code>\n\226\128\162 <b>Your Rank</b> : <b>" .. ten .. "</b>", 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\134\216\167\217\133 \216\180\217\133\216\167 : " .. name .. "\n\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 \216\180\217\133\216\167 : " .. username .. "\n\226\128\162 \216\180\217\134\216\167\216\179\217\135 \216\180\217\133\216\167 : " .. result.id_ .. "\n\226\128\162 \217\133\217\130\216\167\217\133 \216\180\217\133\216\167 : " .. tfa, 1, "html")
            end
          end
          getUser(msg.sender_user_id_, get_me)
        end
       if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Aa]dd$") then
          local adding = function(extra, result)
            local txt = {
              string.match(text, "^([Aa]dd)$")
            }
            if database:get("bot:enable:" .. msg.chat_id_) then
              if not database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\175\216\177\217\136\217\135 " .. (chat.title_ or "") .. " \216\167\216\178 \217\130\216\168\217\132 \216\175\216\177 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\219\140\216\170\219\140 \216\177\216\168\216\167\216\170 \217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Group " .. (chat.title_ or "") .. " is *Already* in *Management* list !", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Group " .. (chat.title_ or "") .. [[
 has been *Added* to *Management* list !
Please *specify* the group and the group reputation !
If you *want* to get the bot phone number , send command *Botphone* .]], 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\175\216\177\217\136\217\135 " .. (chat.title_ or "") .. " \216\168\217\135 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\219\140\216\170\219\140 \216\177\216\168\216\167\216\170 \216\167\216\182\216\167\217\129\217\135 \216\180\216\175 !\n\217\132\216\183\217\129\216\167 \216\181\216\167\216\173\216\168 \218\175\216\177\217\136\217\135 \217\136 \217\133\219\140\216\178\216\167\217\134 \216\167\216\185\216\170\216\168\216\167\216\177 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\170\216\185\219\140\219\140\217\134 \217\134\217\133\216\167\219\140\219\140\216\175 !\n \216\175\216\177\216\181\217\136\216\177\216\170 \216\170\217\133\216\167\219\140\217\132 \216\168\217\135 \216\175\216\177\219\140\216\167\217\129\216\170 \216\180\217\133\216\167\216\177\217\135 \216\177\216\168\216\167\216\170 \216\140 \216\175\216\179\216\170\217\136\216\177 *Botphone* \216\177\216\167 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 .", 1, "md")
              end
              local fname = result.first_name_ or ""
              local lname = result.last_name_ or ""
              local username = "@" .. result.username_ or "\217\134\216\175\216\167\216\177\216\175"
              send(bot_owner, 0, 1, "\226\128\162 \218\175\216\177\217\136\217\135 \216\172\216\175\219\140\216\175\219\140 \216\168\217\135 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\219\140\216\170\219\140 \216\177\216\168\216\167\216\170 \216\167\216\182\216\167\217\129\217\135 \216\180\216\175 !\n\n\226\128\162\226\128\162 \216\170\216\167\216\177\219\140\216\174 : " .. Time().date .. "\n\226\128\162\226\128\162 \216\179\216\167\216\185\216\170 : " .. Time().time .. "\n\n\226\128\162\226\128\162  \217\133\216\180\216\174\216\181\216\167\216\170 \217\135\217\133\218\169\216\167\216\177 \216\167\216\182\216\167\217\129\217\135 \218\169\217\134\217\134\216\175\217\135 :\n\226\128\162\226\128\162 \216\162\219\140\216\175\219\140 \217\135\217\133\218\169\216\167\216\177 : <code>" .. msg.sender_user_id_ .. "</code>\n\226\128\162\226\128\162 \217\134\216\167\217\133 \217\135\217\133\218\169\216\167\216\177 : " .. fname .. " " .. lname .. "\n\226\128\162\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 \217\135\217\133\218\169\216\167\216\177 : " .. username .. "\n\n\226\128\162\226\128\162 \217\133\216\180\216\174\216\181\216\167\216\170 \218\175\216\177\217\136\217\135 :\n\226\128\162\226\128\162  \216\162\219\140\216\175\219\140 \218\175\216\177\217\136\217\135 : <code>" .. msg.chat_id_ .. "</code>\n\226\128\162\226\128\162 \217\134\216\167\217\133 \218\175\216\177\217\136\217\135 : " .. (chat.title_ or "") .. "\n\n\226\128\162\226\128\162 \216\167\218\175\216\177 \217\133\219\140\216\174\217\136\216\167\217\135\219\140\216\175 \216\177\216\168\216\167\216\170 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\170\216\177\218\169 \218\169\217\134\216\175 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177 \216\178\219\140\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \218\169\217\134\219\140\216\175 : \n\n\226\128\162\226\128\162  <code>leave" .. msg.chat_id_ .. "</code>\n\n\226\128\162\226\128\162 \216\167\218\175\216\177 \217\130\216\181\216\175 \217\136\216\167\216\177\216\175 \216\180\216\175\217\134 \216\168\217\135 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\175\216\167\216\177\219\140\216\175 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177 \216\178\219\140\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \218\169\217\134\219\140\216\175 : \n\n\226\128\162\226\128\162  <code>join" .. msg.chat_id_ .. "</code>\n\n\226\128\162\226\128\162 \226\128\162\226\128\162 \226\128\162\226\128\162 \226\128\162\226\128\162 \226\128\162\226\128\162 \226\128\162\226\128\162 \n\n\226\128\162\226\128\162  \216\167\218\175\216\177 \217\130\216\181\216\175 \216\170\217\133\216\175\219\140\216\175 \218\175\216\177\217\136\217\135 \216\177\216\167 \216\175\216\167\216\177\219\140\216\175 \216\167\216\178 \216\175\216\179\216\170\217\136\216\177\216\167\216\170 \216\178\219\140\216\177 \216\167\216\179\216\170\217\129\216\167\216\175\217\135 \218\169\217\134\219\140\216\175 : \n\n\226\128\162\226\128\162 \216\168\216\177\216\167\219\140 \216\180\216\167\216\177\218\152 \216\168\217\135 \216\181\217\136\216\177\216\170 \219\140\218\169 \217\133\216\167\217\135 :\n\226\128\162\226\128\162  <code>plan1" .. msg.chat_id_ .. "</code>\n\n\226\128\162\226\128\162 \216\168\216\177\216\167\219\140 \216\180\216\167\216\177\218\152 \216\168\217\135 \216\181\217\136\216\177\216\170 \216\179\217\135 \217\133\216\167\217\135 :\n\226\128\162\226\128\162  <code>plan2" .. msg.chat_id_ .. "</code>\n\n\226\128\162\226\128\162 \216\168\216\177\216\167\219\140 \216\180\216\167\216\177\218\152 \216\168\217\135 \216\181\217\136\216\177\216\170 \217\134\216\167\217\133\216\173\216\175\217\136\216\175 :\n\226\128\162\226\128\162  <code>plan3" .. msg.chat_id_ .. "</code>\n\n\226\128\162\226\128\162 \216\168\216\177\216\167\219\140 \216\180\216\167\216\177\218\152 \216\168\217\135 \216\181\217\136\216\177\216\170 \216\175\217\132\216\174\217\136\216\167\217\135 :\n\226\128\162\226\128\162 <code>plan4" .. msg.chat_id_ .. "</code>", 1, "html")
              database:set("bot:enable:" .. msg.chat_id_, true)
              database:setex("bot:charge:" .. msg.chat_id_, 2 * day, true)
          
              database:sadd("sudo:data:" .. msg.sender_user_id_, msg.chat_id_)
            end
          end
          getUser(msg.sender_user_id_, adding)
        end
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Cc]onfig$") or text:match("^\216\167\216\177\216\170\217\130\216\167 \217\133\217\130\216\167\217\133 \216\167\216\175\217\133\219\140\217\134 \217\135\216\167$")) then
          local padmin = function(extra, result)
            local chat_id = msg.chat_id_
            local admins = result.members_
            for i = 0, #admins do
              database:sadd("bot:momod:" .. msg.chat_id_, admins[i].user_id_)
            end
            local hash = "bot:momod:" .. msg.chat_id_
            local list = database:smembers(hash)
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "\226\128\162 <b>All Moderators</b> Has Been Added To <b>Moderators</b> List : \n\n"
            else
              text = "\226\128\162 \216\170\217\133\216\167\217\133\219\140 \216\167\216\175\217\133\219\140\217\134 \217\135\216\167\219\140 \218\175\216\177\217\136\217\135 \216\168\217\135 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\216\167\217\134 \218\175\216\177\217\136\217\135 \216\167\216\182\216\167\217\129\217\135 \216\180\216\175\217\134\216\175 !\n\n\217\133\216\175\219\140\216\177\216\167\217\134 \218\175\216\177\217\136\217\135 :\n\n"
            end
            for k, v in pairs(list) do
              local user_info = database:get("user:Name" .. v)
              if user_info then
                local username = user_info
                text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
              else
                text = text .. k .. " - [" .. v .. "]\n"
              end
            end
            send(msg.chat_id_, msg.id_, 1, text, 1, "html")
          end
          getChannelMembers(msg.chat_id_, 0, "Administrators", 200, padmin)
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Rr]em$") then
          local txt = {
            string.match(text, "^([Rr]em)$")
          }
          if not database:get("bot:enable:" .. msg.chat_id_) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Group " .. (chat.title_ or "") .. " is *Not* In *Management* List !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\175\216\177\217\136\217\135 " .. (chat.title_ or "") .. " \216\175\216\177 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\219\140\216\170\219\140 \216\177\216\168\216\167\216\170 \217\134\219\140\216\179\216\170 !", 1, "md")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 Group " .. (chat.title_ or "") .. " Has Been *Removed* From *Management* List !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\175\216\177\217\136\217\135 " .. (chat.title_ or "") .. " \216\167\216\178 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\219\140\216\170\219\140 \216\177\216\168\216\167\216\170 \216\173\216\176\217\129 \216\180\216\175 !", 1, "md")
            end
            database:del("bot:charge:" .. msg.chat_id_)
            database:del("bot:enable:" .. msg.chat_id_)
            database:srem("bot:groups", msg.chat_id_)
            database:srem("sudo:data:" .. msg.sender_user_id_, msg.chat_id_)
            local send_to_bot_owner = function(extra, result)
              local v = tonumber(bot_owner)
              local fname = result.first_name_ or ""
              local lname = result.last_name_ or ""
              local username = "@" .. result.username_ or "\217\134\216\175\216\167\216\177\216\175"
              send(v, 0, 1, "\226\128\162\226\128\162  \218\175\216\177\217\136\217\135\219\140 \216\168\216\167 \217\133\216\180\216\174\216\181\216\167\216\170 \216\178\219\140\216\177 \216\167\216\178 \217\132\219\140\216\179\216\170 \217\133\216\175\219\140\216\177\219\140\216\170\219\140 \216\173\216\176\217\129 \216\180\216\175 !\n\n\226\128\162\226\128\162 \216\170\216\167\216\177\219\140\216\174 : " .. Time().date .. "\n\226\128\162\226\128\162 \216\179\216\167\216\185\216\170 : " .. Time().time .. "\n\n \226\128\162\226\128\162 \217\133\216\180\216\174\216\181\216\167\216\170 \217\135\217\133\218\169\216\167\216\177 \216\173\216\176\217\129 \218\169\217\134\217\134\216\175\217\135 : \n \226\128\162\226\128\162 \217\134\216\167\217\133 \217\135\217\133\218\169\216\167\216\177 : " .. fname .. " " .. lname .. "\n \226\128\162\226\128\162 \219\140\217\136\216\178\216\177\217\134\219\140\217\133 \217\135\217\133\218\169\216\167\216\177 : " .. username .. "\n\n\n \226\128\162\226\128\162 \217\133\216\180\216\174\216\181\216\167\216\170 \218\175\216\177\217\136\217\135 :\n \226\128\162\226\128\162 \216\162\219\140\216\175\219\140 \218\175\216\177\217\136\217\135 : <code>" .. msg.chat_id_ .. "</code>\n \226\128\162\226\128\162 \217\134\216\167\217\133 \218\175\216\177\217\136\217\135 : " .. (chat.title_ or "---" or "---"), 1, "html")
            end
            getUser(msg.sender_user_id_, send_to_bot_owner)
          end
        end
if is_admin(msg.sender_user_id_) and text:match("^[Pp]lan1(-%d+)") then
          local txt = {
            string.match(text, "^([Pp]lan1)(-%d+)$")
          }
          local timeplan1 = 2592000
          database:setex("bot:charge:" .. txt[2], timeplan1, true)
          database:set("bot:enable:" .. txt[2], true)
        
          local gp_info = database:get("group:Name" .. txt[2])
          local chatname = gp_info
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\183\216\177\216\173 \216\180\217\133\216\167\216\177\217\135 1 \216\168\216\167 \217\133\217\136\217\129\217\130\219\140\216\170 \216\168\216\177\216\167\219\140 \218\175\216\177\217\136\217\135 " .. chatname .. " \217\129\216\185\216\167\217\132 \216\180\216\175!\n\216\167\219\140\217\134 \218\175\216\177\217\136\217\135 \216\170\216\167 30 \216\177\217\136\216\178 \216\175\219\140\218\175\216\177 \216\167\216\185\216\170\216\168\216\167\216\177 \216\175\216\167\216\177\216\175 ! ", 1, "md")
        end
        if is_admin(msg.sender_user_id_) and text:match("^[Pp]lan2(-%d+)") then
          local txt = {
            string.match(text, "^([Pp]lan2)(-%d+)$")
          }
          local timeplan2 = 7776000
          database:setex("bot:charge:" .. txt[2], timeplan2, true)
          database:set("bot:enable:" .. txt[2], true)
       
          local gp_info = database:get("group:Name" .. txt[2])
          local chatname = gp_info
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\183\216\177\216\173 \216\180\217\133\216\167\216\177\217\135 2 \216\168\216\167 \217\133\217\136\217\129\217\130\219\140\216\170 \216\168\216\177\216\167\219\140 \218\175\216\177\217\136\217\135 " .. chatname .. " \217\129\216\185\216\167\217\132 \216\180\216\175!\n\216\167\219\140\217\134 \218\175\216\177\217\136\217\135 \216\170\216\167 90 \216\177\217\136\216\178 \216\175\219\140\218\175\216\177 \216\167\216\185\216\170\216\168\216\167\216\177 \216\175\216\167\216\177\216\175 ! ", 1, "md")
        end
        if is_admin(msg.sender_user_id_) and text:match("^[Pp]lan3(-%d+)") then
          local txt = {
            string.match(text, "^([Pp]lan3)(-%d+)$")
          }
          database:set("bot:charge:" .. txt[2], true)
          send(msg.chat_id_, msg.id_, 1, "\217\190\217\132\217\134 3 \216\168\216\167 \217\133\217\136\217\129\217\130\219\140\216\170 \216\168\216\177\216\167\219\140 \218\175\216\177\217\136\217\135 " .. txt[2] .. " \217\129\216\185\216\167\217\132 \216\180\216\175\n\216\167\219\140\217\134 \218\175\216\177\217\136\217\135 \216\168\217\135 \216\181\217\136\216\177\216\170 \217\134\216\167\217\133\216\173\216\175\217\136\216\175 \216\180\216\167\216\177\218\152 \216\180\216\175!", 1, "md")
          database:set("bot:enable:" .. txt[2], true)
       
          local gp_info = database:get("group:Name" .. txt[2])
          local chatname = gp_info
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\183\216\177\216\173 \216\180\217\133\216\167\216\177\217\135 3 \216\168\216\167 \217\133\217\136\217\129\217\130\219\140\216\170 \216\168\216\177\216\167\219\140 \218\175\216\177\217\136\217\135 " .. chatname .. " \217\129\216\185\216\167\217\132 \216\180\216\175!\n\216\167\219\140\217\134 \218\175\216\177\217\136\217\135 \216\168\217\135 \216\181\217\136\216\177\216\170 \217\134\216\167\217\133\216\173\216\175\217\136\216\175 \216\167\216\185\216\170\216\168\216\167\216\177 \216\175\216\167\216\177\216\175 !", 1, "md")
        end
        if is_admin(msg.sender_user_id_) and text:match("^[Pp]lan4(-%d+)") then
          local txt = {
            string.match(text, "^([Pp]lan4)(-%d+)$")
          }
          database:setex("bot:plan4:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 120, txt[2])
          send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \217\133\216\175\216\170 \216\178\217\133\216\167\217\134 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\174\217\136\216\175 \216\177\216\167 \216\168\216\177\216\167\219\140 \216\180\216\167\216\177\218\152 \216\167\219\140\217\134 \218\175\216\177\217\136\217\135 \216\168\216\177 \217\136\216\167\216\173\216\175 \216\177\217\136\216\178 \216\167\216\177\216\179\216\167\217\132 \217\134\217\133\216\167\219\140\219\140\216\175 !", 1, "md")
        end
        if database:get("bot:plan4:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
          local chat = database:get("bot:plan4:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          if text:match("^%d+$") then
            local day_ = text:match("^%d+$")
            local time = day_ * day
            database:setex("bot:charge:" .. chat, time, true)
            database:set("bot:enable:" .. chat, true)
           
            local gp_info = database:get("group:Name" .. chat)
            local chatname = gp_info
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\175\216\177\217\136\217\135 " .. chatname .. " \216\168\216\167 \217\133\217\136\217\129\217\130\219\140\216\170 \216\168\217\135 \217\133\216\175\216\170 " .. day_ .. " \216\177\217\136\216\178 \216\180\216\167\216\177\218\152 \216\180\216\175 !", 1, "md")
            database:del("bot:plan4:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          end
        end 
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and msg.reply_to_message_id_ ~= 0 and (text:match("^[Pp]in$") or text:match("^\216\179\217\134\216\172\216\167\217\130 \218\169\217\134$")) and check_user_channel(msg) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          pinmsg(msg.chat_id_, msg.reply_to_message_id_, 0)
          database:set("pinnedmsg" .. msg.chat_id_, msg.reply_to_message_id_)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 The Message has been *Pinned* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \217\133\217\136\216\177\216\175 \217\134\216\184\216\177 \216\179\217\134\216\172\216\167\217\130 \216\180\216\175 !", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Uu]npin$") or text:match("^\216\173\216\176\217\129 \216\179\217\134\216\172\216\167\217\130$")) and check_user_channel(msg) then
          unpinmsg(msg.chat_id_)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 The Message has been *UnPinned* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \216\179\217\134\216\172\216\167\217\130 \216\180\216\175\217\135 \216\167\216\178 \216\173\216\167\217\132\216\170 \216\179\217\134\216\172\216\167\217\130 \216\174\216\167\216\177\216\172 \216\180\216\175 !", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Rr]epin$") or text:match("^\216\179\217\134\216\172\216\167\217\130 \217\133\216\172\216\175\216\175$")) and check_user_channel(msg) then
          local pin_id = database:get("pinnedmsg" .. msg.chat_id_)
          if pin_id then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 The Message has been *RePinned* !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \216\179\217\134\216\172\216\167\217\130 \216\180\216\175\217\135 \216\179\216\167\216\168\217\130 \217\133\216\172\216\175\216\175 \216\179\217\134\216\172\216\167\217\130 \216\180\216\175 !", 1, "md")
            end
            pinmsg(msg.chat_id_, pin_id, 0)
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Message Pinned the former was *not Found* !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \216\179\217\134\216\172\216\167\217\130 \216\180\216\175\217\135 \216\179\216\167\216\168\217\130 \219\140\216\167\217\129\216\170 \217\134\216\180\216\175  !", 1, "md")
          end
        end
      if is_sudo(msg) and text:match("^[Ee]ncode (.*)$") then
          local ap = {
            string.match(text, "^([Ee]ncode) (.*)$")
          }
          local b = enc(ap[2])
          b = b:gsub("A", "\198\162")
          b = b:gsub("B", "\197\189")
          b = b:gsub("E", "\198\183")
          b = b:gsub("G", "\197\146")
          b = b:gsub("I", "\206\169")
          b = b:gsub("L", "\207\137")
          b = b:gsub("O", "\200\170")
          b = b:gsub("S", "\198\184")
          b = b:gsub("T", "\206\163")
          b = b:gsub("U", "\202\163")
          b = b:gsub("Z", "\198\145")
          b = b:gsub("=", "\206\158")
          send(msg.chat_id_, msg.id_, 1, b, 1, "md")
        end
        if is_sudo(msg) and text:match("^[Dd]ecode (.*)$") then
          local ap = {
            string.match(text, "^([Dd]ecode) (.*)$")
          }
          s = ap[2]
          s = s:gsub("\198\162", "A")
          s = s:gsub("\197\189", "B")
          s = s:gsub("\198\183", "E")
          s = s:gsub("\197\146", "G")
          s = s:gsub("\206\169", "I")
          s = s:gsub("\207\137", "L")
          s = s:gsub("\200\170", "O")
          s = s:gsub("\198\184", "S")
          s = s:gsub("\206\163", "T")
          s = s:gsub("\202\163", "U")
          s = s:gsub("\198\145", "Z")
          s = s:gsub("\206\158", "=")
          local b = dec(s)
          send(msg.chat_id_, msg.id_, 1, b, 1, "html")
        end
        if (database:get("fun") == "On" or is_admin(msg.sender_user_id_)) and is_momod(msg.sender_user_id_, msg.chat_id_) then
          text = text:gsub("\217\133\216\167\216\180\219\140\217\134 \216\173\216\179\216\167\216\168", "Calc")
          if text:match("^[Cc]alc (.*)") and check_user_channel(msg) then
            local ap = {
              string.match(text, "^([Cc]alc) (.*)")
            }
            local J = calc(ap[2])
            if not J:match("^ERR$") then
              if not database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\173\216\167\216\181\217\132 : " .. J, 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 Result : " .. J, 1, "md")
              end
            elseif J:match("^Error") then
              if not database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\174\216\183\216\167 \216\175\216\177 \217\133\216\173\216\167\216\179\216\168\216\167\216\170 !", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "\226\128\162 *Error* In Calculation !", 1, "md")
              end
            elseif not database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 \216\168\217\135 \216\175\217\132\219\140\217\132 \217\133\216\180\218\169\217\132 \217\129\217\134\219\140 \216\167\219\140\217\134 \217\130\216\167\216\168\217\132\219\140\216\170 \216\175\216\177 \216\175\216\179\216\170\216\177\216\179 \217\134\217\133\219\140\216\168\216\167\216\180\216\175 !", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "\226\128\162 This *Feature* Is Not Available Due To *Technical* Problems !", 1, "md")
            end
          end
        end
        if (database:get("fun") == "On" or is_admin(msg.sender_user_id_)) and is_momod(msg.sender_user_id_, msg.chat_id_) and text:match("^[Ll]ove (.*) (.*)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Ll]ove) (.*) (.*)$")
          }
          local text1 = ap[2]
          local text2 = ap[3]
          local url = "http://www.iloveheartstudio.com/-/p.php?t=" .. text1 .. "%20%EE%BB%AE%20" .. text2 .. "&bc=FFFFFF&tc=000000&hc=ff0000&f=c&uc=true&ts=true&ff=PNG&w=500&ps=sq"
          local file = download_to_file(url, "love.webp")
          sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, file, "", dl_cb, nil)
        end
        if (database:get("fun") == "On" or is_admin(msg.sender_user_id_)) and is_momod(msg.sender_user_id_, msg.chat_id_) and (text:match("^[Tt]osticker$") or text:match("^\216\170\216\168\216\175\219\140\217\132 \216\168\217\135 \216\167\216\179\216\170\219\140\218\169\216\177$")) and check_user_channel(msg) then
          if msg.reply_to_message_id_ ~= 0 then
            function tosticker(extra, result)
              if result.content_.ID == "MessagePhoto" then
                local usr = database:get("Bot:ServerUser")
                if usr:match("^root$") then
                  tg = "/root/.telegram-cli"
                elseif not usr:match("^root$") then
                  tg = "/home/" .. usr .. "/.telegram-cli"
                end
                file = result.content_.photo_.id_
                local pathf = tg .. "/data/photo/" .. file .. "_(1).jpg"
                local pfile = "data/photos/" .. file .. ".webp"
                os.rename(pathf, pfile)
                if pfile then
                  sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, pfile, "", dl_cb, nil)
                end
              end
            end
            getMessage(msg.chat_id_, msg.reply_to_message_id_, tosticker)
          elseif not database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\168\216\177 \216\177\217\136\219\140 \219\140\218\169 \216\185\218\169\216\179 \216\140 \216\177\219\140\217\190\217\132\216\167\219\140 \218\169\216\177\216\175\217\135 \217\136 \216\179\217\190\216\179 \216\167\219\140\217\134 \216\175\216\179\216\170\217\136\216\177 \216\177\216\167 \216\168\216\178\217\134\219\140\216\175 !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Reply On a Photo* And Then Send This Command !", 1, "md")
          end
        end
        if (database:get("fun") == "On" or is_admin(msg.sender_user_id_)) and is_momod(msg.sender_user_id_, msg.chat_id_) and (text:match("^[Tt]ophoto$") or text:match("^\216\170\216\168\216\175\219\140\217\132 \216\168\217\135 \216\185\218\169\216\179$")) and check_user_channel(msg) then
          if msg.reply_to_message_id_ ~= 0 then
            function tophoto(extra, result)
              if result.content_.sticker_ then
                local usr = database:get("Bot:ServerUser")
                if usr:match("^root$") then
                  tg = "/root/.telegram-cli"
                elseif not usr:match("^root$") then
                  tg = "/home/" .. usr .. "/.telegram-cli"
                end
                local file = result.content_.sticker_.sticker_.path_
                local secp = tostring(tg) .. "/data/sticker/"
                local ffile = string.gsub(file, "-", "")
                local fsecp = string.gsub(secp, "-", "")
                local name = string.gsub(ffile, fsecp, "")
                local sname = string.gsub(name, "webp", "jpg")
                local pfile = "data/photos/" .. sname
                os.rename(file, pfile)
                sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, pfile)
              end
            end
            getMessage(msg.chat_id_, msg.reply_to_message_id_, tophoto)
          elseif not database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 \217\132\216\183\217\129\216\167 \216\168\216\177 \216\177\217\136\219\140 \219\140\218\169 \216\167\216\179\216\170\219\140\218\169\216\177 \216\140 \216\177\219\140\217\190\217\132\216\167\219\140 \218\169\216\177\216\175\217\135 \217\136 \216\179\217\190\216\179 \216\167\219\140\217\134 \216\175\216\179\216\170\217\136\216\177 \216\177\216\167 \216\168\216\178\217\134\219\140\216\175 !", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "\226\128\162 Please *Reply On a Sticker* And Then Send This Command !", 1, "md")
          end
        end
        if (database:get("fun") == "On" or is_admin(msg.sender_user_id_)) and is_momod(msg.sender_user_id_, msg.chat_id_) then
          text = text:gsub("\216\179\216\167\216\174\216\170 \218\175\219\140\217\129", "Gif")
          if text:match("^[Gg]if (.*)$") and check_user_channel(msg) then
            local ap = {
              string.match(text, "^([Gg]if) (.*)$")
            }
            local modes = {
              "memories-anim-logo",
              "alien-glow-anim-logo",
              "flash-anim-logo",
              "flaming-logo",
              "whirl-anim-logo",
              "highlight-anim-logo",
              "burn-in-anim-logo",
              "shake-anim-logo",
              "inner-fire-anim-logo",
              "jump-anim-logo"
            }
            local text = URL.escape(ap[2])
            local url2 = "http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script=" .. modes[math.random(#modes)] .. "&text=" .. text .. "&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141"
            local title, res = http.request(url2)
            local jdat = json.decode(title)
            local gif = jdat.src
            local file = download_to_file(gif, "t2g.gif")
            sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, file, "", dl_cb, nil)
          end
        end
        if (database:get("fun") == "On" or is_admin(msg.sender_user_id_)) and is_momod(msg.sender_user_id_, msg.chat_id_) and text:match("^[Kk][Ee][Ee][Pp][Cc][Aa][Ll][Mm] (.*) (.*) (.*) (.*) (.*)$") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^([Kk][Ee][Ee][Pp][Cc][Aa][Ll][Mm]) (.*) (.*) (.*) (.*) (.*)$")
          }
          local text = URL.escape(matches[2])
          local bgcolor = "mathrm"
          if matches[3] == "blue" then
            bgcolor = "0000ff"
          elseif matches[3] == "pink" then
            bgcolor = "e11bca"
          elseif matches[3] == "violet" then
            bgcolor = "7366BD"
          elseif matches[3] == "red" then
            bgcolor = "ff0000"
          elseif matches[3] == "brown" then
            bgcolor = "B4674D"
          elseif matches[3] == "orange" then
            bgcolor = "FF7F49"
          elseif matches[3] == "gray" then
            bgcolor = "B0B7C6"
          elseif matches[3] == "cream" then
            bgcolor = "FFFF99"
          elseif matches[3] == "green" then
            bgcolor = "00ff00"
          elseif matches[3] == "black" then
            bgcolor = "000000"
          elseif matches[3] == "white" then
            bgcolor = "ffffff"
          elseif matches[3] == "Fuchsia" then
            bgcolor = "ff00ff"
          elseif matches[3] == "Aqua" then
            bgcolor = "00ffff"
          elseif matches[3] == "yellow" then
            bgcolor = "ffff00"
          end
          local textcolor = "blue"
          if matches[4] == "blue" then
            textcolor = "0000ff"
          elseif matches[4] == "pink" then
            textcolor = "e11bca"
          elseif matches[4] == "violet" then
            textcolor = "7366BD"
          elseif matches[4] == "red" then
            textcolor = "ff0000"
          elseif matches[4] == "brown" then
            textcolor = "B4674D"
          elseif matches[4] == "orange" then
            textcolor = "FF7F49"
          elseif matches[4] == "gray" then
            textcolor = "B0B7C6"
          elseif matches[4] == "cream" then
            textcolor = "FFFF99"
          elseif matches[4] == "green" then
            textcolor = "00ff00"
          elseif matches[4] == "black" then
            textcolor = "000000"
          elseif matches[4] == "white" then
            textcolor = "ffffff"
          elseif matches[4] == "Fuchsia" then
            textcolor = "ff00ff"
          elseif matches[4] == "Aqua" then
            textcolor = "00ffff"
          elseif matches[4] == "yellow" then
            textcolor = "ffff00"
          end
          local text = "700"
          if matches[5] == "blue" then
            text = "0000ff"
          elseif matches[5] == "pink" then
            text = "e11bca"
          elseif matches[5] == "violet" then
            text = "7366BD"
          elseif matches[5] == "red" then
            text = "ff0000"
          elseif matches[5] == "brown" then
            text = "B4674D"
          elseif matches[5] == "orange" then
            text = "FF7F49"
          elseif matches[5] == "gray" then
            text = "B0B7C6"
          elseif matches[5] == "cream" then
            text = "FFFF99"
          elseif matches[5] == "green" then
            text = "00ff00"
          elseif matches[5] == "black" then
            text = "000000"
          elseif matches[5] == "white" then
            text = "ffffff"
          elseif matches[5] == "Fuchsia" then
            text = "ff00ff"
          elseif matches[5] == "Aqua" then
            text = "00ffff"
          elseif matches[5] == "yellow" then
            text = "ffff00"
          end
          local size = "size"
          if matches[6] == "100" then
            size = "100"
          elseif matches[6] == "200" then
            size = "200"
          elseif matches[6] == "300" then
            size = "300"
          elseif matches[6] == "400" then
            size = "400"
          elseif matches[6] == "500" then
            size = "500"
          elseif matches[6] == "600" then
            size = "600"
          elseif matches[6] == "700" then
            size = "700"
          elseif matches[6] == "800" then
            size = "800"
          elseif matches[6] == "900" then
            size = "900"
          elseif matches[6] == "1000" then
            size = "1000"
          end
          local url = "http://www.keepcalmstudio.com/-/p.php?t=%EE%BB%AA%0D%0AKEEP%0D%0ACALM%0D%0AAND%0D%0A" .. URL.escape(matches[2]) .. "&bc=" .. bgcolor .. "&tc=" .. textcolor .. "&cc=" .. text .. "&w=" .. size .. "&uc=true&ts=true&ff=PNG&ps=sq"
          local file = download_to_file(url, "file.webp")
          sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, file, "", dl_cb, nil)
        end
end
elseif (data.ID == "UpdateChat") then
    chat = data.chat_
    chats[chat.id_] = chat
--###############################--
     elseif data.ID == "UpdateChat" then
            chat = data.chat_
            chats[chat.id_] = chat
          elseif data.ID == "UpdateUserAction" then
            local chat = data.chat_id_
            local user = data.user_id_
            local idf = tostring(chat)
            if idf:match("-100(%d+)") and not database:get("bot:muted:Time" .. chat .. ":" .. user) and database:sismember("bot:muted:" .. chat, user) then
              database:srem("bot:muted:" .. chat, user)
            end
          elseif data.ID == "UpdateMessageEdited" then
            local msg = data
            local get_msg_contact = function(extra, result)
              local text = result.content_.text_ or result.content_.caption_
              if tonumber(msg.sender_user_id_) == tonumber(api_id) then
                print("\027[" .. color.white[1] .. ";" .. color.magenta[2] .. "m>>> Edit From Api Bot <<<\027[00m")
                return false
              end
              if tonumber(result.sender_user_id_) == tonumber(our_id) then
                print("\027[" .. color.white[1] .. ";" .. color.magenta[2] .. "m>>> Edit From Bot <<<\027[00m")
                return false
              end
              if not is_vipmem(result.sender_user_id_, result.chat_id_) then
                check_filter_words(result, text)
                if database:get("editmsg" .. msg.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if (text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]")) and database:get("bot:links:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if result.content_.entities_ and result.content_.entities_[0] and (result.content_.entities_[0].ID == "MessageEntityTextUrl" or result.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if result.content_.web_page_ and database:get("bot:webpage:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if (text:match("[Hh][Tt][Tt][Pp]") or text:match("[Ww][Ww][Ww]") or text:match(".[Cc][Oo]") or text:match(".[Oo][Rr][Gg]") or text:match(".[Ii][Rr]")) and database:get("bot:webpage:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if text:match("@") and database:get("tags:lock" .. msg.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if text:match("#") and database:get("bot:hashtag:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if text:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if (text:match("[A-Z]") or text:match("[a-z]")) and database:get("bot:english:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if database:get("sayedit" .. msg.chat_id_) and not database:get("editmsg" .. msg.chat_id_) and database:get("bot:editid" .. msg.message_id_) then
                  local old_text = database:get("bot:editid" .. msg.message_id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    send(msg.chat_id_, msg.message_id_, 1, "\226\128\162 Your <b>Messages</b> before Edit :\n\n<b>" .. old_text .. "</b>", 1, "html")
                  else
                    send(msg.chat_id_, msg.message_id_, 1, "\226\128\162 \217\190\219\140\216\167\217\133 \216\180\217\133\216\167 \217\130\216\168\217\132 \216\167\216\178 \216\167\216\175\219\140\216\170 \216\180\216\175\217\134 :\n\n<b>" .. old_text .. "</b>", 1, "html")
                  end
                  if result.id_ and result.content_.text_ then
                    database:set("bot:editid" .. result.id_, result.content_.text_)
                  end
                end
              end
            end
            getMessage(msg.chat_id_, msg.message_id_, get_msg_contact)
--###############################--
  elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
    tdcli_function ({ID="GetChats", offset_order_="9223372036854775807", offset_chat_id_=0, limit_=20}, dl_cb, nil)
  end
--###############################--
end