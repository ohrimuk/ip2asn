#!/usr/bin/luajit

require "bit"

mask={}
mask[24]=4294967040
mask[23]=4294966784
mask[22]=4294966272
mask[21]=4294965248
mask[20]=4294963200
mask[19]=4294959104
mask[18]=4294950912
mask[17]=4294934528
mask[16]=4294901760
mask[15]=4294901760
mask[14]=4294836224
mask[13]=4294705152
mask[12]=4294443008
mask[11]=4293918720
mask[10]=4292870144
mask[9]=4290772992
mask[8]=4286578688
mask[7]=4261412864
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
  local x =0
  for line in io.lines(file) do 
    for i,m,a in string.gmatch(line,"(%w+) (%w+) (%w+)") do
      asn[tonumber(i)]=a
    end
    x=x+1
  end
  print("Loaded ASn:",x)
end
-------------------------------------------------
function processIPs ()
  local file = "./sa.csv"
  local x = 0
  for line in io.lines(file) do 
    for ip,c in string.gmatch(line,"(%g+) (%g+)") do
      c=tonumber(c)
      n=ip2num(ip)
      as=asn[n]
      m=24
      while (as == nil and m > 7) do
        m=m-1
        n=bit.band(n,mask[m])
        as=asn[n]
      end 
      if as == nil then
        as=0
      end
--      print("ip="..ip.." as="..as.." c="..c)
      if(asc[as] == nil) then
        asc[as]=c
      else
        asc[as]=asc[as]+c
      end
    end
    x=x+1
  end
  print("Loaded:",x)
end
-------------------------------------------------
function printCount()
  for an,ac in pairs(asc) do 
    print(an,ac)
  end
end
---------------------- BEGIN --------------------
asn={}
asc={}
loadASn()
processIPs()
printCount()
