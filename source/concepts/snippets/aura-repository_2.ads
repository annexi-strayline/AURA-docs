
-- An example of a repository declaration for a git repository, in this
-- case the ANNEXI-STRAYLINE ASAP public repo.

-- This repo references a specific commit via Snapshot, but also contains
-- tracking information via a tag, whch allows the implementation to
-- update the repository with the user's instruction.

package AURA.Repository_2 with Pure is
   
   Format         : constant Repository_Format := git;
   
   Location       : constant String := "https://github.com/annexi-strayline/ASAP";
   Snapshot       : constant String := "3e5f0781d900ed36cdfc8d8f2d61d71fd5d95122";
   Tracking_Branch: constant String := "tags/v0.21.1";
   
end;
