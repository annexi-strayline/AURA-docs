Overview
========

.. warning::
  The AURA reference implementation is still in beta. Some of the listed commands are not yet implemented. Also, behavior and syntax could be subject to change.

The AURA CLI is implemented as a stand-alone command-line tool, typically as a program named ``aura``.

The AURA CLI is designed to be as intuitive and as user-friendly as possible. It is generally inspired by similar peer programs such as NodeJS' npm, or Python's pip.

The general format of the AURA cli is as follows:

.. prompt:: bash $

  aura [command] [options]

.. note::
  The default command, if not specified, is ``checkout``

CI/CD Pipelines
~~~~~~~~~~~~~~~

The AURA CLI has been designed to work in scripted/headless environments, such as within CI/CD pipelines.

AURA checks to see if it is connected to a terminal, and when it is not, it will output more log-friendly, slightly more verbose messages about its progress.

Command Summary
---------------

====================================   ==========================================================================
Command                                Description
====================================   ==========================================================================
:doc:`help <help_command>`             Output a summary of all commands and their options
:doc:`clean <clean_command>`           | Cleans all compilation products from previous runs, and also removes any
                                       | stored state created by AURA itself
:doc:`checkout <checkout_command>`     Attempts to identify and check-out all required subsystems
:doc:`compile <compile_command>`       Invokes checkout and then compiles all subsystems and project root units
:doc:`build/run <build_run_command>`   Invokes compile and then links or executes an executable partition image
:doc:`library <library_command>`       Generates static or dynamic libraries for use in non-Ada host programs
:doc:`systemize <systemize_command>`   Used to build ``system`` type repositories
====================================   ==========================================================================
