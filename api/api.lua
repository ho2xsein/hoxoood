package.path = package.path ..';.luarocks/share/lua/5.2/?.lua' .. ';./bot/?.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'

--> IMPORTS <--
socket = require("socket")
URL = require "socket.url"
https = require "ssl.https"
http = require("socket.http")
http.TIMEOUT = 10
curl = require 'cURL'
curl_context = curl.easy{verbose = false}
serpent = (loadfile "./api/serpent.lua")()
json = (loadfile "./api/JSON.lua")()
JSON = (loadfile "./api/dkjson.lua")()
utf8 = loadfile("./api/utf8.lua")()
Config = (loadfile "./data/config.lua")() -- Loading Config.lua ...

local R = require 'redis'
redis = R.connect('127.0.0.1', 6379)
redis:select(Config.RedisIndex or 0)

-- Bot_mod.lua
ClerkMessageHash = "enigma:cli:clerk_msg"
ClerkStatusHash = "enigma:cli:clerk_status"
--------------

-- Chat_mod.lua
WelcomeMessageHash = "enigma:cli:wlc:"
RulesHash = "enigma:cli:set_rules:"
FilterHash = "enigma:cli:filtered_words:"
ModeratorsSettingsHash = "enigma:cli:modsaccess:"
---------------

-- Warn.lua
MaxWarnHash = "enigma:cli:max_warn:"
WarnedUsersHash = "enigma:cli:warned_users:"
WarnHash = "enigma:cli:warn:"
-----------

-- Ban.lua
GBanHash = "enigma:cli:global_ban_users"
BanHash = "enigma:cli:ban_users:"

SilentHash = "enigma:cli:silent_users:"
----------

-- Locks.lua
ShowEditHash = "enigma:cli:show_edit_msg_id"
------------

-- Rmsg.lua
RmsgHash = "enigma:cli:rmsg_messages_ids:"
-----------

-- Charge.lua
ChargeHash = "enigma:cli:charge:"
-------------

-- Sec.lua
ModerationFileBackupTimeHash = "enigma:cli:moderationfilebackuptime"
----------

-- Fun.lua
BeautyTextHash = "enigma:cli:beauty_text:"
----------

------------------------------>

--> COLORS FOR PRINT <--
Color = {}
Color.Red = "\027[31m"
Color.Green = "\027[32m"
Color.Yellow = "\027[33m"
Color.Blue = "\027[34m"
Color.Reset = "\027[39m"

Color.pRed = "\027[91m"
Color.pGreen = "\027[92m"
Color.pYellow = "\027[93m"
Color.pBlue = "\027[96m"
Color.pReset = "\027[97m"
-------------------

-- Enable And Disable Emoji
Enb = "✔️ فعال"
Dis = "❌ غیرفعال"
Enb2 = "✔️"
Dis2 = "❌"

Access = "دارند ✔️"
NotAccess = "ندارند ❌"
---------------------------

-- Time Variables ...
MinInSec = 60
HourInSec = 3600
DayInSec = 86400
WeekInSec = 604800
MonthInSec = 2592000
SeasonInSec = 7776000
YearInSec = 31536000
-------

-- Bot Help Texts
BotHelp = {}
BotHelp[1] = [[▪️آموزش دستورات مدیریتی ربات :
————
`/panel`
پنل
> دریافت پنل مدیریت آسان گروه
•دسترسی : فقط مدیر اصلی
————
`/id`
آیدی
> نمایش اطلاعات کاربر (میتوان ریپلای کرد.)
•دسترسی : همه اعضا
————
`/pin`
سنجاق
> سنجاق کردن یک پیام (باید روی پیام ریپلای شود.)
•دسترسی : مدیران فرعی و اصلی
————
`/unpin`
حذف سنجاق
> حذف پیام سنجاق شده در گروه
•دسترسی : مدیران فرعی و اصلی
————
`/config`
پیکربندی
> تنظیم سازنده گروه به عنوان مدیر اصلی(Owner) و تنظیم مدیران گروه به عنوان مدیر فرعی(Moderator) ربات
•دسترسی : تنها مدیر اصلی
————
`/promote [ID | Reply]`
ترفیع [شناسه کاربری | ریپلای]
> ترفیع یک کاربر و تنظیم او به عنوان مدیر فرعی(Moderator) ربات در گروه
•دسترسی : تنها مدیر اصلی

`/modlist`
لیست مدیران فرعی
> نمایش لیست مدیران فرعی ربات در گروه
•دسترسی : مدیران فرعی و اصلی
————
`/setowner [ID | Reply]`
تنظیم مدیر اصلی [شناسه کاربری | ریپلای]
> تنظیم مدیر اصلی ربات در گروه (Owner)
•دسترسی : تنها مدیر اصلی

`/owner`
مدیر اصلی
> نمایش شناسه کاربری مدیر اصلی ربات در گروه
•دسترسی : همه اعضا
————
`/setlink`
تنظیم لینک
> تنظیم لینک گروه برای ربات
•دسترسی : تنها مدیر اصلی

`/link`
لینک
> دریافت لینک تنظیم شده گروه
•دسترسی : همه اعضا
————
`/setrules (Word)`
تنظیم قوانین (متن-قوانین)
> تنظیم متن قوانین گروه
•دسترسی : تنها مدیر اصلی

`/rules`
قوانین
> دریافت قوانین تنظیم شده گروه
•دسترسی : همه اعضا
————
`/ping`
پینگ
> تست فعالیت ربات
•دسترسی : همه اعضا
————
`/card`
شماره کارت
> دریافت شماره کارت  برای خریداری کردن ربات
•دسترسی : همه اعضا
————
`/filter (Word)`
فیلتر (کلمه)
> فیلتر کردن یک کلمه در گروه (ممنوع کردن آن کلمه)
•دسترسی : مدیران فرعی و اصلی

`/rf (Word)`
رفع فیلتر (کلمه)
> رفع فیلتر یک کلمه در گروه (آزاد کردن استفاده از آن)
•دسترسی : مدیران فرعی و اصلی

`/filterlist`
لیست فیلتر
> نمایش لیست کلمات فیلتر شده
•دسترسی : مدیران فرعی و اصلی
————
`/del [Reply]`
حذف پیام [ریپلای]
> حذف یک پیام با ریپلای بر آن.
•دسترسی : مدیران فرعی و اصلی
————
`/rename (NewGroupName)`
تغییر نام (نام-جدید-گروه)
> تغییر نام گروه
•دسترسی : تنها مدیر اصلی
————
`/gpinfo`
اطلاعات گروه
> نمایش اطلاعات گروه
•دسترسی : همه اعضا
————
`/setwlc (Text)`
تنظیم متن خوشامد (متن)
> تنظیم متن خوشامد گویی ربات هنگام ورود کاربران جدید
•دسترسی : تنها مدیر اصلی
————
`/clean [rules | wlc | banlist | silentlist | filterlist | modlist | link]`
پاکسازی [قوانین | خوشامد | لیست مسدود | لیست سایلنت | لیست فیلتر | لیست مدیران فرعی | لینک]
> پاکسازی موارد ذکر شده
•دسترسی : مدیر اصلی
+ پاکسازی همه این موارد در پنل شیشه ای ربات نیز وجود دارد.
————
`/myrank`
مقام من
> نمایش مقام کاربر در گروه
•دسترسی : همه اعضا
————
`/rmsg`
پاکسازی پیام
> پاکسازی آخرین پیام های گروه تا حد ممکن
•دسترسی : مدیران فرعی و اصلی
————
`/setphoto [Reply]`
تنظیم عکس [ریپلای]
> تنظیم عکس گروه با ریپلای بر یک عکس.
•دسترسی : تنها مدیر اصلی

`/delphoto`
حذف عکس
> حذف عکس پروفایل تنظیم شده گروه.
•دسترسی : تنها مدیر اصلی
————
`/setwarn (2-10)`
تنظیم اخطار (2-10)
> تنظیم حداکثر اخطار ها
•دسترسی : تنها مدیر اصلی

`/warn [Reply]`
اخطار [ریپلای]
> دادن یک اخطار به کاربر با ریپلای
•دسترسی : مدیر اصلی و فرعی

`/warn (Number) [Reply]`
اخطار (عدد) [ریپلای]
> دادن اخطار به تعداد دلخواه به کاربر
•دسترسی : مدیر اصلی و فرعی

`/unwarn [Reply]`
حذف اخطار [ریپلای]
> حذف یکی از اخطار های کاربر با ریپلای
•دسترسی : مدیر اصلی و فرعی

`/unwarn (Number) [Reply]`
حذف اخطار (عدد) [ریپلای]
> حذف اخطار های کاربر به تعداد دلخواه با ریپلای
•دسترسی : مدیر اصلی و فرعی
————]]

BotHelp[2] = [[▪️آموزش دستورات جهت مدیریت کاربران:
————
`/ban [ID | Reply]`
مسدود [شناسه کاربری | ریپلای]
> مسدود/رفع مسدودیت یک کاربر در گروه
•دسترسی : مدیران فرعی و اصلی

`/banlist`
لیست مسدود
> نمایش لیست کاربران مسدود در گروه
•دسترسی : مدیران فرعی و اصلی
————
`/silent [ID | Reply]`
سایلنت [شناسه کاربری | ریپلای]
> سایلنت/رفع سایلنت یک کاربر در گروه
•دسترسی : مدیران فرعی و اصلی

`/silentlist`
لیست سایلنت
> نمایش لیست کاربران سایلنت شده در گروه
•دسترسی : مدیران فرعی و اصلی
————
`/kick [ID | Reply]`
اخراج [شناسه کاربری | ریپلای]
> اخراج کردن یک کاربر در گروه
•دسترسی : مدیران فرعی و اصلی
————]]

BotHelp[3] = [[▪️آموزش دستورات سرگرمی ربات :
————
`/time`
زمان
> نمایش زمان کنونی
•دسترسی : همه اعضا
————
`/date`
تاریخ
> نمایش اطلاعات کاملی از تاریخ کنونی
•دسترسی : همه اعضا
————
`/sticker (word)`
استیکر (متن)
> ساخت استیکر با متن درخواستی
•دسترسی : همه اعضا
————
`/short (link)`
کوتاه (لینک)
> کوتاه کردن لینک مورد نظر
•دسترسی : همه اعضا
————
`/tr (word)`
ترجمه (متن)
> ترجمه متن انگلیسی به پارسی
•دسترسی : همه اعضا
————
`/gif (style) (word)`
گیف (استایل) (متن)
> ساخت گیف با استایل و متن مورد نظر
لیست استایل ها :
{*blue, random, text, dazzle
prohibited, star, glitter, bliss,
flasher, roman}*
•دسترسی : همه اعضا
————
`/logo (1-7) (text)`
لوگو (1-7) (متن)
> ساخت لوگو با مدل و متن مورد نظر.
•دسترسی : همه اعضا
————
`/voice (text)`
ویس (متن)
> ساخت ویس به زبان انگلیسی.
•دسترسی : همه اعضا
————
`/weather (city)`
هوا (نام-شهر)
> نمایش وضعیت آب و هوای شهر مورد نظر
+شهر مورد نظر به انگلیسی نوشته شود.
•دسترسی : همه اعضا
————
`/beauty (Word)`
زیباسازی (متن)
> زیباسازی متن مورد نظر
•دسترسی : همه اعضا
————
`/aparat (Word)`
آپارات (متن)
> جستجوی متن دلخواه در وبسایت آپارات
•دسترسی : همه اعضا
————]]
-------------------

-- Bot Token Setting
BaseUrl = "https://api.telegram.org/bot"..https://t.me/joinchat/.."/"

function vardump(value)
	print(Color.pYellow.."=================== START Vardump ==================="..Color.pReset)
	print(ser//pent.block(value, {comment=false}))
	print(Color.pYellow.."=================== END Vardump ==================="..Color.pReset)
	local Text = "```"
	.."\n"..serpent.block(value, {comment=false})
	.."\n```"
end

function getRes(Url)
	Url = BaseUrl..Url
	Req = https.request(Url)
	Res = JSON.decode(Req)
	-- vardump(Res)
	return Res
end

function opizoLink(Url)
	local Opizo = http.request('http://enigma-dev.ir/api/opizo/?url='..URL.escape(Url))
	if Opizo then
		if json:decode(Opizo) then
			OpizoJ = json:decode(Opizo)
			return OpizoJ.result or OpizoJ.description
		end
	end
end

if not Config.BotToken or Config.BotToken == "" then
	print(Color.Red.."    *ERROR => Token is not Available in Config.lua File. Set That and Try Again."..Color.Reset)
	return false
elseif not getRes("getMe").ok then
	print(Color.Red.."    *ERROR => Token Unauthorized. Check your Token Again and Change that on Config.lua"..Color.Reset)
	return false
elseif getRes("getWebhookInfo").result.url ~= "" then
	print(Color.Red.."    *ERROR => Webhook was Set. Webhook and getUpdate can't Work togheter."..Color.Reset)
	io.write("~> Do you want to Remove Webhook From Bot ? [Y/N] : ")
	UserAnswer = io.read():lower()
	if UserAnswer == "yes" or UserAnswer == "y" then
		if getRes("setWebhook").description == "Webhook was deleted" then
			print(Color.Green.."    *Success => Webhook deleted From Your Bot. You can use getUpdates now."..Color.Reset)
		elseif getRes("setWebhook").description == "Webhook is already deleted" then
			print(Color.Green.."    *Success => Webhook is already deleted From Your Bot. You can use getUpdates now."..Color.Reset)
		else
			print("    *ERROR => Unknown Error Occurred.")
			return false
		end
	else
		print(Color.Yellow.."Ok!, No Problem, Bye For now."..Color.Reset)
		return false
	end
elseif not Config.GeneralSudoId or Config.GeneralSudoId == nil then
	print(Color.Red.."    *ERROR => GeneralSudoId isn's Set in Config.lua, Set it and try Again."..Color.Reset)
	return false
end
--------------------

-- Bot Info
BotName = getRes("getMe").result.first_name or false
BotUsername = getRes("getMe").result.username or false
BotId = getRes("getMe").result.id or false
-----------

--> FUNCTIONS <--

-- Sleep Function
function sleep(sec)
    socket.sleep(sec)
end

-- Dl_Cb Function
function dl_cb(arg, data)
	--vardump(arg)
end

-- Sec to Time
function secToTime(Sec)
	if (tonumber(Sec) == nil) or (tonumber(Sec) == 0) then
		return {Day = 0, Hour = 0, Min = 0, Sec = 0}
	else
		Seconds = math.floor(tonumber(Sec))
		Day = math.floor(Seconds / 86400)
		Hour = math.floor( (Seconds - (Day*86400))/3600 )
		Min = math.floor( ((Seconds) - ( (Day*86400) + (Hour*3600) )) / 60)
		Sec = math.floor(Seconds - ((Day*86400) + (Hour*3600) + (Min*60)))
	  return {Day = Day, Hour = Hour, Min = Min, Sec = Sec}
	end
end

-- No HTML Codes
function noHtml(String)
	String = String:gsub("<code>", "")
	String = String:gsub("</code>", "")
	String = String:gsub("<b>", "")
	String = String:gsub("</b>", "")
	String = String:gsub("<i>", "")
	String = String:gsub("</i>", "")
	String = String:gsub("<pre>", "")
	String = String:gsub("</pre>", "")
	String = String:gsub
	String = String:gsub("</user>", "")
 return String
end

-- Load File in JSON Format Function
function loadJson(FilePath)
	local File = io.open(FilePath)
	if not File then
		return {}
	end
	local ReadedDatas = File:read("*all")
	File:close()
	local Data = json:decode(ReadedDatas)
	return Data
end

function saveJson(FilePath, Data)
	local JsonEncodedDatas = json:encode(Data)
	local File = io.open(FilePath, "w")
	File:write(JsonEncodedDatas)
	File:close()
end

-- Download To File ...
function downloadToFile(url, file_name, file_path)
  print("    Url to Download => "..url)

  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }

  -- nil, code, headers, status
  local response = nil

  if url:starts('https') then
    options.redirect = false
    response = {https.request(options)}
  else
    response = {http.request(options)}
  end

  local code = response[2]
  local headers = response[3]
  local status = response[4]

  if code ~= 200 then return nil end

  file_path = file_path.."/"..file_name

  print("    File Saved to => "..file_path)

  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()

  return file_path
end

-- Returns true if String starts with Start
function string:starts(text)
	return text == string.sub(self,1,string.len(text))
end

