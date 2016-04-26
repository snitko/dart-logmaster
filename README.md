Logmaster
=========

A logger intended to catch exceptions or simply report activity,
then post it to a server or store locally fo further inspection.

The idea is that catching errors and forming error messages is separate from
actually reporting them. By loading report-adapters on demand, we can use this library
both in the backend and in the frontend.
