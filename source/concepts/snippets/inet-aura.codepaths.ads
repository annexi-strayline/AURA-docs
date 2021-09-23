
package INET.AURA is
   
   -- ..
   
   package Codepaths is
      TLS: constant String
        := (if Configuration.Enable_TLS then "tls" else "");
      
      OS_Dependent: constant String
        := (if Platform_Family = "unix" then
               "unix"
            else
               "");
      
      IP_Lookup_Base: constant String := "ip_lookup/" & OS_Dependent;
      
      IP_Lookup_Addrinfo: constant String 
        := (if Platform_Flavor in "linux" | "openbsd" | "darwin" then
               IP_Lookup_Base & "/addrinfo_posix"
            elsif Platform_Flavor in 
              "freebsd" | "netbsd" | "solaris" | "illumos"
            then
               IP_Lookup_Base & "/addrinfo_bsd"
            else
               "");
           
   end Codepaths;
   
   -- ..
   
end INET.AURA;
