#!/usr/bin/luajit

-------------------------------------------------
function ip2num(s)
  local a
  local n
  a = string.split(tostring(s),'.')                                                                                                                                                                     
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
--    print(line)
    for i,c in string.gmatch(line,"(%w+),(%w+)") do
      print("i="..i.." c="..c)
    end
  end
  
end
---------------------- BEGIN --------------------
asn={}
--loadASn()
processIPs()


--print("main: asn[3758095360]="..asn[3758095360])

--foreach $as (@ips) {
--  print "[".$as."] [".$ips[$ip]."]\n";
--}

--$ip="217.21.34.0/24";
--print $ip." ".$ips[$ip]."\n";
