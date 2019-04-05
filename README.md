# dotemacs #

## Clean test

Occasionally, I like to test my init files from a clean environment so
I know I haven't messed something up along the way. To do this, I do
the following:

1. Close Emacs
1. Checkout the git revision you think should work (start with master)
1. Clean the existing ELPA compiled directory

        ~/src/dotemacs $ rm -rf elpa
1. Start Emacs

Repeat all steps until you get a clean launch. If you don't get a
clean start, go back to a previous revision in the git log until
you do.

It would be nice to have something like a build server that would
perform a "clean build" on all new configuration changes.
