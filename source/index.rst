AURA: Ada User Repository Annex
===============================

.. meta::
   :description lang=en: AURA Reference Implementation Documentation

.. toctree::
   :maxdepth: 2
   :hidden:
   :caption: Quick start

   quick_start/prerequisites
   quick_start/installation
   quick_start/setting_up_a_project
   quick_start/using_an_aura_package

.. toctree::
   :maxdepth: 2
   :hidden:
   :caption: Concepts

   concepts/projects
   concepts/subsystems
   concepts/dependencies
   concepts/repositories
   concepts/autoconfiguration
   concepts/manifests

.. toctree::
   :maxdepth: 2
   :hidden:
   :caption: AURA CLI

   cli/overview
   cli/help_command
   cli/clean_command
   cli/checkout_command
   cli/compile_command
   cli/build_run_command
   cli/library_command
   cli/systemize_command

The Ada User Repository Annex (AURA) is a proposed specification for a native Ada source code package management system, developed in lock-step with a reference implementation. This is the official documentation for the Reference Implementation (AURA CLI).

AURA CLI was designed to function as a production-ready, integrated build system with similar capabilities to existing native packaging systems for projects like `Rust <https://www.rust-lang.org/>`_ (cargo), `Python <https://python.org/>`_ (pip), and `NodeJS <https://nodejs.org/>`_ (npm). 

AURA CLI has a fully parallelized design for maximum performance on modern systems, and uses all available cores to parse program text, compute dependencies, obtain subsystems, perform configuration, and build projects. Besides having a user-friendly interface, AURA CLI is also designed to work in automated CI/CD pipelines.

Premise
-------

AURA was designed as a hypothetical new :ref:`Specialized Needs Annex <index_SNA_see_also>` of the Ada Reference Manual (the Ada standard). As such it is not designed to be an exclusively stand-alone tool, but rather as a specific set of behaviors that an Ada compiler could optionally implement [#not_an_sna]_. The behavior specified by AURA is triggered when the implementation encounters a dependency that it cannot immediately locate. Dependencies are typically specified through standard Ada `with clauses <http://ada-auth.org/standards/rm12_w_tc1/html/RM-10-1-2.html>`_, though AURA also specifies a new :ref:`pragma <concepts_dependencies_external_with>` for the expression of non-Ada dependencies.

The basic idea is that when an AURA implementation encounters a *with clause* for a library unit of a subsystem it cannot immediately locate, it attempts to retrieve that subsystem from the first available (configured) AURA repository. The AURA reference implementation ("AURA CLI") parses the `context clause <http://ada-auth.org/standards/rm12_w_tc1/html/RM-10-1-2.html>`_ of all Ada sources in a :doc:`project <concepts/projects>`. It then builds a full dependency graph, and uses this information to compute which subsystems must be obtained, and if those subsystems actually contain the required units.

As a conceptual *Specialized Needs Annex*, the behavior is well-defined for both compliant and *non*-compliant compilers. Generally, the attempt to compile an AURA project with a non-compliant compiler may fail, but will never change the meaning of the program text, or the behavior of the compiled program.

.. _index_SNA_see_also:

.. seealso::
   .. rubric:: `Ada Specialized Needs Annexes <http://www.ada-auth.org/standards/rm12_w_tc1/html/RM-1-1-2.html#I1007>`_

   The `Ada Reference Manual <http://ada-auth.org/arm.html>`_ (ARM) is the ISO standardized formal specification for the Ada language, and formally defines how a compliant compiler is required to behave.

   The ARM contains a set of *Specialized Need Annexes* that *"define features that are needed by certain application areas"*. 

.. _index_subsystems_see_also:

.. seealso::
   .. rubric:: :doc:`Subsystems <concepts/subsystems>`

   *Subsystems* are both Ada concepts, and (by extension) AURA concepts, as AURA is a conceptual *Specialized Needs Annex*. Subsystems are essentially any library unit hierarchies rooted by a "top-level" unit. Top-level means a direct child of ``package Standard``.
   
   Subsystems retrieved and configured through AURA are essentially analogues to "packages" or "crates" of other package managers.

Staying true to the Ada philosophy
----------------------------------

| *The best thing is often impractical.*
| *The right thing is usually rejected.*
| *The popular thing is usually wrong.*

Package management is fraught with danger. Two poisons conspire: interdependency and versioning.

AURA takes a deliberate, and possibly controversial position that versioning should not be the responsibility of the package manager. Instead, AURA expects versioning and version interdependency to be handled at the level of the :doc:`repository <concepts/repositories>` and/or :doc:`subsystem <concepts/subsystems>`. This is done to ensure that AURA's behaviour is always predictable and that **checked-out code never changes without explicit user intervention**.

The reference implementation ("AURA CLI") prominently integrates `git <git-scm.com>`_, and encourages the use of submodules, branches, or tags to handle repository versioning. The simple subdirectory based :ref:`repository structure <local_repository_defn>` implemented by AURA CLI encourages repository coalescing, where individual subsystems are maintained in their own git repository, allowing coalesced AURA repositories to include them as git `submodules <https://git-scm.com/docs/gitsubmodules>`_, targeting specific commits of each subsystem. Such coalesced repositories can then be versioned as a collection, where integration testing can be applied to all submodules in the repository. Ideally, a project can create its own *single point of truth* repository to coalesce all project dependencies. This approach, though more work, makes updating of codebases much more reliable, safe, and controlled. 

Please see this `blog post <#>`_ for a deeper philosophical discussion on the design of AURA.

.. [#not_an_sna] As of yet we have not started any formal proposal to the `ARG <http://ada-auth.org>`_

.. [#ARM_compilation] The Ada Reference Manual `clause 10 <http://www.ada-auth.org/standards/rm12_w_tc1/html/RM-10.html>`_ describes library units and compilation.





