
-- INET AURA Configuration Manifest

package aura.inet is
   
   package Configuration is
      Enable_TLS: constant Boolean := True;
   end Configuration;
   
   package Build is
      package External_Libraries is
         LibreSSL_libtls: constant String 
           := (if Configuration.Enable_TLS then
                  "tls"
               else
                  "");
         -- Users should also ensure that the libressl include directory is in
         -- C_INCLUDE_PATH, if not installed in the usual locations
      end External_libraries;
      
      package Ada is
         package Compiler_Options is
            Ignore_Unknown_Pragmas: constant String := "-gnatwG";
         end Compiler_Options;
      end Ada;
      
      package C is
         package Preprocessor_Definitions is
            BSD: constant String
              := (if Platform_Flavor 
                    in "freebsd" | "openbsd" | "netbsd"
                  then
                     "__INET_OS_BSD"
                  else
                     "");
            
            Darwin: constant String
              := (if Platform_Flavor = "darwin" then
                     "__INET_OS_DARWIN"
                  else
                     "");
            
            Linux: constant String
              := (if Platform_Flavor = "linux" then
                     "__INET_OS_LINUX"
                  else
                     "");
         end Preprocessor_Definitions;
      end C;
   end Build;
   
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
   
end aura.inet;
