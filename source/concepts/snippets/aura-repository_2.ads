
-- An example of a repository declaration for a git repository, in this
-- case the ANNEXI-STRAYLINE ASAP public repo.

-- This repo references a specific commit via Snapshot, but also contains
-- tracking information via a tag, whch allows the implementation to
-- update the repository with the user's instruction.

package AURA.Repository_2 with Pure is
   
   Format         : constant Repository_Format := git;
   
   Location       : constant String := "https://github.com/annexi-strayline/ASAP";
   Snapshot       : constant String := "3b6887d5dae0cc2181b34c9ee7b7c87350b9c342";
   Tracking_Branch: constant String := "stable-0.1";
   
end;