-- String Split
function string:split(sep)
	local sep, fields = sep or ":", {}
	local pattern = string.format("([^%s]+)", sep)
	self:gsub(pattern, function(c) fields[#fields+1] = c end)
 return fields
end

-- getUpdates Function
local function getUpdates(Offset)
	local response = {}
	local success, code, headers, status  = https.request{
		url = BaseUrl..'/getUpdates?timeout=20&limit=1&offset='..(Offset or ""),
		method = "POST",
		sink = ltn12.sink.table(response),
	}
	local body = table.concat(response or {"no response"})
	if (success == 1) then
		return JSON.decode(body)
	else
		return nil, "Request Error"
	end
end

function getParseMode(ParseMode)
	if ParseMode:lower() == "html" then
		P = "HTML"
	elseif ParseMode:lower() == "md" or ParseMode:lower() == "markdown" then
		P = "Markdown"
	else
		P = ""
	end
 return P
end

function firstUpdate()
	local Url = "getUpdates?offset=-1"
 return getRes(Url)
end

function sendText(ChatId, Text, ReplyToMessageId, ParseMode, ReplyMarkup, DisableWebPagePreview)
	if not ChatId or not Text then
		print(Color.Red.."    *ERROR => ChatId or Text Didn't Set For Method [sendMessage]."..Color.Reset)
		return false
	end
	local Url = "sendMessage?chat_id="..ChatId.."&text="..URL.escape(Text)
	if ReplyToMessageId then
		Url = Url.."&reply_to_message_id="..ReplyToMessageId
	end
	if ParseMode then
		Url = Url.."&parse_mode="..getParseMode(ParseMode)
	end
	if ReplyMarkup then
		Url = Url.."&reply_markup="..(json:encode(ReplyMarkup))
	end
	if DisableWebPagePreview then
		Url = Url.."&disable_web_page_preview=true"
	end
 return getRes(Url)
end

function getChat(ChatId)
	if not ChatId then
		print(Color.Red.."ChatId is not Set for Method [getChat]"..Color.Reset)
		return false
	end
	Url = "getChat?chat_id="..ChatId
	local Res = getRes(Url)
	if not Res.ok or not Res.result or not Res.result.title then
		return {title = "----", type = "----"}
	end
  return {title = Res.result.title, type = Res.result.title}
end

function forwardMessage(ChatId, FromChatId, MessageId)
	if not ChatId or not FromChatId or not MessageId then
		print(Color.Red.."    *ERROR => ChatId or FromChatId or MessageId isn't Set for Method [forwardMessage]"..Color.Reset)
		return false
	end
	local Url = "forwardMessage?chat_id="..ChatId.."&from_chat_id="..FromChatId.."&message_id="..MessageId
 return getRes(Url)
end

function (ChatId, MessageId)
	if not ChatId or not MessageId then
		print(Color.Red.."    *ERROR => ChatId or MessageId Didn't Set For Method [deleteMessage]."..Color.Reset)
		return false
	end
	local Url = "deleteMessage?chat_id="..ChatId.."&message_id="..MessageId
 return getRes(Url)
end

function editMessageText(Text, InlineMessageId, ChatId, MessageId, ParseMode, ReplyMarkup)
	if not Text then
		print(Color.Red.."    *ERROR => Text is not Set For Method [editMessageText]"..Color.Reset)
		return false
	end
	local Url = "editMessageText?text="..URL.escape(Text)
	if InlineMessageId then
		Url = Url.."&inline_message_id="..InlineMessageId
	elseif ChatId and MessageId then
		Url = Url.."&chat_id="..ChatId.."&message_id="..MessageId
	else
		print(Color.Red.."    *ERROR => Both InlineMessageId and (ChatId and MessageId) Are not Set For Method [editMessageText]"..Color.Reset)
		return false
	end
	if ParseMode then
		Url = Url.."&parse_mode="..getParseMode(ParseMode)
	end
	if ReplyMarkup then
		Url = Url.."&reply_markup="..URL.escape(json:encode(ReplyMarkup))
	end
 return getRes(Url)
end

function editMessageReplyMarkup(ReplyMarkup, InlineMessageId, ChatId, MessageId)
	if not ReplyMarkup then
		print(Color.Red.."    *ERROR => ReplyMarkup is not Set For Method [editMessageReplyMarkup]"..Color.Reset)
		return false
	end
	local Url = "editMessageReplyMarkup?reply_markup="..URL.escape(json:encode(ReplyMarkup))
	if InlineMessageId then
		Url = Url.."&inline_message_id="..InlineMessageId
	elseif ChatId and MessageId then
		Url = Url.."&chat_id="..ChatId.."&message_id="..MessageId
	else
		print(Color.Red.."    *ERROR => Both InlineMessageId and (ChatId and MessageId) Are not Set For Method [editMessageReplyMarkup]"..Color.Reset)
		return false
	end
 return getRes(Url)
end

function answerCallbackQuery(CallbackQueryId, Text, ShowAlert)
	if not CallbackQueryId or not Text then
		print("    *ERROR => CallbackQueryId or Text is not Set For Method [answerCallbackQuery]")
		return false
	end
	local Url = "answerCallbackQuery?callback_query_id="...."&text="..URL.escape(Text)
	if ShowAlert then
		Url = Url.."&show_alert=true"
	end
 return getRes(Url)
end

function deleteMessage(ChatId, MessageId) -- Deleting Messages function
	if not ChatId or not MessageId then
		print(Color.Red.."    *ERROR => ChatId or MessageId is not Set For Method [deleteMessage]"..Color.Reset)
		return false
	end
	Url = "deleteMessage?chat_id="..ChatId.."&message_id="..MessageId
 return getRes(Url)
end

------------------------ Sending Document ------------------------------
function sendDocument(ChatId, Documnet, ReplyToMessageId, Caption)
	if not ChatId or not Documnet then
		print(Color.Red.."    *ERROR => ChatId or Documnet is not Set For Method [sendDocument]"..Color.Reset)
		return false
	end
	local Url = BaseUrl.."sendDocument"
    curl_context:setopt_url(Url)
    local form = curl.form()
    form:add_content("chat_id", ChatId)
    form:add_file("document", Documnet)
	if ReplyToMessageId then
		form:add_content("reply_to_message_id", ReplyToMessageId)
	end
	if Caption then
		form:add_content("caption", Caption)
	end
    data = {}
    local c = curl_context:setopt_writefunction(table.insert, data)
                          :setopt_httppost(form)
                          :perform()

 return table.concat(data), c:getinfo_response_code()
end

function sendDocumentById(ChatId, Documnet, ReplyToMessageId, Caption, ReplyMarkup)
	if not ChatId or not Documnet then
		print(Color.Red.."    *ERROR => ChatId or Documnet is not Set For Method [sendDocument]"..Color.Reset)
		return false
	end
	local Url = "sendDocument?chat_id="..ChatId.."&document="..Documnet
	if ReplyToMessageId then
		Url = Url.."&reply_to_message_id="..ReplyToMessageId
	end
	if Caption then
		Url = Url.."&caption="..URL.escape(Caption)
	end
	if ReplyMarkup then
		Url = Url.."&reply_markup="..URL.escape(json:encode(ReplyMarkup))
	end
 return getRes(Url)
end
--------------------------------------------------------------------

----------------------------- Sending Photo ------------------------
function sendPhoto(ChatId, Photo, ReplyToMessageId, Caption)
	if not ChatId or not Photo then
		print(Color.Red.."    *ERROR => ChatId or Photo isn't Set for Method [sendPhoto]"..Color.Reset)
		return false
	end

	local Url = BaseUrl.."sendPhoto"
    curl_context:setopt_url(Url)
    local form = curl.form()
    form:add_content("chat_id", ChatId)
    form:add_file("photo", Photo)
	if ReplyToMessageId then
		form:add_content("reply_to_message_id", ReplyToMessageId)
	end
	if Caption then
		form:add_content("caption", Caption)
	end
    data = {}
    local c = curl_context:setopt_writefunction(table.insert, data)
                          :setopt_httppost(form)
                          :perform()

 return table.concat(data), c:getinfo_response_code()
end

function sendPhotoById(ChatId, Photo, ReplyToMessageId, Caption, ReplyMarkup)
	if not ChatId or not Photo then
		print(Color.Red.."    *ERROR => ChatId or Photo is not Set For Method [sendPhoto]"..Color.Reset)
		return false
	end

	local Url = "sendPhoto?chat_id="..ChatId.."&photo="..Photo
	if ReplyToMessageId then
		Url = Url.."&reply_to_message_id="..ReplyToMessageId
	end
	if Caption then
		Url = Url.."&caption="..URL.escape(Caption)
	end
	if ReplyMarkup then
		Url = Url.."&reply_markup="..URL.escape(json:encode(ReplyMarkup))
	end
 return getRes(Url)
end
-------------------------------------------------------------------
function sendVoice(ChatId, Voice, ReplyToMessageId, Caption)
	if not ChatId or not Voice then
		print(Color.Red.."    *ERROR => ChatId or Voice isn't Set For Method [sendVoice]"..Color.Reset)
		return false
	end

	local Url = BaseUrl.."sendVoice"
    curl_context:setopt_url(Url)
    local form = curl.form()
    form:add_content("chat_id", ChatId)
    form:add_file("voice", Voice)
	if ReplyToMessageId then
		form:add_content("reply_to_message_id", ReplyToMessageId)
	end
	if Caption then
		form:add_content("caption", Caption)
	end
    data = {}
    local c = curl_context:setopt_writefunction(table.insert, data)
                          :setopt_httppost(form)
                          :perform()

 return table.concat(data), c:getinfo_response_code()
end

function setChatPhoto(ChatId, Photo)
	if not ChatId or not Photo then
		print(Color.Red.."    *ERROR => ChatId or Photo isn't Set For Method [setChatPhoto]"..Color.Reset)
		return false
	end

	local Url = BaseUrl.."setChatPhoto"
    curl_context:setopt_url(Url)
    local form = curl.form()
    form:add_content("chat_id", ChatId)
    form:add_file("photo", Photo)
    data = {}
    local c = curl_context:setopt_writefunction(table.insert, data)
                          :setopt_httppost(form)
                          :perform()

 return table.concat(data), c:getinfo_response_code()
end

function sendSticker(ChatId, Sticker, ReplyToMessageId)
	if not ChatId or not Sticker then
		print(Color.Red.."    *ERROR => ChatId or Sticker isn't Set For Method [sendSticker]"..Color.Reset)
		return false
	end

	local url = BaseUrl..'sendSticker'
    curl_context:setopt_url(url)
    local form = curl.form()
    form:add_content("chat_id", ChatId)
    form:add_file("sticker", Document)
	if ReplyToMessageId then
		form:add_content("reply_to_message_id", ReplyToMessageId)
	end
    data = {}
    local c = curl_context:setopt_writefunction(table.insert, data)
                          :setopt_httppost(form)
                          :perform()
 return table.concat(data), c:getinfo_response_code()
end

function sendStickerById(ChatId, Sticker, ReplyToMessageId, ReplyMarkup)
	if not ChatId or not Sticker then
		print(Color.Red.."    *ERROR => ChatId or Sticker isn't Set For Method [sendStickerById]"..Color.Reset)
		return false
	end

	Url = "sendSticker?chat_id="..ChatId.."&sticker="..Sticker
	if ReplyToMessageId then
		Url = Url.."&reply_to_message_id="..ReplyToMessageId
	end
	if ReplyMarkup then
		Url = Url.."&reply_markup="..URL.escape(json:encode(ReplyMarkup))
	end
 return getRes(Url)
end

function kickUser(ChatId, UserId, UntilDate)
	if not ChatId or not UserId then
		print(Color.Red.."    *ERROR => ChatId or UserId isn't Set For Method [kickUser]"..Color.Reset)
		return false
	end

	local Url = "kickChatMember?chat_id="..ChatId.."&user_id="..UserId
	if UntilDate then
		Url = Url.."&until_date="..UntilDate
	end
 return getRes(Url)
end
------------------

--> NORMAL Functions
function notMod(msg)
	local Text = [[`>` این قابلیت مخصوص مدیران فرعی و اصلی ربات در گروه میباشد.
» _شما دسترسی ندارید !_]]
	sendText(msg.chat.id, Text, msg.message_id, 'md')
end
function notOwner(msg)
	local Text = [[`>` این قابلیت تنها مخصوص مدیر اصلی ربات در گروه میباشد.
» _شما دسترسی ندارید !_]]
	sendText(msg.chat.id, Text, msg.message_id, 'md')
end
function notSudo(msg)
	local Text = [[`>` این قابلیت تنها مخصوص مدیر کل ربات میباشد.
» _شما دسترسی ندارید !_]]
	sendText(msg.chat.id, Text, msg.message_id, 'md')
end
function notReply(msg)
	local Text = [[» این عملیات بدون ریپلای(*Reply*) صورت میگیرد.]]
	sendText(msg.chat.id, Text, msg.message_id, 'md')
end

function isBot(UserId) --> is Bot or Not.
	local UserId = tonumber(UserId)
	if tonumber(BotId) == UserId then
		return true
	end
 return false
end

function isSudo(UserId) --> Is Sudo Or Not Function.
	local UserId = tonumber(UserId)
	if UserId == tonumber(Config.GeneralSudoId) then
		return true
	end
	for i=1, #Config.SudoIds do
		if tonumber(Config.SudoIds[i]) == UserId then
			return true
		end
	end
 return false
end

function isOwner(ChatId, UserId) --> Is Owner Or Not Function.
	local UserId = tonumber(UserId)
	local ChatId = tostring(ChatId)
	local Data = loadJson(Config.ModFile)

	if isSudo(UserId) then
		return true
	end
	if Data[(ChatId)] then
		if Data[tostring(ChatId)]["set_owner"] then
			if tonumber(Data[tostring(ChatId)]["set_owner"]) == UserId then
				return true
			end
		end
	end

 return false
end

function isMod(ChatId, UserId) --> Is Moderator Or Not Function.
	local UserId = tonumber(UserId)
	local ChatId = tostring(ChatId)
	local Data = loadJson(Config.ModFile)

	if isSudo(UserId) then
		return true
	end
	if isOwner(ChatId, UserId) then
		return true
	end
	if Data[tostring(ChatId)] then
		if Data[tostring(ChatId)]["moderators"] then
			if Data[tostring(ChatId)]["moderators"][tostring(UserId)] then
				return true
			end
		end
	end

 return false
end

function isSilentUser(ChatId, UserId)
	UserId = tonumber(UserId)
	SilentUsersHash = SilentHash..ChatId
	if redis:sismember(SilentUsersHash, UserId) then
		return true
	end
  return false
end

function isGBannedUser(UserId)
	UserId = tonumber(UserId)
	if redis:sismember(GBanHash, UserId) then
		return true
	end
 return false
end

function isBannedUser(ChatId, UserId)
	UserId = tonumber(UserId)
	BanUsersHash = BanHash..ChatId
	if redis:sismember(BanUsersHash, UserId) then
		return true
	end
 return false
end

function getSettings(ChatId, PageNum)
	Data = loadJson(Config.ModFile)
	Settings = Data[tostring(ChatId)]['settings']
	PageNum = tonumber(PageNum)

	if PageNum == 1 then
		-- General Locks
		if Settings.lock_link and Settings.lock_link == "yes" then
			lock_link = Enb
		else
			lock_link = Dis
		end

		if Settings.lock_edit and Settings.lock_edit == "yes" then
			lock_edit = Enb
		else
			lock_edit = Dis
		end

		if Settings.show_edit and Settings.show_edit == "yes" then
			show_edit = Enb
		else
			show_edit = Dis
		end

		if Settings.lock_forward and Settings.lock_forward == "yes" then
			lock_forward = Enb
		else
			lock_forward = Dis
		end

		if Settings.lock_cmd and Settings.lock_cmd == "yes" then
			lock_cmd = Enb
		else
			lock_cmd = Dis
		end

		if Settings.lock_english and Settings.lock_english == "yes" then
			lock_english = Enb
		else
			lock_english = Dis
		end

		if Settings.lock_arabic and Settings.lock_arabic == "yes" then
			lock_arabic = Enb
		else
			lock_arabic = Dis
		end

		if Settings.lock_spam and Settings.lock_spam == "yes" then
			lock_spam = Enb
		else
			lock_spam = Dis
		end

		if Settings.lock_bot and Settings.lock_bot == "yes" then
			lock_bot = Enb
		else
			lock_bot = Dis
		end

		if Settings.lock_flood and Settings.lock_flood == "yes" then
			lock_flood = Enb
		else
			lock_flood = Dis
		end

		if Settings.flood_num then
			flood_num = tonumber(Settings.flood_num)
		else
			flood_num = 5
		end

		if Settings.lock_tgservice and Settings.lock_tgservice == "yes" then
			lock_tgservice = Enb
		else
			lock_tgservice = Dis
		end

		-- Important Locks
		if Settings.lock_strict and Settings.lock_strict == "yes" then
			lock_strict = Enb
		else
			lock_strict = Dis
		end

		if Settings.lock_all and Settings.lock_all == "yes" then
			lock_all = Enb
		else
			lock_all = Dis
		end

		keyboard = {}
		keyboard.inline_keyboard =
			{
				-- General Locks
				{
					{text = lock_link, callback_data = ChatId..':locks:lock_link:1'} ,{text = 'قفل لینک', callback_data = ChatId..':locks:lock_link:1'}
				},
				{
					{text = lock_edit, callback_data = ChatId..':locks:lock_edit:1'} ,{text = 'قفل ویرایش', callback_data = ChatId..':locks:lock_edit:1'}
				},
				{
					{text = show_edit, callback_data = ChatId..':locks:show_edit:1'} ,{text = 'نمایش ویرایش', callback_data = ChatId..':locks:show_edit:1'}
				},
				{
					{text = lock_forward, callback_data = ChatId..':locks:lock_forward:1'} ,{text = 'قفل فروارد', callback_data = ChatId..':locks:lock_forward:1'}
				},
				{
					{text = lock_cmd, callback_data = ChatId..':locks:lock_cmd:1'} ,{text = 'قفل دستورات', callback_data = ChatId..':locks:lock_cmd:1'}
				},
				{
					{text = lock_english, callback_data = ChatId..':locks:lock_english:1'} ,{text = 'فیلتر متن انگلیسی', callback_data = ChatId..':locks:lock_english:1'}
				},
				{
					{text = lock_arabic, callback_data = ChatId..':locks:lock_arabic:1'} ,{text = 'قفل عربی/پارسی', callback_data = ChatId..':locks:lock_arabic:1'}
				},
				{
					{text = lock_spam, callback_data = ChatId..':locks:lock_spam:1'} ,{text = 'حذف پیام طولانی', callback_data = ChatId..':locks:lock_spam:1'}
				},
				{
					{text = lock_bot, callback_data = ChatId..':locks:lock_bot:1'} ,{text = 'قفل ربات(API)', callback_data = ChatId..':locks:lock_bot:1'}
				},
				{
					{text = lock_flood, callback_data = ChatId..':locks:lock_flood:1'} ,{text = 'قفل رگباری', callback_data = ChatId..':locks:lock_flood:1'}
				},
				{
					{text = "🔽 حساسیت رگباری 🔽", callback_data = "---"}
				},
				{
					{text = "➖", callback_data = ChatId..":locks:minus_flood:1"}, {text = tostring(flood_num), callback_data = "---"}, {text = "➕", callback_data = ChatId..":locks:plus_flood:1"}
				},
				{
					{text = lock_tgservice, callback_data = ChatId..':locks:lock_tgservice:1'} ,{text = 'حذف پیام ورود/خروج', callback_data = ChatId..':locks:lock_tgservice:1'}
				},

				-- Important Locks
				{
					{text = lock_strict, callback_data = ChatId..':locks:lock_strict:1'} ,{text = 'شرایط سخت', callback_data = ChatId..':locks:lock_strict:1'}
				},
				{
					{text = lock_all, callback_data = ChatId..':locks:lock_all:1'} ,{text = 'قفل چت', callback_data = ChatId..':locks:lock_all:1'}
				},

				-- Extra Buttons
				{
					{text = "▶️ صفحه بعدی", callback_data = ChatId..':showmenu:generalsettings:2'}
				},
				{
					{text = "بازگشت به منو اصلی ↩", callback_data = ChatId..':showmenu:mainmenu:1'}
				},

			}
		return keyboard

	elseif PageNum == 2 then
		-- Fun Locks
		if Settings.lock_wlc and Settings.lock_wlc == "yes" then
			lock_wlc = Enb
		else
			lock_wlc = Dis
		end

		if Settings.lock_bye and Settings.lock_bye == "yes" then
			lock_bye = Enb
		else
			lock_bye = Dis
		end

		-- Tag and Username and Abuse Locks
		if Settings.lock_abuse and Settings.lock_abuse == "yes" then
			lock_abuse = Enb
		else
			lock_abuse = Dis
		end

		if Settings.lock_tag and Settings.lock_tag == "yes" then
			lock_tag = Enb
		else
			lock_tag = Dis
		end

		if Settings.lock_username and Settings.lock_username == "yes" then
			lock_username = Enb
		else
			lock_username = Dis
		end

		--- M E D I A S
		if Settings.lock_sticker and Settings.lock_sticker == 'yes' then
			lock_sticker = Enb
		else
			lock_sticker = Dis
		end

		if Settings.lock_audio and Settings.lock_audio == "yes" then
			lock_audio = Enb
		else
			lock_audio = Dis
		end

		if Settings.lock_voice and Settings.lock_voice == "yes" then
			lock_voice = Enb
		else
			lock_voice = Dis
		end

		if Settings.lock_photo and Settings.lock_photo == 'yes' then
			lock_photo = Enb
		else
			lock_photo = Dis
		end

		if Settings.lock_video and Settings.lock_video == "yes" then
			lock_video = Enb
		else
			lock_video = Dis
		end

		if Settings.lock_text and Settings.lock_text == "yes" then
			lock_text = Enb
		else
			lock_text = Dis
		end

		if Settings.lock_document and Settings.lock_document == 'yes' then
			lock_document = Enb
		else
			lock_document = Dis
		end

		if Settings.lock_gif and Settings.lock_gif == "yes" then
			lock_gif = Enb
		else
			lock_gif = Dis
		end

		if Settings.lock_contact and Settings.lock_contact == "yes" then
			lock_contact = Enb
		else
			lock_contact = Dis
		end
		--------

		keyboard = {}
		keyboard.inline_keyboard =
			{
				-- Fun Locks
				{
					{text = lock_wlc, callback_data = ChatId..':locks:lock_wlc:2'} ,{text = 'پیام خوش‌آمد گویی', callback_data = ChatId..':locks:lock_wlc:2'}
				},
				{
					{text = lock_bye, callback_data = ChatId..':locks:lock_bye:2'} ,{text = 'پیام خداحافظی', callback_data = ChatId..':locks:lock_bye:2'}
				},

				-- Tag and username and abuse Lock
				{
					{text = lock_abuse, callback_data = ChatId..':locks:lock_abuse:2'} ,{text = 'قفل فحش', callback_data = ChatId..':locks:lock_abuse:2'}
				},
				{
					{text = lock_tag, callback_data = ChatId..':locks:lock_tag:2'} ,{text = 'قفل تگ(#)', callback_data = ChatId..':locks:lock_tag:2'}
				},
				{
					{text = lock_username, callback_data = ChatId..':locks:lock_username:2'} ,{text = 'قفل یوزرنیم(@)', callback_data = ChatId..':locks:lock_username:2'}
				},
				-- Media Locks
				{
					{text = lock_sticker, callback_data = ChatId..':locks:lock_sticker:2'} ,{text = 'قفل استیکر', callback_data = ChatId..':locks:lock_sticker:2'}
				},
				{
					{text = lock_audio, callback_data = ChatId..':locks:lock_audio:2'} ,{text = 'قفل صدا', callback_data = ChatId..':locks:lock_audio:2'}
				},
				{
					{text = lock_voice, callback_data = ChatId..':locks:lock_voice:2'} ,{text = 'قفل وویس', callback_data = ChatId..':locks:lock_voice:2'}
				},
				{
					{text = lock_photo, callback_data = ChatId..':locks:lock_photo:2'} ,{text = 'قفل تصاویر', callback_data = ChatId..':locks:lock_photo:2'}
				},
				{
					{text = lock_video, callback_data = ChatId..':locks:lock_video:2'} ,{text = 'قفل ویدیو', callback_data = ChatId..':locks:lock_video:2'}
				},
				{
					{text = lock_text, callback_data = ChatId..':locks:lock_text:2'} ,{text = 'قفل متن', callback_data = ChatId..':locks:lock_text:2'}
				},
				{
					{text = lock_document, callback_data = ChatId..':locks:lock_document:2'} ,{text = 'قفل فایل', callback_data = ChatId..':locks:lock_document:2'}
				},
				{
					{text = lock_gif, callback_data = ChatId..':locks:lock_gif:2'} ,{text = 'قفل گیف(تصویر متحرک)', callback_data = ChatId..':locks:lock_gif:2'}
				},
				{
					{text = lock_contact, callback_data = ChatId..':locks:lock_contact:2'} ,{text = 'قفل ارسال مخاطب', callback_data = ChatId..':locks:lock_contact:2'}
				},

				-- Extra Buttons
				{
					{text = "صفحه قبلی ◀️", callback_data = ChatId..':showmenu:generalsettings:1'}
				},
			}

		return keyboard
	end
end

-- Get Moderators Accesses in Group ...
function getModsAccess(ChatId, Page)
	local Hash = ModeratorsSettingsHash..ChatId
	local Page = tonumber(Page)
	if redis:hget(Hash, "inlinepanel") then
		InlinePanel = Access
	else
		InlinePanel = NotAccess
	end

	if Page == 1 then
		keyboard = {}
		keyboard.inline_keyboard =
			{
				{
					{text = InlinePanel, callback_data = ChatId..":modsaccess:inlinepanel:1"},
					{text = "دسترسی کار با پنل", callback_data = ChatId..":modsaccess:inlinepanel:1"}
				},
				{
					{text = "بازنگری/Update 🔃", callback_data = ChatId..":showmenu:modsaccess:1"},
				},
				{
					{text = "منو اطلاعات گروه ↩️", callback_data = ChatId..":showmenu:groupinfo:1"},
				},
			}
	end
 return keyboard
end
--------------------

--------------------
ChargeAlert = {}
ChargeAlert.OneWeekLeft = {}
ChargeAlert.ThreeDaysLeft = {}
function chargePlugin(msg) --> CHARGE.LUA !

	Data = loadJson(Config.ModFile)
	if not Data[tostring(msg.chat.id)] then
		return
	end

	Hash = ChargeHash..msg.chat.id -- ChargeHash For Group

	ChargeLeftInSec = tonumber(redis:ttl(Hash))

	-----------------------------------
	if ChargeLeftInSec >= DayInSec*3 and ChargeLeftInSec <= WeekInSec then -- If Group Charge Was Less Than One Week ...
		TextForGroup = [[#اطلاعیه
🔋از شارژ این گروه کمتر از 1 هفته باقی مانده.
در صورت تمام شدن شارژ گروهتون ربات از این گروه خارج میشود.
🔌 جهت شارژ مجدد گروه خود اقدام کنید.

🔑 دستور دریافت شارژ باقی مانده از گروه :
/expire
]]
		TextForOwner = "#اطلاعیه"
		.."\n🔋از شارژ گروه شما با نام"
		.."\n"..(msg.chat.title or "")
		.."\nکمتر از 1هفته باقی مانده است."
		.."\nدر صورت تمام شدن شارژ گروهتون، ربات از اونجا خارج میشه!"
		.."\n🔌 جهت شارژ مجدد گروه خود اقدام کنید."
		if not ChargeAlert.OneWeekLeft[tostring(msg.chat.id)] then
			sendText(msg.chat.id, TextForGroup)
			if Data[tostring(msg.chat.id)]["set_owner"] and tostring(Data[tostring(msg.chat.id)]['set_owner']) ~= "0" then
				GroupOwner = tonumber(Data[tostring(msg.chat.id)]['set_owner'])
				sendText(GroupOwner, TextForOwner)
			end
			ChargeAlert.OneWeekLeft[tostring(msg.chat.id)] = true
		end
		-----------------------------------
	elseif ChargeLeftInSec <= DayInSec*3 and ChargeLeftInSec >= DayInSec then -- If Group Charge Was Less Than 3Days ...
		TextForGroup = [[#اطلاعیه
🔋از شارژ این گروه کمتر از 3 روز باقی مانده.
در صورت تمام شدن شارژ گروهتون ربات از این گروه خارج میشود.
🔌 جهت شارژ مجدد گروه خود اقدام کنید.

🔑 دستور دریافت شارژ باقی مانده از گروه :
/expire
]]
		TextForOwner = "#اطلاعیه"
		.."\n🔋از شارژ گروه شما با نام"
		.."\n"..(msg.chat.title or "")
		.."\nکمتر از 3روز باقی مانده است!"
		.."\nدر صورت تمام شدن شارژ گروهتون، ربات از اونجا خارج میشه!"
		.."\n🔌 جهت شارژ مجدد گروه خود اقدام کنید."
		if not ChargeAlert.ThreeDaysLeft[tostring(msg.chat.id)] then
			sendText(msg.chat.id, TextForGroup)
			if Data[tostring(msg.chat.id)]["set_owner"] and tostring(Data[tostring(msg.chat.id)]['set_owner']) ~= "0" then
				GroupOwner = tonumber(Data[tostring(msg.chat.id)]['set_owner'])
				sendText(GroupOwner, TextForOwner)
			end
			ChargeAlert.ThreeDaysLeft[tostring(msg.chat.id)] = true
		end
		-----------------------------------
	elseif tostring(redis:ttl(Hash)) == "-2" and tostring(redis:get(Hash)):lower() ~= "unlimit" then -- If Group Charge Ends ...
		TextForGroup =  "🚫 شارژ این گروه به پایان رسید."
		.."\nجهت شارژ مجدد این گروه به ما پیام دهید :"
		.."\n"..Config.SupportBot
		--
		if Data[tostring(msg.chat.id)]['set_owner'] and tostring(Data[tostring(msg.chat.id)]['set_owner']) ~= "0" then
			GroupOwner = tonumber(Data[tostring(msg.chat.id)]['set_owner'])
			Text = "🔻 شارژ گروه شما با نام"
			.."\n"..(msg.chat.title or "---")
			.."\n و شناسه"
			.."\n"..msg.chat.id
			.."\nبه پایان رسیده است !"
			.."\n> جهت شارژ به ما پیام دهید :"
			.."\n"..Config.SupportBot
			sendText(GroupOwner, Text)
		else
			GroupOwner = 'تنظیم نشده!'
		end
		if Data[tostring(msg.chat.id)]['settings']['set_link'] then
			GroupLink = Data[tostring(msg.chat.id)]['settings']['set_link']
		else
			GroupLink = "تنظیم نشده!"
		end
		TextForSudo = "🚫 شارژ یک گروه تمام شد !"
		..'\n'
		.."\n— مشخصات گروه :"
		.."\nنام گروه : <b>"..msg.chat.title.."</b>"
		.."\nشناسه گروه : <code>"..msg.chat.id.."</code>"
		.."\nشناسه مدیر اصلی : "..GroupOwner
		.."\nلینک ثبت شده : "..GroupLink
		.."\n"
		.."\n— دستورات پیشفرض :"
		..'\n<code>></code> دستور خروج ربات از آنجا :'
		..'\n<code>/exit '..msg.chat.id..'</code>'
		..'\n<code>></code> حذف گروه از لیست گروه ها :'
		..'\n<code>/rem '..msg.chat.id..'</code>'
		..'\n<code>></code> شارژ آن گروه برای 30روز :'
		..'\n<code>/charge '..msg.chat.id..' 30d</code>'
		sendText(msg.chat.id, TextForGroup)
		sendText(Config.GeneralSudoId, TextForSudo, 0, 'html')
		getRes("leaveChat?chat_id="..msg.chat.id)
	end

	if msg.text then
		Cmd = msg.text
		CmdLower = msg.text:lower()

		-- Charge Unlimit [in Group]
		if (CmdLower:match("^[/!#](charge) (.*)$") or Cmd:match("^(شارژ) (.*)$")) and isSudo(msg.from.id) then
			MatchesEN = {CmdLower:match("^[/!#](charge) (.*)$")}; MatchesFA = {Cmd:match("^(شارژ) (.*)$")}
			Ptrn = MatchesEN[2] or MatchesFA[2]
			if Ptrn == "unlimit" or Ptrn == "نامحدود" then
				if tostring(redis:get(Hash)):lower() == "unlimit" then
					Text = "`>` شارژ این گروه از قبل نامحدود بوده است."
					sendText(msg.chat.id, Text, msg.message_id, 'md')
					return
				end
				redis:set(Hash,"unlimit")
				Text = "`>` این گروه بصورت نامحدود شارژ شد. ✅"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
				return
			end
		end

		if (CmdLower:match("^[/!#](charge) (%d+)(.*)$") or Cmd:match("^(شارژ) (%d+)(.*)$")) and isSudo(msg.from.id) then -- lock options
			MatchesEN = {CmdLower:match("^[/!#](charge) (%d+)(.*)$")}; MatchesFA = {Cmd:match("^(شارژ) (%d+)(.*)$")}
			ChargeNum = tonumber(MatchesEN[2]) or tonumber(MatchesFA[2])
			ChargeType = MatchesEN[3] or MatchesFA[3]
			if (ChargeType:lower() == "m" or ChargeType == "دقیقه") then
				TimeInSec = ChargeNum * MinInSec
			elseif (ChargeType:lower() == "h" or ChargeType == "ساعت") then
				TimeInSec = ChargeNum * HourInSec
			elseif (ChargeType:lower() == "d" or ChargeType == "روز") then
				TimeInSec = ChargeNum * DayInSec
			elseif (ChargeType:lower() == "s" or ChargeType == "ثانیه") then
				TimeInSec = ChargeNum
			else
				Text = "`>` نوع شارژ باید یکی از عبارت های [روز،ساعت،دقیقه،ثانیه] باشه."
				.."\n`>` Charge type must be one of [*d*,*h*,*m*,*s*]"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
				return
			end

			A = secToTime(TimeInSec)
			StrDay = A.Day
			StrHour = A.Hour
			StrMin = A.Min
			StrSec = A.Sec
			redis:setex(Hash, TimeInSec, "true")
			Text = "`>` شارژ این گروه با شناسه `"..msg.chat.id.."` برای مدت"
			.."\n*"..StrDay.."*روز"
			.."\n*"..StrHour.."*ساعت"
			.."\n*"..StrMin.."*دقیقه"
			.."\nو *"..StrSec.."*ثانیه"
			.."\nتنظیم شد ✅"
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end

		if (CmdLower:match("^[/!#](expire)$") or Cmd:match("^(انقضا)$")) and isMod(msg.chat.id, msg.from.id) then
			if tostring(redis:get(Hash)):lower() == "unlimit" then
				ExpireText = "`>` شارژ این گروه نامحدود میباشد !"
			elseif tostring(redis:ttl(Hash)):lower() ~= "-2" then
				ExpireTime = redis:ttl(Hash)
				A = secToTime(ExpireTime)
				StrDay = A.Day
				StrHour = A.Hour
				StrMin = A.Min
				StrSec = A.Sec
				ExpireText = "🔂 از شارژ این گروه"
				.."\n*"..StrDay.."*روز"
				.."\n*"..StrHour.."*ساعت"
				.."\n*"..StrMin.."*دقیقه"
				.."\nو *"..StrSec.."*ثانیه"
				.."\nباقی مانده است."
				if http.request("http://enigma-dev.ir/api/unix-time-to-date/?unix_time="..os.time()+ExpireTime) then
					J = http.request("http://enigma-dev.ir/api/unix-time-to-date/?unix_time="..os.time()+ExpireTime)
					if json:decode(J) then
						K = json:decode(J)
						ExpireText = ExpireText
						.."\n"
						.."\n⌛️ شارژ این گروه در تاریخ "..K.JalaliDate.."، ساعت "..K.Time.." به پایان خواهد رسید."
					end
				end
			else
				ExpireText = "~> شارژ این گروه به پایان رسیده است !"
			end
			sendText(msg.chat.id, ExpireText, msg.message_id, 'md')
		end

	end -- end msg.text

end -- End CHARGE.LUA

function botModPlugin(msg) --> BOT_MOD.LUA !

	Data = loadJson(Config.ModFile)

	if msg.text then

		Cmd = msg.text
		CmdLower = msg.text:lower()

		--> CMD => //[Text] | Echo a message By Bot ...
		if Cmd:match("^(//)(.*)$") and isSudo(msg.from.id) then
			MatchesEN = {Cmd:match("^(//)(.*)$")}
			Text = MatchesEN[2]
			if msg.reply_to_message then
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id)
				if msg.chat.type ~= "private" then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			else
				sendText(msg.chat.id, Text)
				if msg.chat.type ~= "private" then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end

		--> CMD => /backup | Backup from different parts of bot ...
		if (CmdLower:match("^[/!#](backup) (.*)$") or Cmd:match("^(بکاپ) (.*)")) and isSudo(msg.from.id) then
			MatchesEN = {CmdLower:match("^[/!#](backup) (.*)$")}; MatchesFA = {Cmd:match("^(بکاپ) (.*)$")}
			ChizToBackup = MatchesEN[2] or MatchesFA[2]
			if ChizToBackup == "redis" or ChizToBackup == "ردیس" then
				io.popen("redis-cli save"):read("*all")
				RedisBackupFilePath = "/var/lib/redis/dump.rdb"
				Cap = "#Backup"
				.."\n> #Redis Backup 🔃"
				sendDocument(msg.from.id, RedisBackupFilePath, 0, Cap)
				Text = "`>` فایل پشتیبان #ردیس به خصوصی شما ارسال شد."
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			elseif ChizToBackup == "مدیریت" or ChizToBackup == "mod" or ChizToBackup == "moderation" then
				ModerationFilePath = "./data/moderation.json"
				Cap = "#Backup"
				.."\n> #Moderation File Backup 🔃"
				sendDocument(msg.from.id, ModerationFilePath, 0, Cap)
				Text = "`>` فایل پشتیبان #مدیریت گروه ها به خصوصی شما ارسال شد."
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			elseif ChizToBackup  == "کانفیگ" or ChizToBackup == "config" then
				ConfigFilePath = "./data/config.lua"
				Cap = "#Backup"
				.."\n> #Config File Backup 🔃"
				sendDocument(msg.from.id, ConfigFilePath, 0, Cap)
				Text = "`>` فایل پشتیبان #کانفیگ به خصوصی شما ارسال شد."
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
		--------------------------------------------------------->

		--> CMD => /edit | Edit a text message by reply ...
		if (Cmd:match("^[/!#]([Ee][Dd][Ii][Tt]) (.*)$") or Cmd:match("^(ویرایش) (.*)")) and isSudo(msg.from.id) then
			MatchesEN = {Cmd:match("^[/!#](edit) (.*)$")}; MatchesFA = {Cmd:match("^(ویرایش) (.*)$")}
			NewText = MatchesEN[2] or MatchesFA[2]
			if msg.reply_to_message then
				editMessageText(NewText, false, msg.chat.id, msg.reply_to_message.message_id)
			end
		end
		--------------------------------->

		--> CMD => /exit | Exit bot from a group ...
		if (CmdLower:match("^[/!#](exit)$") or Cmd:match("^(خروج)$")) and isSudo(msg.from.id) then
			if msg.chat.type == "private" then
				Text = "> اینجا چت خصوصی است، نمیتوان از آن خارج شد."
				sendText(msg.chat.id, Text, msg.message_id)
				return
			end
			Text = "× ربات از این گروه خارج خواهد شد. ×"
			sendText(msg.chat.id, Text, msg.message_id)
			getRes("leaveChat?chat_id="..msg.chat.id)
		end

		if (CmdLower:match("^[/!#](exit) (-%d+)$") or Cmd:match("^(خروج) (-%d+)$")) and isSudo(msg.from.id) then
			MatchesEN = {CmdLower:match("^[/!#](exit) (-%d+)$")}; MatchesFA = {Cmd:match("^(خروج) (-%d+)$")}
			GroupIdToLeave = MatchesEN[2] or MatchesFA[2]
			Text = "× ربات از این گروه خارج خواهد شد. ×"
			sendText(GroupIdToLeave, Text)
			getRes("leaveChat?chat_id="..GroupIdToLeave)
			TextForSudo = "`>` ربات از این گروه با شناسه `"..GroupIdToLeave.."` خارج شد."
			sendText(msg.chat.id, TextForSudo, msg.message_id, 'md')
		end
		--------------------------------->

		--> CMD => /fbc | ForwardBroadcast a Message to All Moderated Groups of Bot ...
		if (CmdLower:match("^[/!#](fbc)$") or Cmd:match("^(فروارد همگانی)$")) and isSudo(msg.from.id) then
			if not msg.reply_to_message then sendText(msg.chat.id, "`>` برای فروارد یک پیام به تمامی گروه های ربات ابتدا باید روی آن ریپلای(*Reply*) کنید و سپس دستور فروارد همگانی را تایپ کنید.", msg.message_id, 'md') return end
			Data = loadJson(Config.ModFile)
			local i = 0
			Text = "`>` در حال فروارد پیام به گروه های مدیریت شده ..."
			sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
			for k,v in pairs(Data['groups']) do
				forwardMessage(v, msg.chat.id, msg.reply_to_message.message_id)
				i = i + 1
				sleep(0.5)
			end
			Text = "فروارد همگانی اتمام یافت ✅"
			.."\nاین پیام برای *"..i.."* گروه فروارد شد."
			sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
		end

		--> CMD => /bc | Broadcast a Message to All Moderated Groups of Bot ...
		if (Cmd:match("^[/!#]([Bb][Cc])(.*)$") or Cmd:match("^(ارسال همگانی)(.*)$")) and isSudo(msg.from.id) then
			Data = loadJson(Config.ModFile)
			MatchesEN = {Cmd:match("^[/!#]([Bb][Cc])(.*)$")}; MatchesFA = {Cmd:match("^(ارسال همگانی)(.*)$")}
			TextToSend = MatchesEN[2] or MatchesFA[2]
			Text = "`>` در حال ارسال پیام به گروه های مدیریت شده ربات ..."
			local i = 0
			for k,v in pairs(Data['groups']) do
				sendText(v, TextToSend)
				i = i + 1
				sleep(0.5)
			end
			Text = "ارسال همگانی اتمام یافت ✅"
			.."\nاین پیام برای "..i.." گروه ارسال شد."
			.."\n————————"
			.."\nمتن پیام ارسالی به گروه ها :"
			.."\n"..TextToSend
			sendText(msg.chat.id, Text, msg.message_id)
		end
		--------------------------------->

		--> CMD = /rem | Removing Group From Moderated Groups' list ...
		if (CmdLower:match("^[/!#](rem) (-%d+)$") or Cmd:match("^(لغو نصب) (-%d+)$")) and isSudo(msg.from.id) then
			MatchesEN = {CmdLower:match("^[/!#](rem) (-%d+)$")}; MatchesFA = {Cmd:match("^(لغو نصب) (-%d+)$")}
			ChatId = MatchesEN[2] or MatchesFA[2]
			Data = loadJson(Config.ModFile)
			if Data[tostring(ChatId)] then
				Ssilent_Hash = SilentHash..ChatId
				BbanUsers_Hash = BanHash..ChatId
				FfilteredWords_Hash = FilterHash..ChatId
				Rrmsg_Hash = RmsgHash..ChatId
				Rrules_Hash = RulesHash..ChatId
				Ccharge_Hash = ChargeHash..ChatId
				Bbeauty_Hash = BeautyTextHash..ChatId
				MmoderatorsSettings_Hash = ModeratorsSettingsHash..ChatId
				WwelcomeMessage_Hash = WelcomeMessageHash..ChatId
				redis:del(Ssilent_Hash)
				redis:del(BbanUsers_Hash)
				redis:del(FfilteredWords_Hash)
				redis:del(Rrmsg_Hash)
				redis:del(Rrules_Hash)
				redis:setex(Ccharge_Hash, 1, true)
				redis:del(Bbeauty_Hash)
				redis:del(MmoderatorsSettings_Hash)
				redis:del(WwelcomeMessage_Hash)
				Data[tostring(ChatId)] = nil
				saveJson(Config.ModFile, Data)
				if Data["groups"] then
					if Data["groups"][tostring(ChatId)] then
						Data["groups"][tostring(ChatId)] = nil
						saveJson(Config.ModFile, Data)
					end
				end
				getRes("leaveChat?chat_id="..ChatId)
				Text = "❌ این گروه با شناسه `"..ChatId.."` از لیست گروه های مدیریت شده ربات حذف شد."
				.."\nهمچنین ربات از آن گروه خارج گردید ..."
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			else
				if Data["groups"] then
					if Data["groups"][tostring(ChatId)] then
						Data["groups"][tostring(ChatId)] = nil
						saveJson(Config.ModFile, Data)
					end
				end
				Text = "`>` این گروه با شناسه `"..ChatId.."` در لیست گروه های مدیریت شده ربات قرار ندارد!"
				..'\n_نیازی به حذف آن نیست._'
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
		------------------------------------------->

		--> CMD = /reset | Removing Junk Redis Hashs ...
		if (CmdLower:match("^[/!#](reset)$") or Cmd:match("^(ریست)$")) and isSudo(msg.from.id) then
			redis:del(ShowEditHash)
			Text = "ردیس های کم اهمیت و جاگیر پاک شدند!\nردیس های پاک شده:\n   `1- ردیس نمایش ادیت`"
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
		------------------------------------------->

		--> CMD = /gplist | Get Groups list of Bot ...
		if (CmdLower:match("^[/!#](gplist)$") or Cmd:match("^(لیست گروه ها)$")) and isSudo(msg.from.id) then
			Data = loadJson(Config.ModFile)
			Text = "<code>></code> لیست گروه های مدیریت شده ربات :\n\n"
			F = 0
			for k,v in pairs(Data['groups']) do
				if redis:get(ChargeHash..v) then
					A = tostring(redis:get(ChargeHash..v)):lower()
					if A == "unlimit" then
						GroupCharge = "نامحدود 🔃"
					elseif A == "true" then
						 = '<b>'..math.floor(redis:ttl(ChargeHash..v)/86400).."</b>روز ✅"
					else
						GroupCharge = "نامعلوم ❌"
					end
				else
					GroupCharge = "تمام شده ⛔️"
				end
				F = F+1
				Text = Text..F.."— شناسه گروه : <code>"..v.."</code>"
				.."\nمقدار شارژ : "..GroupCharge
				.."\nا—————"
				.."\n"
			end
			local file = io.open("./data/gplist.txt", "w")
			file:write(noHtml(Text))
			file:close()
			Cap = "لیست گروه های ربات بصورت فایل متنی"
			.."\n#GroupList"
			sendDocument(msg.chat.id, "./data/gplist.txt", 0, Cap)
			sendText(msg.chat.id, Text, msg.message_id, 'html')
		end
		------------------------------------------->

		-- CMD => /setclerk | Working With Clerk.
		if (Cmd:match("^[/!#]([Ss][Ee][Tt][Cc][Ll][Ee][Rr][Kk][Mm][Ss][Gg]) (.*)$") or Cmd:match("^(تنظیم پیام منشی) (.*)$")) and isSudo(msg.from.id) then
			Data = loadJson(Config.ModFile)
			MatchesEN = {Cmd:match("^[/!#]([Ss][Ee][Tt][Cc][Ll][Ee][Rr][Kk][Mm][Ss][Gg]) (.*)$")}; MatchesFA = {Cmd:match("^(تنظیم پیام منشی) (.*)$")}
			TextToSet = MatchesEN[2] or MatchesFA[2]
			redis:set(ClerkMessageHash, TextToSet)
			Text = "• این متن به عنوان متن پاسخگویی ربات در خصوصی تنظیم شد."
			.."\n———————"
			.."\n"..TextToSet
			sendText(msg.chat.id, Text, msg.message_id)
		end
		if (Cmd:match("^[/!#]([Cc][Ll][Ee][Rr][Kk]) (.*)$") or Cmd:match("^(منشی) (.*)$")) and isSudo(msg.from.id) then
			Data = loadJson(Config.ModFile)
			MatchesEN = {Cmd:match("^[/!#]([Cc][Ll][Ee][Rr][Kk]) (.*)$")}; MatchesFA = {Cmd:match("^(منشی) (.*)$")}
			Ptrn = MatchesEN[2] or MatchesFA[2]
			if Ptrn == "فعال" or Ptrn:lower() == "on" then
				if redis:get(ClerkStatusHash) then
					sendText(msg.chat.id, "> منشی از قبل فعال بوده است.", msg.message_id)
					return
				end
				redis:set(ClerkStatusHash, true)
				sendText(msg.chat.id, "> منشی فعال شد!\nهم اکنون ربات در خصوصی پاسخگو میباشد.", msg.message_id)
			end
			if Ptrn == "غیر فعال" or Ptrn == "غیرفعال" or Ptrn:lower() == "off" then
				if redis:get(ClerkStatusHash) then
					redis:del(ClerkStatusHash)
					sendText(msg.chat.id, "> منشی غیرفعال شد.", msg.message_id)
					return
				end
				sendText(msg.chat.id, "> منشی از قبل غیرفعال بوده است.", msg.message_id)
			end
		end
		------------------------------------------->

		--> CMD => /botpanel | get the panel of Robot ...
		if (CmdLower:match("^[/!#](botpanel)$") or Cmd:match("^(پنل ربات)$")) and isSudo(msg.from.id) then
			-- Monshi
			ClerkStatus = "غیرفعال 🚫"
			ClerkMessage = "این اکانت ربات است"
			if redis:get(ClerkStatusHash) then
				ClerkStatus = "فعال ✅"
			end
			if redis:get(ClerkMessageHash) then
				ClerkMessage = redis:get(ClerkMessageHash)
			end
			---------
			Text = "⚙️ به پنل ربات خوش آمدید !"
			.."\n\n"
			.."— منشی :"
			.."\nوضعیت منشی : "..ClerkStatus
			.."\nپیام منشی : "..ClerkMessage
			.."\n"
			.."\n— دستورات مرتبط :"
			.."\nدریافت لیست گروه های ربات :\n/gplist"
			.."\nفعال/غیرفعال کردن منشی :\n/clerk [on/off]"
			.."\nتنظیم متن منشی :\n/setclerkmsg [متن-پیام-منشی]"
			sendText(msg.chat.id, Text, msg.message_id)
		end
		------------------------------------------->

		--> CMD => /panel [GroupId] | Get Panel of a Group ...
		if (CmdLower:match("^[!/#](panel) (-%d+)") or Cmd:match("^(پنل) (-%d+)")) and isSudo(msg.from.id) then
			MatchesEN = {CmdLower:match("^[!/#](panel) (-%d+)")}; MatchesFA = {Cmd:match("^(پنل) (-%d+)")}
			ChatId = tostring(MatchesEN[2]) or tostring(MatchesFA[2])

			if not Data[tostring(ChatId)] then
				Text = "× این گروه با شناسه `"..ChatId.."` در لیست گروه های مدیریت شده ربات وجود ندارد."
				sendText(msg.chat.id, Text, msg.message_id)
				return
			end

			if msg.chat.type == "private" then
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = '⚙️ تنظیمات اصلی گروه', callback_data = ChatId..':showmenu:generalsettings:1'}
						},
						{
							{text = '🔖 اطلاعات گروه و مدیریت کاربران', callback_data = ChatId..':showmenu:groupinfo:1'}
						},
						{
							{text = 'زمان و تاریخ', callback_data = ChatId..':showmenu:timeanddate:1'},
							{text = 'ورود به کانال ربات', url = Config.ChannelLink}
						},
					}
			else
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = '⚙️ تنظیمات اصلی گروه', callback_data = ChatId..':showmenu:generalsettings:1'}
						},
						{
							{text = '🔖 اطلاعات گروه و مدیریت کاربران', callback_data = ChatId..':showmenu:groupinfo:1'}
						},
						{
							{text = 'زمان و تاریخ', callback_data = ChatId..':showmenu:timeanddate:1'},
							{text = 'ورود به کانال ربات', url = Config.ChannelLink}
						},
						{
							{text = '🔑 دریافت همین پنل در خصوصی', url = "https://telegram.me/"..BotUsername.."?start=getpanel"..ChatId}
						},
					}
			end
			Text = "~> به پنل مدیریت آسان گروه خوش آمدید."
			.."\n• نام گروه : "..getChat(ChatId).title
			.."\n• شناسه گروه : "..ChatId
			.."\n• با استفاده از این پنل شما میتوانید به راحتی و با تنها یک کلیک/لمس ساده تنظیمات گروه خود را انجام داده و آن را مدیریت کنید."
			.."\n> جهت استفاده از هر کدام کافیست روی آن کلیک کنید :"
			sendText(msg.chat.id, Text, msg.message_id, false, keyboard)
		end
		------------------------------------------------------

		--> CMD => /charge [GroupId] [Charge] | Charge a Group Out of That ...
		if (CmdLower:match("^[/!#](charge) (-%d+) (.*)$") or Cmd:match("^(شارژ) (-%d+) (.*)$")) and isSudo(msg.from.id) then
			MatchesEN = {CmdLower:match("^[/!#](charge) (-%d+) (.*)$")}; MatchesFA = {Cmd:match("^(شارژ) (-%d+) (.*)$")}
			ChatId = tostring(MatchesEN[2]) or tostring(MatchesFA[2])
			Ptrn = MatchesEN[3] or MatchesFA[3]
			if not Data[tostring(ChatId)] then
				Text = "`>` این گروه در لیست گروه های مدیریت شده ربات وجود ندارد !"
				.."\n"..ChatId
				sendText(msg.chat.id, Text, msg.message_id, 'md')
				return
			end

			if Ptrn == "unlimit" or Ptrn == "نامحدود" then --> Unlimit Charge
				Hash = ChargeHash..ChatId
				if tostring(redis:get(Hash)):lower() == "unlimit" then
					Text = "`>` شارژ این گروه با شناسه `"..ChatId.."` از قبل نامحدود بوده است."
					sendText(msg.chat.id, Text, msg.message_id, 'md')
					return
				end
				redis:set(Hash, "unlimit")
				Text = "`>` این گروه با شناسه `"..ChatId.."` بصورت نامحدود شارژ شد. ✅"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
				return
			end

			if Ptrn:match("^(%d+)(.*)$") then
				Hash = ChargeHash..ChatId
				MatCh = {Ptrn:match("^(%d+)(.*)$")}
				ChargeNum = tonumber(MatCh[1])
				ChargeType = tostring(MatCh[2])
				if (ChargeType:lower() == "m" or ChargeType == "دقیقه") then
					TimeInSec = ChargeNum * MinInSec
				elseif (ChargeType:lower() == "h" or ChargeType == "ساعت") then
					TimeInSec = ChargeNum * HourInSec
				elseif (ChargeType:lower() == "d" or ChargeType == "روز") then
					TimeInSec = ChargeNum * DayInSec
				elseif (ChargeType:lower() == "s" or ChargeType == "ثانیه") then
					TimeInSec = ChargeNum
				else
					Text = "`>` نوع شارژ باید یکی از عبارت های [روز،ساعت،دقیقه،ثانیه] باشه."
					.."\n`>` Charge type must be one of [*d*,*h*,*m*,*s*]"
					sendText(msg.chat.id, Text, msg.message_id, 'md')
					return
				end

				A = secToTime(TimeInSec)
				StrDay = A.Day
				StrHour = A.Hour
				StrMin = A.Min
				StrSec = A.Sec
				redis:setex(Hash, TimeInSec, "true")
				Text = "شناسه گروه : "..ChatId
				.."\n\n> شارژ این گروه برای مدت"
				.."\n"..StrDay.."روز"
				.."\n"..StrHour.."ساعت"
				.."\n"..StrMin.."دقیقه"
				.."\nو "..StrSec.."ثانیه"
				.."\nتنظیم شد ✅"
				sendText(msg.chat.id, Text, msg.message_id)
			end
		end
		------------------------------------------->

		if (CmdLower:match("^[/!#](expire) (-%d+)$") or Cmd:match("^(انقضا) (-%d+)$")) and isSudo(msg.from.id) then
			MatchesEN = {CmdLower:match("^[/!#](expire) (-%d+)$")}; MatchesFA = {Cmd:match("^(انقضا) (-%d+)$")}
			ChatId = tostring(MatchesEN[2] or MatchesFA[2])
			Hash = "enigma:cli:charge:"..ChatId
			Data = loadJson(Config.ModFile)

			if not Data[tostring(ChatId)] then
				Text = "`>` این گروه با شناسه `"..ChatId.."` در لیست گروه های مدیریت شده ربات قرار ندارد!"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
				return
			end

 			if tostring(redis:get(Hash)):lower() == "unlimit" then
				ExpireText = "`>` شارژ این گروه نامحدود میباشد !"
			elseif tostring(redis:ttl(Hash)):lower() ~= "-2" then
				ExpireTime = redis:ttl(Hash)
				A = convertTime(ExpireTime)
				StrDay = A.Day
				StrHour = A.Hour
				StrMin = A.Min
				StrSec = A.Sec
				ExpireText = "🔂 از شارژ این گروه"
				.."\n*"..StrDay.."*روز"
				.."\n*"..StrHour.."*ساعت"
				.."\n*"..StrMin.."*دقیقه"
				.."\nو *"..StrSec.."*ثانیه"
				.."\nباقی مانده است."
			else
				ExpireText = "~> شارژ این گروه به اتمام رسیده است !"
			end
			sendText(msg.chat.id, ExpireText, msg.message_id, 'md')
		end
		
		--> CMD => /check | Check Group ...
		if (CmdLower:match("^[/!#](check)$") or Cmd:match("^(بررسی)$")) and isSudo(msg.from.id) then
			Data = loadJson(Config.ModFile)
			if Data[tostring(msg.chat.id)] then
				GroupAdded = "بله"
			else
				GroupAdded = "خیر"
			end
			Text = "• شناسه گفتگو : `"..msg.chat.id.."`"
			.."\n• نوع گفتگو : `"..msg.chat.type.."`"
			.."\n• آیا گفتگو در لیست وجود دارد؟ "..GroupAdded
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
		
	end -- end msg.text
	
