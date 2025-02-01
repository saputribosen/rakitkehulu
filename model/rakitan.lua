local fs = require("nixio.fs")

map = Map("rakitanconf", "Rakitan Configuration", "Configure Rakitan.")
map.description = [[
<p>This tool helps to configure settings for various rakitan modem types including Dell DW5821e, Lt4220, L860gl, L850GL.</p>
<br>
<p>Tutorial this <a href="https://bit.ly/aryochannel" target="_blank">HERE</a></p>
]]

section = map:section(NamedSection, "settings", "rakitanconf", "Telegram Config")
section.addremove = false
section.anonymous = true

option = section:option(Value, "telegram_token", "Telegram Token")
option.password = true
option.default = ""
option.placeholder = "Telegram BOT Token"

option = section:option(Value, "chat_id", "Chat ID")
option.default = ""
option.placeholder = "Message Chat ID"

option = section:option(Value, "message_thread_id", "Message Thread ID")
option.datatype = "integer"
option.default = 0
option.placeholder = "Message Thread ID Telegram"

section = map:section(NamedSection, "settings", "rakitanconf", "Duration Settings")
section.addremove = false
section.anonymous = true

option = section:option(Value, "lan_off_duration", "Ping Duration (s)")
option.datatype = "uinteger"
option.default = 30
option.placeholder = "Enter Ping Duration in second"

option = section:option(Value, "modem_path", "Modem Path")
option.default = "/usr/bin/adel"
option.placeholder = "Path Script (/usr/bin/script.sh)"

service_btn = section:option(Button, "_service", "Control Services")
service_btn.inputstyle = "apply"

status_title = section:option(DummyValue, "_status_title", ".", "")
status_title.rawhtml = true

local function is_service_running()
  local rc_path = "/etc/rc.local"
  local script_line = "/usr/bin/rakitan -r"
  return fs.readfile(rc_path) and fs.readfile(rc_path):find(script_line, 1, true)
end

local function update_status()
  if is_service_running() then
    service_btn.inputtitle = "Stop Service" -- Set the button label dynamically
    service_btn.inputstyle = "remove"
    status_title.value = '<span style="color:green;">Service is Running</span>'
  else
    service_btn.inputtitle = "Start Service" -- Set the button label dynamically
    service_btn.inputstyle = "apply"
    status_title.value = '<span style="color:red;">Service is Stopped</span>'
  end
end

update_status()

function service_btn.write(self, section)
  local rc_path = "/etc/rc.local"
  local script_line = "/usr/bin/rakitan -r"

  if is_service_running() then
    luci.sys.call("rakitan -s >/dev/null 2>&1")

    local rc_content = fs.readfile(rc_path)
    if rc_content then
      local new_content = rc_content:gsub(script_line:gsub("%-", "%%-") .. "\n?", "")
      fs.writefile(rc_path, new_content)
    end
  else
    luci.sys.call("rakitan -r >/dev/null 2>&1 &")

    if not fs.readfile(rc_path):find(script_line, 1, true) then
      fs.writefile(rc_path, fs.readfile(rc_path):gsub("exit 0", script_line .. "\nexit 0"))
    end
  end

  update_status()
end

return map
