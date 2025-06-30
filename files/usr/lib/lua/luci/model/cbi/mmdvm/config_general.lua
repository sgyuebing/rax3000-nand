local n=require"luci.sys"
local o=require"nixio.fs"
local e=require"luci.jsonc"
local a,t,e=...
local i=require("luci.model.mmdvm")
local s=require("luci.http")
a=Map("mmdvm","",translate("Here you can configure the basic aspects of your device like its callsign or the operating modes."))
a.on_after_commit=function(e)
if e.changed then
changes=e.uci:changes("mmdvm")
if i.uci2ini(changes)then
n.call("env -i /etc/init.d/mmdvmhost restart >/dev/null")
end
end
end
i.ini2uci(a.uci)
t=a:section(NamedSection,"General","mmdvmhost",translate("General Settings"))
t.anonymous=true
t.addremove=false
e=t:option(Value,"Callsign",translate("Callsign"))
e.optional=false
e=t:option(Value,"Id",translate("ID"),translate("Your DmrId or DmrId + <abbr title=\"ex. 460713301\">2 digitals</abbr>"))
e.optional=true
e.datatype="uinteger"
e=t:option(ListValue,"Duplex",translate("Duplex/Simplex"))
e:value("0",translate("Simplex"))
e:value("1",translate("Duplex"))
e=t:option(Value,"NetModeHang",translate("NetModeHang"))
e.datatype="uinteger"
e=t:option(Value,"RFModeHang",translate("RFModeHang"))
e.datatype="uinteger"
t=a:section(NamedSection,"Info","mmdvmhost",translate("Infomation Settings"),translate("Those infomation will show up at brandmeister.network if you enable DMR mode"))
t.anonymous=true
e=t:option(Value,"RXFrequency",translate("RXFrequency"),translate("Use the format <abbr title=\"the Unit is Hz\">434500000</abbr>, in Hz"))
e.optional=true
e.datatype="uinteger"
e=t:option(Value,"TXFrequency",translate("TXFrequency"),translate("Use the same format as RXFrequency"))
e.optional=true
e.datatype="uinteger"
e=t:option(Value,"Latitude",translate("Latitude"),translate("e.g. 22.10 N"))
e=t:option(Value,"Longitude",translate("Longitude"),translate("e.g. 114.3 E"))
e=t:option(Value,"Height",translate("Height"),translate("e.g. 110 Meters"))
e.optional=true
e.datatype="uinteger"
e=t:option(Value,"Power",translate("TXPower"),translate("e.g. 1 Watt"))
e.optional=true
e.datatype="uinteger"
e=t:option(Value,"Location",translate("Location"))
e=t:option(Value,"Description",translate("Description"))
e=t:option(Value,"URL",translate("URL"))
t=a:section(NamedSection,"Modem","mmdvmhost",translate("Modem Settings"))
t.anonymous=true
e=t:option(ListValue,"Port",translate("Port"),translate("The port of Modem"))
e:value("NullModem","NullModem")
if o.access("/dev/ttyS0")then e:value("/dev/ttyS0")end
if o.access("/dev/ttyUSB0")then e:value("/dev/ttyUSB0")end
if o.access("/dev/ttyUSB1")then e:value("/dev/ttyUSB1")end
if o.access("/dev/ttyUSB2")then e:value("/dev/ttyUSB2")end
if o.access("/dev/ttyACM0")then e:value("/dev/ttyACM0")end
if o.access("/dev/ttyAMA0")then e:value("/dev/ttyAMA0")end
e=t:option(Value,"RXOffset",translate("RXOffset"))
e=t:option(Value,"TXOffset",translate("TXOffset"))
e=t:option(Value,"RSSIMappingFile",translate("RSSIMappingFile"))
return a
