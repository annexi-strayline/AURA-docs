Subsystem Manifests
===================

Each AURA subsystem can *optionally* include a special library unit called the *manifest*. This is an Ada package that is the first child of the subsystem root package itself, with a name "AURA". For example, for a the CLI subsystem in our :doc:`quick start example </quick_start/using_an_aura_package>`, the *AURA manifest* would be declared like this:

.. code-block:: ada

  package CLI.AURA is
    ..

If included, manifests are copied to the project root as-is (spec and body), except that they are renamed as direct children of the AURA package with the subsystem name. As with the root AURA package, any AURA subsystem can then *with* this unit to access the configuration properties.

.. note::
  Manifests, as well as all special nested packages described in this documentation, are completely optional.

In the example above, the CLI manifest would be converted into a unit in the project root that would be declared as follows:

.. code-block:: ada

  package AURA.CLI is
    ..

Manifests should contain sufficient comments to allow the user to make their own modifications to the configuration of the subsystem once :doc:`checked-out <repositories>`.

.. note::
  Since the AURA package is Pure, manifest packages must also be Pure. This is by design, and limits what manifest packages can do during autoconfiguration. This is both a safety/security feature, and encouragement to create AURA packages that build more efficiently and reliably.

Role in Autoconfiguration
-------------------------

Once a subsystem manifest gets copied to the root project during the :doc:`checkout <repositories>` of an AURA subsystem, it becomes what is known as the *configuration package*. Configuration packages are a powerful feature of the autoconfiguration process. 

.. note::

  If a subsystem does not have a manfiest, an empty configuration package is generated automatically. In other words, manifests are implicitly empty packages.


During the build process, each subsystem is *:doc:`configured <autoconfiguration>`*, which involves parsing and evaluating each available subsystem configuration package, and using some of the explicitly defined components to influence the build environment with code paths, external libraries, compiler settings, and C language definitions.

Manifest Contents
-----------------

An AURA manifest package may contain any legal Ada declarations, and may also have a body. The only restriction is that an AURA manifest cannot have any dependencies except the Ada standard library, and my not be generic.

There are three special nested packages that the AURA implementation recognizes and processes specially (``Build`` ``Codepaths`` ``Information``), and one recommended neutral nested package (``Configuration``).

All of the specially recognized nested packages can contain any number of constant String declarations (often initialized with non-static expressions). These declarations are used by the AURA implementation to affect different capabilities, features, and configuration parameters for the subsystem and build environment.

Example of a Manifest
---------------------

The ASAP INET subsystem provides a great example of a package manifest that contains both platform-based autoconfiguration, as well as user-configured options. The INET manifest also uses most of the important AURA-specific configuration facilities.

Here is the complete INET manifest.

.. note::
  Remember that the manifest will become a configuration package with the name ``aura.inet`` after checkout. The actual manifest itself will never be directly compiled by AURA, and must not be withed directly by any unit of the subsystem.

.. literalinclude:: snippets/aura-inet.ads
  :language: ada


The Configuration Nested Package
--------------------------------

.. literalinclude:: snippets/aura-inet.config-focus.ads
  :language: ada

The ``Configuration`` nested package is a recommended convention, but is not specially recognized by the AURA implementation. It's recommended role is to contain all user-configurable options for the subsystem.

In this example, the ``Configuration`` package contains the option for enabling TLS support for the ``INET`` subsystem. The manifest should contain the default configuration.

If the user of the INET package wished to enable TLS support, they would edit the subsystem ``Configuration`` package to enable that feature.

By following this convention, the AURA subsystem users can more easily configure their checkouts of the subsystem.

This package, if present, should be the first declaration of the manifest.

The Build Nested Package
------------------------

The ``Build`` nested package is used to control the building of subsystems, as well as the linking of projects that depend on the subsystem.

The ``Build`` nested package is it composed of a a number of specific AURA-recognized packages.

The ``Build`` nested package, as well as all of its nested children, is optional.

The External_Libraries Package
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. literalinclude:: snippets/aura-inet.build-externlibs.ads
  :language: ada

The ``Build.External_Libraries`` package can contain any number of constant String declarations which declare the linker/compiler-recognized library name. 

.. note::
  The AURA implementation is advised to generally follow the UNIX convention of using the library name, not including 'lib'. So, for example "iberty" for "libiberty", which for the uix ``cc`` and ``ld`` convention would imply a command line option of ``-Liberty``

  The reference implementation follows this convention.

  For an AURA subsystem that relies on libiberty, it should have a manifest with a declaration for ``Build.External_Libraries`` that contains a constant string with the value "iberty".

The name of the constant String objects if ignored by the AURA implementation, but should typically be descriptive enough to maximize readability.

Empty strings are ignored, which is useful when the requirement of an external library is conditional, depending on the configuration.

