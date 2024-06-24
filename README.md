# assertutils.h
A tiny C logging library which also implements exceptions and assertions

![Screenshot_2024-06-22_03-26-05](https://github.com/TsukiGva2/assertutils/assets/71048858/b453759f-352d-48eb-a297-d4a779a07fd3)

# Objective

This project started out at work when i needed a quick and simple logging tool, without the need for excessive configuration and
setup. After some thinkering i came up with this implementation, which made me really happy.

I also must admit that i'm not really proficient at C programming AT ALL, this project will be kept really simple and minimal,
with only some portability tweaks here and there (PRs welcome! 😍)

# Building instructions

run:

    $ cmake -B build && cd build && make

if you wish to install the library to your system, do that step and then `make install` afterwards, this will install the library
to `/usr/local/lib/assertutils` and the header files to `/usr/local/include/assertutils/`.

Remember to run:

    # ldconfig /usr/local/lib/assertutils/

Or whatever directory you installed the library to.

The examples were removed until i figure out CMake for good, feel free to play around and use it in your own code (do not use it on production!).
Do consider opening a pull request (or an issue) if you find weird/unexpected behaviour.

# Platform support

This project is a work in progress, the current version is only a simple prototype, I do intend to correctly handle different platforms at a later stage,
but that requires some things to be done first, which takes us to the next section:

## TODOs (PRs welcome)

- [X] Improve the build system (don't look at the Makefile, it's frightening)
- [ ] Reduce the macro abuse in assertutils.h
- [ ] Plan a better error checking model
- [ ] Add tests
- [ ] Make the code more portable (the only things in the way right now really are the colors)
