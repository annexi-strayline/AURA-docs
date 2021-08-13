*Compile*
=========

Usage
-----

.. prompt:: bash $

  aura compile [-no-pic] [-debug] [-assertions] [-optimize-(1/2/3/size/debug)]

The ``compile`` command compiles all object code for all units within the project. On subsequent invocations of ``compile`` after an invocation of :doc:`clean </cli/clean_command>`, ``compile`` only re-compiles units that need to be recompiled, based on any changes to the project sources. The AURA CLI does this intelligently by combining the full unit dependency maps with Ada separate compilation semantics.

.. note::
  ``Compile`` implicitly invokes :doc:`checkout </cli/checkout_command>`

.. note::
  ``Compile`` does **not** invoke the binder, nor does it link the final executable.

.. _ref_compile_command_options:

Options
~~~~~~~

-no-pic
  By default, the AURA CLI compiles all units into Position-Independent Code (PIC). This option overrides this behavior.

-debug
  This instructs the compiler to make object code that contains extra debugging symbols. It is typically unadvisable to apply any optimization when using this option, except for *-optimize-debug*.

-assertions
  This instructs the Ada compiler to enable all assertions in the Ada code. This typically activate checking for all Ada contracts such as ``pragma assert``, pre- and post-conditions, and subtype predicates.

-optimize-(1/2/3/size/debug)
  Enables the standard compiler optimization levels. These correspond directly with the compiler's optimization options.

.. warning::
  Enabling all assertions via a compiler option is not behaviour specified by the Ada standard. Since AURA CLI is simply a compiler driver, it cannot enforce exactly which assertions are forced on with the *-assertions* flag.

  For assertions that are intended to be used in production, please use Ada's ``pragma Assertions``, which does have specified behavior. The *-assertions* option is intended for testing phases of development.

  When driving GCC (GNAT), *-assertions* causes the *-gnata* option to be passed to gcc.

Tips
----

``Compile`` is particularly useful during the typical phase of Ada development when the compiler finding all of your thousands mistakes. The AURA CLI provides clearly formatted output from the units that failed to compile. The intelligent recompilation feature together with the highly parallelized design of the AURA reference implementation, this can be much quicker than more traditional approaches. When needing to attempt a compile many dozens of times, this can make a big difference.