.. note::
  In the above example that the value of ``LibreSSL_libtls`` is declared with a conditional expression that is based on the value of ``Configuration.Enable_TLS``. This is the recommended application of user configuration, using the ``Configuration`` package.

The Ada Package
^^^^^^^^^^^^^^^

.. literalinclude:: snippets/aura-inet.build-ada.ads
  :language: ada

The ``Build.Ada`` package supplies subsystem-specific configuration for the building of Ada sources.

Currently AURA only specifies a further nested package ``Compiler_Options``.

.. _ada_compiler_options_description:

The ``Compiler_Options`` nested package should contain a number of constant String declarations, where each one represents a specific option to pass to the Ada compiler.

.. note::
  In the above example, the GNAT-specific option ``-gnatwG`` is included. Notice how the object is given the descriptive name ``Ignore_Unknown_Pragmas``. This is included because the AURA specification includes a new ``pragma External_With`` used by AURA subsystems to include non-Ada units in their codebase.

.. seealso::
  See this section [Need Ref] for more discussion on the new ``pragma External_With``, and how to include non-Ada sources in an AURA subsystem.

The C Package
^^^^^^^^^^^^^

.. literalinclude:: snippets/aura-inet.c.ads
  :language: ada

The ``Build.C`` package supplies subsystem-specific configuration for the building of C sources, and is a particularly powerful tool in the integration of C sources in AURA subsystems.

Currently, AURA specifies two further nested packages: ``Compiler_Options`` and ``Preprocessor_Definitions``.

``Build.C.Compiler_Options``
  This functions identically as it does for ``Build.Ada.Compiler_Options``, as discussed :ref:`above <ada_compiler_options_description>`, except that it applies only to the C compiler.

``Build.C.Preprocessor_Definitions``
  This package is the most interesting and powerful tool for the integration of C sources.

  Like most of the other nested packages, the ``Preprocessor_Definitions`` package should contain a series of constant String declarations. Each String causes the content of that string to be "defined" for any C sources in the subsystem's codepath [Ref Needed].

  For example, if the ``INET`` AURA subsystem is built on MacOS, ``AURA.Platform_Flavor`` will have a value of "darwin", which will cause ``Build.C.Darwin`` to evaluate to "__INET_OS_DARWIN". This will cause all C sources that are part of the ``INET`` subsystem to be (in effect) compiled with ``#define __INET_OS_DARWIN``. 

.. note::
    If any of the constant String declarations of ``Build.C.Preprocessor_Definitions`` evaluate to a *null string*, AURA will ignore that declaration. Therefore (as in the above example), if a preprocessor definition should not be made in some cases, it should be set to a *null string*.

The Codepaths Nested Package
----------------------------

.. literalinclude:: snippets/aura-inet.codepaths.ads
  :language: ada

The ``Codepaths`` nested package is perhaps the most powerful single feature of AURA subsystem autoconfiguration. ``Codepaths`` allow the actual codebase to be selected through the autoconfiguration process. Among other things, this allows platform-specific code to be selected automatically for the target platform when the code is selected. In the above INET example, it is also used to include the additional TLS code when that option is enabled.

While the ``Codebase`` mechanics are implementation-defined, the required behavior strongly hints at the typical implementation, and the recommended implementation is that of the reference implementation.

The ``Codepaths`` package consists of any number of static String declarations. Each declaration that evaluates to a non-*null string* refers to some collection of library units, and/or other further collections. For the reference implementation, these declarations should evaluate to UNIX-style paths, without leading '/'. These paths should index subdirectories of the subsystem's own subdirectory.

For the ``INET`` example, we see that if TLS is enabled (``Configuration.Enable_TLS = True``), the immediate source code of the ``tls`` subdirectory should be included.

.. note::
  Any subdirectories of a selected Codepath are **not** automatically included. These must be explicitly selected if they are to be included as well.

Codepaths can be of any depth. In the ``INET`` example, we see that all platforms have a base ``ip_lookup`` codepath (subdirectory), which further contains ``addrinfo_posix`` and ``addrinfo_bsd``. These second-level subdirectories are selected base on the platform. It is important to note that the content of these second-level subdirectories would **not** be entered if not explicitly given as a codepath. That is to say, if only ``IP_Lookup_Base`` was declared, the contents of ``addrinfo_posix`` and ``addrinfo_bsd`` would **not** be included.

The ``Codepaths`` mechanisms, when combined with the autoconfiguration mechanics, and the ability of a subsystem to *with* its own configuration package, provides the full compliment of capabilities to the Ada environment that can be achieved with *autotools* and C preprocessor definitions in the traditional UNIX development workflow. Generally speaking, the configuration package itself can be used to control static conditionals in the Ada codebase, and ``Codepaths`` can be used to select from implementation specific implementations (such as alternate unit bodies or subunits).