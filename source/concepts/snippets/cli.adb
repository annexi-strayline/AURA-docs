
with Ada.Text_IO;       use Ada;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Interfaces.C;      use Interfaces.C;

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

pragma External_With ("tty_info.c");

package body CLI is
   
   -- ..