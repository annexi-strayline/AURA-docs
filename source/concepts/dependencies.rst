Dependencies
============

For any given :doc:`project <projects>`, all Ada units are scanned for their dependencies, including units within :ref:`checked-out <concepts_repositories_checkout>` AURA subsystems. which is used to build a dependency map. Dependencies that are not available cause an attempt to :ref:`checkout <concepts_repositories_checkout>` the missing subsystem from any available repository.

For the reference implementation, this is achieved iteratively. First all root units (in the root of the project subdirectory) are scanned. Any missing units cause an attempt to :ref:`check-out <concepts_repositories_checkout>` the subsystem to which that unit would belong. If that checkout succeeds, all units within the (:doc:`configured ` <autoconfiguration>) subsystem are then scanned. This process repeats until either all units become available, or else a required subsystem fails to be :ref:`checked-out <concepts_repositories_checkout>`.

Including Non-Ada Sources
-------------------------

For the most part, dependencies are given through normal Ada `context clauses <http://ada-auth.org/standards/rm12_w_tc1/html/RM-10-1-2.html>`_ (``with`` clauses).

AURA, like Ada itself, is standardized specifically to operate in a mixed-language environment.

AURA provides a mechanism for an Ada source to specify that some non-Ada unit is a dependency of that unit. To achieve this, 