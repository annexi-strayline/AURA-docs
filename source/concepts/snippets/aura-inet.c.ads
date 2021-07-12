
package aura.inet is
   
   package Configuration is
      -- ..
   end Configuration;
   
   package Build is
      -- ..
      
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
   
   -- ..
   
end aura.inet;
