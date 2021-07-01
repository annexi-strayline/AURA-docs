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

   concepts/subsystems
   concepts/repositories
   concepts/autoconfiguration
   concepts/manifests

The Ada User Repository Annex (AURA) is a proposed specification for a native Ada source code package management system.

AURA is an experimental project to bring the equivalent of package management to Ada with an approach that feels as native as possible. Ada has a few unique properties that differentiate it from other modern languages.

This documentation primarily describes the ANNEXI-STRAYLINE reference implementation of the conceptual AURA "annex". This implementation and was used to both develop and prove the concept.

The reference implementation described throughout this documentation is the `ANNEXI-STRAYLINE <https://annexi-strayline.com/>`_'s reference implementation of AURA, which also functions as a highly parallelized, integrated build system similar with similar capabilities of the native packaging systems for projects like `Rust <https://www.rust-lang.org/>`_ (cargo), `Python <https://python.org/>`_ (pip), and `NodeJS <https://nodejs.org/>`_ (npm).

The ANNEXI-STRAYLINE AURA implementation was developed to develop and prove the AURA concept, as well as provide a modern, user friendly general toolchain and package manager for Ada projects. Unlike the GPR suite, AURA attempts to be as easy as possible to obtain and learn, and is designed to be portable between any modern Ada compiler.

Premise
-------
AURA was designed in the context of a conceptual new *Specialized Needs Annex* addendum to the Ada Reference Manual (the Ada standard). As such it is designed not as a "package manager", per-se, but as a defined behavior for the specification of a user-defined source-code repository that the compiler may natively support [#]_. 
   
The basic idea is that when the compiler encounters "with" clauses for subsystems it cannot immediately locate, it attempts to retrieve them from the AURA repository. The AURA reference implementation program mimics this behaviour by scanning the with statements of all Ada sources.

There are two foundational differentiation that drove the conceptualization of AURA:

#. Ada has been built from the very beginning from a formal specification.
#. Ada has a design emphasis on, and pedigree for, high integrity and safety-critical software



AURA as a hypothetical Specialized Needs Annex
----------------------------------------------
The Ada Reference Manual *Specialized Needs Annexes*
   The `Ada Reference Manual <http://ada-auth.org/arm.html>` (ARM) is the ISO standardized formal specification for the Ada language, and formally defines how a compliant compiler is required to behave.

   The ARM contains a set of *Specialized Need Annexes* that *"define features that are needed by certain application areas"*. Generally, these Annexes (currently C-H) specify additional optional functionality that a complier complier may (or may not) support.

AURA is designed to be optionally implemented by natively by any Ada compiler, with defined behavior, and in a way that ensures that an AURA "project" is still a valid Ada program for compilers that do not implement the hypothetical AURA annex.

AURA achieves this by defining the behaviour of a compiler should it encounter the inclusion ("withing") of an unknown Ada subsystem. Recall that subsystem is any "top-level" library unit, and its children. For example, package Ada and package Interfaces are both language-defined subsystems. Additionally AURA supports the "withing" of non-Ada units via an annex-specific pragma ("pragma External_With").

Therefore the attempt to compile an AURA "project" with a non-conformant compiler will simply result in the failure to find the withed units. In contrast, a compliant compiler will attempt to retrieve any missing subsystems via the configured repositories, as is explained in greater detail throughout this documentation.


Staying true to the Ada philosophy
----------------------------------
The best thing is often impractical.
The right thing is usually rejected.
The popular thing is usually wrong.

Package management is fraught with danger. Two poisons conspire: interdependency and versioning.

AURA takes a deliberate, and likely controversial move completely ignoring versioning, instead expecting versioning and interdependency to be handled at the level of the repository. The ANNEXI-STRAYLINE reference implementation integrates git, and encourages the use of submodules, branches, and tags, handle these issues. Additionally, the generally open format of a repository in this reference implementation's style lends itself well to repository coalescing, where any user can fork a number of repositories from specific commits, into a single integrated repository - thereby specifying a specific "version" of all dependencies and interdependencies, in one location. This is the preferred way to maintain a project's AURA dependencies. The reference implementation "automatically" coalesces all repository dependencies in the sense that it records the source repository's commit (for git) or hash (for filesystem-based), and then makes local copies of the source data, stored in the project itself. More on this in the relevant sections.

The basic concept is that once a given AURA project compiles, none of the code should change unless explicitly changed. There will be no accidental breakages through naïve updating mechanisms, as is problematic with other package managers such as npm, pip, and cargo. Of course this comes at the disadvantage of requiring somewhat more maintenance effort. This trade-off seems to be consistent with Ada generally, where convenience is traded for greater safety and reliability.

To counter the higher administrative overhead of not having "native" versioning, the definition, specification, and physical representation of a repository is kept as simple, and as regular as possible. The goal is that any user can quickly learn and "grok" the repository system within a few minutes of reading.
   


.. [#] No actual new annex has yet been formally developed, or proposed to the `ARG <http://ada-auth.org>`_







