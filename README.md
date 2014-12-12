# Base-Auth

The aim is to have a complete authentication and authorization boilerplate system in order to speed up the creation of new applicaitons.

It uses Bootstrap 3.2.0, Angular 1.2.25 and RequireJS 2.1.

## Why Angular and RequireJS?

This may seems confusing at first, but they work nicely together after you grasp what each one does.

The RequireJS will load the files - each Angular module lives in an independent file. During the development time it shows what files have errors and makes it much faster. For production it should be concatenated and minified, but still RequireJS will guarantee that all the modules will be available before calling for it.