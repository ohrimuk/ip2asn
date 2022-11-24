#!/usr/bin/luajit

string = require('string')

-------------------------------------------------
function ip2num(s)
  local a = {}
  local i = 1
  local n
  for d in string.gmatch(tostring(s),'(%d+)') do 
    a[i]=tonumber(d)
    i=i+1
  end
  n = a[1]*16777216+a[2]*65536+a[3]*256+a[4]
  return n
end
-------------------------------------------------
function loadASn ()
  local file = "./ip2asn.csv"
  for line in io.lines(file) do 
    for i,m,a in string.gmatch(line,"(%w+) (%w+) (%w+)") do
      asn[tonumber(i)]=a
    end
  end
  
end
-------------------------------------------------
function processIPs ()
  local file = "./out_sa.csv"
  for line in io.lines(file) do 
    for ip,c in string.gmatch(line,"(%g+) (%g+)") do
      n=ip2num(ip)
      as=asn[n]
      if as == nil then
        as=0
      end
      print("ip="..ip.." as="..as.." c="..c)
    end
  end
  
end
---------------------- BEGIN --------------------
asn={}
loadASn()
processIPs()

--print("main: asn[3758095360]="..asn[3758095360])
c='217.21.34.0'
print(ip2num(c))
print(asn[ip2num(c)])
