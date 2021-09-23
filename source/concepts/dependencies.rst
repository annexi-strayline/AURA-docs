Dependencies
============

For any given :doc:`project <projects>`, all Ada units are scanned for their dependencies, including within the configured :ref:`codepaths <concepts_manifests_codepaths>` of already :ref:`checked-out <concepts_repositories_checkout>` AURA subsystems. Dependencies that cannot be immediately resolved through this scan cause a iterative attempt to :ref:`checkout <concepts_repositories_checkout>` each missing subsystem from one of the configured :doc:`repositories <repositories>`, :doc:`configure it <autoconfiguration>`, and then scan its codepaths. This process is repeated until all dependencies are resolved, or cannot be resolved.

In the case of AURA CLI, the process begins by first scanning all root units (Ada source files in the *current directory*), followed by all already checked-out subsystems.

.. _concepts_dependencies_external_with:

Including Non-Ada Sources
-------------------------

For the most part, dependencies are given through normal Ada `context clauses <http://ada-auth.org/standards/rm12_w_tc1/html/RM-10-1-2.html>`_ (``with`` clauses). However AURA, like Ada itself, is is designed to operate in a mixed-language environment.

AURA provides a mechanism for an Ada source to specify that some non-Ada unit is a dependency of that unit. To achieve this, AURA introduces a new pragma ``pragma External_With``. This pragma is intended to be used similarly to the ``with`` clause, and must only be placed in the `context clause <http://ada-auth.org/standards/rm12_w_tc1/html/RM-10-1-2.html>`_ of a library unit. 

``pramga External_With`` takes a single parameter, which shall be a static String, Wide_String, or Wide_Wide_String expression. The content of the string shall be the simple file name (no path components), including the appropriate extension indicating the language, of a single unit (e.g. ``"foo.c"``).

.. note::

    At the time of writing, AURA CLI only accepts external units with the ``.c`` extension.

Generally, such a pragma should be used in any Ada unit invokes the ``Import`` pragma or aspect to import a subprogram or object from an external unit within the same AURA subsystem or AURA project. 

By using ``pragma External_With``, AURA will ensure that the required unit is compiled and linked appropriately. AURA also ensures that the relevent :doc:`manifest <manifests>` configuration applies to the compilation step for those units.

.. warning::
  External units cannot be "withed" across AURA subsystems, nor can a project with an external unit from any of it's AURA subsystem dependencies.

Example
^^^^^^^

The `CLI AURA subsystem <https://github.com/annexi-strayline/ASAP-CLI>`_ of the `ASAP repository <https://github.com/annexi-strayline/ASAP>`_ uses a simple external unit as a C source file to make an ``ioctl`` to query the terminal. This C source is in the root of the subsystem subdirectory, along-side the Ada sources. The C source could also be in any :ref:`codepath <concepts_manifests_codepaths>`. The C external unit exports a few subprograms. These subprograms are imported by the body of ``package CLI``, in ``cli.adb``. The context clause of cli.adb appears as follows:

.. literalinclude:: snippets/cli.adb
  :language: ada
  :emphasize-lines: 7