end -- END BOT_MOD.LUA

-------------------------------------------------
KickTable = {}
function antiFloodPlugin(msg) --> ANTI_FLOOD.LUA
	Data = loadJson(Config.ModFile)

	if not Data[tostring(msg.chat.id)] then
		return
	end
	if isMod(msg.chat.id, msg.from.id) then
		return
	end
	if msg.service then
		return
	end

	if Data[tostring(msg.chat.id)]['settings'] then
		if Data[tostring(msg.chat.id)]['settings']['flood_num'] then
			local FloodMax = Data[tostring(msg.chat.id)]['settings']['flood_num'] or 5
			FloodMax = tonumber(FloodMax)
			local FloodTime = 2 -- in Sec
			if Data[tostring(msg.chat.id)]['settings']['lock_flood'] then
				if Data[tostring(msg.chat.id)]['settings']['lock_flood'] == "yes" then
					local Hash = 'enigma:cli:flood:'..msg.chat.id..':'..msg.from.id
					UserMsgs = tonumber(redis:get(Hash)) or 0
					if UserMsgs > (FloodMax - 1) then
						if msg.from.username then
							User = "@"..msg.from.username
						else
							User = msg.from.id
						end
						Text = "🚫 کاربر "..User.." به دلیل ارسال پیام ها به صورت مکرر و رگباری از گروه اخراج شد!"
						kickUser(msg.chat.id, msg.from.id)
						if KickTable[msg.from.id] == true then
							return
						end
						sendText(msg.chat.id, Text, msg.message_id)
						KickTable[msg.from.id] = true
					end
					redis:setex(Hash, FloodTime, UserMsgs+1)
				end
			end
		end
	end

end -- END ANTI_FLOOD.LUA
-----------------------------------------

