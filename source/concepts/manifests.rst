Subsystem Manifests
===================

Each AURA subsystem can *optionally* include a special library unit called the *manifest*. This is an Ada package that is the first child of the subsystem root package itself, with a name "AURA". For example, for a the CLI subsystem in our :doc:`quick start example </quick_start/using_an_aura_package>`, the *AURA manifest* would be declared like this:

.. code-block:: ada

  package CLI.AURA is
    ..

If included, manifests are copied to the project root as-is (spec and body), except that they are renamed as direct children of the AURA package with the subsystem name. As with the root AURA package, any AURA subsystem can then *with* this unit to access the configuration properties.

In the example above, the CLI manifest would be converted into a unit in the project root that would be declared as follows:

.. note::
  Since the AURA package is Pure, manifest packages must also be Pure. This is by design, and limits what manifest packages can do during autoconfiguration. This is both a safety/security feature, and encouragement to create AURA packages that build more efficiently and reliably.

.. code-block:: ada

  package AURA.CLI is
    ..

Manifest should contain sufficient comments to allow the user to make their own modifications to the configuration of the subsystem once :doc:`checked-out <repositories>`.



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

.. literalinclude:: snippets/aura-inet.build-externlibs.ads
  :language: ada

The ``Build`` nested package is used to control the build and linking of projects that depend on the subsystem, and itself contains a number of specific AURA-recognized packages.

The External_Libraries Package
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``Build.External_Libraries`` package can contain any number of constant String declarations which declare the linker/compiler-recognized library name. 

.. note::
  The AURA implementation is advised to generally follow the UNIX convention of using the library name, not including 'lib'. So, for example "iberty" for "libiberty", which for the uix ``cc`` and ``ld`` convention would imply a command line option of ``-Liberty``

  The reference implementation follows this convention.

  For an AURA subsystem that relies on libiberty, it should have a manifest with a declaration for ``Build.External_Libraries`` that contains a constant string with the value "iberty".

The name of the constant String objects if ignored by the AURA implementation, but should typically be descriptive enough to maximize readability.

Empty strings are ignored, which is useful when the requirement of an external library is conditional, depending on the configuration.

Note in the above example that the value of ``LibreSSL_libtls`` is declared with a conditional expression that is based on the value of ``Configuration.Enable_TLS``. This is the recommended application of user configuration.

