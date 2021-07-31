Clean
=====

Usage
-----

.. prompt:: $

  aura clean

The ``clean`` command takes no arguments.

``clean`` removes all *intermediate* compilation products from the project, and also removes any AURA-specific saved-state (such as compilation state, code hashes, and dependency graphs).

.. note::
  *Intermediate compilation products* does **not** include the final linked programs, which will remain in the project root.

  Depending on the compiler, it may be necessary to delete the linked program if a full recompile is desired. This needs to be done manually

Tips
----

``clean`` is a useful first step in general problem-solving when an AURA project fails to compile properly.