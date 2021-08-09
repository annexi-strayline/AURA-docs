*Checkout*
==========

Usage
-----

.. prompt:: bash $

  aura checkout [[*subsystem name*] [*subsystem name*]]

The ``checkout`` command attempts to :ref:`checkout <concepts_repositories_checkout>` the targeted :doc:`subsystems </concepts/subsystems>`.

If no subsystems are specified, then the project dependency graph is generated, and an attempt is made to check-out all required subsystems.

.. note::
  ``checkout`` is the default command if no command is given.

.. note::
  ``checkout`` (with no parameters) is implicitly invoked as the early stages of any command that causes compilation, including ``compile``, ``build``, and ``run``

Tips
----

``checkout`` with a specific target is helpful for explicitly obtaining an AURA subsystem before it has any dependencies in the project. Since Ada is so well structured package specifications are often the only documentation required to use an AURA subsystem in a project. Using checkout this way allows you to obtain the specifications first, to use as documentation for the inclusion of those subsystems in your project.