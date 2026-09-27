# Assignment Checker

A tiny stand-in for the kind of automated checker used to grade assignments:
it builds the application in [`src/`](src/) and compares its output against
the reference outputs in [`tests/`](tests/).

Run it locally with:

```console
./check.sh
```

The point of the exercise in the workshop `README.md` is to run this same
script *inside a container*, so that the build and the tests do not depend
on what happens to be installed on your machine.
