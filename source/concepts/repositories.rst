Repositories
============

Repositories are simply a store of any number of :doc:`subsystems <subsystems>`. Repositories can be of any implementation-defined number of types, with only one type being required (the *local* type). Declared repositories either shall specify an immutable snapshot of some kind, or else the implementation must compute a snapshot hash of the repository's contents at the first moment a subsystem is *checked-out* from the repository.


.. _concepts_repositories_checkout:

Types of Repositories
---------------------

AURA implementations shall define all supported repository types as enumeration literals for the enumeration type ``Repository_Format``. The implementation must include the repository of type ``local``. The implementation may also include remote repositories such as ``git``.

The reference implementation supports three repository types: ``system``, ``local``, and ``git``.

System Repositories
  ``system`` repositories allow for common subsystems that are used across a large project (of separate partitions) to be individually made into separately compiled dynamically linked libraries. This feature is targeted at large CI/CD deployments, particularly in containerized environments. This ensures that changes to core subsystems can be distributed efficiently, minimizing recompilation needs across the entire program.

.. warning::
  At the time of writing, the ``system`` repository type has not yet been implemented.

Local Repositories
  ``local`` repositories are simply directories accessible directly from the filesystem. For local repository declarations, the Location object gives the root path of the repository. Subsystems are expected to be within subdirectories with the Ada-specified folded name of the subsystem.

Git Repositories
  ``git`` repositories refer to a specific git repository and commit hash, with an optional ability to follow tracking branches. When checking-out from a git repository, the reference implementation makes a local cache by checking-out the git repo itself, and also initialized and updates any submodules present, before treating the checked-out cache exactly as it would a local repository.

  This means the git repository itself should be a collection of directories with the names of subsystems that the repository contains. This scheme is particularly useful for submodules; where each submodule is a subsystem that is checked-out from its own repository. This allows the central repository to ensure version compatibility between all hosted subsystems for any given commit/branch/tag.

.. _ref_repository_declarations:

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

.. _git_repository_example:

.. literalinclude:: snippets/aura-repository_2.ads
  :language: ada
  :caption: An example repository declaration

When attempting to *checkout* a subsystem that has not been previously checked-out, the implementation must acquire the subsystem from the repository with the lowest index among all configured repositories that contain it.

.. _ref-repository-1:

Repository_1
   Indexes start at 1, and ``Repository_1`` shall be of format ``local``, and shall allow the user to explicitly register subsystems under the project itself.

   The implementation must not accept a non-conformant declaration for ``Repository_1``.

  In the reference implementation, ``Repository_1`` simply refers to the project root directly, meaning that any subdirectories of the project root are considered to be available subsystems.

.. note::
  
  The reference implementation does not yet support the direct management of user-declared repositories from the cli, though this is a planned feature. Repositories are fairly easy to declare as seen in :ref:`Repository Declarations <ref_repository_declarations>`. :ref:`Here <git_repository_example>` is a great example of a typical git repository declaration. 

Checkout
--------

The *checkout* process is the process by which an AURA implementation causes a missing subsystem to be included in the *program library* by retrieving it from the first available repository.

The mechanical details of the *checkout* process is implementation-defined, but the high-level behavior is explicitly defined as follows:

#. If a checkout package exists for the subsystem in the project, the implementation must obtain the exact same representation of the subsystem as originally acquired by the previous checkout. If the implementation is unable to satisfy that requirement, it must reject compilation of the program. The implementation can do this by maintaining the necessary information about the repository such as a commit ID or a full repository hash. This information should be stored within the repository declaration (except for :ref:`Repository_1 <ref-repository-1>`). The implementation can insert this information in the repository declaration if it does not exist.
#. If a checkout package does not exist for the subsystem, it shall be created if the subsystem is located within any of the configured repository. The checkout package must be a package renaming of the source repository declaration.
#. When searching for a repository from which to *acquire* a missing subsystem, if there are multiple repositories that contain the missing subsystem, the implementation shall use the repository with the lowest index.
#. The implementation should make a local copy of any checked-out subsystem within the project such that the project itself can be compiled independently.

The the reference implementation, the checkout process typically results in the full codebase of the subsystem being copied to a subdirectory in the project's root directory, with the same name as the subsystem itself. This varies slightly for the ``system`` repository type.