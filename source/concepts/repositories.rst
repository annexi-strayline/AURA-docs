Repositories
============

Repositories are simply a store of any number of :doc:`subsystems <subsystems>`. Repositories can be of any implementation-defined number of types, with only one type being required (the *local* type).

.. _concepts_repositories_checkout:

Types of Repositories
---------------------

AURA implementations shall define all supported repository types as enumeration literals for the enumeration type ``Repository_Format``. The implementation must include the repository of type ``local``. The implementation may also include remote repositories such as ``git``.


Repository Declarations
-----------------------

AURA implementations are required to support the indexed declaration of repositories in priority order, through child packages of the AURA package named Repository_*index*. Indexes start at 1. ``Repository_1`` is reserved and is explicitly specified by AURA (:ref:`see below <ref-repository-1>`).

All defined repositories shall be contiguous in their index. If a repository is removed, the lower indexes shall be adjusted to fill the created gap.

The implementation *can* include pre-configured repositories. If the implementation includes pre-configured repositories, it:
* Must use a contiguous series of indexes starting at 2 for all such repositories
* Must Auto-generate the declarations for *all* pre-configured repositories in every project, unless the declarations at those index are already present.
* Shall accept existing configurations that overlap (user overrides)
* Can notify the user of overridden pre-configured repositories

A repository declaration must contain a constant declaration of the object ``Format`` that is of time ``Repository_Format``.

.. literalinclude:: snippets/aura-repository_2.ads
  :language: ada
  :caption: An example repository declaration

When attempting to *checkout* a subsystem that has not been previously checked-out, the implementation must acquire the subsystem from the repository with the lowest index among all configured repositories that contain it.



.. _ref-repository-1:

Repository_1
   Indexes start at 1, and ``Repository_1`` shall be of format ``local``, and shall allow the user to explicitly register subsystems under the project itself.

   The implementation must not accept a non-conformant declaration for ``Repository_1``.


Checkout
--------

The *checkout* process is the process by which an AURA implementation causes a missing subsystem to be included in the *program library* by retrieving it from the first available repository.

The mechanical details of the *checkout* process is implementation-defined, but the high-level behavior is explicitly defined as follows:

#. If a checkout package exists for the subsystem in the project, the implementation must obtain the exact same representation of the subsystem as originally acquired by the previous checkout. If the implementation is unable to satisfy that requirement, it must reject compilation of the program.
#. If a checkout package does not exist for the subsystem, it shall be created if the subsystem is located within any of the configured repository. This checkout package shall contain a renaming of the source repository package, and shall contain a checksum of sufficient strength to ensure that any subsequent checkouts obtain exactly the same representation.
#. When searching for a repository from which to *acquire* a missing subsystem, if there are multiple repositories that contain the missing subsystem, the implementation shall use the repository with the lowest index.
#. The implementation should make a local copy of any checked-out subsystem within the project such that the project itself can be compiled independently.

