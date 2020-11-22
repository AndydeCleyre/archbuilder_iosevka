Personal Builder for the Iosevka Font
=====================================

|build status|

This repo has a GitHub Workflow which can build Arch Linux
packages for the incredible Iosevka_ font.

The built package can be installed on Arch Linux with ``sudo pacman -U``,
or you can simply extract the fonts with your favorite archive tool for use on
any system.

.. contents::
   :depth: 1

How to Use
----------

If you want to have GitHub build your custom configuration,
fork this repo on GitHub, then:

- get a local copy

.. code:: console

   $ git clone <your-github-fork>
   $ cd archbuilder_iosevka

- configure your font

.. code:: console

   $ $EDITOR vars.yml

- activate a `Python Virtual Environment`_ matching ``requirements.txt``, e.g.:

.. code:: console

   $ python3 -m venv venv
   $ . ./venv/bin/activate
   $ python -m pip install -r requirements.txt

- generate your new workflow

.. code:: console

   $ ./mk/buildpkg.yml.sh

- tag your changes as a release (start tag with 'r<number>'), and push

.. code:: console

   $ git commit vars.yml .github/workflows/buildpkg.yml -m "much better now"
   $ git tag r123-awesome-build-label
   $ git push --tags

You can watch the build process in your ``Actions`` tab, and after ~30 minutes
find the built font in your ``Releases``.

Python Virtual Environment
--------------------------

We use two small Python tools to render the Workflow (``buildpkg.yml``)
from an included template, using the data in ``vars.yml``.

You can create and activate a virtual environment in your favorite way,
as long as it has the packages listed in ``requirements.txt``.

Some methods are described below.

Python's ``venv`` Directly
++++++++++++++++++++++++++

.. code:: console

   $ python3 -m venv venv
   $ . ./venv/bin/activate
   $ python -m pip install -r requirements.txt

zpy
+++

zpy_ is a toolset for managing Python venvs and packages, with Zsh and pip-tools_.

Either create and activate a venv matching ``requirements.txt``:

.. code:: console

   % envin

or install the necessary tools (wheezy.template, yamlpath) into their own isolated venvs,
adding links to the relevant scripts (``wheezy.template``, ``yaml-get``) to your ``PATH``:

.. code:: console

   % pipz install --cmd wheezy.template,yaml-get wheezy.template yamlpath

pipenv
++++++

.. code:: console

   $ pipenv shell
   $ pipenv install

pipx
++++

.. code:: console

   $ pipx install wheezy.template yamlpath


.. _ttf-iosevka-term-custom-git: https://aur.archlinux.org/packages/ttf-iosevka-term-custom-git
.. _Iosevka: https://github.com/be5invis/Iosevka/
.. _zpy: https://github.com/andydecleyre/zpy
.. _pip-tools: https://github.com/jazzband/pip-tools

.. |build status| image:: https://github.com/AndydeCleyre/archbuilder_iosevka/workflows/Build%20and%20upload%20Arch%20Linux%20packages/badge.svg
   :alt: Build Status
   :target: https://github.com/AndydeCleyre/archbuilder_iosevka/actions
