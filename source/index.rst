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

The Ada User Repository Annex (AURA) is a proposed specification for a native Ada source code package management system, developed along-side a reference implementation.

AURA is an experimental project to bring the equivalent of package management to Ada with an approach that feels as native as possible. Ada has a few unique properties that differentiate it from other modern languages.

This documentation primarily focused on the reference implementation of AURA, but also covers the core content of the future AURA specification.

The reference implementation of AURA also functions as a highly parallelized, integrated build system with similar capabilities of the native packaging systems for projects like `Rust <https://www.rust-lang.org/>`_ (cargo), `Python <https://python.org/>`_ (pip), and `NodeJS <https://nodejs.org/>`_ (npm). The AURA cli is further designed to enable modern CI/CD pipelines for Ada applications.

The AURA reference implementation was developed not only to prove the AURA specification, but also with a goal to provide a modern, open-source, freely-available, user friendly one-stop toolchain and package manager for Ada development. The AURA reference implementation prioritized the following design goals:

* Deeply parallelized
* CI/CD orientated
* Free for any use
* Fully decentralized
* Easy to use
* Easy to learn
* Low barrier to entry


Premise
-------

AURA was designed in the context of a hypothetical new :ref:`Specialized Needs Annex <index_SNA_see_also>` of the Ada Reference Manual (the Ada standard). As such it is not designed explicitly as a "package manager", per-se, but rather as a defined behavior for the specification of a user-defined, generalized, auto-configuring source code repositories that the compiler may natively support [#not_an_sna]_. 

AURA therefore is really the definition of the behavior a compliant Ada compiler should exhibit when encountering the *withing* of a *library unit* from an Ada :ref:`subsystem <index_subsystems_see_also>` that was not entered into the *library* through the normal mechanisms [#ARM_compilation]_.

The basic idea is that when the compiler encounters *with* clauses (as well as AURA-specific *External_With* pragmas for subsystems it cannot immediately locate, it attempts to retrieve them from the AURA repository. The AURA reference implementation program mimics this behavior by scanning the with statements of all Ada sources.

There are two foundational Ada differentiators that drove the conceptualization of AURA:

#. Ada has been built from the very beginning from a formal specification.
#. Ada has a design emphasis on, and pedigree for, high integrity and safety-critical software

.. _index_SNA_see_also:

.. seealso::
   .. rubric:: `Ada Specialized Needs Annexes <http://www.ada-auth.org/standards/rm12_w_tc1/html/RM-1-1-2.html#I1007>`_

   The `Ada Reference Manual <http://ada-auth.org/arm.html>`_ (ARM) is the ISO standardized formal specification for the Ada language, and formally defines how a compliant compiler is required to behave.

   The ARM contains a set of *Specialized Need Annexes* that *"define features that are needed by certain application areas"*. 

.. _index_subsystems_see_also:

.. seealso::
   .. rubric:: :doc:`Subsystems <concepts/subsystems>`

   *Subsystems* are both Ada concepts, and (by extension) AURA concepts, as AURA is a conceptual *Specialized Needs Annex*. Subsystems are basically any *root* (top-level) library units and all of their children.

   Subsystems retrieved and configured through AURA are essentially analogues to "packages" or "crates" of other package managers.

AURA as a hypothetical Specialized Needs Annex
----------------------------------------------

The Ada Reference Manual *Specialized Needs Annexes*
   Generally, these Annexes (currently C-H) specify additional optional functionality that a complier complier may (or may not) support.

Therefore the attempt to compile an AURA "project" with a non-conformant compiler will simply result in the failure to find the withed units. In contrast, a compliant compiler will attempt to retrieve any missing subsystems via the configured repositories, as is explained in greater detail throughout this documentation.

As a conceptual *Specialized Needs Annex*, the behavior is well-defined for both compliant and *non*-compliant compilers. Generally, the attempt to compile an AURA project with a non-compliant compiler will likely fail, but will never change the behavior of the compiled program in any case.


Staying true to the Ada philosophy
----------------------------------

| The best thing is often impractical.
| The right thing is usually rejected.
| The popular thing is usually wrong.

Package management is fraught with danger. Two poisons conspire: interdependency and versioning.

AURA takes a deliberate, and possibly controversial position that versioning is not the role of the package manager. Instead AURA expects versioning and version interdependency to be handled at the level of the repository or codebase. AURA simply seeks to ensure that any checked-out code never changes without explicit user intervention. The reference implementation integrates git, and encourages the use of submodules, branches, and tags, to handle versioning. Additionally, the generally open format of a repository in this reference implementation's style lends itself well to repository coalescing, where any user can fork a number of repositories from specific commits, into a single integrated repository - thereby specifying a specific "version" of all dependencies and interdependencies, in one location. This is the preferred way to maintain a project's AURA dependencies. The reference implementation "automatically" coalesces all repository dependencies in the sense that it records the source repository's commit (for git) or hash (for filesystem-based), and then makes local copies of the source data, stored in the project itself. More on this in the relevant sections.

The basic concept is that once a given AURA project compiles, none of the code should change unless explicitly changed. There will be no accidental breakages through naïve updating mechanisms, as is problematic with other package managers such as npm, pip, and cargo. Of course this comes at the disadvantage of requiring somewhat more maintenance effort. This trade-off seems to be consistent with Ada generally, where convenience is traded for greater safety and reliability.

To counter the higher administrative overhead of not having "native" versioning, the definition, specification, and physical representation of a repository is kept as simple and regular as possible. The goal is that any user can not only quickly learn, but also quickly "grok" AURA in its entirety.


.. [#not_an_sna] No actual new annex has yet been formally developed, or proposed to the `ARG <http://ada-auth.org>`_

.. [#ARM_compilation] The Ada Reference Manual `clause 10 <http://www.ada-auth.org/standards/rm12_w_tc1/html/RM-10.html>`_ describes library units and compilation.





