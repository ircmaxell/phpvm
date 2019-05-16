# PHPVM

This project is currently an experiment. It will likely break your system.

You have been warned.

## Installation

Clone this repository somewhere on your device (I'd recommend something like `~/.phpvm` but it should work anywhere you have write privliges).

Run composer install on the directory.

```console
me@local:path/to/phpvm$ composer install
```

Then run with an existing PHP install

```console
me@local:~$ php path/to/phpvm/bin/phpvm setup
```

This will edit your `~/.profile` file to adjust the path, as well as initialize its configuration files.

Restart your terminal.

Finally, if you're on Ubuntu, you can install the compile dependnecies automatically (this requires sudo):

```console
me@local:~$ phpvm install-dependencies
```

It will propt for your sudo password. If you're unconfortable with that, you can manually install the dependencies. Just look at the `phpvm` file for information.

## Installing new versions of PHP

To install new versions, you can run `phpvm install`:

```console
me@local:~$ phpvm install 7.3.5
// installing 7.3.5, will take a few minutes
```

## Listing installed versions

You can list all installed versions with the `list` command:

```console
me@local:~$ phpvm list
✓ 7.2.17
✓ 7.3.5
✓ 7.1.2
```

## Switching versions

Switching versions is done by the `use` command:

```console
me@local:~$ phpvm use 7.3.5
me@local:~$ php -v
PHP 7.3.5 (cli) (built: May 16 2019 18:00:08) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.3.5, Copyright (c) 1998-2018 Zend Technologies
```

## Automatically switching versions

You can also have it automatically switch versions depending on which folder you are in (the current working directory).

It will recursively scan for a `.php-version` file. If it finds one, it will use the install specified inside.

Therefore, if you have multiple projects, each requiring a seperate version of PHP, you can have it automatically switch when you `cd` between the projects.

Imagine the following structure:

* ~/foo
* ~/foo/baz

If we add a `.php-version` inside of `/home/foo` with the contents of `7.1.2`, then the following will result:

```console
me@local:~$ php -v
PHP 7.2.17
me@local:~$ cd foo
me@local:~/foo$ php -v
PHP 7.1.2
me@local:~/foo$ cd baz
me@local:~/foo/baz$ php -v
PHP 7.1.2
me@local:~/foo/baz$ cd ../..
me@local:~$ php -v
PHP 7.2.17
```

And so on.

Note: if a `.php-version` file is found, it will always override the `phpvm use` version. if you really need to override it, you can manually do so using the `PHP_OVERRIDE` environment variable:

```console
me@local:~$ php -v
PHP 7.2.17
me@local:~$ cd foo
me@local:~/foo$ php -v
PHP 7.1.2
me@local:~/foo$ PHP_OVERRIDE="7.3.5" php -v
PHP 7.3.5
```

## Composer, etc

Composer should work out of the box, supporting whatever version is currently in use.

## Extensions

Currently, extensions aren't supported. Consider this a todo.

# TODO:

* Support non-Ubuntu distros for dependency installation
* Support extensions
* Support non-compiled versions of PHP (package installed)
* And a lot more...