module("luci.controller.rakitan", package.seeall)

function index()
    entry({"admin", "services", "rakitan"}, cbi("rakitan"), _("Rakitan Monitor"), 88).dependent = true
end