-----------------------------------------
function secPlugin(msg) --> SEC.LUA
	local function isLink(text) --> Finding Link in a Message Function
		if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/")
		or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
		or text:match("[Tt].[Mm][Ee]/")
		or text:match("[Hh][Tt][Tt][Pp][Ss]://")
		or text:match("[Hh][Tt][Tt][Pp]://")
		or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Oo][Rr][Gg]")
		or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]")
		or text:match("[Ww][Ww][Ww].")
		or text:match(".[Cc][Oo][Mm]")
		or text:match(".[Ii][Rr]")
		or text:match(".[Oo][Rr][Gg]")
		or text:match(".[Nn][Ee][Tt]") then
			return true
		end
	 return false
	end

	local function isAbuse(text) --> Finding Abuse in a Message Function
		if text:match("کیر")
		or text:match("کون")
		or text:match("فاک")
		or text:lower():match("fuck")
		or text:lower():match("pussy")
		or text:lower():match("sex")
		or text:match("عوضی")
		or text:match("آشغال")
		or text:match("جنده")
		or text:match("سیکتیر")
		or text:match("سکس")
		or text:lower():match("siktir")
		or text:match("دیوث") then
			return true
		end
	  return false
	end

	-- Sending Backup Of Moderation.json File to GeneralSudo ...
	if not redis:get(ModerationFileBackupTimeHash) then
		local Cap = "#Moderation"
		.."\n#Backup"
		.."\nبکاپ فایل مدیریت"
		sendDocument(Config.GeneralSudoId, Config.ModFile, 0, Cap)
		redis:setex(ModerationFileBackupTimeHash, HourInSec, true)
	end
	------------------------------------------------------------

	Data = loadJson(Config.ModFile)
	--> OnService Plugin ...
	if msg.new_chat_members then
		for i=1, #msg.new_chat_members do
			if msg.new_chat_members[i].id == BotId then
				if not isSudo(msg.from.id) and not Data[tostring(msg.chat.id)] then
					Text = "🚫 شما نمیتونید ربات رو به گروه اضافه کنید."
					.."\nجهت خریداری ربات پیام دهید :"
					.."\n> "..(Config.SupportBot or Config.SudoUsername or "")
					sendText(msg.chat.id, Text)
					getRes("leaveChat?chat_id="..msg.chat.id)
					break
				end
			end
		end
	end

	--> If Group Wasn't Moderated The Do Nothing ...
	if not Data[tostring(msg.chat.id)] then
		return
	end

	if Data[tostring(msg.chat.id)]['settings'] then

		lock_strict = 'no' --> Lock Strict
		if Data[tostring(msg.chat.id)]['settings']['lock_strict'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_strict'] == 'yes' then
				lock_strict = 'yes'
			end
		end

		--> Saving Message Content for Show Edit
		if Data[tostring(msg.chat.id)]['settings']['show_edit'] then
			if Data[tostring(msg.chat.id)]['settings']['show_edit'] == "yes" then
				if msg.text or msg.caption then
					ContentToSave = msg.text or msg.caption
					redis:hset(ShowEditHash, msg.chat.id..":"..msg.message_id, ContentToSave)
				end
			end
		end
		-->

		--> Lock Bot
		if Data[tostring(msg.chat.id)]['settings']['lock_bot'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_bot'] == "yes" then
				if msg.new_chat_members then
					k = 0
					for i=1, #msg.new_chat_members do
						if msg.new_chat_members[i].username then
							if string.sub(msg.new_chat_members[i].username:lower(), -3) == 'bot' then
								if not isMod(msg.chat.id, msg.new_chat_members[i].id) and not isBot(msg.new_chat_members[i].id) then
									kickUser(msg.chat.id, msg.new_chat_members[i].id)
									k = k+1
								end
							end
						end
					end
					if k > 0 then
						if k == 1 then
							KICK = "اخراجش"
						else
							KICK = "اخراجشون"
						end
						Text = "~> توی این اضافه کردنا من "..k.." ربات پیدا کردم."
						.."\n× چون قفل ربات فعال بود "..KICK.." کردم !"
						sendText(msg.chat.id, Text, msg.message_id)
					end
				end

				if msg.from.is_bot then
					kickUser(msg.chat.id, msg.from.id)
					deleteMessage(msg.chat.id, msg.message_id)
				end

			end
		end
		-- End Lock Bot

		--> lock all (lock chat)
		if Data[tostring(msg.chat.id)]['settings']['lock_all'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_all'] == 'yes' and not msg.service then
				if not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-- End Lock All

		--> Delete Silented Users's Message
		if isSilentUser(msg.chat.id, msg.from.id) and not isMod(msg.chat.id, msg.from.id) then
			deleteMessage(msg.chat.id, msg.message_id)
		end

		-- Kick Banned User
		if (isBannedUser(msg.chat.id, msg.from.id) or isGBannedUser(msg.from.id)) and not isMod(msg.chat.id, msg.from.id) then
			kickUser(msg.chat.id, msg.from.id)
		end

		-- Lock Link (On msg.text AND msg.caption)
		if Data[tostring(msg.chat.id)]['settings']['lock_link'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_link'] == 'yes' then
				if msg.text or msg.caption then
					TextToFindLink = msg.text or msg.caption
					if isLink(TextToFindLink) then
						if not isMod(msg.chat.id, msg.from.id) then
							deleteMessage(msg.chat.id, msg.message_id)
							if lock_strict == 'yes' then
								kickUser(msg.chat.id, msg.from.id)
							end
						end
					end
				end
			end
		end
		-- End Lock Link

		--> Lock Spam
		if Data[tostring(msg.chat.id)]['settings']['lock_spam'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_spam'] == 'yes' then
				if msg.text then
					if (utf8.len(msg.text) > 2500) and not isMod(msg.chat.id, msg.from.id) then
						deleteMessage(msg.chat.id, msg.message_id)
						Text = "✖️ کاربر "..(msg.from.first_name or "---").."، پیام شما به دلیل طولانی بودن حذف شد."
						sendText(msg.chat.id, Text)
					end
				end
			end
		end
		-- End Lock Spam

		-- Rem msg with filtered word !
		if tonumber(redis:scard(FilterHash..msg.chat.id)) > 0 then
			local FilteredWords = redis:smembers(FilterHash..msg.chat.id)
			if msg.text then
				for i=1, #FilteredWords do
					if string.match(msg.text:lower(), FilteredWords[i]) then
						if not isMod(msg.chat.id, msg.from.id) then
							deleteMessage(msg.chat.id, msg.message_id)
						end
					end
				end
			end
		end
		-- End Filtered Words

		-- Lock Abuse (Fosh)
		if Data[tostring(msg.chat.id)]['settings']['lock_abuse'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_abuse'] == 'yes' then
				if msg.text or msg.caption then
					if not isMod(msg.chat.id, msg.from.id) then
						TextToCheckForAbuse = msg.text or msg.caption
						if isAbuse(TextToCheckForAbuse) then
							deleteMessage(msg.chat.id, msg.message_id)
						end
					end
				end
			end
		end
		-- End Lock Fosh

		-- Lock forward
		if Data[tostring(msg.chat.id)]['settings']['lock_forward'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_forward'] == 'yes' then
				if (msg.forward_from or msg.forward_from_chat) and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-- End Lock Forward

		-- lock_wlc and lock_bye
		if msg.service then

			if Data[tostring(msg.chat.id)]['settings']['lock_tgservice'] then -- Lock TgService
				if Data[tostring(msg.chat.id)]['settings']['lock_tgservice'] == 'yes' then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end

			if msg.new_chat_members then --> Lock Wlc
				if Data[tostring(msg.chat.id)]['settings']['lock_wlc'] then
					if Data[tostring(msg.chat.id)]['settings']['lock_wlc'] == 'yes' then
						if #msg.new_chat_members == 1 then
							if not isBot(msg.new_chat_members[1].id) then
								Text = "سلام 🌹\nبه گروه خوش اومدی !"
								if redis:get(WelcomeMessageHash..msg.chat.id) then
									Text = redis:get(WelcomeMessageHash..msg.chat.id)
									Text = Text:gsub("GROUPNAME", (msg.chat.title or ""))
									Text = Text:gsub("FIRSTNAME", (msg.new_chat_members[1].first_name or ''))
									Text = Text:gsub("LASTNAME", (msg.new_chat_members[1].last_name or ''))
									Text = Text:gsub("USERNAME", (msg.new_chat_members[1].username or ""))
									Text = Text:gsub("USERID",(msg.new_chat_members[1].id or ''))
								end
								sendText(msg.chat.id, Text, msg.message_id)
							end
						else
							Text = "سلام 🌹"
							.."\nبه گروه خوش اومدید."
							sendText(msg.chat.id, Text, msg.message_id)
						end
					end
				end
			elseif msg.left_chat_member then -- Lock Bye
				if Data[tostring(msg.chat.id)]['settings']['lock_bye'] then
					if Data[tostring(msg.chat.id)]['settings']['lock_bye'] == 'yes' then
						if msg.from.id == msg.left_chat_member.id then
							Text = "بدرود\nشما از گروه رفتی!"
							sendText(msg.chat.id, Text, msg.message_id)
						end
					end
				end
			end

		end -- End if msg.service
		-- End lock_wlc and lock_bye

		-- Lock Text
		if Data[tostring(msg.chat.id)]['settings']['lock_text'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_text'] == "yes" then
				if msg.text and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-- End Lock Text

		-- Lock English
		if Data[tostring(msg.chat.id)]['settings']['lock_english'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_english'] == "yes" then
				if msg.text and (msg.text:match("[A-Z]") or msg.text:match("[a-z]")) then
					if not isMod(msg.chat.id, msg.from.id) then
						deleteMessage(msg.chat.id, msg.message_id)
					end
				end
			end
		end
		-- End Lock English

		-- Lock Persian/Arabic
		if Data[tostring(msg.chat.id)]['settings']['lock_arabic'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_arabic'] == "yes" then
				if msg.text and msg.text:match("[\216-\219][\128-\191]") then
					if not isMod(msg.chat.id, msg.from.id) then
						deleteMessage(msg.chat.id, msg.message_id)
					end
				end
			end
		end
		-- End Lock Persian/Arabic

		-- Lock Username (@)
		if Data[tostring(msg.chat.id)]['settings']['lock_username'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_username'] == "yes" then
				if msg.text or msg.caption then
					TextToCheck = msg.text or msg.caption
					if TextToCheck:match("@") then
						if not isMod(msg.chat.id, msg.from.id) then
							deleteMessage(msg.chat.id, msg.message_id)
						end
					end
				end
			end
		end
		-- End Lock Username

		-- Lock Tag (#)
		if Data[tostring(msg.chat.id)]['settings']['lock_tag'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_tag'] == "yes" then
				if msg.text or msg.caption then
					TextToCheck = msg.text or msg.caption
					if TextToCheck:match("#") then
						if not isMod(msg.chat.id, msg.from.id) then
							deleteMessage(msg.chat.id, msg.message_id)
						end
					end
				end
			end
		end
		-- End Lock Tag

		-- Lock Photo
		if Data[tostring(msg.chat.id)]['settings']['lock_photo'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_photo'] == 'yes' then
				if msg.photo and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-- End Lock Photo

		-- Lock Sticker
		if Data[tostring(msg.chat.id)]['settings']['lock_sticker'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_sticker'] == 'yes' then
				if msg.sticker and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-- End Lock Sticker

		-- Lock Audio
		if Data[tostring(msg.chat.id)]['settings']['lock_audio'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_audio'] == 'yes' then
				if msg.audio and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-- End Lock Audio

		-- Lock Voice
		if Data[tostring(msg.chat.id)]['settings']['lock_voice'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_voice'] == 'yes' then
				if msg.voice and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-- End Lock Voice

		-- Lock Video
		if Data[tostring(msg.chat.id)]['settings']['lock_video'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_video'] == 'yes' then
				if msg.video and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-- End Lock Video

		-- Lock Document
		if Data[tostring(msg.chat.id)]['settings']['lock_document'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_document'] == 'yes' then
				if msg.document and msg.document.mime_type ~= "video/mp4" and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-- End Lock Document

		-- Lock Gif
		if Data[tostring(msg.chat.id)]['settings']['lock_gif'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_gif'] == 'yes' then
				if msg.document and msg.document.mime_type == "video/mp4" and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-- End Lock Gif

		-- Lock Contact
		if Data[tostring(msg.chat.id)]['settings']['lock_contact'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_contact'] == 'yes' then
				if msg.contact and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-- End Lock Contact

	end -- END if Data[tostring(msg.chat.id)]['settings'] then

end -- End SEC.LUA

function rmsgPlugin(msg) --> RMSG.LUA !

	Data = loadJson(Config.ModFile)
	local Hash = RmsgHash..msg.chat.id
	redis:sadd(Hash, msg.message_id)

	if msg.text then
		Cmd = msg.text
		CmdLower = msg.text:lower()
		if CmdLower:match("^[!/#](rmsg)$") or Cmd:match("^(پاکسازی پیام)$") then
			if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Mods Only !
			local Messages = redis:smembers(Hash)
			b = #Messages
			MessagesInt = {}
			for i=1, #Messages do
				MessagesInt[i] = tonumber(Messages[i])
			end
			local Url = "http://enigma-dev.ir/api/telegram/?token="..Config.BotToken.."&method=deleteMessages&chat_id="..msg.chat.id.."&message_ids="..json:encode(MessagesInt)
			http.request(Url)
			redis:del(Hash)
			
			Text = "• آخرین پیام های گروه تا حد ممکن پاکسازی شدند! 🚮"
			sendText(msg.chat.id, Text)
		end
	end -- end [if msg.text then]

end -- End RMSG.LUA !

function addRemPlugin(msg) --> LOCKS.LUA !

	Cmd = msg.text
	CmdLower = msg.text:lower()
	Data = loadJson(Config.ModFile)

	--> CMD = /add | Adding a Group to Moderated Groups' list
	if (CmdLower:match("^[/!#](add)$") or Cmd:match("^(نصب)$")) and isSudo(msg.from.id) then
		if not Data[tostring(msg.chat.id)] then
			Data[tostring(msg.chat.id)] = {
				moderators = {},
				set_owner = "0",
				settings = {

					-- Orginal Locks
					lock_link = "yes",
					lock_edit = "no",
					show_edit = "no",
					lock_forward = "yes",
					lock_cmd = "no",
					lock_english = "no",
					lock_arabic = "no",
					lock_username = "no",
					lock_tag = "no",
					lock_spam = "yes",
					lock_bot = "no",
					lock_flood = "yes",
					flood_num = "5",
					lock_tgservice = "yes",

					-- Media Locks
					lock_abuse = "no",
					lock_sticker = "no",
					lock_audio = "no",
					lock_voice = "no",
					lock_photo = "no",
					lock_video = "no",
					lock_text = "no",
					lock_document = "no",
					lock_gif = "no",
					lock_contact = "no",

					-- Important Locks
					lock_strict = "no",
					lock_all = "no",

					-- Fun Locks
					lock_wlc = "no",
					lock_bye = "no"
				}
			}
			saveJson(Config.ModFile, Data)
			if not Data["groups"] then
				Data["groups"] = {}
				saveJson(Config.ModFile, Data)
			end
			Data["groups"][tostring(msg.chat.id)] = msg.chat.id
			saveJson(Config.ModFile, Data)
			redis:setex(ChargeHash..msg.chat.id, HourInSec, true) --> Adding Charge to Group For 1Hour
			Text = "`>` این گروه به لیست گروه های تحت مدیریت ربات اضافه شد. ✅"
			..'\n_همچنین بصورت پیشفرض برای 1 ساعت شارژ اتوماتیک دریافت کرد._'
			..'\n شناسه گروه : `'..msg.chat.id..'`'
			sendText(msg.chat.id, Text, msg.message_id, 'md')

			TextForSudo = "➕ گروهی به لیست گروه های مدیریتی ربات اضافه شد."
			..'\n'
			..'\n— مشخصات گروه اضافه شده :'
			..'\n• نام گروه : <b>'..msg.chat.title.."</b>"
			..'\n• شناسه گروه : <code>'..msg.chat.id..'</code>'
			..'\n'
			..'\n— مشخصات اضافه کننده :'
			..'\n• نام کامل : <b>'..(msg.from.first_name or "").." "..(msg.from.last_name or "").."</b>"
			..'\n• نام کاربری : @'..(msg.from.username or "----")
			..'\n• شناسه کاربری : <code>'..msg.from.id..'</code>'
			..'\n'
			..'\n— دستور های پیشفرض برای گروه :'
			..'\n<code>></code> شارژ گروه برای 30 روز :'
			..'\n<code>/charge '..msg.chat.id..' 30d</code>'
			..'\n<code>></code> حذف گروه از لیست گروه های مدیریت شده :'
			..'\n<code>/rem '..msg.chat.id..'</code>'
			..'\n<code>></code> خارج شدن ربات از آن گروه :'
			..'\n<code>/exit '..msg.chat.id..'</code>'
			sendText(Config.GeneralSudoId, TextForSudo, 0, 'html')
		else
			Text = "`>` این گروه با شناسه `"..msg.chat.id.."` از قبل در لیست گروه های مدیریت شده ربات قرار داشت."
			..'\n_نیازی به اضافه کردن آن نیست._'
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
	end

	--> CMD = /rem | Removing Group From Moderated Groups' list ...
	if (CmdLower:match("^[/!#](rem)$") or Cmd:match("^(لغو نصب)$")) and isSudo(msg.from.id) then
		Data = loadJson(Config.ModFile)
		if Data[tostring(msg.chat.id)] then
			Data[tostring(msg.chat.id)] = nil
			saveJson(Config.ModFile, Data)
			if Data["groups"] then
				if Data["groups"][tostring(msg.chat.id)] then
					Data["groups"][tostring(msg.chat.id)] = nil
					saveJson(Config.ModFile, Data)
				end
			end
			S_silent_Hash = SilentHash..msg.chat.id
			B_banUsers_Hash = BanHash..msg.chat.id
			F_filteredWords_Hash = FilterHash..msg.chat.id
			R_rmsg_Hash = RmsgHash..msg.chat.id
			R_rules_Hash = RulesHash..msg.chat.id
			C_charge_Hash = ChargeHash..msg.chat.id
			B_beauty_Hash = BeautyTextHash..msg.chat.id
			M_moderatorsSettings_Hash = ModeratorsSettingsHash..msg.chat.id
			W_welcomeMessage_Hash = WelcomeMessageHash..msg.chat.id
			redis:del(S_silent_Hash)
			redis:del(B_banUsers_Hash)
			redis:del(F_filteredWords_Hash)
			redis:del(R_msg_Hash)
			redis:del(R_rules_Hash)
			redis:setex(C_charge_Hash, 1, true)
			redis:del(B_beauty_Hash)
			redis:del(M_moderatorsSettings_Hash)
			redis:del(W_welcomeMessage_Hash)
			Text = "❌ این گروه با شناسه `"..msg.chat.id.."` از لیست گروه های مدیریت شده ربات حذف شد."
			sendText(msg.chat.id, Text, msg.message_id, 'md')
			TextForSudo = "✖️یک گروه از لیست گروه های مدیریت شده ربات حذف شد!"
			.."\n"
			.."\n— مشخصات گروه حذف شده :"
			.."\n• نام گروه : <b>"..msg.chat.title.."</b>"
			.."\n• شناسه گروه : <code>"..msg.chat.id.."</code>"
			.."\n"
			.."\n— مشخصات حذف کننده :"
			..'\n• نام کامل : <b>'..(msg.from.first_name or "").." "..(msg.from.last_name or "").."</b>"
			..'\n• نام کاربری : @'..(msg.from.username or "----")
			..'\n• شناسه کاربری : <code>'..msg.from.id..'</code>'
			..'\n'
			..'\n— دستور های پیشفرض برای گروه :'
			..'\n<code>></code> خروج ربات از آن گروه :'
			..'\n<code>/exit '..msg.chat.id..'</code>'
			sendText(Config.GeneralSudoId, TextForSudo, 0, 'html')
		else
			if Data["groups"] then
				if Data["groups"][tostring(msg.chat.id)] then
					Data["groups"][tostring(msg.chat.id)] = nil
					saveJson(Config.ModFile, Data)
				end
			end
			Text = "`>` این گروه در لیست گروه های مدیریت شده ربات قرار ندارد!"
			..'\n_نیازی به حذف آن از لیست نیست._'
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
	end
	------------------------------------------->
end

function chatModPlugin(msg) --> CHAT_MOD.LUA !

	Cmd = msg.text
	CmdLower = msg.text:lower()
	Data = loadJson(Config.ModFile)
	if not Data[tostring(msg.chat.id)] then
		return
	end

	-- LOCK CMD -----------
	if Data[tostring(msg.chat.id)]["settings"] then
		if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] then
			if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] == "yes" and not isMod(msg.chat.id, msg.from.id) then
				return
			end
		end
	end
	-----------------------

	--> CMD = /id | Getting ID of User or Group ...
	if CmdLower:match("^[/!#](id)$") or Cmd:match("^(آیدی)$") or Cmd:match("^(ایدی)$") then
		if msg.reply_to_message then
			if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end
			Text = "نام کاربر : "..(msg.reply_to_message.from.first_name or "")
			.."\nفامیل کاربر : "..(msg.reply_to_message.from.last_name or "")
			.."\nنام کاربری : @"..(msg.reply_to_message.from.username or "")
			.."\nشناسه کاربری : "..(msg.reply_to_message.from.id or "")
			sendText(msg.chat.id, Text, msg.reply_to_message.message_id)
		else
			Photo = getRes("getUserProfilePhotos?user_id="..msg.from.id).result
			if Photo.total_count > 0 then
				Cap = "شناسه گروه : "..msg.chat.id
				.."\nشناسه شما : "..msg.from.id
				.."\nتعداد تصاویر پروفایل شما : "..Photo.total_count
				getRes("sendPhoto?chat_id="..msg.chat.id.."&photo="..Photo.photos[1][1].file_id.."&caption="..URL.escape(Cap).."&reply_to_message_id="..msg.message_id)
			else
				Text = "*پروفایل شما تصویری ندارد."
				.."\nنام کاربری شما : @"..(msg.from.username or "")
				.."\nشناسه کاربری شما : `"..(msg.from.id or "").."`"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
	end
	---------------------------------------------------

	--> CMD = /pin | Pin a message in a chat ...
	if CmdLower:match("^[/!#](pin)$") or Cmd:match("^(پین)$") or Cmd:match("^(سنجاق)$") then
		if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Mods Only !
		if msg.reply_to_message then
			Res = getRes("pinChatMessage?chat_id="..msg.chat.id.."&message_id="..msg.reply_to_message.message_id)
			if not Res.ok then
				if Res.description == "Bad Request: not enough rights to pin a message" then
					Text = "× ربات دسترسی کافی جهت سنجاق(*Pin*) کردن پیام در گروه ندارد."
					sendText(msg.chat.id, Text, msg.message_id, 'md')
					return
				elseif Res.description == "Bad Request: CHAT_NOT_MODIFIED" then
					Text = "× این پیام از قبل سنجاق شده بود."
					sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
					return
				end
				sendText(msg.chat.id, "×> مشکلی پیش اومد، نمیتونم این پیامو سنجاق کنم.", msg.reply_to_message.message_id)
				return
			end
			Text = "`>` این پیام با شناسه `"..msg.reply_to_message.message_id..'` در گفتگو سنجاق(*Pin*) شد.'
			sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
		else
			Text = "`>` این عملیات نیازمند ریپلای(*Reply*) میباشد."
			..'\n_روی یک پیام ریپلای کرده و سپس دستور سنجاق را تایپ کنید._'
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
	end
	--> CMD = /unpin | UnPin a message in a chat ...
	if CmdLower:match("^[/!#](unpin)$") or Cmd:match("^(آنپین)$") or Cmd:match("^(انپین)$") or Cmd:match("^(حذف سنجاق)$") then
		if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end
		Res = getRes("unpinChatMessage?chat_id="..msg.chat.id)
		if not Res.ok then
			if Res.description == "Bad Request: not enough rights to unpin a message" then
				Text = "× ربات دسترسی کافی جهت حذف سنجاق پیام سنجاق شده را ندارد."
				sendText(msg.chat.id, Text, msg.message_id, 'md')
				return
			elseif Res.description == "Bad Request: CHAT_NOT_MODIFIED" then
				Text = "× در این گروه پیامی سنجاق نشده است."
				sendText(msg.chat.id, Text, msg.message_id, 'md')
				return
			end
			sendText(msg.chat.id, "×> مشکلی پیش اومد، نمیتونم این پیامو آنپین کنم.", msg.reply_to_message.message_id)
			return
		end
		Text = "`>` پیام سنجاق شده *UnPin* شد."
		sendText(msg.chat.id, Text, msg.message_id, 'md')
	end
	------------------------------------------->

	--> CMD = /config | Promote Chat Administrators to Bot Moderator and Set the Creator to Owner ...
	if CmdLower:match("^[/!#](config)$") or Cmd:match("^(پیکربندی)$") then
		if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owners Only !
		Data = loadJson(Config.ModFile)
		Res = getRes("getChatAdministrators?chat_id="..msg.chat.id)
		local AdminNum = 0
		for i=1, #Res.result do
			if Res.result[i].status == "creator" then
				if Res.result[i].user then
					if not isBot(Res.result[i].user.id) then
						Data[tostring(msg.chat.id)]["set_owner"] = tostring(Res.result[i].user.id)
						saveJson(Config.ModFile, Data)
					end
				end
			elseif Res.result[i].status == "administrator" then
				if not isBot(Res.result[i].user.id) then
					UserUsername = Res.result[i].user.username or "None"
					Data[tostring(msg.chat.id)]["moderators"][tostring(Res.result[i].user.id)] = UserUsername
					saveJson(Config.ModFile, Data)
					AdminNum = AdminNum+1
				end
			end
		end
		Text = "> سازنده گروه به عنوان مدیر اصلی ربات در گروه انتخاب شد."
		.."\n• همچنین "..AdminNum.." نفر از مدیران این گروه به عنوان مدیر فرعی ربات در گروه منصوب شدند."
		sendText(msg.chat.id, Text, msg.message_id)
	end
	------------------------------------------->

	--> CMD = /promote [By Username and ID] | Promote a user to Bot Moderator in Group ...
	if CmdLower:match("^[/!#](promote) (%d+)$") or Cmd:match("^(ترفیع) (%d+)$") then
		if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owners Only !
		if not msg.reply_to_message then
			MatchesEN = {CmdLower:match("^[/!#](promote) (%d+)$")}; MatchesFA = {Cmd:match("^(ترفیع) (%d+)$")}
			Ptrn = MatchesEN[2] or MatchesFA[2]
			UserId = tonumber(Ptrn)
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را ترفیع دهید.", msg.message_id, 'md') return end
			if isOwner(msg.chat.id, UserId) then sendText(msg.chat.id, "`>` کاربر با شناسه `"..UserId.."` نیازی به ترفیع ندارد.\n_او در حال حاضر مقام بالاتری از مدیر فرعی ربات در گروه دارد._", msg.message_id, 'md') return end
			Data = loadJson(Config.ModFile)
			if isMod(msg.chat.id, UserId) then
				Data[tostring(msg.chat.id)]["moderators"][tostring(UserId)] = nil
				saveJson(Config.ModFile, Data)
				Text = "⏬ کاربر با شناسه `"..UserId.."` از مدیریت گروه برکنار شد."
				.."\n_او دیگر مدیر فرعی ربات در گروه نمیباشد._"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			else
				Data[tostring(msg.chat.id)]["moderators"][tostring(UserId)] = "None"
				saveJson(Config.ModFile, Data)
				Text = "⏫ کاربر با شناسه `"..UserId.."` ترفیع یافت."
				.."\n_او هم‌اکنون مدیر جزو مدیران فرعی ربات در گروه قرار گرفت._"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
	end
	--> CMD = /promote [By Reply] | Promote a member to a Moderator in Chat ...
	if CmdLower:match("^[/!#](promote)$") or Cmd:match("^(ترفیع)$") then
		if msg.reply_to_message then
			UserId = msg.reply_to_message.from.id
			if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owners Only !
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را ترفیع دهید.", msg.message_id, 'md') return end
			if isOwner(msg.chat.id, UserId) then sendText(msg.chat.id, "`>` این کاربر با شناسه `"..UserId.."` نیازی به ترفیع ندارد.\n_او در حال حاضر مقام بالاتری از مدیر فرعی ربات در گروه دارد._", msg.reply_to_message.message_id, 'md') return end
			if isMod(msg.chat.id, UserId) then
				Data[tostring(msg.chat.id)]["moderators"][tostring(UserId)] = nil
				saveJson(Config.ModFile, Data)
				Text = "⏬ این کاربر با شناسه `"..UserId.."` از مدیریت گروه برکنار شد."
				.."\n_او دیگر مدیر فرعی ربات در گروه نمیباشد._"
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
			else
				UserUsername = msg.reply_to_message.from.username or "None"
				Data[tostring(msg.chat.id)]["moderators"][tostring(UserId)] = UserUsername
				saveJson(Config.ModFile, Data)
				Text = "⏫ این کاربر با شناسه `"..UserId.."` ترفیع یافت."
				.."\n_او هم‌اکنون مدیر جزو مدیران فرعی ربات در گروه قرار گرفت._"
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
			end
		end
	end

	--> CMD = /modlist | Showing Moderators list ...
	if CmdLower:match("^[/!#](modlist)$") or Cmd:match("^(لیست مدیران فرعی)$") then
		if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Mods Only !
		Data = loadJson(Config.ModFile)
		if next(Data[tostring(msg.chat.id)]["moderators"]) == nil then sendText(msg.chat.id, "`>` لیست مدیران فرعی این گروه خالی میباشد.\n_این گروه مدیر فرعی ندارد._", msg.message_id, 'md') return end
		Text = '🏷 شناسه گروه : <code>'..msg.chat.id..'</code>'
		..'\n» لیست مدیران فرعی ربات در گروه :'
		..'\n———————\n'
		i = 0
		for k,v in pairs(Data[tostring(msg.chat.id)]["moderators"]) do
			i = i + 1
			Text = Text..i..'- <code>'..k..'</code> => (@'..v..')\n'
		end
		Text = Text.."———————"
		sendText(msg.chat.id, Text, msg.message_id, 'html')
	end
	------------------------------------------->

	--> CMD = /setowner [By Username and ID] | Set owner of a Group ...
	if CmdLower:match("^[/!#](setowner) (%d+)$") or Cmd:match("^(تنظیم مدیر اصلی) (%d+)$") then
		if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owners Only !
		if not msg.reply_to_message then
			MatchesEN = {CmdLower:match("^[/!#](setowner) (%d+)$")}; MatchesFA = {Cmd:match("^(تنظیم مدیر اصلی) (%d+)$")}
			Ptrn = MatchesEN[2] or MatchesFA[2]
			UserId = tonumber(Ptrn)
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را مدیر اصلی کنید.", msg.message_id, 'md') return end
			if isSudo(UserId) then sendText(msg.chat.id, "`>` کاربر با شناسه `"..UserId.."` مدیر کل ربات میباشد. نیازی به تنظیم او به عنوان مدیر اصلی گروه نیست.", msg.message_id, 'md') return end
			if isOwner(msg.chat.id, UserId) then sendText(msg.chat.id, "`>` کاربر با شناسه `"..UserId.."` در حال حاضر مدیر اصلی در گروه میباشد.", msg.message_id, 'md') return end
			Data = loadJson(Config.ModFile)
			Data[tostring(msg.chat.id)]["set_owner"] = tostring(UserId)
			saveJson(Config.ModFile, Data)
			Text = "👤 کاربر با شناسه `"..UserId.."` به عنوان مدیر اصلی ربات(*Owner*) در گروه تنظیم شد."
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
	end
	--> CMD = /setowner [By Reply] | Set owner of a Group ...
	if CmdLower:match("^[/!#](setowner)$") or Cmd:match("^(تنظیم مدیر اصلی)$") then
		if msg.reply_to_message then
			if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owners Only !
			UserId = msg.reply_to_message.from.id
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را به عنوان مدیر اصلی گروه تنظیم کنید.", msg.message_id, 'md') return end
			if isSudo(UserId) then sendText(msg.chat.id, "`>` این کاربر مدیر کل ربات است و نیازی به تنظیم او به عنوان مدیر اصلی گروه نیست.", msg.reply_to_message.message_id, 'md') return end
			if isOwner(msg.chat.id, UserId) then sendText(msg.chat.id, "`>` این کاربر با شناسه `"..UserId.."` در حال حاضر مدیر اصلی ربات در گروه میباشد.", msg.reply_to_message.message_id, 'md') return end
			Data = loadJson(Config.ModFile)
			Data[tostring(msg.chat.id)]["set_owner"] = tostring(UserId)
			saveJson(Config.ModFile, Data)
			Text = "👤 این کاربر با شناسه `"..UserId.."` به عنوان مدیر اصلی ربات(*Owner*) در گروه تنظیم شد."
			sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
		end
	end

	--> CMD = /owner | Showing owner of The Group ...
	if CmdLower:match("^[/!#](owner)$") or Cmd:match("^(مدیر اصلی)$") then
		Data = loadJson(Config.ModFile)
		if Data[tostring(msg.chat.id)]['set_owner'] then
			if Data[tostring(msg.chat.id)]['set_owner'] ~= "0" then
				OwnerId = tonumber(Data[tostring(msg.chat.id)]['set_owner'])
				Text = "• شناسه مدیر اصلی ربات در گروه : `"..OwnerId.."`"
				.."\n[نمایش پروفایل مدیر اصلی ربات در گروه](tg://user?id="..OwnerId..")"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
				return
			end
		end
		Text = "`>` مدیر اصلی ربات در این گروه تنظیم نشده است."
		..'\nجهت تنظیم کردن آن باید با مدیر کل ربات در تماس باشید.'
		sendText(msg.chat.id, Text, msg.message_id, 'md')
	end
	------------------------------------------->

	--> CMD = /setlink , /link | Set and Get Group Link ...
	if CmdLower:match("^[/!#](setlink)$") or Cmd:match("^(تنظیم لینک)$") then
		if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owners Only !
		Data = loadJson(Config.ModFile)
		Data[tostring(msg.chat.id)]['settings']['set_link'] = "wait"
		saveJson(Config.ModFile, Data)
		Text = "👈 حال برای تنظیم لینک ، لینک گروه را به تنهایی، همینجا ارسال نمایید ..."
		sendText(msg.chat.id, Text, msg.message_id)
	end
	if msg.text then
		Data = loadJson(Config.ModFile)
		if Data[tostring(msg.chat.id)]['settings']['set_link'] then
			if Data[tostring(msg.chat.id)]['settings']['set_link'] == 'wait' then
				if msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$") then
					if isOwner(msg.chat.id, msg.from.id) then
						Data[tostring(msg.chat.id)]['settings']['set_link'] = msg.text
						saveJson(Config.ModFile, Data)
						Text = "✅ لینک جدید تنظیم شد !"
						.."\nبرای دریافت لینک میتوانید از این دستور استفاده نمایید :"
						.."\n*/link*"
						sendText(msg.chat.id, Text, msg.message_id, 'md')
					end
				end
			end
		end
	end
	if CmdLower:match("^[/!#](link)$") or Cmd:match("^(لینک)$") then --> Get Setted Link
		Data = loadJson(Config.ModFile)
		if Data[tostring(msg.chat.id)]['settings']['set_link'] then
			if Data[tostring(msg.chat.id)]['settings']['set_link'] ~= "wait" then
				SettedLink = Data[tostring(msg.chat.id)]['settings']['set_link']
				Text = "🌟 لینک تنظیم شده برای این گروه :"
				.."\n⏺ "..SettedLink
				sendText(msg.chat.id, Text, msg.message_id)
			else
				Text = "`>` لینک گروه هنوز تنظیم نشده است."
				.."\nدستور تنظیم لینک گروه :"
				.."\n/setlink"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		else
			Text = "`>` لینک گروه هنوز تنظیم نشده است."
			.."\nدستور تنظیم لینک گروه :"
			.."\n/setlink"
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
	end
	------------------------------------------->

	--> CMD = /setrules | Set Group Rules ...
	if Cmd:match("^[/!#]([Ss][Ee][Tt][Rr][Uu][Ll][Ee][Ss]) (.*)$") or Cmd:match("^(تنظیم قوانین) (.*)$") then
		if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owners Only !
		MatchesEN = {Cmd:match("^[/!#]([Ss][Ee][Tt][Rr][Uu][Ll][Ee][Ss]) (.*)$")}; MatchesFA = {Cmd:match("^(تنظیم قوانین) (.*)$")}
		RulesText = MatchesEN[2] or MatchesFA[2]
		Rules_Hash = RulesHash..msg.chat.id
		--[[if (utf8.len(RulesText) > 500) or (utf8.len(RulesText) < 10) then
			if utf8.len(RulesText) > 500 then
				stats = "_تعداد حروف متن خود را جهت تنظیم قوانین کاهش دهید._"
			else
				stats = "_تعداد حروف متن خود را جهت تنظیم قوانین افزایش دهید._"
			end
			Text = "محدوده تعداد کاراکتر ها برای تنظیم قوانین گروه از `10` تا `500` کاراکتر میباشد!\nتعداد کاراکتر های متن شما : `"..#rules.."`\n"..stats
			sendText(msg.chat.id, Text, msg.message_id_, 'md')
			return
		end]]
		redis:set(Rules_Hash, RulesText)
		Text = "متن قوانین با موفقیت تنظیم گردید !"
		.."\nبرای دریافت قوانین از دستور زیر استفاده کنید :"
		.."\n/rules"
		sendText(msg.chat.id, Text, msg.message_id)
	end
	if CmdLower:match("^[/!#](rules)$") or Cmd:match("^(قوانین)$") then --> Getting Setted Rules ...
		Rules_Hash = RulesHash..msg.chat.id
		if redis:get(Rules_Hash) then
			GettedRules = redis:get(Rules_Hash)
			sendText(msg.chat.id, GettedRules, msg.message_id)
		else
			Text = "> قوانین این گروه تنظیم نشده است !"
			..'\nجهت تنظیم کردن قوانین از دستور زیر استفاده کنید :'
			..'\n/setrules [متن-قوانین]'
			sendText(msg.chat.id, Text, msg.message_id)
		end
	end
	------------------------------------------->

	--> CMD = /ping | Checking Robot Off or On ...
	if CmdLower:match("^[/!#](ping)$") or Cmd:match("^(پینگ)$") then
		Text = "✅ ربات فعال میباشد."
		sendText(msg.chat.id, Text, msg.message_id)
	end
	------------------------------------------->
	if CmdLower:match("^[/!#](card)$") or Cmd:match("^(شماره کارت)$") then
		Text = "5892 1010 3609 6861\nبنام⇦ امیرعلیپور"
		sendText(msg.chat.id, Text, msg.message_id)
	end
-------------------------------------->

	--> CMD = /Filter | Filtering Words ...
	if CmdLower:match("^[/!#](filter) (.*)$") or CmdLower:match("^(فیلتر) (.*)$") then
		if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Mods Only !
		MatchesEN = {CmdLower:match("^[/!#](filter) (.*)$")}; MatchesFA = {Cmd:match("^(فیلتر) (.*)$")}
		TextForFilter = MatchesEN[2] or MatchesFA[2]
		Hash = FilterHash..msg.chat.id
		IsFiltered = redis:sismember(Hash, TextForFilter)
		if not IsFiltered then
			redis:sadd(Hash, TextForFilter)
			Text = "✅ عبارت '"..TextForFilter.."' به لیست عبارات فیلتر شده در گروه اضافه گردید."
			.."\n> اگر کاربری عادی از این عبارت در پیام خود استفاده کند ، پیامش حذف خواهد شد."
			sendText(msg.chat.id, Text, msg.message_id)
		else
			Text = "عبارت '"..TextForFilter.."' از قبل فیلتر شده است."
			.."\nنیازی به فیلتر مجدد آن نیست."
			.."\n〰 جهت حذف آن از لیست فیلتر از دستور زیر استفاده کنید :"
			.."\n/rf "..TextForFilter
			sendText(msg.chat.id, Text, msg.message_id)
		end
	end

	--> CMD = /rf | Remove filtered word from list ...
	if CmdLower:match("^[/!#](rf) (.*)$") or CmdLower:match("^(رفع فیلتر) (.*)$") then
		if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Mods Only !
		MatchesEN = {CmdLower:match("^[/!#](rf) (.*)$")}; MatchesFA = {CmdLower:match("^(رفع فیلتر) (.*)$")}
		TextForUnFilter = MatchesEN[2] or MatchesFA[2]
		Hash = FilterHash..msg.chat.id
		IsFiltered = redis:sismember(Hash, TextForUnFilter)
		if IsFiltered then
			redis:srem(Hash, TextForUnFilter)
			Text = "عبارت '"..TextForUnFilter.."' از لیست فیلتر عبارات فیلتر شده حذف گردید."
			.."\nهم اکنون استفاده از آن در گروه مجاز است."
			sendText(msg.chat.id, Text, msg.message_id)
		else
			Text = "🚫 عبارت '"..TextForUnFilter.."' تا به حال فیلتر نشده است که بخواهد حذف گردد!"
			sendText(msg.chat.id, Text, msg.message_id)
		end
	end

	--> CMD = /filterlist | Getting Filter List ...
	if CmdLower:match("^[/!#](filterlist)$") or CmdLower:match("^(لیست فیلتر)") then
		if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Mods Only !
		Hash = FilterHash..msg.chat.id
		if redis:scard(Hash) < 1 then
			Text = "`>` لیست کلمات فیلتر شده خالی میباشد !"
			sendText(msg.chat.id, Text, msg.message_id, 'md')
			return
		end
		FilteredWords = redis:smembers(Hash)
		Text = "📝 شناسه گروه : "..msg.chat.id
		.."\n📛 لیست کلمات فیلتر شده :"
		.."\n—————————"
		.."\n"
		for i=1, #FilteredWords do
			Text = Text..i..'- '..FilteredWords[i]..'\n'
		end
		sendText(msg.chat.id, Text, msg.message_id)
	end
	------------------------------------------->

	--> CMD => /del | Delete a Message By Reply ...
	if CmdLower:match("^[/!#](del)$") or Cmd:match("^(حذف پیام)$") then
		if msg.reply_to_message and isMod(msg.chat.id, msg.from.id) then
			deleteMessage(msg.chat.id, msg.reply_to_message.message_id)
			deleteMessage(msg.chat.id, msg.message_id)
		end
	end

	--> CMD => /rename | Changing Chat Title ...
	if Cmd:match("^[/!#]([Rr][Ee][Nn][Aa][Mm][Ee]) (.*)$") or Cmd:match("^(تغییر نام) (.*)$") then
		if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owner Only !
		MatchesEN = {Cmd:match("^[/!#]([Rr][Ee][Nn][Aa][Mm][Ee]) (.*)$")}; MatchesFA = {Cmd:match("^(تغییر نام) (.*)$")}
		ChatNewTitle = MatchesEN[2] or MatchesFA[2]
		Res = getRes("setChatTitle?chat_id="..msg.chat.id.."&title="..URL.escape(ChatNewTitle))
		if not Res.ok then
			Text = "× من نتونستم اسم گروهو عوض کنم :|"
			sendText(msg.chat.id, Text, msg.message_id)
			return
		end
		Text = "> نام گروه با موفقیت به"
		.."\n"..ChatNewTitle
		.."\nتغییر کرد. ✅"
		sendText(msg.chat.id, Text, msg.message_id)
	end
	------------------------------------------->

	--> CMD => /setphoto | Set the photo Of Group ...
	if CmdLower:match("^[/!#](setphoto)$") or Cmd:match("^(تنظیم عکس)$") then
		if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owner Only !
		MatchesEN = {CmdLower:match("^[/!#](setphoto)$")}; MatchesFA = {Cmd:match("^(تنظیم عکس)$")}
		if msg.reply_to_message then
			if msg.reply_to_message.photo then
				PhotoFile = msg.reply_to_message.photo[4] or msg.reply_to_message.photo[3] or msg.reply_to_message.photo[2] or msg.reply_to_message.photo[1]
				PhotoFileId = PhotoFile.file_id
				PhotoPathRes = getRes("getFile?file_id="..PhotoFileId)
				if PhotoPathRes.ok then
					FilePath = PhotoPathRes.result.file_path
					FileUrl = "https://api.telegram.org/file/bot"..Config.BotToken.."/"..FilePath
					PathToSave = "./data/FunData"
					Photo = downloadToFile(FileUrl, "GroupPhoto.jpg", PathToSave)
					SetChatPhoto = setChatPhoto(msg.chat.id, Photo)
					Text = "عکس جدید گروه تنظیم شد. ✅"
					sendText(msg.chat.id, Text, msg.reply_to_message.message_id)
				else
					Text = "× این فایلو یه بار دیگه همینجا بفرست و روش ریپلای کن و دستور 'تنظیم عکس' رو بزن."
					sendText(msg.chat.id, Text, msg.message_id)
				end
			else
				Text = "× جهت تنظیم عکس پروفایل گروه لازمه روی یک عکس ریپلای کنی، نه چیز دیگه."
				sendText(msg.chat.id, Text, msg.message_id)
			end
		else
			Text = "× برای تنظیم عکس پروفایل گروه، باید روی یک عکس ریپلای کنید و سپس دستور 'تنظیم عکس' را وارد کنید."
			sendText(msg.chat.id, Text, msg.message_id)
		end
	end
	------------------------------------------->

	--> CMD => /delphoto | Delete the photo Of Group ...
	if CmdLower:match("^[/!#](delphoto)$") or Cmd:match("^(حذف عکس)$") then
		if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owner Only !
		MatchesEN = {CmdLower:match("^[/!#](delphoto)$")}; MatchesFA = {Cmd:match("^(حذف عکس)$")}
		DelChatPhoto = getRes("deleteChatPhoto?chat_id="..msg.chat.id)
		if DelChatPhoto.ok then
			Text = "تصویر پروفایل گروه با موفقیت حذف شد ! ❌"
			sendText(msg.chat.id, Text, msg.message_id)
		else
			Text = "× نتونستم عکس پروفایل گروه رو حذف کنم !!"
			sendText(msg.chat.id, Text, msg.message_id)
		end
	end
	------------------------------------------->

	--> CMD => /gpinfo | Get Chat Info ....
	if CmdLower:match("^[/!#](gpinfo)$") or Cmd:match("^(اطلاعات گروه)$") then
		R = getRes("getChat?chat_id="..msg.chat.id)
		Re = getRes("getChatMembersCount?chat_id="..msg.chat.id)
		Text = "• نام گروه : "..(R.result.title or "")
		.."\n• شناسه گروه : "..msg.chat.id
		.."\n• تعداد اعضا گروه : "..(Re.result or "----")
		sendText(msg.chat.id, Text, msg.message_id)
	end
	------------------------------------------->

	-- CMD => /setwlc AND /delwlc | Set and Del Welcome Message ...
	if Cmd:match("^[/!#]([Ss][Ee][Tt][Ww][Ll][Cc])(.*)$") or Cmd:match("^(تنظیم خوشامد)(.*)$") then
		if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owners Only !
		MatchesEN = {Cmd:match("^[/!#]([Ss][Ee][Tt][Ww][Ll][Cc])(.*)$")}; MatchesFA = {Cmd:match("^(تنظیم خوشامد)(.*)$")}
		WelcomeText = MatchesEN[2] or MatchesFA[2]
		Hash = WelcomeMessageHash..msg.chat.id
		redis:set(Hash, WelcomeText)
		Text = "`>` متن خوشامد گویی به روزرسانی شد !"
		sendText(msg.chat.id, Text, msg.message_id, 'md')
	end
	----------------------------------------

	--> CMD => /clean | clean something ...
	if CmdLower:match("^[/!#](clean) (.*)$") or CmdLower:match("^(پاکسازی) (.*)$") then
		if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owner Only !
		MatchesEN = {CmdLower:match("^[/!#](clean) (.*)$")}; MatchesFA = {Cmd:match("^(پاکسازی) (.*)$")}
		ChizToClean = MatchesEN[2] or MatchesFA[2] -- :)

		-- Clean Rules
		if ChizToClean == "rule" or ChizToClean == "rules" or ChizToClean == "قانون" or ChizToClean == "قوانین" then
			if redis:get(RulesHash..msg.chat.id) then
				redis:del(RulesHash..msg.chat.id)
				Text = "❌ قوانین گروه پاکسازی شد."
				sendText(msg.chat.id, Text, msg.message_id)
			else
				Text = "> قوانین تنظیم نشده نشده است که بخواهد حذف گردد !"
				sendText(msg.chat.id, Text, msg.message_id)
			end
		end
		-------------

		-- Clean Welcome Message
		if ChizToClean == "welcome" or ChizToClean == "wlc" or ChizToClean == "خوشامد" or ChizToClean == "خوش آمد" or ChizToClean == "خوش امد" then
			Hash = WelcomeMessageHash..msg.chat.id
			if redis:get(Hash) then
				redis:del(Hash)
				Text = "`>` متن خوشامد گویی تنظیم شده حذف شد !"
				.."\n_متن خوشامد گویی به متن پیشفرض تنظیم شد._"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			else
				Text = "`>` متن خوشامد گویی جهت حذف وجود ندارد."
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
		-------------

		-- Clean BanList
		if ChizToClean == "banlist" or ChizToClean == "لیست مسدود" then
			Hash = BanHash..msg.chat.id
			if redis:scard(Hash) == 0 then
				Text = [[⛔️ لیست کاربران مسدود این گروه خالی میباشد !
_نیازی به پاکسازی آن نیست._]]
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			else
				redis:del(Hash)
				Text = [[✅ لیست کاربران مسدود گروه پاکسازی شد.
_کاربران مسدود مجددا اجازه ورود به گروه را پیدا کردند._]]
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
		----------------

		-- Clean SilentList
		if ChizToClean == "silentlist" or ChizToClean == "لیست سایلنت" then
			Hash = SilentHash..msg.chat.id
			if redis:scard(Hash) == 0 then
				Text = [[🔇 لیست کاربران سایلنت این گروه خالی میباشد !
_نیازی به پاکسازی آن نیست._]]
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			else
				redis:del(Hash)
				Text = [[✅ لیست کاربران سایلنت گروه پاکسازی شد.
_کاربران سایلنت مجددا اجازه چت در گروه را دریافت کردند._]]
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
		----------------

		-- Clean FilterList
		if ChizToClean == "filters" or ChizToClean == "filterlist" or ChizToClean == "لیست فیلتر" then
			Hash = FilterHash..msg.chat.id
			if redis:scard(Hash) == 0 then
				Text = [[⛔️ هیچ عبارت فیلتر شده ای در این گروه وجود ندارد!
_نیازی به پاکسازی آن نیست._]]
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			else
				redis:del(Hash)
				Text = [[✅ تمامی عبارات فیلتر شده در گروه مجاز شدند!
_لیست عبارات فیلتر شده پاکسازی شد._]]
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
		-------------

		-- Clean Group Link
		if ChizToClean == "modlist" or ChizToClean == "لیست مدیران" or ChizToClean == "لیست مدیران فرعی" then
			Data = loadJson(Config.ModFile)
			if next(Data[tostring(msg.chat.id)]['moderators']) == nil then
				Text = [[🔹هیچ مدیر فرعی انتخاب نشده(لیست مدیران فرعی خالی است.) که لیست مدیران فرعی پاک گردد!
_نیازی به پاکسازی لیست مدیران فرعی نیست._]]
				sendText(msg.chat.id, Text, msg.message_id, 'md')
				return
			end
			Num = 0
			for k,v in pairs(Data[tostring(msg.chat.id)]['moderators']) do
				Data[tostring(msg.chat.id)]['moderators'][tostring(k)] = nil
				saveJson(Config.ModFile, Data)
				Num = Num+1
			end
			Text = "✅ لیست مدیران فرعی ربات در گروه با تعداد *"..Num.."*نفر پاکسازی شد."
			.."\n_هم اکنون هیچکس به عنوان مدیر فرعی ربات در گروه قرار ندارد._"
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
		-------------------

		-- Clean Group Link
		if ChizToClean == "لینک" or ChizToClean == "link" then
			Data = loadJson(Config.ModFile)
			if Data[tostring(msg.chat.id)]["settings"]["set_link"] then
				if Data[tostring(msg.chat.id)]["settings"]["set_link"] ~= "wait" and Data[tostring(msg.chat.id)]["settings"]["set_link"] ~= nil then
					Data[tostring(msg.chat.id)]["settings"]["set_link"] = nil
					saveJson(Config.ModFile, Data)
					Text = "❌ لینک گروه پاکسازی شد !"
					.."\n> دستور تنظیم مجدد لینک گروه :"
					.."\n/setlink"
				else
					Text = "لینک گروه تنظیم نشده است!\nتنظیم لینک گروه:\n/setlink"
				end
			else
				Text = "لینک گروه تنظیم نشده است!\nتنظیم لینک گروه:\n/setlink"
			end
			sendText(msg.chat.id, Text, msg.message_id)
		end
		-------------------

		-- Clean Group Link
		if ChizToClean == "owner" or ChizToClean == "مدیر اصلی" or ChizToClean == "اونر" then
			if not isSudo(msg.from.id) then notSudo(msg) return end -- Sudo Only !
			Data = loadJson(Config.ModFile)
			if Data[tostring(msg.chat.id)]['set_owner'] then
				if tonumber(Data[tostring(msg.chat.id)]['set_owner']) ~= 0 then
					Data[tostring(msg.chat.id)]['set_owner'] = "0"
					saveJson(Config.ModFile, Data)
					Text = "`>` مدیر اصلی ربات در گروه خلع مقام شد."
					.."\n_در حال حاضر کسی مدیر اصلی ربات در گروه نمیباشد._"
					sendText(msg.chat.id, Text, msg.message_id, 'md')
				else
					Text = "`>` مدیر اصلی این گروه تنظیم نشده است که خلع مقام شود."
					sendText(msg.chat.id, Text, msg.message_id, 'md')
				end
			end
		end
		-------------------

	end -- end Clean [STH]

	--> CMD => /me | Get the rank of user ...
	if CmdLower:match("^[/!#](me)$") or CmdLower:match("^[/!#](myrank)$") or Cmd:match("^(مقام من)$") then
		if isSudo(msg.from.id) then
			UserRankFA = "مدیر کل ربات"
			UserRankEN = "*Sudo*"
			Stars = "🎖🎖🎖"
		elseif isOwner(msg.chat.id, msg.from.id) then
			UserRankFA = "مدیر اصلی ربات در گروه"
			UserRankEN = "*Owner*"
			Stars = "🎖🎖"
		elseif isMod(msg.chat.id, msg.from.id) then
			UserRankFA = "مدیر فرعی ربات در گروه"
			UserRankEN = "*Moderator*"
			Stars = "🎖"
		else
			UserRankFA = "کاربر عادی"
			UserRankEN = "*Member*"
			Stars = ""
		end
		Text = "`>` شناسه شما : `"..msg.from.id.."`"
		.."\n`>` مقام شما (فارسی) : "..UserRankFA
		.."\n`>` مقام شما (انگلیسی) : "..UserRankEN
		.."\n"..Stars
		sendText(msg.chat.id, Text, msg.message_id, 'md')
	end
	---------------------------------------

end -- END CHAT_MOD.LUA

function warnPlugin(msg) -- WARN.LUA

	Cmd = msg.text
	CmdLower = msg.text:lower()
	Data = loadJson(Config.ModFile)
	if not Data[tostring(msg.chat.id)] then
		return
	end

	-- LOCK CMD -----------
	if Data[tostring(msg.chat.id)]["settings"] then
		if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] then
			if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] == "yes" and not isMod(msg.chat.id, msg.from.id) then
				return
			end
		end
	end
	-----------------------
	
	--> CMD = /setwarn | Set Max Warn in Group ...
	if CmdLower:match("^[/!#](setwarn) (%d+)$") or Cmd:match("^(تنظیم اخطار) (%d+)$") then
			MatchesEN = {CmdLower:match("^[/!#](setwarn) (%d+)$")}; MatchesFA = {Cmd:match("^(تنظیم اخطار) (%d+)$")}
			Ptrn = MatchesEN[2] or MatchesFA[2]
			MaxWarnToSet = tonumber(Ptrn)
			Hash = MaxWarnHash..msg.chat.id
			if not isOwner(msg.chat.id, msg.from.id) then notOwner(msg) return end -- Owners Only !
			if MaxWarnToSet < 2 or MaxWarnToSet > 10 then
				Text = "🚫 محدوده تنظیم حداکثر تعداد اخطار در گروه بین 2 تا 10 میباشد."
				.."\nاما شما عدد "..MaxWarnToSet.." را انتخاب کرده اید."
				sendText(msg.chat.id, Text, msg.message_id)
			elseif tonumber(redis:get(Hash)) == MaxWarnToSet then
				Text = "حداکثر تعداد اخطار در گروه از قبل "..MaxWarnToSet.." بوده است!"
				sendText(msg.chat.id, Text, msg.message_id)
			else
				redis:set(Hash, MaxWarnToSet)
				Text = "حداکثر تعداد اخطار در گروه به "..MaxWarnToSet.." تنظیم شد. ✅"
				sendText(msg.chat.id, Text, msg.message_id)
			end
	end
	---------------------------------------------

	--> CMD => /warn | warn a User in Group ...
	if CmdLower:match("^[/!#](warn)$") or Cmd:match("^(اخطار)$") then
		if msg.reply_to_message then
			if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Only Mods !
			UserId = msg.reply_to_message.from.id
			if isMod(msg.chat.id, UserId) then
				Text = "این کاربر با شناسه `"..UserId.."` جزو مدیران ربات در گروه میباشد."
				.."\nنمیتوانید به او اخطار دهید."
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
			elseif isBot(UserId) then
				Text = "به خود ربات نمیتوان اخطار داد ..."
				sendText(msg.chat.id, Text, msg.message_id)
			else
				Hash = WarnHash..msg.chat.id
				WarnsLimit = redis:get(MaxWarnHash..msg.chat.id) or 3
				WarnsLimit = tonumber(WarnsLimit)
				UserWarnsUntilNow = redis:hget(Hash, UserId) or 0
				UserWarnsUntilNow = tonumber(UserWarnsUntilNow)
				redis:hset(Hash, UserId, UserWarnsUntilNow+1)
				redis:sadd(WarnedUsersHash..msg.chat.id, UserId)
				UserWarnsAfterWarn = redis:hget(Hash, UserId) or 0
				UserWarnsAfterWarn = tonumber(UserWarnsAfterWarn)
				if UserWarnsAfterWarn >= WarnsLimit then
					Text = "🔺 کاربر ["..(msg.reply_to_message.from.first_name or "----").."](tg://user?id="..UserId..") از طرف مدیران یک اخطار دریافت کرد."
					.."\n📛 کل اخطار های کاربر : "..UserWarnsAfterWarn
					.."\n⛔️ حداکثر تعداد مجاز اخطار : "..WarnsLimit
					.."\n> این کاربر به دلیل اخطار های دریافتی از گروه اخراج شد ! 👞"
					kickUser(msg.chat.id, UserId)
					redis:hdel(Hash, UserId)
					sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
				else
					Text = "🔺 کاربر ["..(msg.reply_to_message.from.first_name or "----").."](tg://user?id="..UserId..") از طرف مدیران یک اخطار دریافت کرد."
					.."\n📛 اخطار هایی که این کاربر دریافت کرده : "..UserWarnsAfterWarn
					.."\n⛔️ حداکثر تعداد مجاز اخطار : "..WarnsLimit
					.."\n> در صورتی که این کاربر "..(WarnsLimit - UserWarnsAfterWarn).." اخطار دیگر از سوی مدیران دریافت کند، از گروه اخراج خواهد شد."
					sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
				end
			end
		end
	end
	
	if CmdLower:match("^[/!#](warn) (%d+)$") or Cmd:match("^(اخطار) (%d+)$") then
		if msg.reply_to_message then
			if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Only Mods !
			MatchesEN = {CmdLower:match("^[/!#](warn) (%d+)$")}; MatchesFA = {Cmd:match("^(اخطار) (%d+)$")}
			NumberToWarn = MatchesEN[2] or MatchesFA[2]
			NumberToWarn = tonumber(NumberToWarn)
			UserId = msg.reply_to_message.from.id
			if isMod(msg.chat.id, UserId) then
				Text = "این کاربر با شناسه `"..UserId.."` جزو مدیران ربات در گروه میباشد."
				.."\nنمیتوانید به او اخطار دهید."
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
			elseif isBot(UserId) then
				Text = "به خود ربات نمیتوان اخطار داد ..."
				sendText(msg.chat.id, Text, msg.message_id)
			else
				Hash = WarnHash..msg.chat.id
				WarnsLimit = redis:get(MaxWarnHash..msg.chat.id) or 3
				WarnsLimit = tonumber(WarnsLimit)
				UserWarnsUntilNow = redis:hget(Hash, UserId) or 0
				UserWarnsUntilNow = tonumber(UserWarnsUntilNow)
				redis:hset(Hash, UserId, UserWarnsUntilNow+NumberToWarn)
				redis:sadd(WarnedUsersHash..msg.chat.id, UserId)
				UserWarnsAfterWarn = redis:hget(Hash, UserId) or 0
				UserWarnsAfterWarn = tonumber(UserWarnsAfterWarn)
				if UserWarnsAfterWarn >= WarnsLimit then
					Text = "🔺 کاربر ["..(msg.reply_to_message.from.first_name or "----").."](tg://user?id="..UserId..") از طرف مدیران "..NumberToWarn.." اخطار دریافت کرد."
					.."\n📛 کل اخطار های کاربر : "..UserWarnsAfterWarn
					.."\n⛔️ حداکثر تعداد مجاز اخطار : "..WarnsLimit
					.."\n> این کاربر به دلیل اخطار های دریافتی از گروه اخراج شد ! 👞"
					kickUser(msg.chat.id, UserId)
					redis:hdel(Hash, UserId)
					sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
				else
					Text = "🔺 کاربر ["..(msg.reply_to_message.from.first_name or "----").."](tg://user?id="..UserId..") از طرف مدیران "..NumberToWarn.." اخطار دریافت کرد."
					.."\n📛 کل اخطار های کاربر : "..UserWarnsAfterWarn
					.."\n⛔️ حداکثر تعداد مجاز اخطار : "..WarnsLimit
					.."\n> در صورتی که این کاربر "..(WarnsLimit - UserWarnsAfterWarn).." اخطار دیگر از سوی مدیران دریافت کند، از گروه اخراج خواهد شد."
					sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
				end
			end
		end
	end
	----------------------------------------

	--> CMD => /unwarn | UnWarn a User in Group ...
	if CmdLower:match("^[/!#](unwarn)$") or Cmd:match("^(حذف اخطار)$") then
		if msg.reply_to_message then
			if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Only Mods !
			UserId = msg.reply_to_message.from.id
			Hash = WarnHash..msg.chat.id
			WarnsLimit = redis:get(MaxWarnHash..msg.chat.id) or 3
			WarnsLimit = tonumber(WarnsLimit)
			UserWarnsUntilNow = redis:hget(Hash, UserId) or 0
			UserWarnsUntilNow = tonumber(UserWarnsUntilNow)
			if UserWarnsUntilNow == 0 then
				Text = "کاربر ["..(msg.reply_to_message.from.first_name or "----").."](tg://user?id="..UserId..") هیچ اخطاری ندارد که از آنها کم شود."
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
			else
				redis:hset(Hash, UserId, UserWarnsUntilNow-1) -- Deleting 1 Of Warns OF User ...
				UserWarnsAfterWarn = redis:hget(Hash, UserId) or 0
				UserWarnsAfterWarn = tonumber(UserWarnsAfterWarn)
				TextA = "> این کاربر هم اکنون "..UserWarnsAfterWarn.." اخطار دارد !"
				if UserWarnsAfterWarn <= 0 then
					TextA = "> این کاربر دیگر اخطاری ندارد !"
					redis:srem(WarnedUsersHash..msg.chat.id, UserId) -- Delete UserId From WarnedUsers List
				end
				Text = "کاربر ["..(msg.reply_to_message.from.first_name or "----").."](tg://user?id="..UserId..")،"
				.."\n"..UserWarnsUntilNow.." اخطار داشت که یکی از آنها کم شد."
				.."\n"..TextA
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
			end
		end
	end
	
	if CmdLower:match("^[/!#](unwarn) (%d+)$") or Cmd:match("^(حذف اخطار) (%d+)$") then
		if msg.reply_to_message then
			if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Only Mods !
			MatchesEN = {CmdLower:match("^[/!#](unwarn) (%d+)$")}; MatchesFA = {Cmd:match("^(حذف اخطار) (%d+)$")}
			NumberToDelWarn = MatchesEN[2] or MatchesFA[2]
			NumberToDelWarn = tonumber(NumberToDelWarn)
			UserId = msg.reply_to_message.from.id
			Hash = WarnHash..msg.chat.id
			WarnsLimit = redis:get(MaxWarnHash..msg.chat.id) or 3
			WarnsLimit = tonumber(WarnsLimit)
			UserWarnsUntilNow = redis:hget(Hash, UserId) or 0
			UserWarnsUntilNow = tonumber(UserWarnsUntilNow)
			if UserWarnsUntilNow == 0 then
				Text = "کاربر ["..(msg.reply_to_message.from.first_name or "----").."](tg://user?id="..UserId..") هیچ اخطاری ندارد که از آنها کم شود."
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
			else
				if UserWarnsUntilNow-NumberToDelWarn < 0 then
					NewWarns = 0
				else
					NewWarns = UserWarnsUntilNow-NumberToDelWarn
				end
				redis:hset(Hash, UserId, NewWarns)
				UserWarnsAfterWarn = redis:hget(Hash, UserId) or 0
				UserWarnsAfterWarn = tonumber(UserWarnsAfterWarn)
				TextA = "> این کاربر هم اکنون "..UserWarnsAfterWarn.." اخطار دارد !"
				if NewWarns == 0 then
					TextA = "> این کاربر دیگر اخطاری ندارد !"
					redis:srem(WarnedUsersHash..msg.chat.id, UserId) -- Delete UserId From WarnedUsers List
				end
				Text = "کاربر ["..(msg.reply_to_message.from.first_name or "----").."](tg://user?id="..UserId..")،"
				.."\n"..UserWarnsUntilNow.." اخطار داشت که "..NumberToDelWarn.." از آنها کم شد."
				.."\n"..TextA
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
			end
		end
	end
	------------------------------------------------
	
	--> /warnlist | Warned Users List ....
	if CmdLower:match("^[/!#](warnlist)$") or Cmd:match("^(لیست اخطار)$") then
		if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Only Mods !
		Hash = WarnedUsersHash..msg.chat.id
		if tonumber(redis:scard(Hash)) == 0 then
			Text = "لیست کاربران اخطار داده شده خالی میباشد !"
			sendText(msg.chat.id, Text, msg.message_id)
		else
			Text = "📛 لیست کاربران اخطار داده شده در گروه :"
			.."\n"
			.."\n"
			Users = redis:smembers(Hash)
			for i=1, #redis:smembers(Hash) do
				Text = Text..i.."- ["..Users[i].."](tg://user?id="..Users[i]..") | اخطار ها : "..(redis:hget(WarnHash..msg.chat.id, Users[i]) or 0)
				.."\n"
				.."\n"
			end
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
	end
	------------------------------------------------

end -- End WARN.LUA !

function banPlugin(msg) -- BAN.LUA

	Cmd = msg.text
	CmdLower = msg.text:lower()
	Data = loadJson(Config.ModFile)
	if not Data[tostring(msg.chat.id)] then
		return
	end

	-- LOCK CMD -----------
	if Data[tostring(msg.chat.id)]["settings"] then
		if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] then
			if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] == "yes" and not isMod(msg.chat.id, msg.from.id) then
				return
			end
		end
	end
	-----------------------

	--> CMD = /ban [By Username and ID] | Ban and Kick a User From Group ...
	if CmdLower:match("^[/!#](ban) (%d+)$") or Cmd:match("^(مسدود) (%d+)$") then
		if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Owners Only !
		if not msg.reply_to_message then
			MatchesEN = {CmdLower:match("^[/!#](ban) (%d+)$")}; MatchesFA = {Cmd:match("^(مسدود) (%d+)$")}
			Ptrn = MatchesEN[2] or MatchesFA[2]
			Hash = BanHash..msg.chat.id
			UserId = tonumber(Ptrn)
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را مسدود نمایید.", msg.message_id, 'md') return end
			if isMod(msg.chat.id, UserId) then sendText(msg.chat.id, "`>` کاربر با شناسه `"..UserId.."` جزو مدیران میباشد.\n_نمیتوانید او را مسدود کنید._", msg.message_id, 'md') return end
			if isBannedUser(msg.chat.id, UserId) then
				redis:srem(Hash, UserId)
				Text = "`>` کاربر با شناسه `"..UserId.."` از لیست کاربران مسدود گروه خارج شد. ✅"
				.."\n_او هم‌اکنون اجازه ورود به گروه را دارد._"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			else
				redis:sadd(Hash, UserId)
				kickUser(msg.chat.id, UserId)
				Text = "`>` کاربر با شناسه `"..UserId.."` در گروه مسدود شد. 🚫"
				.."\n_در صورت وارد شدن، به سرعت اخراج خواهد شد._"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
	end

	--> CMD = /ban [By Reply] | Ban a User From Group ...
	if CmdLower:match("^[/!#](ban)$") or Cmd:match("^(مسدود)$") then
		if msg.reply_to_message then
			if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Owners Only !
			UserId = msg.reply_to_message.from.id
			Hash = BanHash..msg.chat.id
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را مسدود نمایید.", msg.message_id, 'md') return end
			if isMod(msg.chat.id, UserId) then sendText(msg.chat.id, "`>` کاربر با شناسه `"..UserId.."` جزو مدیران میباشد.\n_نمیتوانید او را مسدود کنید._", msg.message_id, 'md') return end
			if isBannedUser(msg.chat.id, UserId) then
				redis:srem(Hash, UserId)
				Text = "`>` این کاربر با شناسه `"..UserId.."` از لیست کاربران مسدود گروه خارج شد. ✅"
				.."\n_او هم‌اکنون اجازه ورود به گروه را دارد._"
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
			else
				redis:sadd(Hash, UserId)
				kickUser(msg.chat.id, UserId)
				Text = "`>` این کاربر با شناسه `"..UserId.."` در گروه مسدود شد. 🚫"
				.."\n_در صورت وارد شدن، به سرعت اخراج خواهد شد._"
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
			end
		end
	end

	--> CMD = /banlist | Get the Banlist OF Group ...
	if CmdLower:match("^[/!#](banlist)$") or Cmd:match("^(لیست مسدود)$") then
		Hash = BanHash..msg.chat.id
		BanUsersArray = redis:smembers(Hash)
		if tonumber(redis:scard(Hash)) < 1 then
			local Text = "`>` لیست مسدودی های گروه خالی میباشد."
			.."\n_کسی در گروه مسدود نمیباشد._"
			sendText(msg.chat.id, Text, msg.message_id, 'md')
			return
		end
		Text = "🚫 لیست کاربران مسدود در گروه :"
		.."\n———————"
		.."\n"
		for i=1, #BanUsersArray do
			Text = Text..i.."- `"..BanUsersArray[i].."`\n"
		end
		sendText(msg.chat.id, Text, msg.message_id, 'md')
	end
	------------------------------------------------

	--> CMD = /gban [By Username and ID] | Ban a User From All Moderated Groups Of Bot ...
	if CmdLower:match("^[/!#](gban) (%d+)$") or Cmd:match("^(مسدود همگانی) (%d+)$") then
		if not isSudo(msg.from.id) then notSudo(msg) return end -- Owners Only !
		if not msg.reply_to_message then
			MatchesEN = {CmdLower:match("^[/!#](gban) (%d+)$")}; MatchesFA = {Cmd:match("^(مسدود همگانی) (%d+)$")}
			Ptrn = MatchesEN[2] or MatchesFA[2]
			UserId = tonumber(Ptrn)
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را مسدود همگانی کنید.", msg.message_id, 'md') return end
			if isSudo(UserId) then sendText(msg.chat.id, "<code>></code> کاربر با شناسه <code>"..UserId.."</code> جزو مدیران کل ربات میباشد.\n_نمیتوانید او را مسدود همگانی کنید._", msg.message_id, 'html') return end
			if isGBannedUser(UserId) then
				redis:srem(GBanHash, UserId)
				Text = "`>` کاربر با شناسه `"..UserId.."` از لیست کاربران مسدود همگانی خارج شد. ✅"
				.."\n_او هم‌اکنون اجازه ورود به گروه های تحت مدیریت ربات را دارد._"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			else
				redis:sadd(GBanHash, UserId)
				Text = "`>` کاربر با شناسه `"..UserId.."` از همه گروه های ربات مسدود شد. 🚫"
				.."\n_در صورت وارد شدن به هر کدام از گروه های مدیریت شده ربات، به سرعت اخراج خواهد شد._"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
	end

	--> CMD = /gban [By Reply] | Ban a User From All Moderated Groups ...
	if CmdLower:match("^[/!#](gban)$") or Cmd:match("^(مسدود همگانی)$") then
		if msg.reply_to_message then
			UserId = msg.reply_to_message.from.id
			if not isSudo(msg.from.id) then notSudo(msg) return end -- Owners Only !
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را مسدود همگانی کنید", msg.message_id, 'md') return end
			if isSudo(UserId) then sendText(msg.chat.id, "`>` این کاربر با شناسه `"..UserId.."` جزو مدیران ربات کل ربات میباشد.\n_نمیتوانید او را مسدود کنید._", msg.reply_to_message, 'md') return end
			if isGBannedUser(UserId) then
				redis:srem(GBanHash, UserId)
				Text = "<code>></code> این کاربر با شناسه <code>"..UserId.."</code> از لیست کاربران مسدود همگانی خارج شد. ✅"
				.."\n<i>او هم‌اکنون اجازه ورود به گروه های مدیریت شده ربات را دارد.</i>"
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'html')
			else
				redis:sadd(GBanHash, UserId)
				Text = "<code>></code> این کاربر با شناسه <code>"..UserId.."</code> از تمامی گروه های مدیریت شده ربات مسدود شد. 🚫"
				.."\n<i>در صورت وارد شدن به هر کدام از گروه های مدیریت شده ربات، به سرعت اخراج خواهد شد.</i>"
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'html')
			end
		end
	end

	--> CMD => /gbanlist | Getting GbanList ...
	if CmdLower:match("^[/!#](gbanlist)$") or Cmd:match("^(لیست مسدود همگانی)$") then
		GBanUsersArray = redis:smembers(GBanHash)
		if tonumber(redis:scard(GBanHash)) < 1 then
			local Text = "`>` لیست مسدودی های همگانی خالی میباشد."
			sendText(msg.chat.id, Text, msg.message_id, 'md')
			return
		end
		Text = "🚫 لیست کاربران مسدود از تمامی گروه های تحت مدیریت ربات :"
		.."\n———————"
		.."\n"
		for i=1, #GBanUsersArray do
			Text = Text..i.."- `"..GBanUsersArray[i].."`\n"
		end
		sendText(msg.chat.id, Text, msg.message_id, 'md')
	end
	----------------------------------------

	--> CMD = /silent [By Username and ID] | Silent a user in a Chat ...
	if CmdLower:match("^[/!#](silent) (%d+)$") or Cmd:match("^(سایلنت) (%d+)$") then
		if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Owners Only !
		if not msg.reply_to_message then
			MatchesEN = {CmdLower:match("^[/!#](silent) (%d+)$")}; MatchesFA = {Cmd:match("^(سایلنت) (%d+)$")}
			Ptrn = MatchesEN[2] or MatchesFA[2]
			Hash = SilentHash..msg.chat.id
			UserId = tonumber(Ptrn)
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را سایلنت کنید.", msg.message_id, 'md') return end
			if isMod(msg.chat.id, UserId) then sendText(msg.chat.id, "`>` کاربر با شناسه `"..UserId.."` جزو مدیران میباشد.\n_نمتوانید او را سایلنت کنید._", msg.message_id, 'md') return end
			if isSilentUser(msg.chat.id, UserId) then
				redis:srem(Hash, UserId)
				Text = "`>` کاربر با شناسه `"..UserId.."` از لیست کاربران سایلنت گروه خارج گردید. 🔉"
				.."\n_او هم‌اکنون اجازه چت در گروه را دارد._"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			else
				redis:sadd(Hash, UserId)
				Text = "`>` کاربر با شناسه `"..UserId.."` در گروه سایلنت شد. 🔇"
				.."\n_هر چتی از طرف این کاربر در گروه پاک خواهد شد._"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
	end

	--> CMD = /ban [By Reply] | Ban a User From Group ...
	if CmdLower:match("^[/!#](silent)$") or Cmd:match("^(سایلنت)$") then
		if msg.reply_to_message then
			if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Owners Only !
			Hash = SilentHash..msg.chat.id
			UserId = msg.reply_to_message.from.id
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را در گروه سایلنت کنید.", msg.message_id, 'md') return end
			if isMod(msg.chat.id, UserId) then sendText(msg.chat.id, "`>` این کاربر با شناسه `"..UserId.."` جزو مدیران ربات در گروه است.\n_نمیتوانید او را سایلنت کنید._", msg.reply_to_message.message_id, 'md') return end
			if isSilentUser(msg.chat.id, UserId) then
				redis:srem(Hash, UserId)
				Text = "<code>></code> این کاربر با شناسه <code>"..UserId.."</code> از لیست کاربران سایلنت گروه خارج شد. 🔉"
				.."\n<i>او هم‌اکنون اجازه چت در گروه را دارد.</i>"
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'html')
			else
				redis:sadd(Hash, UserId)
				Text = "<code>></code> این کاربر با شناسه <code>"..UserId.."</code> در گروه سایلنت شد. 🔇"
				.."\n<i>هر چتی از طرف این کاربر در گروه پاک خواهد شد.</i>"
				sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'html')
			end
		end
	end

	--> CMD = /silentlist | Get The Silent List of Group ...
	if CmdLower:match("^[/!#](silentlist)$") or Cmd:match("^(لیست سایلنت)$") then
		Hash = SilentHash..msg.chat.id
		SilentUsersArray = redis:smembers(Hash)
		if tonumber(redis:scard(Hash)) < 1 then
			local Text = "`>` لیست کاربران سایلنت در گروه خالی میباشد."
			.."\n_کسی در گروه سایلنت نمیباشد._"
			sendText(msg.chat.id, Text, msg.message_id, 'md')
			return
		end
		Text = "🔇 لیست کاربران سایلنت در گروه :"
		.."\n———————"
		.."\n"
		for i=1, #SilentUsersArray do
			Text = Text..i.."- `"..SilentUsersArray[i].."`\n"
		end
		sendText(msg.chat.id, Text, msg.message_id, 'md')
	end
	----------------------------------------

	--> CMD = /kick [By Username and ID] | Silent a user in a Chat ...
	if CmdLower:match("^[/!#](kick) (%d+)$") or Cmd:match("^(اخراج) (%d+)$") then
		if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Owners Only !
		if not msg.reply_to_message then
			MatchesEN = {CmdLower:match("^[/!#](kick) (%d+)$")}; MatchesFA = {Cmd:match("^(اخراج) (%d+)$")}
			Ptrn = MatchesEN[2] or MatchesFA[2]
			UserId = tonumber(Ptrn)
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را از گروه اخراج کنید.", msg.message_id, 'md') return end
			if isMod(msg.chat.id, UserId) then sendText(msg.chat.id, "`>` کاربر با شناسه `"..UserId.."` جزو مدیران میباشد.\n_نمیتوانید او را اخراج کنید._", msg.message_id, 'md') return end
			kickUser(msg.chat.id, UserId)
			Text = "`>` کاربر با شناسه `"..UserId.."` از گروه اخراج شد. 👞"
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
	end

	--> CMD = /kick [By Reply] | Ban a User From Group ...
	if CmdLower:match("^[/!#](kick)$") or Cmd:match("^(اخراج)$") then
		if msg.reply_to_message then
			if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end -- Owners Only !
			UserId = msg.reply_to_message.from.id
			if isBot(UserId) then sendText(msg.chat.id, "`>` نمیتوانید خود ربات را از گروه اخراج کنید.", msg.message_id, 'md') return end
			if isMod(msg.chat.id, UserId) then sendText(msg.chat.id, "`>` این کاربر با شناسه `"..UserId.."` جزو مدیران ربات در گروه است.\n_نمیتوانید او را اخراج کنید._", msg.reply_to_message, 'md') return end
			kickUser(msg.chat.id, UserId)
			Text = "`>` این کاربر با شناسه `"..UserId.."` از گروه اخراج شد. 👞"
			sendText(msg.chat.id, Text, msg.reply_to_message.message_id, 'md')
		end
	end
	----------------------------------------

end -- END BAN.LUA

function forceAdd(msg) -- ForceAdd.Lua

	Cmd = msg.text
	CmdLower = msg.text:lower()
	Data = loadJson(Config.ModFile)
	if not Data[tostring(msg.chat.id)] then
		return
	end

	-- LOCK CMD -----------
	if Data[tostring(msg.chat.id)]["settings"] then
		if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] then
			if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] == "yes" and not isMod(msg.chat.id, msg.from.id) then
				return
			end
		end
	end
	-----------------------

end -- End ForceAdd.Lua

function panelPlugin(msg)

	Cmd = msg.text
	CmdLower = msg.text:lower()
	Data = loadJson(Config.ModFile)
	if not Data[tostring(msg.chat.id)] then
		return
	end
	
	-- LOCK CMD -----------
	if Data[tostring(msg.chat.id)]["settings"] then
		if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] then
			if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] == "yes" and not isMod(msg.chat.id, msg.from.id) then
				return
			end
		end
	end
	-----------------------
	
	--> CMD => /panel | Getting inline Panel of a Group ...
	if CmdLower:match("^[/!#](panel)$") or Cmd:match('^(پنل)$') then

		-- Checking Permission for Getting Panel ...
		if redis:hget(ModeratorsSettingsHash..msg.chat.id, "inlinepanel") then
			if not isMod(msg.chat.id, msg.from.id) then notMod(msg) return end
		elseif not isOwner(msg.chat.id, msg.from.id) then
			notOwner(msg)
			return
		end

		keyboard = {}
		keyboard.inline_keyboard =
			{
				{
					{text = '⚙️ تنظیمات اصلی گروه', callback_data = msg.chat.id..':showmenu:generalsettings:1'}
				},
				{
					{text = '🔖 اطلاعات گروه و مدیریت کاربران', callback_data = msg.chat.id..':showmenu:groupinfo:1'}
				},
				{
					{text = 'زمان و تاریخ', callback_data = msg.chat.id..':showmenu:timeanddate:1'},
					{text = 'ورود به کانال ربات', url = Config.ChannelLink}
				},
				{
					{text = '💡راهنما دستورات ربات', callback_data = msg.chat.id..':showmenu:bothelp:1'}
				},
				{
					{text = '🔑 دریافت همین پنل در خصوصی', url = "https://telegram.me/"..BotUsername.."?start=getpanel"..msg.chat.id}
				},
				{
					{text = '❌ بستن پنل', callback_data = msg.chat.id..':showmenu:closepanel:1'},
				},
			}
		Text = "~> به پنل مدیریت آسان گروه خوش آمدید."
		.."\n• نام گروه : "..getChat(msg.chat.id).title
		.."\n• شناسه گروه : "..msg.chat.id
		.."\n• با استفاده از این پنل شما میتوانید به راحتی و با تنها یک کلیک/لمس ساده تنظیمات گروه خود را انجام داده و آن را مدیریت کنید."
		.."\n> جهت استفاده از هر کدام کافیست روی آن کلیک کنید :"
		sendText(msg.chat.id, Text, msg.message_id, false, keyboard)
	end

end

function funPlugin(msg)

	Cmd = msg.text
	CmdLower = msg.text:lower()
	Data = loadJson(Config.ModFile)

	if not Data[tostring(msg.chat.id)] then
		return
	end
	-- LOCK CMD -----------
	if Data[tostring(msg.chat.id)]["settings"] then
		if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] then
			if Data[tostring(msg.chat.id)]["settings"]["lock_cmd"] == "yes" and not isMod(msg.chat.id, msg.from.id) then
				return
			end
		end
	end
	-----------------------

	--> CMD => /time | get the time ...
	if CmdLower:match("^[/!#](time)$") or Cmd:match("^(زمان)$") then
		local url , res = https.request('https://enigma-dev.ir/api/time/')
		if res ~= 200 then return end
		if url then
			local jd = json:decode(url)
			if jd then
				Text = "🗓 امروز : "..jd.FaDate.WordTwo
				.."\n⏰ ساعت : "..jd.FaTime.Number
				.."\n"
				.."\n🗓*Today* : *"..jd.EnDate.WordOne.."*"
				.."\n⏰ *Time* : *"..jd.EnTime.Number.."*"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
				return
			end
		end
		Text = "× در نمایش زمان خطایی رخ داد !"
		sendText(msg.chat.id, Text, msg.message_id)
	end
	-----------------------------------

	--> CMD => /time | get the date ...
	if CmdLower:match("^[/!#](date)$") or Cmd:match("^(تاریخ)$") then
		url , res = https.request('https://enigma-dev.ir/api/date/')
		if res ~= 200 then return end
		if url then
			if json:decode(url) then
				j = json:decode(url)
				Text = "☀ _منطقه ی زمانی_ : `"..j.ZoneName
				.."`\n\n⚜ قرن (شمسی) : `"..j.Century
				.."` اُم\n⚜ سال شمسی : `"..j.Year.Number
				.."`\n⚜ فصل : `"..j.Season.Name
				.."`\n⚜ ماه : `"..j.Month.Number.."` اُم ( `"..j.Month.Name.."` )"
				.."\n⚜ روز از ماه : `"..j.Day.Number
				.."`\n⚜ روز هفته : `"..j.Day.Name
				.."`\n\n⚡️ نام سال : `"..j.Year.Name
				.."`\n⚡️ نام ماه : `"..j.Month.Name
				.."`\n\n〽 تعداد روز های گذشته از سال : `"..j.DaysPassed.Number.."` ( `"..j.DaysPassed.Percent.."%` )"
				.."\n〽 روز های باقیمانده از سال : `"..j.DaysLeft.Number.."` ( `"..j.DaysLeft.Percent.."%` )\n\n"
				sendText(msg.chat.id, Text, msg.message_id, 'md')
			end
		end
	end
	---------------------------------

	--> CMD => /sticker [text] | Making Sticker using www.flamingtext.com ...
	if Cmd:match("^[/!#]([Ss][Tt][Ii][Cc][Kk][Ee][Rr]) (.*)$") or Cmd:match("^(استیکر) (.*)$") then
		MatchesEN = {Cmd:match("^[/!#]([Ss][Tt][Ii][Cc][Kk][Ee][Rr]) (.*)$")}; MatchesFA = {Cmd:match("^(استیکر) (.*)$")}
		Ptrn = MatchesEN[2] or MatchesFA[2]
		Modes = {'comics-logo','water-logo','3d-logo','blackbird-logo','runner-logo','graffiti-burn-logo','electric','standing3d-logo','style-logo','steel-logo','fluffy-logo','surfboard-logo','orlando-logo','fire-logo','clan-logo','chrominium-logo','harry-potter-logo','amped-logo','inferno-logo','uprise-logo','winner-logo','star-wars-logo','silver-logo','Design-Dance'}
		TextToSticker = URL.escape(Ptrn)
		local Url = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..Modes[math.random(#Modes)]..'&text='..TextToSticker..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141'
		title , res = http.request(Url)
		if res ~= 200 then return end
		if title then
			if json:decode(title) then
				jdat = json:decode(title)
				local StickerUrl = jdat.src
				sendStickerById(msg.chat.id, StickerUrl, msg.message_id)
				Text = "• درخواست ساخت استیکر توسط کاربر ["..msg.from.first_name.."](tg://user?id="..msg.from.id..") ارسال شد."
				sendText(msg.chat.id, Text, 0, 'md')
			end
		end
	end
	------------------------------------------------------------------------

	--> CMD => /short [link] | Make links Short ...
	if CmdLower:match("^[/!#](short) (.*)$") or Cmd:match("^(کوتاه) (.*)$") then
		MatchesEN = {CmdLower:match("^[/!#](short) (.*)$")}; MatchesFA = {Cmd:match("^(کوتاه) (.*)$")}
		Ptrn = MatchesEN[2] or MatchesFA[2]:lower()
		if string.match(Ptrn,"^https://") or string.match(Ptrn,"^http://") then
			local Opizo = http.request('http://enigma-dev.ir/api/opizo/?url='..URL.escape(Ptrn))
			if Opizo then
				if json:decode(Opizo) then
					OpizoJ = json:decode(Opizo)
					Text = '🔗 لینک مورد نظر :'
					.."\n<code>"..Ptrn.."</code>"
					.."\n————————"
					.."\n🔂 لینک کوتاه شده با <b>Opizo</b> :"
					.."\n"..(OpizoJ.result or OpizoJ.description)
					sendText(msg.chat.id, Text, msg.message_id, 'html')
				end
			end
		else
			Text = "فرمت لینک شما صحیح نمیباشد !\nلینک شما باید یکی از پیشوند های زیر را در ابتدای خود دارا باشد :\n`http://`\n`https://`"
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
	end
	------------------------------------------------------------------------

	--> CMD => /tr [Word] | Translate a Word ...
	-- دریافت معنی یک کلمه
	if Cmd:match("^[/!#]([Tt][Rr]) (.*)$") or Cmd:match("^(ترجمه) (.*)$") then
		MatchesEN = {Cmd:match("^[/!#]([Tt][Rr]) (.*)$")}; MatchesFA = {Cmd:match("^(ترجمه) (.*)$")}
		Ptrn = MatchesEN[2] or MatchesFA[2]
		url, res = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang=fa&text='..URL.escape(Ptrn))
		if res ~= 200 then return end
		if url then
			if json:decode(url) then
				TrJ = json:decode(url)
				Text = '🏷 عبارت اولیه : '..Ptrn..'\n🎙 زبان ترجمه : '..(TrJ.lang or "")..'\n\n📝 ترجمه : '..(TrJ.text[1] or "").."\n——————"
				.."\n• درخواست کننده : ["..msg.from.id.."]"
				sendText(msg.chat.id, Text, msg.message_id)
			end
		end
	end
	--------------------------------------------

	--> CMD => /gif [style] [word] | Create Gif ...
	if Cmd:match("^[/!#]([Gg][Ii][Ff]) (%a+) (.*)$") or Cmd:match("^(گیف) (%a+) (.*)$") then
		MatchesEN = {Cmd:match("^[/!#]([Gg][Ii][Ff]) (%a+) (.*)$")}; MatchesFA = {Cmd:match("^(گیف) (%a+) (.*)$")}
		Style = MatchesEN[2] or MatchesFA[2]
		TextToGif = MatchesEN[3] or MatchesFA[3]
		if Style:lower() == "blue" then
			text = URL.escape(TextToGif)
			url2 = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script=blue-fire&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141'
			title , res = http.request(url2)
			if res ~= 200 then return end
			if title then
				if json:decode(title) then
					jdat = json:decode(title)
					gif = jdat.src
					sendDocumentById(msg.chat.id, gif)
					Text = "• کاربر با شناسه `"..msg.from.id.."` درخواست ساخت گیف را ارسال کرد."
					sendText(msg.chat.id, Text, msg.message_id, "md")
				end
			end
			return
		elseif Style:lower() == "random" then
			local modes = {'memories-anim-logo','alien-glow-anim-logo','flash-anim-logo','flaming-logo','whirl-anim-logo','highlight-anim-logo','burn-in-anim-logo','shake-anim-logo','inner-fire-anim-logo','jump-anim-logo'}
			local text = URL.escape(TextToGif)
			local url = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..modes[math.random(#modes)]..'&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141'
			local title , res = http.request(url)
			if res ~= 200 then return end
			if title then
				if json:decode(title) then
					local jdat = json:decode(title)
					local gif = jdat.src
					sendDocumentById(msg.chat.id, gif)
					Text = "• کاربر با شناسه `"..msg.from.id.."` درخواست ساخت گیف را ارسال کرد."
					sendText(msg.chat.id, Text, msg.message_id, "md")
				end
			end
			return
		elseif Style:lower() == 'text' then
			set = 'Blinking+Text'
		elseif Style:lower() == 'dazzle' then
			set = 'Dazzle+Text'
		elseif Style:lower() == 'prohibited' then
			set = 'No+Button'
		elseif Style:lower() == 'star' then
			set = 'Walk+of+Fame+Animated'
		elseif Style:lower() == 'wag' then
			set = 'Wag+Finger'
		elseif Style:lower() == 'glitter' then
			set = 'Glitter+Text'
		elseif Style:lower() == 'bliss' then
			set = 'Bliss'
		elseif Style:lower() == 'flasher' then
			set = 'Flasher'
		elseif Style:lower() == 'roman' then
			set = 'Roman+Temple+Animated'
		else
			set = 'Roman+Temple+Animated'
		end
		text = URL.escape(TextToGif)
		colors = {'00FF00','6699FF','CC99CC','CC66FF','0066FF','000000','CC0066','FF33CC','FF0000','FFCCCC','FF66CC','33FF00','FFFFFF','00FF00'}
		bc = colors[math.random(#colors)]
		colorss = {'00FF00','6699FF','CC99CC','CC66FF','0066FF','000000','CC0066','FF33CC','FFF200','FF0000','FFCCCC','FF66CC','33FF00','FFFFFF','00FF00'}
		tc = colorss[math.random(#colorss)]
		url2 = 'http://www.imagechef.com/ic/maker.jsp?filter=&jitter=0&tid='..set..'&color0='..bc..'&color1='..tc..'&color2=000000&customimg=&0='..text
		title , res = http.request(url2)
		if res ~= 200 then return end
		if title then
			if json:decode(title) then
				jdat = json:decode(title)
				gif = jdat.resImage
				sendDocumentById(msg.chat.id, gif)
				Text = "• کاربر با شناسه `"..msg.from.id.."` درخواست ساخت گیف را ارسال کرد."
				sendText(msg.chat.id, Text, msg.message_id, "md")
			end
		end
	end
	-----------------------------------------

	--> CMD => /logo [Style] [Text]
	if Cmd:match("^[/!#]([Ll][Oo][Gg][Oo]) (%d+) (.*)$") or Cmd:match("^(لوگو) (%d+) (.*)$") then
		MatchesEN = {Cmd:match("^[/!#]([Ll][Oo][Gg][Oo]) (%d+) (.*)$")}; MatchesFA = {Cmd:match("^(لوگو) (%d+) (.*)$")}
		Style = MatchesEN[2] or MatchesFA[2]
		Style = tonumber(Style)
		Text = MatchesEN[3] or MatchesFA[3]
		Text = URL.escape(Text)

		if Style == 1 then
			PhotoUrlToDownload = "http://api.monsterbot.ir/pic/?text="..Text.."&color=red&font=ANGEL&fsize=200&bg=logo34&angel=0&y=0&x=-20"
		elseif Style == 2 then
			PhotoUrlToDownload = "http://api.monsterbot.ir/pic/?text="..Text.."&color=black&font=28&fsize=50&angel=-0&y=140&bg=mk&x=130&angel=-11"
		elseif Style == 3 then
			PhotoUrlToDownload = "http://api.monsterbot.ir/pic/?text="..Text.."&color=white&font=28&fsize=50&bg=logo31&angel=-0&y=245"
		elseif Style == 4 then
			PhotoUrlToDownload = "http://api.monsterbot.ir/pic/?text="..Text.."&y=15&font=Steamy&fsize=90&bg=logo8"
		elseif Style == 5 then
			PhotoUrlToDownload = "http://api.monsterbot.ir/pic/?text="..Text.."&color=gold&font=Steamy&fsize=110&bg=logo"
		elseif Style == 6 then
			PhotoUrlToDownload = "http://api.monsterbot.ir/pic/?text="..Text.."&color=white&fsize=35&bg=logo7"
		elseif Style == 7 then
			PhotoUrlToDownload = "http://api.monsterbot.ir/pic/?text="..Text.."&color=grey&font=halls&fsize=70&bg=spiders"
		else
			Text = "× محدوده لوگو از 1 تا 7 میباشد."
			sendText(msg.chat.id, Text, msg.message_id)
			return
		end
		PhotoFile = downloadToFile(PhotoUrlToDownload, "Logo.jpg", "./data/FunData")
		Cap = Config.Channel
		sendPhoto(msg.chat.id, PhotoFile, msg.message_id, Cap)
	end
	-----------------------------------------

	--> CMD => /voice (Text) | Creat Voice in English ...
	if Cmd:match("^[/!#]([Vv][Oo][Ii][Cc][Ee]) (.*)$") or Cmd:match("^(ویس) (.*)$") then
		MatchesEN = {Cmd:match("^[/!#]([Vv][Oo][Ii][Cc][Ee]) (.*)$")}; MatchesFA = {Cmd:match("^(ویس) (.*)$")}
		Text = MatchesEN[2] or MatchesFA[2]
		UrlForVoice = "http://tts.baidu.com/text2audio?lan=en&ie=UTF-8&text="..URL.escape(Text)
		Voice = downloadToFile(UrlForVoice, "Voice.mp3","./data/FunData")
		Cap = Config.Channel
		sendVoice(msg.chat.id, Voice, msg.message_id, Cap)
	end
	-----------------------------------------------------

	--> CMD => /weather [cityName] | Get the Stats of a City's weather ...
	if Cmd:match("^[/!#]([Ww][Ee][Aa][Tt][Hh][Ee][Rr]) (.*)$") or Cmd:match("^(هوا) (.*)$") then
		MatchesEN = {Cmd:match("^[/!#]([Ww][Ee][Aa][Tt][Hh][Ee][Rr]) (.*)$")}; MatchesFA = {Cmd:match("^(هوا) (.*)$")}
		Ptrn = MatchesEN[2] or MatchesFA[2]
		local function temps(K)
			local F = (K*1.8)-459.67
			local C = K-273.15
			return F,C
		end

		local url , res = http.request("http://api.openweathermap.org/data/2.5/weather?q="..URL.escape(Ptrn).."&appid=269ed82391822cc692c9afd59f4aabba")
		if res ~= 200 then return end
		if not url then
			return
		end
		if not json:decode(url) then
			return
		end
		local jtab = json:decode(url)
		if jtab.name then
			if jtab.weather[1].main == "Thunderstorm" then
				status = "⛈طوفاني"
			elseif jtab.weather[1].main == "Drizzle" then
				status = "🌦نمنم باران"
			elseif jtab.weather[1].main == "Rain" then
				status = "🌧باراني"
			elseif jtab.weather[1].main == "Snow" then
				status = "🌨برفي"
			elseif jtab.weather[1].main == "Atmosphere" then
				status = "🌫مه - غباز آلود"
			elseif jtab.weather[1].main == "Clear" then
				status = "🌤️صاف"
			elseif jtab.weather[1].main == "Clouds" then
				status = "☁️ابري"
			elseif jtab.weather[1].main == "Extreme" then
					status = "-------"
			elseif jtab.weather[1].main == "Additional" then
				status = "-------"
			else
				status = "-------"
			end
			local F1,C1 = temps(jtab.main.temp)
			local F2,C2 = temps(jtab.main.temp_min)
			local F3,C3 = temps(jtab.main.temp_max)
			if jtab.rain then
				rain = jtab.rain["3h"].." ميليمتر"
			else
				rain = "-----"
			end
			if jtab.snow then
				snow = jtab.snow["3h"].." ميليمتر"
			else
				snow = "-----"
			end
			today = "نام شهر : *"..jtab.name.."*\n"
			.."کشور : *"..(jtab.sys.country or "----").."*\n"
			.."وضعیت هوا :\n"
			.."   `"..C1.."° درجه سانتيگراد (سلسيوس)`\n"
			.."   `"..F1.."° فارنهايت`\n"
			.."   `"..jtab.main.temp.."° کلوين`\n"
			.."هوا "..status.." ميباشد\n\n"
			.."حداقل دماي امروز: `C"..C2.."°   F"..F2.."°   K"..jtab.main.temp_min.."°`\n"
			.."حداکثر دماي امروز: `C"..C3.."°   F"..F3.."°   K"..jtab.main.temp_max.."°`\n"
			.."رطوبت هوا: `"..jtab.main.humidity.."%`\n"
			.."مقدار ابر آسمان: `"..jtab.clouds.all.."%`\n"
			.."سرعت باد: `"..(jtab.wind.speed or "------").." متر بر ثانیه`\n"
			.."جهت باد: `"..(jtab.wind.deg or "------").."° درجه`\n"
			.."فشار هوا: `"..(jtab.main.pressure/1000).." بار(اتمسفر)`\n"
			.."بارندگي 3ساعت اخير: `"..rain.."`\n"
			.."بارش برف 3ساعت اخير: `"..snow.."`\n\n"
			after = ""
			local res = http.request("http://api.openweathermap.org/data/2.5/forecast?q="..URL.escape(Ptrn).."&appid=269ed82391822cc692c9afd59f4aabba")
			local jtab = json:decode(res)
			for i=1,5 do
				local F1,C1 = temps(jtab.list[i].main.temp_min)
				local F2,C2 = temps(jtab.list[i].main.temp_max)
				if jtab.list[i].weather[1].main == "Thunderstorm" then
					status = "⛈طوفانی"
				elseif jtab.list[i].weather[1].main == "Drizzle" then
					status = "🌦نمنم باران"
				elseif jtab.list[i].weather[1].main == "Rain" then
					status = "🌧بارانی"
				elseif jtab.list[i].weather[1].main == "Snow" then
					status = "🌨برفی"
				elseif jtab.list[i].weather[1].main == "Atmosphere" then
					status = "🌫مه - غباز آلود"
				elseif jtab.list[i].weather[1].main == "Clear" then
					status = "🌤️صاف"
				elseif jtab.list[i].weather[1].main == "Clouds" then
					status = "☁️ابری"
				elseif jtab.list[i].weather[1].main == "Extreme" then
					status = "-------"
				elseif jtab.list[i].weather[1].main == "Additional" then
					status = "-------"
				else
					status = "-------"
				end
				if i == 1 then
					day = "فردا هوا "
				elseif i == 2 then
					day = "پس فردا هوا "
				elseif i == 3 then
					day = "3 روز بعد هوا "
				elseif i == 4 then
					day ="4 روز بعد هوا "
				elseif i == 5 then
					day = "5 روز بعد هوا "
				end
				after = after.."- "..day..status.." ميباشد. \n🔺`C"..C2.."°`  *-*  `F"..F2.."°`\n🔻`C"..C1.."°`  *-*  `F"..F1.."°`\n"
			end
			Text = today.."وضعيت آب و هوا در پنج روز آينده:\n"..after
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		else
			Text = "مکان وارد شده صحیح نمیباشد."
			sendText(msg.chat.id, Text, msg.message_id, 'md')
		end
	end
	------------------------------------------------------------------------

	--> CMD => /beauty [Word] | Beauty a Text ...
	if Cmd:match("^[/!#]([Bb][Ee][Aa][Uu][Tt][Yy]) (.*)$") or Cmd:match("^(زیباسازی) (.*)$") then
		MatchesEN = {Cmd:match("^[/!#]([Bb][Ee][Aa][Uu][Tt][Yy]) (.*)$")}; MatchesFA = {Cmd:match("^(زیباسازی) (.*)$")}
		TextToBeauty = MatchesEN[2] or MatchesFA[2]
		if TextToBeauty:len() > 20 then
			sendText(msg.chat.id, "> تعداد حروف متن جهت زیباسازی باید کمتر از 20 تا باشد.\nمتن شما دارای "..TextToBeauty:len().." کاراکتر است.", msg.message_id)
			return
		end
		local font_base = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,9,8,7,6,5,4,3,2,1,.,_"
		local font_hash = "z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,0,1,2,3,4,5,6,7,8,9,.,_"
		local fonts = {
			"ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,⓪,➈,➇,➆,➅,➄,➃,➂,➁,➀,●,_",
			"⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⓪,⑼,⑻,⑺,⑹,⑸,⑷,⑶,⑵,⑴,.,_",
			"α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,⊘,९,𝟠,7,Ϭ,Ƽ,५,Ӡ,ϩ,𝟙,.,_",		"ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,Q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ᅙ,9,8,ᆨ,6,5,4,3,ᆯ,1,.,_",
			"α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
			"Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,0,9,8,7,6,5,4,3,2,1,.,_",
			"Λ,Б,Ͼ,Ð,Ξ,Ŧ,G,H,ł,J,К,Ł,M,Л,Ф,P,Ǫ,Я,S,T,U,V,Ш,Ж,Џ,Z,Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"A̴,̴B̴,̴C̴,̴D̴,̴E̴,̴F̴,̴G̴,̴H̴,̴I̴,̴J̴,̴K̴,̴L̴,̴M̴,̴N̴,̴O̴,̴P̴,̴Q̴,̴R̴,̴S̴,̴T̴,̴U̴,̴V̴,̴W̴,̴X̴,̴Y̴,̴Z̴,̴a̴,̴b̴,̴c̴,̴d̴,̴e̴,̴f̴,̴g̴,̴h̴,̴i̴,̴j̴,̴k̴,̴l̴,̴m̴,̴n̴,̴o̴,̴p̴,̴q̴,̴r̴,̴s̴,̴t̴,̴u̴,̴v̴,̴w̴,̴x̴,̴y̴,̴z̴,̴0̴,̴9̴,̴8̴,̴7̴,̴6̴,̴5̴,̴4̴,̴3̴,̴2̴,̴1̴,̴.̴,̴_̴",
			"ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,⓪,➈,➇,➆,➅,➄,➃,➂,➁,➀,●,_",
			"⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⓪,⑼,⑻,⑺,⑹,⑸,⑷,⑶,⑵,⑴,.,_",
			"α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,в,c,ɗ,є,f,g,н,ι,נ,к,Ɩ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,x,у,z,α,в,c,ɗ,є,f,g,н,ι,נ,к,Ɩ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,x,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,Ⴆ,ƈ,ԃ,ҽ,ϝ,ɠ,ԋ,ι,ʝ,ƙ,ʅ,ɱ,ɳ,σ,ρ,ϙ,ɾ,ʂ,ƚ,υ,ʋ,ɯ,x,ყ,ȥ,α,Ⴆ,ƈ,ԃ,ҽ,ϝ,ɠ,ԋ,ι,ʝ,ƙ,ʅ,ɱ,ɳ,σ,ρ,ϙ,ɾ,ʂ,ƚ,υ,ʋ,ɯ,x,ყ,ȥ,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ą,ɓ,ƈ,đ,ε,∱,ɠ,ɧ,ï,ʆ,ҡ,ℓ,ɱ,ŋ,σ,þ,ҩ,ŗ,ş,ŧ,ų,√,щ,х,γ,ẕ,ą,ɓ,ƈ,đ,ε,∱,ɠ,ɧ,ï,ʆ,ҡ,ℓ,ɱ,ŋ,σ,þ,ҩ,ŗ,ş,ŧ,ų,√,щ,х,γ,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
			"ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,⊘,९,𝟠,7,Ϭ,Ƽ,५,Ӡ,ϩ,𝟙,.,_",
			"მ,ჩ,ƈ,ძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,მ,ჩ,ƈ,ძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,0,Գ,Ց,Դ,6,5,Վ,Յ,Զ,1,.,_",
			"ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ª,b,¢,Þ,È,F,૬,ɧ,Î,j,Κ,Ļ,м,η,◊,Ƿ,ƍ,r,S,⊥,µ,√,w,×,ý,z,ª,b,¢,Þ,È,F,૬,ɧ,Î,j,Κ,Ļ,м,η,◊,Ƿ,ƍ,r,S,⊥,µ,√,w,×,ý,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"Δ,Ɓ,C,D,Σ,F,G,H,I,J,Ƙ,L,Μ,∏,Θ,Ƥ,Ⴓ,Γ,Ѕ,Ƭ,Ʊ,Ʋ,Ш,Ж,Ψ,Z,λ,ϐ,ς,d,ε,ғ,ɢ,н,ι,ϳ,κ,l,ϻ,π,σ,ρ,φ,г,s,τ,υ,v,ш,ϰ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"Λ,ß,Ƈ,D,Ɛ,F,Ɠ,Ĥ,Ī,Ĵ,Ҡ,Ŀ,M,И,♡,Ṗ,Ҩ,Ŕ,S,Ƭ,Ʊ,Ѵ,Ѡ,Ӿ,Y,Z,Λ,ß,Ƈ,D,Ɛ,F,Ɠ,Ĥ,Ī,Ĵ,Ҡ,Ŀ,M,И,♡,Ṗ,Ҩ,Ŕ,S,Ƭ,Ʊ,Ѵ,Ѡ,Ӿ,Y,Z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,Q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ᅙ,9,8,ᆨ,6,5,4,3,ᆯ,1,.,_",
			"α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ค,๖,¢,໓,ē,f,ງ,h,i,ว,k,l,๓,ຖ,໐,p,๑,r,Ş,t,น,ง,ຟ,x,ฯ,ຊ,ค,๖,¢,໓,ē,f,ງ,h,i,ว,k,l,๓,ຖ,໐,p,๑,r,Ş,t,น,ง,ຟ,x,ฯ,ຊ,0,9,8,7,6,5,4,3,2,1,.,_",
			"ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
			"Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,♏,И,Ø,P,Ҩ,R,$,ƚ,Ц,V,Щ,X,￥,Ẕ,Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,♏,И,Ø,P,Ҩ,R,$,ƚ,Ц,V,Щ,X,￥,Ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
			"Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,0,9,8,7,6,5,4,3,2,1,.,_",
			"Λ,Б,Ͼ,Ð,Ξ,Ŧ,G,H,ł,J,К,Ł,M,Л,Ф,P,Ǫ,Я,S,T,U,V,Ш,Ж,Џ,Z,Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"Թ,Յ,Շ,Ժ,ȝ,Բ,Գ,ɧ,ɿ,ʝ,ƙ,ʅ,ʍ,Ռ,Ծ,ρ,φ,Ր,Տ,Ե,Մ,ע,ա,Ճ,Վ,Հ,Թ,Յ,Շ,Ժ,ȝ,Բ,Գ,ɧ,ɿ,ʝ,ƙ,ʅ,ʍ,Ռ,Ծ,ρ,φ,Ր,Տ,Ե,Մ,ע,ա,Ճ,Վ,Հ,0,9,8,7,6,5,4,3,2,1,.,_",
			"Æ,þ,©,Ð,E,F,ζ,Ħ,Ї,¿,ズ,ᄂ,M,Ñ,Θ,Ƿ,Ø,Ґ,Š,τ,υ,¥,w,χ,y,շ,Æ,þ,©,Ð,E,F,ζ,Ħ,Ї,¿,ズ,ᄂ,M,Ñ,Θ,Ƿ,Ø,Ґ,Š,τ,υ,¥,w,χ,y,շ,0,9,8,7,6,5,4,3,2,1,.,_",
			"ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"4,8,C,D,3,F,9,H,!,J,K,1,M,N,0,P,Q,R,5,7,U,V,W,X,Y,2,4,8,C,D,3,F,9,H,!,J,K,1,M,N,0,P,Q,R,5,7,U,V,W,X,Y,2,0,9,8,7,6,5,4,3,2,1,.,_",
			"Λ,M,X,ʎ,Z,ɐ,q,ɔ,p,ǝ,ɟ,ƃ,ɥ,ı,ɾ,ʞ,l,ա,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,Λ,M,X,ʎ,Z,ɐ,q,ɔ,p,ǝ,ɟ,ƃ,ɥ,ı,ɾ,ʞ,l,ա,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,‾",
			"A̴,̴B̴,̴C̴,̴D̴,̴E̴,̴F̴,̴G̴,̴H̴,̴I̴,̴J̴,̴K̴,̴L̴,̴M̴,̴N̴,̴O̴,̴P̴,̴Q̴,̴R̴,̴S̴,̴T̴,̴U̴,̴V̴,̴W̴,̴X̴,̴Y̴,̴Z̴,̴a̴,̴b̴,̴c̴,̴d̴,̴e̴,̴f̴,̴g̴,̴h̴,̴i̴,̴j̴,̴k̴,̴l̴,̴m̴,̴n̴,̴o̴,̴p̴,̴q̴,̴r̴,̴s̴,̴t̴,̴u̴,̴v̴,̴w̴,̴x̴,̴y̴,̴z̴,̴0̴,̴9̴,̴8̴,̴7̴,̴6̴,̴5̴,̴4̴,̴3̴,̴2̴,̴1̴,̴.̴,̴_̴",
			"A̱,̱Ḇ,̱C̱,̱Ḏ,̱E̱,̱F̱,̱G̱,̱H̱,̱I̱,̱J̱,̱Ḵ,̱Ḻ,̱M̱,̱Ṉ,̱O̱,̱P̱,̱Q̱,̱Ṟ,̱S̱,̱Ṯ,̱U̱,̱V̱,̱W̱,̱X̱,̱Y̱,̱Ẕ,̱a̱,̱ḇ,̱c̱,̱ḏ,̱e̱,̱f̱,̱g̱,̱ẖ,̱i̱,̱j̱,̱ḵ,̱ḻ,̱m̱,̱ṉ,̱o̱,̱p̱,̱q̱,̱ṟ,̱s̱,̱ṯ,̱u̱,̱v̱,̱w̱,̱x̱,̱y̱,̱ẕ,̱0̱,̱9̱,̱8̱,̱7̱,̱6̱,̱5̱,̱4̱,̱3̱,̱2̱,̱1̱,̱.̱,̱_̱",
			"A̲,̲B̲,̲C̲,̲D̲,̲E̲,̲F̲,̲G̲,̲H̲,̲I̲,̲J̲,̲K̲,̲L̲,̲M̲,̲N̲,̲O̲,̲P̲,̲Q̲,̲R̲,̲S̲,̲T̲,̲U̲,̲V̲,̲W̲,̲X̲,̲Y̲,̲Z̲,̲a̲,̲b̲,̲c̲,̲d̲,̲e̲,̲f̲,̲g̲,̲h̲,̲i̲,̲j̲,̲k̲,̲l̲,̲m̲,̲n̲,̲o̲,̲p̲,̲q̲,̲r̲,̲s̲,̲t̲,̲u̲,̲v̲,̲w̲,̲x̲,̲y̲,̲z̲,̲0̲,̲9̲,̲8̲,̲7̲,̲6̲,̲5̲,̲4̲,̲3̲,̲2̲,̲1̲,̲.̲,̲_̲",
			"Ā,̄B̄,̄C̄,̄D̄,̄Ē,̄F̄,̄Ḡ,̄H̄,̄Ī,̄J̄,̄K̄,̄L̄,̄M̄,̄N̄,̄Ō,̄P̄,̄Q̄,̄R̄,̄S̄,̄T̄,̄Ū,̄V̄,̄W̄,̄X̄,̄Ȳ,̄Z̄,̄ā,̄b̄,̄c̄,̄d̄,̄ē,̄f̄,̄ḡ,̄h̄,̄ī,̄j̄,̄k̄,̄l̄,̄m̄,̄n̄,̄ō,̄p̄,̄q̄,̄r̄,̄s̄,̄t̄,̄ū,̄v̄,̄w̄,̄x̄,̄ȳ,̄z̄,̄0̄,̄9̄,̄8̄,̄7̄,̄6̄,̄5̄,̄4̄,̄3̄,̄2̄,̄1̄,̄.̄,̄_̄",
			"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,9,8,7,6,5,4,3,2,1,.,_",
			"a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
		}
		local result = {}
		i=0
		for k=1,#fonts do
			i=i+1
			local tar_font = fonts[i]:split(",")
			local text = TextToBeauty
			local text = text:gsub("A",tar_font[1])
			local text = text:gsub("B",tar_font[2])
			local text = text:gsub("C",tar_font[3])
			local text = text:gsub("D",tar_font[4])
			local text = text:gsub("E",tar_font[5])
			local text = text:gsub("F",tar_font[6])
			local text = text:gsub("G",tar_font[7])
			local text = text:gsub("H",tar_font[8])
			local text = text:gsub("I",tar_font[9])
			local text = text:gsub("J",tar_font[10])
			local text = text:gsub("K",tar_font[11])
			local text = text:gsub("L",tar_font[12])
			local text = text:gsub("M",tar_font[13])
			local text = text:gsub("N",tar_font[14])
			local text = text:gsub("O",tar_font[15])
			local text = text:gsub("P",tar_font[16])
			local text = text:gsub("Q",tar_font[17])
			local text = text:gsub("R",tar_font[18])
			local text = text:gsub("S",tar_font[19])
			local text = text:gsub("T",tar_font[20])
			local text = text:gsub("U",tar_font[21])
			local text = text:gsub("V",tar_font[22])
			local text = text:gsub("W",tar_font[23])
			local text = text:gsub("X",tar_font[24])
			local text = text:gsub("Y",tar_font[25])
			local text = text:gsub("Z",tar_font[26])
			local text = text:gsub("a",tar_font[27])
			local text = text:gsub("b",tar_font[28])
			local text = text:gsub("c",tar_font[29])
			local text = text:gsub("d",tar_font[30])
			local text = text:gsub("e",tar_font[31])
			local text = text:gsub("f",tar_font[32])
			local text = text:gsub("g",tar_font[33])
			local text = text:gsub("h",tar_font[34])
			local text = text:gsub("i",tar_font[35])
			local text = text:gsub("j",tar_font[36])
			local text = text:gsub("k",tar_font[37])
			local text = text:gsub("l",tar_font[38])
			local text = text:gsub("m",tar_font[39])
			local text = text:gsub("n",tar_font[40])
			local text = text:gsub("o",tar_font[41])
			local text = text:gsub("p",tar_font[42])
			local text = text:gsub("q",tar_font[43])
			local text = text:gsub("r",tar_font[44])
			local text = text:gsub("s",tar_font[45])
			local text = text:gsub("t",tar_font[46])
			local text = text:gsub("u",tar_font[47])
			local text = text:gsub("v",tar_font[48])
			local text = text:gsub("w",tar_font[49])
			local text = text:gsub("x",tar_font[50])
			local text = text:gsub("y",tar_font[51])
			local text = text:gsub("z",tar_font[52])
			local text = text:gsub("0",tar_font[53])
			local text = text:gsub("9",tar_font[54])
			local text = text:gsub("8",tar_font[55])
			local text = text:gsub("7",tar_font[56])
			local text = text:gsub("6",tar_font[57])
			local text = text:gsub("5",tar_font[58])
			local text = text:gsub("4",tar_font[59])
			local text = text:gsub("3",tar_font[60])
			local text = text:gsub("2",tar_font[61])
			local text = text:gsub("1",tar_font[62])
			table.insert(result, text)
		end

		local result_text = "〰کلمه ی اولیه: "..TextToBeauty.."\nطراحی با "..tostring(#fonts).." فونت:\n___________________\n"
		for v=1,#result do
			redis:hset(BeautyTextHash..msg.chat.id, v, result[v])
			result_text = result_text..v.."- "..result[v].."\n"
		end
		result_text = result_text.."___________________\n=> برای دریافت متن مورد نظر ، ابتدا دستور دریافت متن را تایپ کرده و سپس با قید یک فاصله(Space) شماره آن را بنویسید.\nمثال :\nدریافت متن "..(#result - 5)
		sendText(msg.chat.id, result_text, msg.message_id)
	end

	if Cmd:match("^[/!#]([Gg][Ee][Tt] [Tt][Ee][Xx][Tt]) (%d+)$") or Cmd:match("^(دریافت متن) (%d+)$") then
		MatchesEN = {Cmd:match("^[/!#]([Gg][Ee][Tt] [Tt][Ee][Xx][Tt]) (%d+)$")}; MatchesFA = {Cmd:match("^(دریافت متن) (%d+)$")}
		TextNum = MatchesEN[2] or MatchesFA[2]
		Num = tonumber(TextNum)
		Hash = BeautyTextHash..msg.chat.id
		if not redis:hget(BeautyTextHash..msg.chat.id, Num) then
			sendText(msg.chat.id, "× متن زیبا سازی شده با شماره مورد نظر شما یعنی "..Num.." یافت نشد!", msg.message_id)
			return
		end
		Word = redis:hget(BeautyTextHash..msg.chat.id, Num)
		sendText(msg.chat.id, Word)
	end
	---------------------------------------------
	
	--> CMD => /aparat | Searching in Aparat.com
	if CmdLower:match("^[/!#](aparat) (.*)$") or CmdLower:match("^(آپارات) (.*)$") then
		MatchesEN = {CmdLower:match("^[/!#](aparat) (.*)$")}; MatchesFA = {CmdLower:match("^(آپارات) (.*)$")}
		Word = MatchesEN[2] or MatchesFA[2]
		Url , res = http.request("http://www.aparat.com/etc/api/videoBySearch/text/"..URL.escape(Word))
		if res ~= 200 then return end
		if json:decode(Url) then
			J = json:decode(Url)
			if J.videobysearch then
				Items = J.videobysearch
				Text = "🔍 نتایج جستجو در [وبسایت آپارات](http://aparat.com) :"
				.."\n"
				.."\n"
				for i=1, #Items do
					Text = Text..i.."- _"..Items[i].title.."_"
					.."\n👁 تعداد بازدید : *"..Items[i].visit_cnt.."*"
					.."\n[لینک نمایش در وبسایت آپارات]("..opizoLink("http://aparat.com/v/"..Items[i].uid)..")"
					.."\n"
					.."\n"
				end
				sendText(msg.chat.id, Text, msg.message_id, 'md', false, true)
				return
			end
		end
	end
	-------------------------------------------------------
	
end

function inPrivatePlugin(msg) --> IN_PRIVATE.LUA PLUGIN !

	Cmd = msg.text
	CmdLower = msg.text:lower()
	Data = loadJson(Config.ModFile)

	-- /start the bot
	if CmdLower:match("^/start$") then
		Text = Config.StartMessage or "-----"
		keyboard = {resize_keyboard = true}
		keyboard.keyboard =
			{
				{
					{text = "این ربات رو واسه گروهم میخوام!"}
				},
				{
					{text = 'امکانات ربات'} , {text = "درباره ربات"}
				},
			}
		A = sendText(msg.chat.id, Text, msg.message_id, false, keyboard)
		return
	end
	-----------------

	-- /buy | How to Buy The Bot ...
	if CmdLower:match("^/(buy)$") or Cmd:match("^(خرید ربات)$") or Cmd:match("^(این ربات رو واسه گروهم میخوام!)$") then
		Text = Config.BotPrice or "-----"
		sendText(msg.chat.id, Text, msg.message_id)
	end
	--------------------------------

	-- /features | Get Bot Features ...
	if CmdLower:match("^(/features)$") or Cmd:match("^(امکانات ربات)$") then
		Text = Config.BotFeatures or "----"
		sendText(msg.chat.id, Text, msg.message_id)
	end
	-----------------------------------

	-- /about | Get Bot Information ...
	if CmdLower:match("^(/about)$") or Cmd:match("^(درباره ربات)$") then
		Text = Config.AboutBot or "----"
		keyboard = {}
		keyboard.inline_keyboard =
			{
				{
					{text = '📣 ورود به کانال تیم سازنده ربات', url = Config.ChannelLink}
				},
			}
		sendText(msg.chat.id, Text, msg.message_id, false, keyboard)
	end
	-----------------------------------

	-- Get a Group Panel in Bot Private ...
	if CmdLower:match("^/start getpanel(-%d+)$") then
		Matches = {CmdLower:match("^/start getpanel(-%d+)$")}
		ChatId = Matches[1]
		if not Data[tostring(ChatId)] then
			Text = "× گروه شما با شناسه `"..ChatId.."` در لیست گروه های مدیریت شده ربات نیست."
			.."\n• جهت خرید ربات برای گروهتان روی /buy کلیک کنید."
			sendText(msg.chat.id, Text, msg.message_id, 'md')
			return
		end

		if redis:hget(ModeratorsSettingsHash..ChatId, "inlinepanel") then
			if not isMod(ChatId, msg.from.id) then
				Text = "× شما دسترسی کافی جهت دریافت پنل گروه `"..ChatId.."` را ندارید."
				.."\n• جهت خرید ربات برای گروهتان روی /buy کلیک کنید."
				sendText(msg.chat.id, Text, msg.message_id, 'md')
				return
			end
		elseif not isOwner(ChatId, msg.from.id) then
			Text = "× شما دسترسی کافی جهت دریافت پنل گروه `"..ChatId.."` را ندارید."
			.."\n• جهت خرید ربات برای گروهتان روی /buy کلیک کنید."
			sendText(msg.chat.id, Text, msg.message_id, 'md')
			return
		end

		keyboard = {}
		keyboard.inline_keyboard =
			{
				{
					{text = '⚙️ تنظیمات اصلی گروه', callback_data = ChatId..':showmenu:generalsettings:1'}
				},
				{
					{text = '🔖 اطلاعات گروه و مدیریت کاربران', callback_data = ChatId..':showmenu:groupinfo:1'}
				},
				{
					{text = 'زمان و تاریخ', callback_data = ChatId..':showmenu:timeanddate:1'},
					{text = 'ورود به کانال ربات', url = Config.ChannelLink}
				},
				{
					{text = '💡راهنما دستورات ربات', callback_data = ChatId..':showmenu:bothelp:1'},
				},
				{
					{text = '❌ بستن پنل', callback_data = ChatId..':showmenu:closepanel:1'},
				},
			}
		Text = "~> به پنل مدیریت آسان گروه خوش آمدید."
		.."\n• نام گروه : "..getChat(ChatId).title
		.."\n• شناسه گروه : "..ChatId
		.."\n• با استفاده از این پنل شما میتوانید به راحتی و با تنها یک کلیک/لمس ساده تنظیمات گروه خود را انجام داده و آن را مدیریت کنید."
		.."\n> جهت استفاده از هر کدام کافیست روی آن کلیک کنید :"
		sendText(msg.chat.id, Text, msg.message_id, false, keyboard)
		return
	end
	-----------------------------------------

	-- Clerk Message Sending ...
	if redis:get(ClerkStatusHash) then
		Text = redis:get(ClerkMessageHash) or "این اکانت ربات ضد تبلیغات و مدیریت گروه است."
		sendText(msg.chat.id, Text, msg.message_id)
	end
	-----------------------------

end --> End IN_PRIVATE.LUA PLUGIN !

function callbackQueryResponses(msg) --> callbackQueryResponses.lua !

	Data = loadJson(Config.ModFile)

	--> Working With Group Settings and Locks !
	if msg.data:match("(-%d+):(showmenu):(%a+):(%d+)") then
		Split = msg.data:split(":")
		ChatId = Split[1]
		MenuName = Split[3]
		Page = tonumber(Split[4])

		if not Data[tostring(ChatId)] then -- IF GROUP IS NOT ADDED !
			Text = "× این گروه با شناسه `"..ChatId.."` در لیست گروه های مدیریت شده ربات وجود ندارد."
			keyboard = {}
			keyboard.inline_keyboard =
				{
					{
						{text = 'دریافت ربات برای گروه', url = "https://telegram.me/"..BotUsername.."?start=buy"}
					},
					{
						{text = 'ورود به کانال ربات', url = Config.ChannelLink}
					},
				}
			editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
			answerCallbackQuery(msg.id, "× خطایی رخ داد! گروه رو نمیشناسم.")
			return
		end

		if MenuName == "timeanddate" then -- Showing Time By answerCallbackQuery
			if https.request("https://enigma-dev.ir/api/time/") then
				TimeUrl = https.request("https://enigma-dev.ir/api/time/")
				if json:decode(TimeUrl) then
					TimeInJson = json:decode(TimeUrl)
					Text = "امروز "..TimeInJson.FaDate.WordTwo.." بوده و ساعت "..TimeInJson.FaTime.Number.." به وقت تهران میباشد."
					.."\n• "..TimeInJson.FaDate.Number
					.."\n————————"
					.."\n• "..TimeInJson.EnDate.WordOne
					.."\n• "..TimeInJson.EnDate.Number
					answerCallbackQuery(msg.id, Text, true)
					return
				end
			end
			Text = "× هنگام نمایش زمان خطایی رخ داد !"
			answerCallbackQuery(msg.id, Text, true)
		end
	
		-- Check Permission !
		if redis:hget(ModeratorsSettingsHash..ChatId, "inlinepanel") then
			if not isMod(ChatId, msg.from.id) then
				Text = "پیام ربات :"
				.."\n× شما به این قسمت دسترسی ندارید."
				answerCallbackQuery(msg.id, Text, true)
				return
			end
		elseif not isOwner(ChatId, msg.from.id) then
			Text = "پیام ربات :"
			.."\n× شما به این قسمت دسترسی ندارید."
			answerCallbackQuery(msg.id, Text, true)
			return
		end

		if MenuName == "mainmenu" then -- Showing Main Menu
			if msg.message.chat.type == "supergroup" then
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = '⚙️ تنظیمات اصلی گروه', callback_data = ChatId..':showmenu:generalsettings:1'}
						},
						{
							{text = '🔖 اطلاعات گروه و مدیریت کاربران', callback_data = ChatId..':showmenu:groupinfo:1'}
						},
						{
							{text = 'زمان و تاریخ', callback_data = ChatId..':showmenu:timeanddate:1'},
							{text = 'ورود به کانال ربات', url = Config.ChannelLink}
						},
						{
							{text = '💡راهنما دستورات ربات', callback_data = ChatId..':showmenu:bothelp:1'}
						},
						{
							{text = '🔑 دریافت همین پنل در خصوصی', url = "https://telegram.me/"..BotUsername.."?start=getpanel"..msg.message.chat.id}
						},
						{
							{text = '❌ بستن پنل', callback_data = ChatId..':showmenu:closepanel:1'},
						},
					}
			else
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = '⚙️ تنظیمات اصلی گروه', callback_data = ChatId..':showmenu:generalsettings:1'}
						},
						{
							{text = '🔖 اطلاعات گروه و مدیریت کاربران', callback_data = ChatId..':showmenu:groupinfo:1'}
						},
						{
							{text = 'زمان و تاریخ', callback_data = ChatId..':showmenu:timeanddate:1'},
							{text = 'ورود به کانال ربات', url = Config.ChannelLink}
						},
						{
							{text = '💡راهنما دستورات ربات', callback_data = ChatId..':showmenu:bothelp:1'}
						},
						{
							{text = '❌ بستن پنل', callback_data = ChatId..':showmenu:closepanel:1'},
						},
					}
			end
			Text = "~> به پنل مدیریت آسان گروه خوش آمدید."
			.."\n• نام گروه : "..getChat(ChatId).title
			.."\n• شناسه گروه : "..ChatId
			.."\n• با استفاده از این پنل شما میتوانید به راحتی و با تنها یک کلیک/لمس ساده تنظیمات گروه خود را انجام داده و آن را مدیریت کنید."
			.."\n> جهت استفاده از هر کدام کافیست روی آن کلیک کنید :"
			editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
		elseif MenuName == "generalsettings" then -- Showing Settings Menu
			if Page == 1 then
				Text = "⚙️ به بخش تنظیمات اصلی گروه خوش آمدید."
				.."\n• صفحه : 1"
				.."\n• نام گروه : "..getChat(ChatId).title
				.."\n• شناسه گروه : "..ChatId
				.."\n• در این قسمت میتونید با کلیک روی هر کدام از تنظیمات زیر اونارو فعال یا غیرفعال کنید."
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, getSettings(ChatId, Page))
			elseif Page == 2 then
				Text = "⚙️ به بخش تنظیمات اصلی گروه خوش آمدید."
				.."\n• صفحه : 2"
				.."\n• نام گروه : "..getChat(ChatId).title
				.."\n• شناسه گروه : "..ChatId
				.."\n• در این قسمت میتونید با کلیک روی هر کدام از تنظیمات زیر اونارو فعال یا غیرفعال کنید."
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, getSettings(ChatId, Page))
			end
		elseif MenuName == "groupinfo" then
			if Page == 1 then
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = '👥 لیست مدیران فرعی ربات در گروه', callback_data = ChatId..':showmenu:modlist:1'}
						},
						{
							{text = '👥🤚 تنظیم دسترسی مدیران فرعی', callback_data = ChatId..':showmenu:modsaccess:1'}
						},
						{
							{text = '⛔️ لیست مسدود', callback_data = ChatId..':showmenu:banlist:1'},
							{text = '🚫 لیست فیلتر', callback_data = ChatId..':showmenu:filterlist:1'}
						},
						{
							{text = '🔇 لیست سایلنت', callback_data = ChatId..':showmenu:silentlist:1'},
						},
						{
							{text = '👤 مدیر اصلی ربات در گروه', callback_data = ChatId..':showmenu:owner:1'}
						},
						{
							{text = '💬 قوانین', callback_data = ChatId..':showmenu:gprules:1'},
							{text = '📎 لینک گروه', callback_data = ChatId..':showmenu:gplink:1'}
						},
						{
							{text = '🔋 وضعیت شارژ گروه', callback_data = ChatId..':showmenu:gpcharge:1'}
						},
						{
							{text = 'بازگشت به منو اصلی ↩️', callback_data = ChatId..':showmenu:mainmenu:1'}
						},
					}
				Text = "🔖 به بخش اطلاعات گروه و مدیریت آسان کاربران خوش آمدید."
				.."\n• نام گروه : "..getChat(ChatId).title
				.."\n• شناسه گروه : "..ChatId
				.."\n• در این قسمت میتونید کاربرای گروه خودتون اعم از کسانی که در گروه مسدود، سایلنت و ... شده اند را به آسانی مدیریت کنید و همچنین اطلاعات کلی گروه خود را نیز به راحتی در اختیار داشته باشید."
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			end

		------------------- WORKING WITH MODERATION LIST ---------------------------------------
		elseif MenuName == "modlist" then
			if not isOwner(ChatId, msg.from.id) then -- تنها مدیران اصلی !
				Text = "پیام ربات :"
				.."\n× تنها مدیر اصلی ربات در گروه به این قسمت دسترسی دارد."
				.."\nشما دسترسی ندارید !"
				answerCallbackQuery(msg.id, Text, true)
				return
			end
			if Page == 1 then
				Data = loadJson(Config.ModFile)
				if next(Data[tostring(ChatId)]['moderators']) ~= nil then
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "پاکسازی لیست مدیران فرعی", callback_data = ChatId..":showmenu:delmodlist:1"}
							},
							{
								{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:modlist:1"}
							},
							{
								{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
								{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
							},
						}
					Text = "• لیست مدیران فرعی ربات در گروه : "
					.."\n"
					i = 0
					for k,v in pairs(Data[tostring(ChatId)]["moderators"]) do
						i = i + 1
						Text = Text..i..'- <code>'..k..'</code> (@'..v..')\n'
					end
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, 'html', keyboard)
				else
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:modlist:1"}
							},
							{
								{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
								{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
							},
						}
					Text = "× لیست مدیران فرعی ربات در گروه خالی میباشد."
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
				end
			end
		elseif MenuName == "delmodlist" then
			if not isOwner(ChatId, msg.from.id) then -- تنها مدیران اصلی !
				Text = "پیام ربات :"
				.."\n× تنها مدیر اصلی ربات در گروه به این قسمت دسترسی دارد."
				.."\nشما دسترسی ندارید !"
				answerCallbackQuery(msg.id, Text, true)
				return
			end
			if Page == 1 then
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = "خیر ❌", callback_data = ChatId..":showmenu:modlist:1"},
							{text = "بله ✅", callback_data = ChatId..":showmenu:delmodlistyes:1"}
						},
					}
				Text = "در صورت موافقت با پاکسازی لیست مدیران فرعی گروه، همه مدیران فرعی ربات در گروه از مقام خود عزل خواهند شد."
				.."\n• آیا با انجام این عملیات موافقید ؟"
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			end
		elseif MenuName == "delmodlistyes" then
			if not isOwner(ChatId, msg.from.id) then -- تنها مدیران اصلی !
				Text = "پیام ربات :"
				.."\n× تنها مدیر اصلی ربات در گروه به این قسمت دسترسی دارد."
				.."\nشما دسترسی ندارید !"
				answerCallbackQuery(msg.id, Text, true)
				return
			end
			if Page == 1 then
				Data = loadJson(Config.ModFile)
				if next(Data[tostring(ChatId)]['moderators']) ~= nil then
					local i = 0
					for k,v in pairs(Data[tostring(ChatId)]['moderators']) do
						Data[tostring(ChatId)]['moderators'][tostring(k)] = nil
						saveJson(Config.ModFile, Data)
						i = i+1
					end
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "منو اطلاعات گروه ↩️", callback_data = ChatId..":showmenu:groupinfo:1"},
							},
						}
					Text = "• تعداد *"..i.."* مدیر فرعی ربات در گروه وجود داشت که با موفقیت پاکسازی شد. ✅"
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
				else
					Text = "× لیست مدیران فرعی ربات در گروه خالی میباشد، نیازی به پاکسازی آن نیست."
					answerCallbackQuery(msg.id, Text, true)
				end
			end
		------------------- End WORKING WITH MODERATION LIST ---------------------------------------

		-------------------- Working With Moderation Accesses --------------------------------------
		elseif MenuName == "modsaccess" then
			if not isOwner(ChatId, msg.from.id) then -- تنها مدیران اصلی !
				Text = "پیام ربات :"
				.."\n× تنها مدیر اصلی ربات در گروه به این قسمت دسترسی دارد."
				.."\nشما دسترسی ندارید !"
				answerCallbackQuery(msg.id, Text, true)
				return
			end
			if Page == 1 then
				Text = "👤 به بخش مدیریت دسترسی های مدیران فرعی ربات در گروه خوش آمدید."
				.."\n• نام گروه : "..getChat(ChatId).title
				.."\n• در این بخش شما میتوانید دسترسی های مدیران فرعی ربات در گروه تنظیم کنید که چه کارهایی را در گروه میتوانند انجام بدهند و چه کار هایی را نتوانند."
				.."\n• جهت تغییر دسترسی ها کافیست رو آنها کلیک کنید."
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, 'md', getModsAccess(ChatId, Page))
			end
		-------------------- End Working With Moderation Accesses --------------------------------------

		------------------- WORKING WITH FILTER LIST ------------------------------------------------
		elseif MenuName == "filterlist" then
			Hash = FilterHash..ChatId
			if tonumber(redis:scard(Hash)) == 0 then
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:filterlist:1"}
						},
						{
							{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
							{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
						},
					}
				Text = "× لیست کلمات فیلتر شده گروه خالی میباشد."
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			else
				Filters = redis:smembers(Hash)
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = "پاکسازی لیست کلمات فیلتر شده", callback_data = ChatId..":showmenu:delfilterlist:1"}
						},
						{
							{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:filterlist:1"}
						},
						{
							{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
							{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
						},
					}
				Text = "• لیست کلمات فیلتر شده(ممنوعه) در گروه :"
				.."\n"
				for i=1, #Filters do
					Text = Text..i.."- "..Filters[i].."\n"
				end
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			end
		elseif MenuName == "delfilterlist" then
			Hash = FilterHash..ChatId
			if Page == 1 then
				if tonumber(redis:scard(Hash)) < 1 then
					Text = "× لیست کلمات فیلتر شده گروه خالی میباشد، نیازی به پاکسازی آن نیست."
					answerCallbackQuery(msg.id, Text)
				else
					Text = "در صورت موافقت با پاکسازی لیست کلمات فیلتر شده گروه، لیست آنها پاکسازی خواهد شد و استفاده از کلمات و عبارات فیلتر شده در گروه آزاد خواهد شد."
					.."\n• آیا با انجام عملیات [پاکسازی لیست کلمات فیلتر شده در گروه] موافقید ؟"
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "خیر ❌", callback_data = ChatId..":showmenu:filterlist:1"},
								{text = "بله ✅", callback_data = ChatId..":showmenu:delfilterlistyes:1"}
							},
						}
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
				end
			end
		elseif MenuName == "delfilterlistyes" then
			Hash = FilterHash..ChatId
			if tonumber(redis:scard(Hash)) < 1 then
				Text = "× لیست کلمات فیلتر شده گروه خالی میباشد، نیازی به پاکسازی آن نیست."
				answerCallbackQuery(msg.id, Text)
			else
				Text = "• لیست کلمات فیلتر شده گروه با تعداد "..tonumber(redis:scard(Hash)).." کلمه، پاکسازی شد. ✅"
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = "منو اطلاعات گروه ↩️", callback_data = ChatId..":showmenu:groupinfo:1"},
						},
					}
				redis:del(Hash)
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			end
		------------------- End WORKING WITH FILTER LIST -----------------------------------------

		------------------- WORKING WITH BAN LIST -----------------------------------------
		elseif MenuName == "banlist" then
			Hash = BanHash..ChatId
			if tonumber(redis:scard(Hash)) == 0 then
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:banlist:1"}
						},
						{
							{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
							{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
						},
					}
				Text = "× لیست کاربران مسدود شده در گروه خالی میباشد."
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			else
				Bans = redis:smembers(Hash)
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = "پاکسازی لیست کاربران مسدود", callback_data = ChatId..":showmenu:delbanlist:1"}
						},
						{
							{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:banlist:1"}
						},
						{
							{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
							{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
						},
					}
				Text = "• لیست کاربران مسدود شده در گروه :"
				.."\n"
				for i=1, #Bans do
					Text = Text..i.."- "..Bans[i].."\n"
				end
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			end
		elseif MenuName == "delbanlist" then
			Hash = BanHash..ChatId
			if Page == 1 then
				if tonumber(redis:scard(Hash)) < 1 then
					Text = "× لیست کاربران مسدود شده گروه خالی میباشد، نیازی به پاکسازی آن نیست."
					answerCallbackQuery(msg.id, Text)
				else
					Text = "در صورت موافقت با پاکسازی لیست کاربران مسدود شده گروه، لیست آنها پاکسازی شده و به همه کاربران مسدود اجازه ورود به گروه داده میشه."
					.."\n• آیا با انجام عملیات [پاکسازی لیست کاربران مسدود شده در گروه] موافقید ؟"
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "خیر ❌", callback_data = ChatId..":showmenu:banlist:1"},
								{text = "بله ✅", callback_data = ChatId..":showmenu:delbanlistyes:1"}
							},
						}
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
				end
			end
		elseif MenuName == "delbanlistyes" then
			Hash = BanHash..ChatId
			if tonumber(redis:scard(Hash)) < 1 then
				Text = "× لیست کاربران مسدود شده گروه خالی میباشد، نیازی به پاکسازی آن نیست."
				answerCallbackQuery(msg.id, Text)
			else
				Text = "• لیست کاربران مسدود گروه با تعداد "..tonumber(redis:scard(Hash)).." کاربر، پاکسازی شد. ✅"
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = "منو اطلاعات گروه ↩️", callback_data = ChatId..":showmenu:groupinfo:1"},
						},
					}
				redis:del(Hash)
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			end
		------------------- End WORKING WITH BAN LIST -----------------------------------------

		------------------- WORKING WITH SILENT LIST -----------------------------------------
		elseif MenuName == "silentlist" then
			Hash = SilentHash..ChatId
			if tonumber(redis:scard(Hash)) == 0 then
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:silentlist:1"}
						},
						{
							{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
							{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
						},
					}
				Text = "× لیست کاربران سایلنت شده در گروه خالی میباشد."
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			else
				Silents = redis:smembers(Hash)
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = "پاکسازی لیست کاربران سایلنت شده", callback_data = ChatId..":showmenu:delsilentlist:1"}
						},
						{
							{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:silentlist:1"}
						},
						{
							{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
							{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
						},
					}
				Text = "• لیست کاربران سایلنت شده در گروه :"
				.."\n"
				for i=1, #Silents do
					Text = Text..i.."- "..Silents[i].."\n"
				end
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			end
		elseif MenuName == "delsilentlist" then
			Hash = SilentHash..ChatId
			if Page == 1 then
				if tonumber(redis:scard(Hash)) < 1 then
					Text = "× لیست کاربران سایلنت شده در گروه خالی میباشد، نیازی به پاکسازی آن نیست."
					answerCallbackQuery(msg.id, Text)
				else
					Text = "در صورت موافقت با پاکسازی لیست کاربران سایلنت شده گروه، لیست آنها پاکسازی شده و به همه کاربران سایلنت شده اجازه چت داده میشود."
					.."\n• آیا با انجام عملیات [پاکسازی لیست کاربران سایلنت شده در گروه] موافقید ؟"
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "خیر ❌", callback_data = ChatId..":showmenu:silentlist:1"},
								{text = "بله ✅", callback_data = ChatId..":showmenu:delsilentlistyes:1"}
							},
						}
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
				end
			end
		elseif MenuName == "delsilentlistyes" then
			Hash = SilentHash..ChatId
			if tonumber(redis:scard(Hash)) < 1 then
				Text = "× لیست کاربران سایلنت شده گروه خالی میباشد، نیازی به پاکسازی آن نیست."
				answerCallbackQuery(msg.id, Text)
			else
				Text = "• لیست کاربران سایلنت شده گروه با تعداد "..tonumber(redis:scard(Hash)).." کاربر، پاکسازی شد. ✅"
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = "منو اطلاعات گروه ↩️", callback_data = ChatId..":showmenu:groupinfo:1"},
						},
					}
				redis:del(Hash)
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			end
		------------------- End WORKING WITH Silent LIST -----------------------------------------

		---------------------- Working with Owner Panel ------------------------------------------
		elseif MenuName == "owner" then
			if Data[tostring(ChatId)]['set_owner'] then
				if Data[tostring(ChatId)]['set_owner'] ~= "0" then
					OwnerId = tonumber(Data[tostring(ChatId)]['set_owner'])
					Text = "• شناسه کاربری مدیر اصلی ربات در گروه : `"..OwnerId.."`"
					.."\n[نمایش پروفایل مدیر اصلی ربات در گروه](tg://user?id="..OwnerId..")"
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "خلع مقام مدیر اصلی گروه", callback_data = ChatId..":showmenu:delowner:1"}
							},
							{
								{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:owner:1"}
							},
							{
								{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
								{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
							},
						}
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
					return
				end
			end
			Text = "× مدیر اصلی در این گروه تنظیم نشده است."
			.."\n تنها مدیر کل ربات توانایی تنظیم کردن آن را دارد."
			keyboard = {}
			keyboard.inline_keyboard =
				{
					{
						{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:owner:1"}
					},
					{
						{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
						{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
					},
				}
			editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
		elseif MenuName == "delowner" then
			if not isSudo(msg.from.id) then -- Sudoes Only !
				Text = "پیام ربات :" 
				.."\n× تنها مدیر کل ربات اجازه خلع مقام کردن مدیر اصلی ربات در گروه ها را دارد."
				.."\n• شما دسترسی ندارید."
				answerCallbackQuery(msg.id, Text, true)
				return
			end
			if Data[tostring(ChatId)]['set_owner'] then
				if Data[tostring(ChatId)]['set_owner'] ~= "0" then
					Text = "با انجام اینکار، مدیر اصلی(Owner) خلع مقام شده و تا فرد دیگری را به عنوان مدیر اصلی ربات در آن گروه تنظیم نکنید، آن گروه بدون مدیر اصلی میماند."
					.."\n• آیا با انجام این عملیات موافقید ؟"
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "خیر ❌", callback_data = ChatId..":showmenu:owner:1"},
								{text = "بله ✅", callback_data = ChatId..":showmenu:delowneryes:1"}
							},
						}
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
					return
				end
			end
			Text = "× مدیر اصلی در این گروه تنظیم نشده است."
			answerCallbackQuery(msg.id, Text)
		elseif MenuName == "delowneryes" then
			if not isSudo(msg.from.id) then -- Sudoes Only !
				Text = "پیام ربات :"
				.."\n× تنها مدیر کل ربات اجازه خلع مقام کردن مدیر اصلی ربات در گروه ها را دارد."
				.."\n• شما دسترسی ندارید."
				answerCallbackQuery(msg.id, Text, true)
				return
			end
			if Data[tostring(ChatId)]['set_owner'] then
				if Data[tostring(ChatId)]['set_owner'] ~= "0" then
					Data[tostring(ChatId)]['set_owner'] = "0"
					saveJson(Config.ModFile, Data)
					Text = "• مدیر اصلی (Owner) در گروه خلع مقام شد. ✅"
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "منو اطلاعات گروه ↩️", callback_data = ChatId..":showmenu:groupinfo:1"},
							},
						}
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
					return
				end
			end
			Text = "× مدیر اصلی در این گروه تنظیم نشده است."
			answerCallbackQuery(msg.id, Text)
		---------------------- End Working with Owner Panel ------------------------------------------

		---------------------- Working with Group Link Panel ------------------------------------------
		elseif MenuName == "gplink" then
			if Data[tostring(ChatId)]["settings"]["set_link"]then
				if Data[tostring(ChatId)]["settings"]["set_link"] ~= "wait" and Data[tostring(ChatId)]["settings"]["set_link"] ~= nil then
					GpLink = Data[tostring(ChatId)]["settings"]["set_link"]
					Text = "• لینک تنظیم شده برای گروه : "
					.."\n ~> "..GpLink
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "پاکسازی لینک گروه", callback_data = ChatId..":showmenu:delgplink:1"}
							},
							{
								{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:gplink:1"}
							},
							{
								{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
								{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
							},
						}
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
					return
				end
			end
			Text = "× لینک این گروه تنظیم نشده است !"
			keyboard = {}
			keyboard.inline_keyboard =
				{
					{
						{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:gplink:1"}
					},
					{
						{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
						{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
					},
				}
			editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
		elseif MenuName == "delgplink" then
			if Data[tostring(ChatId)]["settings"]["set_link"]then
				if Data[tostring(ChatId)]["settings"]["set_link"] ~= "wait" and Data[tostring(ChatId)]["settings"]["set_link"] ~= nil then
					Text = "• آیا از انجام عملیات [پاکسازی لینک تنظیم شده گروه] مطمعنید ؟"
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "خیر ❌", callback_data = ChatId..":showmenu:gplink:1"},
								{text = "بله ✅", callback_data = ChatId..":showmenu:delgplinkyes:1"}
							},
						}
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
					return
				end
			end
			Text = "× لینک این گروه تنظیم نشده است !"
			answerCallbackQuery(msg.id, Text)
		elseif MenuName == "delgplinkyes" then
			if Data[tostring(ChatId)]["settings"]["set_link"]then
				if Data[tostring(ChatId)]["settings"]["set_link"] ~= "wait" and Data[tostring(ChatId)]["settings"]["set_link"] ~= nil then
					Data[tostring(ChatId)]["settings"]["set_link"] = nil
					saveJson(Config.ModFile, Data)
					Text = "• لینک گروه با موفقیت پاکسازی شد. ✅"
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "منو اطلاعات گروه ↩️", callback_data = ChatId..":showmenu:groupinfo:1"},
							},
						}
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
					return
				end
			end
			Text = "× مدیر اصلی در این گروه تنظیم نشده است."
			answerCallbackQuery(msg.id, Text)
		---------------------- End Working with Owner Panel ------------------------------------------

		---------------------- Working with Group Rules ------------------------------------------
		elseif MenuName == "gprules" then
			if Page == 1 then
				Hash = RulesHash..ChatId
				if redis:get(Hash) then
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "پاکسازی قوانین گروه", callback_data = ChatId..":showmenu:delgprules:1"}
							},
							{
								{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:gprules:1"}
							},
							{
								{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
								{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
							},
						}
					Text = "• نام گروه : "..getChat(ChatId).title
					.."\n• شناسه گروه : "..ChatId
					.."\n-> قوانین تنظیم شده برای این گروه : "
					.."\n"
					.."\n"..redis:get(Hash)
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
				else
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:grprules:1"}
							},
							{
								{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
								{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
							},
						}
					Text = "× قوانین این گروه تنظیم نشده اند !"
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
				end
			end
		elseif MenuName == "delgprules" then
			if Page == 1 then
				Hash = RulesHash..ChatId
				if redis:get(Hash) then
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "خیر ❌", callback_data = ChatId..":showmenu:gprules:1"},
								{text = "بله ✅", callback_data = ChatId..":showmenu:delgprulesyes:1"}
							},
						}
					Text = "• آیا با انجام عملیات [پاکسازی قوانین گروه] موافقید ؟"
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
				else
					Text = "× قوانین گروه تنظیم نشده است !"
					answerCallbackQuery(msg.id, Text)
				end
			end
		elseif MenuName == "delgprulesyes" then
			if Page == 1 then
				Hash = RulesHash..ChatId
				if redis:get(Hash) then
					redis:del(Hash)
					keyboard = {}
					keyboard.inline_keyboard =
						{
							{
								{text = "منو اطلاعات گروه ↩️", callback_data = ChatId..":showmenu:groupinfo:1"},
							},
						}
					Text = "قوانین گروه با موفیت پاکسازی شد. ✅"
					editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
				else
					Text = "× قوانین گروه تنظیم نشده است !"
					answerCallbackQuery(msg.id, Text)
				end
			end
		---------------------- End Working with Group Rules ------------------------------------------

		---------------------- Working with Group Charge ----------------------------------------------
		elseif MenuName == "gpcharge" then
			if Page == 1 then
				Hash = ChargeHash..ChatId
				if redis:get(Hash) == "unlimit" then
					Text = "• نام گروه : "..(getChat(ChatId).title or "----")
					.."\n• شناسه گروه : "..(ChatId or "----")
					.."\n• این گروه به بصورت نامحدود شارژ شده است. 🔃"
				elseif tostring(redis:ttl(Hash)) ~= "-2" then
					TimeLeft = redis:ttl(Hash)
					A = secToTime(TimeLeft)
					StrDay = A.Day
					StrHour = A.Hour
					StrMin = A.Min
					StrSec = A.Sec
					Text = "• نام گروه : "..getChat(ChatId).title
					.."\n• شناسه گروه : "..ChatId
					.."\n🔂 از شارژ این گروه"
					.."\n"..StrDay.."روز"
					.."\n"..StrHour.."ساعت"
					.."\n"..StrMin.."دقیقه"
					.."\nو "..StrSec.."ثانیه"
					.."\nباقی مانده است."
					if http.request("http://enigma-dev.ir/api/unix-time-to-date/?unix_time="..os.time()+TimeLeft) then
					J = http.request("http://enigma-dev.ir/api/unix-time-to-date/?unix_time="..os.time()+TimeLeft)
					if json:decode(J) then
						K = json:decode(J)
						Text = Text
						.."\n"
						.."\n⌛️ شارژ این گروه در تاریخ "..K.JalaliDate.."، ساعت "..K.Time.." به پایان خواهد رسید."
					end
				end
				else
					Text = "× شارژ این گروه تمام شده است."
				end
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = "🔃 بازنگری/Update", callback_data = ChatId..":showmenu:gpcharge:1"}
						},
						{
							{text = "بازگشت به منو ↩️", callback_data = ChatId..":showmenu:mainmenu:1"},
							{text = "صفحه قبلی ◀️", callback_data = ChatId..":showmenu:groupinfo:1"}
						},
					}
				editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, false, keyboard)
			end
		---------------------- End Working with Group Charge ------------------------------------------

		---------------------- Working with Bot's Help -----------------------------------------
		elseif MenuName == "bothelp" then
			if Page == 1 then
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = '➡️ صفحه بعدی ', callback_data = ChatId..":showmenu:bothelp:2"}
						},
						{
							{text = 'منو اصلی ↩️', callback_data = ChatId..":showmenu:mainmenu:1"}
						},
					}
				answerCallbackQuery(msg.id, "راهنما دستورات، صفحه اول")
				editMessageText(BotHelp[Page], false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
			elseif Page == 2 then
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = 'صفحه قبلی ⬅️', callback_data = ChatId..":showmenu:bothelp:1"}, {text = '➡️ صفحه بعدی ', callback_data = ChatId..":showmenu:bothelp:3"}
						},
						{
							{text = 'منو اصلی ↩️', callback_data = ChatId..":showmenu:mainmenu:1"}
						},
					}
				answerCallbackQuery(msg.id, "راهنما دستورات، صفحه دوم")
				editMessageText(BotHelp[Page], false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
			elseif Page == 3 then
				keyboard = {}
				keyboard.inline_keyboard =
					{
						{
							{text = 'صفحه قبلی ⬅️', callback_data = ChatId..":showmenu:bothelp:2"}
						},
						{
							{text = 'منو اصلی ↩️', callback_data = ChatId..":showmenu:mainmenu:1"}
						},
					}
				answerCallbackQuery(msg.id, "راهنما دستورات، صفحه سوم")
				editMessageText(BotHelp[Page], false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
			end
		-----------------------------------------------------------------------------------------

		-------------------------------------- Closing Panel ------------------------------------
		elseif MenuName == "closepanel" then
			if msg.message.chat.type == "private" then
				TextA = "× پنل بسته شد !"
				TextB = "❌ پنل بسته شد !"
			else
				TextA = "× پنل مدیریت آسان گروه بسته شد !"
				.."\nجهت نمایش مجدد پنل از دستور 'پنل' استفاده کنید."
				TextB = "❌ پنل بسته شد !"
			end
			answerCallbackQuery(msg.id, TextB)
			editMessageText(TextA, false, msg.message.chat.id, msg.message.message_id)
		-----------------------------------------------------------------------------------------
		end
	elseif msg.data:match("(-%d+):(locks):(lock_%a+):(%d+)") or msg.data:match("(-%d+):(locks):(show_%a+):(%d+)") then
		Split = msg.data:split(":")
		ChatId = Split[1]
		LockName = Split[3]
		Page = tonumber(Split[4])

		if not Data[tostring(ChatId)] then -- IF GROUP IS NOT ADDED !
			Text = "× این گروه با شناسه `"..ChatId.."` در لیست گروه های مدیریت شده ربات وجود ندارد."
			keyboard = {}
			keyboard.inline_keyboard =
				{
					{
						{text = 'دریافت ربات برای گروه', url = "https://telegram.me/"..BotUsername.."?start=buy"}
					},
					{
						{text = 'ورود به کانال ربات', url = Config.ChannelLink}
					},
				}
			editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
			answerCallbackQuery(msg.id, "× خطایی رخ داد! گروه رو نمیشناسم.")
			return
		end

		if not Data[tostring(ChatId)]['settings'] then
			Text = "× تنظیمات این گروه در دیتابیس ربات وجود ندارد !"
			answerCallbackQuery(msg.id, Text)
			return
		end

		if redis:hget(ModeratorsSettingsHash..ChatId, "inlinepanel") then
			if not isMod(ChatId, msg.from.id) then
				Text = "پیام ربات :"
				.."\n× شما به این قسمت دسترسی ندارید."
				answerCallbackQuery(msg.id, Text, true)
				return
			end
		elseif not isOwner(ChatId, msg.from.id) then
			Text = "پیام ربات :"
			.."\n× شما به این قسمت دسترسی ندارید."
			answerCallbackQuery(msg.id, Text, true)
			return
		end

		if LockName == "lock_link" then
			LockText = "قفل لینک"
		elseif LockName == "lock_edit" then
			LockText = "قفل ویرایش"
		elseif LockName == "show_edit" then
			LockText = "نمایش ویرایش"
		elseif LockName == "lock_forward" then
			LockText = "قفل فروارد"
		elseif LockName == "lock_inline" then
			LockText = "قفل دکمه شیشه‌ای"
		elseif LockName == "lock_cmd" then
			LockText = "قفل دستورات"
		elseif LockName == "lock_english" then
			LockText = "قفل متن انگلیسی"
		elseif LockName == "lock_arabic" then
			LockText = "قفل عربی/پارسی"
		elseif LockName == "lock_spam" then
			LockText = "حذف پیام طولانی"
		elseif LockName == "lock_bot" then
			LockText = "قفل ربات(API)"
		elseif LockName == "lock_flood" then
			LockText = "قفل پیام رگباری"
		elseif LockName == "lock_tgservice" then
			LockText = "حذف پیام ورود/خروج"

		-- Tag and Username and Abuse Locks
		elseif LockName == "lock_abuse" then
			LockText = "قفل فحش"
		elseif LockName == "lock_tag" then
			LockText = "قفل تگ(#)"
		elseif LockName == "lock_username" then
			LockText = "قفل یوزرنیم(@)"

		-- Media Locks
		elseif LockName == "lock_sticker" then
			LockText = "قفل استیکر"
		elseif LockName == "lock_audio" then
			LockText = "قفل صدا"
		elseif LockName == "lock_voice" then
			LockText = "قفل وویس"
		elseif LockName == "lock_photo" then
			LockText = "قفل تصاویر"
		elseif LockName == "lock_video" then
			LockText = "قفل ویدیو"
		elseif LockName == "lock_text" then
			LockText = "قفل متن"
		elseif LockName == "lock_document" then
			LockText = "قفل فایل"
		elseif LockName == "lock_gif" then
			LockText = "قفل گیف(تصویر متحرک)"
		elseif LockName == "lock_contact" then
			LockText = "قفل ارسال مخاطب"

		-- Important Locks
		elseif LockName == "lock_strict" then
			LockText = "شرایط سخت"
		elseif LockName == "lock_all" then
			LockText = "فیلتر همگانی(قفل چت)"

		-- Fun Locks
		elseif LockName == "lock_wlc" then
			LockText = "پیام خوش‌آمد گویی"
		elseif LockName == "lock_bye" then
			LockText = "پیام خداحافظی"
		else
			LockText = LockName
		end
		if Data[tostring(ChatId)]['settings'][LockName] then
			if Data[tostring(ChatId)]['settings'][LockName] == "yes" then
				Data[tostring(ChatId)]['settings'][LockName] = "no"
				saveJson(Config.ModFile, Data)
				editMessageReplyMarkup(getSettings(ChatId, Page), false, msg.message.chat.id, msg.message.message_id)
				Text = LockText.." غیرفعال شد "..Dis2
				answerCallbackQuery(msg.id, Text)
			else
				Data[tostring(ChatId)]['settings'][LockName] = "yes"
				saveJson(Config.ModFile, Data)
				editMessageReplyMarkup(getSettings(ChatId, Page), false, msg.message.chat.id, msg.message.message_id)
				Text = LockText.." فعال شد "..Enb2
				answerCallbackQuery(msg.id, Text)
			end
		else
			Data[tostring(ChatId)]['settings'][LockName] = "yes"
			saveJson(Config.ModFile, Data)
			editMessageReplyMarkup(getSettings(ChatId, Page), false, msg.message.chat.id, msg.message.message_id)
			Text = LockText.." فعال شد "..Enb2
			answerCallbackQuery(msg.id, Text)
		end

		-- Plus and Minus FloodMaxNum ...
	elseif msg.data:match("(-%d+):(locks):(minus_flood):(%d+)") or msg.data:match("(-%d+):(locks):(plus_flood):(%d+)") then
		Split = msg.data:split(":")
		ChatId = Split[1]
		LockName = Split[3]
		Page = tonumber(Split[4])

		if not Data[tostring(ChatId)] then -- IF GROUP IS NOT ADDED !
			Text = "× این گروه با شناسه `"..ChatId.."` در لیست گروه های مدیریت شده ربات وجود ندارد."
			keyboard = {}
			keyboard.inline_keyboard =
				{
					{
						{text = 'دریافت ربات برای گروه', url = "https://telegram.me/"..BotUsername.."?start=buy"}
					},
					{
						{text = 'ورود به کانال ربات', url = Config.ChannelLink}
					},
				}
			editMessageText(Text, false, msg.message.chat.id, msg.message.message_id, 'md', keyboard)
			answerCallbackQuery(msg.id, "× خطایی رخ داد! گروه رو نمیشناسم.")
			return
		end

		if not Data[tostring(ChatId)]['settings'] then
			Text = "× تنظیمات این گروه در دیتابیس ربات وجود ندارد !"
			answerCallbackQuery(msg.id, Text)
			return
		end

		if not isOwner(ChatId, msg.from.id) then
			Text = "پیام ربات :"
			.."\n× شما به این قسمت دسترسی ندارید."
			answerCallbackQuery(msg.id, Text, true)
			return
		end

		if Data[tostring(ChatId)]['settings']['flood_num'] then
			FloodMaxNum = tonumber(Data[tostring(ChatId)]['settings']['flood_num'])
		else
			FloodMaxNum = 5
		end
		if LockName == "minus_flood" then
			if FloodMaxNum < 6 then
				Text = "× محدوده حساسیت رگباری از 5 تا 20 میباشد !"
				answerCallbackQuery(msg.id, Text)
			else
				NewFloodMaxNum = FloodMaxNum - 1
				Data[tostring(ChatId)]['settings']['flood_num'] = tostring(NewFloodMaxNum)
				saveJson(Config.ModFile, Data)
				TextForAnswerCallbackQuery = NewFloodMaxNum.." 👈🏽 "..FloodMaxNum
				answerCallbackQuery(msg.id, TextForAnswerCallbackQuery)
			end
		elseif LockName == "plus_flood" then
			if FloodMaxNum > 19 then
				Text = "× محدوده حساسیت رگباری از 5 تا 20 میباشد !"
				answerCallbackQuery(msg.id, Text)
			else
				NewFloodMaxNum = FloodMaxNum + 1
				Data[tostring(ChatId)]['settings']['flood_num'] = tostring(NewFloodMaxNum)
				saveJson(Config.ModFile, Data)
				TextForAnswerCallbackQuery = FloodMaxNum.." 👉🏻 "..NewFloodMaxNum
				answerCallbackQuery(msg.id, TextForAnswerCallbackQuery)
			end
		end
		editMessageReplyMarkup(getSettings(ChatId, Page), false, msg.message.chat.id, msg.message.message_id)
	---------------------------------------------------------------------------------------------------------

	-- Giving or Getting Access From Moderators -----------------
	elseif msg.data:match("(-%d+):(modsaccess):(%a+):(%d+)") then
		Split = msg.data:split(":")
		ChatId = Split[1]
		AccessName = Split[3]
		Page = tonumber(Split[4])
		Hash = ModeratorsSettingsHash..ChatId

		if not isOwner(ChatId, msg.from.id) then
			Text = "× تنها مدیر اصلی ربات در گروه به این قسمت دسترسی دارد!"
			.."\nشما دسترسی ندارید."
			answerCallbackQuery(msg.id, Text, true)
			return
		end

		if Page == 1 then
			if AccessName == "inlinepanel" then
				AccessNameFA = "کار با پنل شیشه‌ای"
			else
				AccessNameFA = AccessName
			end
			if redis:hget(Hash, AccessName) then
				redis:hdel(Hash, AccessName)
				Text = "دسترسی "..AccessNameFA.." برای مدیران فرعی غیرفعال شد! ❌"
				answerCallbackQuery(msg.id, Text)
			else
				redis:hset(Hash, AccessName, true)
				Text = "دسترسی "..AccessNameFA.." برای مدیران فرعی فعال شد! ✅"
				answerCallbackQuery(msg.id, Text)
			end
			editMessageReplyMarkup(getModsAccess(ChatId, Page), false, msg.message.chat.id, msg.message.message_id)
		end
	------------------------------------------------------------------------------------------------------------
	end

end -- End callbackQueryResponses.lua

function editProcessPlugin(msg) --> EDIT_PROCESS.LUA !
	local function isLink(text) --> Finding Link in a Message Function
		if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/")
		or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
		or text:match("[Tt].[Mm][Ee]/")
		or text:match("[Hh][Tt][Tt][Pp][Ss]://")
		or text:match("[Hh][Tt][Tt][Pp]://")
		or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Oo][Rr][Gg]")
		or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]")
		or text:match("[Ww][Ww][Ww].")
		or text:match(".[Cc][Oo][Mm]")
		or text:match(".[Ii][Rr]")
		or text:match(".[Oo][Rr][Gg]")
		or text:match(".[Nn][Ee][Tt]") then
			return true
		end
	 return false
	end

	local function isAbuse(text) --> Finding Abuse in a Message Function
		if text:match("کیر")
		or text:match("کون")
		or text:match("فاک")
		or text:lower():match("fuck")
		or text:lower():match("pussy")
		or text:lower():match("sex")
		or text:match("عوضی")
		or text:match("آشغال")
		or text:match("جنده")
		or text:match("سیکتیر")
		or text:match("سکس")
		or text:lower():match("siktir")
		or text:match("دیوث") then
			return true
		end
	  return false
	end

	Data = loadJson(Config.ModFile)
	if not Data[tostring(msg.chat.id)] then
		return
	end

	if msg.text then
		NewContent = msg.text
	elseif msg.caption then
		NewContent = msg.caption
	else
		return
	end

	if Data[tostring(msg.chat.id)]['settings'] then

		-- Lock Link [On Edit]
		if Data[tostring(msg.chat.id)]['settings']['lock_link'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_link'] == "yes" then
				if isLink(NewContent) and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		----------------------

		-- Lock Abuse [On Edit]
		if Data[tostring(msg.chat.id)]['settings']['lock_abuse'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_abuse'] == "yes" then
				if isAbuse(NewContent) and not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		----------------------

		-- Lock Edit
		if Data[tostring(msg.chat.id)]['settings']['lock_edit'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_edit'] == "yes" then
				if not isMod(msg.chat.id, msg.from.id) then
					deleteMessage(msg.chat.id, msg.message_id)
				end
			end
		end
		-------------

		-- Lock English [On Edit]
		if Data[tostring(msg.chat.id)]['settings']['lock_english'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_english'] == "yes" then
				if (NewContent:match("[A-Z]") or NewContent:match("[a-z]")) then
					if not isMod(msg.chat.id, msg.from.id) then
						deleteMessage(msg.chat.id, msg.message_id)
					end
				end
			end
		end
		------------------------

		-- Lock Persian/Arabic [On Edit]
		if Data[tostring(msg.chat.id)]['settings']['lock_arabic'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_arabic'] == "yes" then
				if NewContent:match("[\216-\219][\128-\191]") then
					if not isMod(msg.chat.id, msg.from.id) then
						deleteMessage(msg.chat.id, msg.message_id)
					end
				end
			end
		end
		-------------------------------

		-- Lock Username (@)
		if Data[tostring(msg.chat.id)]['settings']['lock_username'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_username'] == "yes" then
				if NewContent:match("@[%a%d]") then
					if not isMod(msg.chat.id, msg.from.id) then
						deleteMessage(msg.chat.id, msg.message_id)
					end
				end
			end
		end
		--------------------

		-- Lock Tag (#)
		if Data[tostring(msg.chat.id)]['settings']['lock_tag'] then
			if Data[tostring(msg.chat.id)]['settings']['lock_tag'] == "yes" then
				if NewContent:match("#") then
					if not isMod(msg.chat.id, msg.from.id) then
						deleteMessage(msg.chat.id, msg.message_id)
					end
				end
			end
		end
		--------------

		-- Show Edit
		if Data[tostring(msg.chat.id)]['settings']['show_edit'] then
			if Data[tostring(msg.chat.id)]['settings']['show_edit'] == "yes" then
				if redis:hget(ShowEditHash, msg.chat.id..":"..msg.message_id) then
					OldContent = redis:hget(ShowEditHash, msg.chat.id..":"..msg.message_id)
					Text = "» این پیام ویرایش(Edit) شد !"
					.."\nمتن پیام قبل از ویرایش :"
					.."\n"..OldContent
					sendText(msg.chat.id, Text, msg.message_id)
					redis:hset(ShowEditHash, msg.chat.id..":"..msg.message_id, NewContent)
				else
					redis:hset(ShowEditHash, msg.chat.id..":"..msg.message_id, NewContent)
					Text = "» این پیام ویرایش(*Edit*) شد !"
					sendText(msg.chat.id, Text, msg.message_id, 'md')
				end
			end
		end
		------------

	end -- end Data[tostring(msg.chat.id)]['settings']
end -- End EDIT_PROCESS.LUA !

-- ================================================================================================ --
print("\n\n")
TextForSayingBotIsRunning = Color.Green.."    ~> [Anti Ads Bot] Activated ! <~"..Color.Reset
..Color.Yellow.."\n    Base On Telegram"..Color.Reset
..Color.pBlue.."\n       Our Channel On Telegram : @MaTaDoRTeaM"..Color.pReset
.."\n"
.."\n    Bot Name : "..getRes("getMe").result.first_name
.."\n    Bot ID : "..getRes("getMe").result.id
.."\n    Bot Username : @"..getRes("getMe").result.username
.."\n    Bot Token : "..string.sub(Config.BotToken, 1, utf8.len(Config.BotToken)-10).."**********"
.."\n======================================================="
print(TextForSayingBotIsRunning)

function messageValid(data) -- Message is Valid Or Not.
	if data.message then
		if data.message.date < os.time() - 10 then
			print(Color.Red.."    *ERROR => This Message is Old, Bot Will ignore that."..Color.Reset)
			return false
		end
	end
 return true
end

firstUpdate()
while true do -- Keep Bot Runnig and Sending Datas to Plugins ...
	local Res = getUpdates((LastUpdate or 0)+1)
	if Res then
		--vardump(Res)
		-----------------------------------
		for i=1, #Res.result do -- Proccessing Messages and Sending them to Related Plugin ...
			EnigmaTM = Res.result[i]
			--------------------------->>>>
			if EnigmaTM.message then
			--	if messageValid(EnigmaTM) then -- Message is Valid Or Not.
				msg = EnigmaTM.message
				
				if msg.new_chat_members or msg.left_chat_member or msg.new_chat_title
				or msg.new_chat_photo or msg.delete_chat_photo or msg.group_chat_created
				or msg.supergroup_chat_created or msg.channel_chat_created then
					msg.service = true
				end

				-- Removing Bot Username in Message if There is.
				if msg.text then
					if msg.text:match("@"..BotUsername) then
						msg.text = msg.text:gsub("@"..BotUsername, "")
					end
				end

				botModPlugin(msg) --> CALLING BOT_MOD.LUA PLUGIN !
				if msg.chat.type == "supergroup" then
					chargePlugin(msg) --> CALLING CHARGE.LUA PLUGIN !
					antiFloodPlugin(msg) --> CALLING ANTI_FLOOD.LUA PLUGIN !
					secPlugin(msg) --> CALLING SEC.LUA PLUGIN !
					rmsgPlugin(msg) --> CALLING RMSG.LUA PLUGIN !
					if msg.text then
						addRemPlugin(msg) --> CALLING LOCKS.LUA PLUGIN !
						panelPlugin(msg) --> CALLING PANEL.LUA PLUGIN !
						chatModPlugin(msg) --> CALLING CHAT_MOD.LUA PLUGIN !
						warnPlugin(msg) --> CALLING WANR.LUA PLUGIN !
						banPlugin(msg) --> CALLING BAN.LUA PLUGIN !
						forceAdd(msg) --> CALLING FORCE_ADD.LUA PLUGIN !
						funPlugin(msg) --> CALLING FUN.LUA PLUGIN !
					end
				elseif msg.chat.type == "private" then
					if msg.text then
						inPrivatePlugin(msg) --> CALLING IN_PRIVATE.LUA PLUGIN !
					end
				end
				--end
			--------------------------->>>>
			elseif EnigmaTM.callback_query then
				msg = EnigmaTM.callback_query
				callbackQueryResponses(msg)
			-------------------------------

			--------------------------->>>>
			elseif EnigmaTM.edited_message then
				msg = EnigmaTM.edited_message
				editProcessPlugin(msg) --> CALLING EDIT_PROCESS.LUA PLUGIN !
			-------------------------------
			end
		end
		------------------------------------
		for i, msg in pairs(Res.result) do -- Go through every new message.
			LastUpdate = msg.update_id
		end
	else
		print(Color.Red..'    => Connection Error, Check Intenet Please !'..Color.Reset)
	end
end
