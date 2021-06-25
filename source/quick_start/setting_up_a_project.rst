Setting up a Project
====================

AURA projects themselves start simply as any subdirectory, optionally with the project's core sourcecode.

.. seealso::
    
    To learn more about what defines a project for this reference implementation, please see the :doc:`<../concepts/projects>` explainer.

Let's make a quick directory

.. prompt:: bash $

    mkdir hello_world
    cd hello_world

This is really all it takes to create a new AURA project - just a subdirectory!

The classic Hello World
-----------------------

Let's begin by first writing out the typical Ada hello world example.

Open a file *hello.adb* in your favourite editor, and enter the following code:

.. literalinclude:: snippets/hello.adb
    :language: ada
    :linenos:

Run it
------

.. prompt:: bash $

    aura run hello

Which should produce an output like this:

.. figure:: /_static/images/quick_start/runhello1.png
    :target: /_static/images/quick_start/runhello1.png
    :align: center

The first time we run the AURA CLI , it will initialize the project with the AURA-specific files, if missing. This includes the AURA root package (aura.ads), as well as the auto-generated local Respository_1 repository configuration package (aura-repository_1.ads), and will then attempt to "checkout" all required subsystems from the configured repositories.

In this example, since we are relying only on the Ada standard library, there are no other dependencies, and aura is able to build the program without the need for any repositories.
