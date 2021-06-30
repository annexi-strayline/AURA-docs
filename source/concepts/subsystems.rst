Subsystems
==========

Ada was originally designed as a language for *programming in the large*, which is more than just being designed for the construction of very large programs, but also for the construction of large programs built by a large number of people across concurrent teams. Ada's powerful package paradigm is the foundational mechanism for enabling programming in the large.

AURA is designed to be as Ada-specific as possible. In the effort to achieve this vis-a-vis packaging led to the somewhat obvious association between what would naturally be a "package", and what is the appropriate Ada concept - the *subsystem*.

The Ada Reference Manual defines a *subsystem* as a *root* library unit together with all of its children. [#f1]_ A root library unit is essentially a library unit declared without a prefixed name (more specifically, a first child of package Standard). [#f2]_

.. [#f1] `Ada Reference Manual, 10.1-3 <http://ada-auth.org/standards/rm12_w_tc1/html/RM-10-1.html>`_, defines a *subsystem*.
.. [#f2] `Ada Reference Manual, 10.1.1-10 <http://ada-auth.org/standards/rm12_w_tc1/html/RM-10-1-1.html>`_ - defines a *root* library unit.

AURA thus refers to *subsystems* in the Ada-native sense, and these are effectively the analog to what a "package" or "crate" would be in comparable packaging systems. AURA implementations are expected to recognize missing Ada subsystems that are withed by any unit in a program, and then use user-configured repositories to attempt retrieve the codebase of those subsystems, recursively, until all dependencies can be satisfied.
