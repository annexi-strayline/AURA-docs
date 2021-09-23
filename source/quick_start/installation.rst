Building and Installation
=========================

Building and installation is very simple given the :doc:`prerequisites <prerequisites>` are met.

The AURA reference implementation CLI program is a single executable, and may be installed anywhere the user desires (preferably somewhere under PATH$).

Config and Build
----------------

The AURA CLI program itself is dependent on ANNEXI-STRAYLINE's 'ASAP' AURA repository, however these required components are included in the AURA CLI repository as submodules.

1. Clone the repo and checkout submodules
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. prompt:: bash $

    git clone --recurse-submodules https://github.com/annexi-strayline/aura.git

2. Build it
^^^^^^^^^^^

.. prompt:: bash $

    cd AURA
    ./build.sh

The build script executes two steps:

#. Runs a configuration Python script (platform_config.py) which generates the base AURA target platform configuration base files *platform_info.h* and *platform_info.ads*. These base files are used to configure AURA according to the target.
#. Executes gnatmake -j0 to build the AURA binary in parallel

.. note::
    Additional features are planned to give the user the ability to set the target triplet to build the AURA CLI for cross-compilation targets.

Install
-------

Place the resulting *aura* executable where appropriate, typically somewhere under PATH$.
