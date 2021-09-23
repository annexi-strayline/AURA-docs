
-- INET AURA Configuration Manifest

package INET.AURA is
   
   package Configuration is
      -- ..
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
      
      -- ..
   end Build;
   
   -- ..
   
end INET.AURA;
