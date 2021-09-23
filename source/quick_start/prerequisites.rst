Prerequisites
=============

Ada compiler
------------

The ANNEXI-STRAYLINE AURA reference implementation is very portable and has dependencies. The current beta release of AURA is targeted at `FSF GCC's Ada compiler (GNAT) <https://gcc.gnu.org/>`_, with a recommended version of 10.3.0.

.. note::
    **Container Cursor Patch**

    For the recommended GCC 10.3.0, there happens to be a bug in the Ada standard library implementation of some container types. This bug impacts the functioning AURA, though not critically.

    Without a patch for this bug, AURA will not be able to consistently avoid unnecessary recompilation.

    The fix for this bug has been accepted into mainline GCC (but not GCC 10.3.0). The patch is compatible with the 10.3.0 codebase, and can be obtained from the official `commit <https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=5b4b66291f2086f56dc3a1d7df494f901cd0b63e>`_.

    If using ANNEXI-STRAYLINE's pre-built FSF GCC packages (see below), this patch has already been applied.

Pre-built Binary GCC Builds
    ANNEXI-STRAYLINE maintains a number of pre-built binary tarball distributions of FSF GCC with Ada support (GNAT), among other packages. AURA only requires the base GCC build, and does not require gprbuild or any other AdaCore-maintained packages.

    A list of prebuilt FSF GCC Ada compiler packages can be found `here <https://github.com/annexi-strayline/gnat-packs>`_.

Python
------

The target system should have Python 3 installed to permit the installation scripts to self-configure.

.. note::
    If the command ``python`` does not invoke Python 3, it should be aliased to do so when running the build script.

Other Dependencies
------------------

Depending on the platform, other libraries and packages may need to be installed, and include:

* iconv
* binutils

