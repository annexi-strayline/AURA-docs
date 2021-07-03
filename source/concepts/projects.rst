Projects
========

An AURA *project* is any distinct Ada *program library* [#armdef_library]_ that contains an AURA subsystem (the package AURA and its children). This includes contexts where the implementation automatically generates one.

In laymen's terms, a project is the codebase of a program excluding the :doc:`repository <repositories>`-sourced AURA subsystems, but including the AURA root packages. Recall that a *program* in the Ada sense can be more than one executable (*partition*)[#armdef_program]. Similarly, an AURA project can produce multiple partitions from a single codebase.

Reference Implementation
------------------------

For the AS reference implementation, a *project* is further defined as any directory on the file system that either contains the AURA subsystem packages, or is the *current directory* when the AURA CLI tool is run.

The AURA CLI will auto-generate the basic AURA subsystem packages in the *current directory* if they are not found.

.. [#armdef_library] The `Ada Reference Manual <http://www.ada-auth.org/standards/rm12_w_tc1/html/RM-10.html>`_ defines a *program library* as follows: "An implementation may support a concept of a program library (or simply, a “library”), which contains library_items and their subunits. Library units may be organized into a hierarchy of children, grandchildren, and so on."