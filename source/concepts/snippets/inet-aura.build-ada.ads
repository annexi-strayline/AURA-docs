
package INET.AURA is
   
   package Configuration is
      -- ..
   end Configuration;
   
   package Build is
      -- ..
      
      package Ada is
         package Compiler_Options is
            Ignore_Unknown_Pragmas: constant String := "-gnatwG";
         end Compiler_Options;
      end Ada;
      
      -- ..
   end Build;
   
   -- ..
   
end INET.AURA;
