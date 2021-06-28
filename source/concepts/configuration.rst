User Configuration
==================

All user configuration of an ARUA project is completely and visibly contained within the project root. Unlike package managers such as *pip* and *npm*, AURA does not store fetched "packages" (subsystems) anywhere except for in the project roots of projects that require them. This ensures that projects remain self-contained, highly auditable, portable, and consistent. The intent is to follow the Ada philosophy of safety and reliability.