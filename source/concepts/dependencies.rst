Dependencies
============

For any given :doc:`project <projects>`, all units and subsystems are scanned for their dependencies, which is used to build a dependency map. Dependencies that are not available cause an attempt to :ref:`checkout <concepts_repositories_checkout>` 

When the AURA cli program is run, the first step it takes is to "enter" all recognized program units in the *current directory* (the root directory of the :doc:`project <projects>`. Currently the reference implementation recognizes ``.ads``, ``.adb``, and ``.c`` files. These units are added to a global dependency map. Ada sources are then parsed for their dependencies. These dependencies are essentially Ada 'with' statements, and the AURA-specific 'External_With' pragma. 

The Ada Reference Manual defines a *subsystem* as a *root* library unit together with all of its children [#f1]_. A root library unit is essentially a library unit declared without a prefixed name (more specifically, a first child of package Standard) [#f2]_.

Ada was originally designed as a language for *programming in the large*, which is more than just being designed for the construction of very large programs, but also for the construction of large programs by a large number of people across concurrent teams (this happens to be an excellent property for open-source projects). Ada's powerful package paradigm is the foundational mechanism for enabling programming in the large.

Subsystems in AURA are semantically subset to Ada subsystem since AURA is defined in the context of the Ada standard. An Ada subsystem becomes an AURA subsystem by either being accessible from an AURA repository, or containing an :doc:`AURA subsystem manifest <manifests>`. AURA Subsystems are the functional analogues to "packages" or "crates" in package management systems. 

An AURA-compliant implementation will always attempt to resolve all dependencies of a program (project) by :ref:`checking-out <concepts_repositories_checkout>` any missing subsystems needed by a program from configured repositories. For subsystems installed and configured from a repository, the AURA implementation also iteratively attempts to :ref:`checkout <concepts_repositories_checkout>` all missing subsystems depended-upon by any checked-out subsystems.

.. [#f1] `Ada Reference Manual, 10.1-3 <http://ada-auth.org/standards/rm12_w_tc1/html/RM-10-1.html>`_, defines a *subsystem*.
.. [#f2] `Ada Reference Manual, 10.1.1-10 <http://ada-auth.org/standards/rm12_w_tc1/html/RM-10-1-1.html>`_ - defines a *root* library unit.
