Projects
========

An AURA *project* is, specifically, any distinct Ada *program library* [#armdef_library]_ that contains the AURA subsystem (the package AURA and its children). This includes contexts where the implementation automatically generates one.

In laymen's terms, a project is the codebase of a program, and optionally the :doc:`repository <repositories>`-sourced AURA subsystem dependencies. Recall that a *program* in the Ada sense can be more than one executable (*partition*) [#armdef_program]_. Similarly, an AURA project can produce multiple partitions in a single codebase.

Reference Implementation
------------------------

The reference implementation (AURA CLI), further defines a *project* as any directory on the file system that either contains the AURA subsystem packages, or is the *current directory* when the AURA CLI tool is run.

AURA CLI will auto-generate the basic AURA subsystem packages in the *current directory* if they are not found.

.. [#armdef_library] The `Ada Reference Manual <http://www.ada-auth.org/standards/rm12_w_tc1/html/RM-10.html>`_ defines a *program library* as follows: "An implementation may support a concept of a program library (or simply, a “library”), which contains library_items and their subunits. Library units may be organized into a hierarchy of children, grandchildren, and so on."

.. [#armdef_program] The `Ada Reference Manual <http://www.ada-auth.org/standards/rm12_w_tc1/html/RM-10.html>`_ defines a *program* as follows: "A *program* is a set of *partitions*, each of which may execute in a separate address space, possibly on a separate computer. "