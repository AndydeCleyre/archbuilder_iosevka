Personal Builder for the Iosevka Font
=====================================

|build-status|

This repo has a GitHub Workflow which can build Arch Linux
packages for the incredible Iosevka_ font.

The built package can be installed on Arch Linux with ``sudo pacman -U``,
or you can simply extract the fonts with your favorite archive tool for use on
any system.

.. contents::
   :depth: 1

How to Use
----------

If you want to have GitHub build your custom configuration:

#. Fork this repo on GitHub
#. Clone your fork locally
#. Edit ``vars.yml`` to your liking
#. Activate a Python virtual environment to match ``requirements.txt``
#. Regenerate ``buildpkg.yml``
#. Commit the changes
#. Create and push a tag starting with ``r<number>``

.. code:: console

  $ git clone <your-github-fork>
  $ cd archbuilder_iosevka
  $ $EDITOR vars.yml
  $ # activate a new virtual environment (see next section)
  $ ./mk/buildpkg.yml.sh
  $ git commit vars.yml .github/workflows/buildpkg.yml -m "much better now"
  $ git tag r123-awesome-build-label
  $ git push --tags

You can watch the build process in your ``Actions`` tab, and after ~30 minutes
find the built font in your ``Releases``.

Python Virtual Environment
--------------------------

We use a small Python environment to render the Workflow (``buildpkg.yml``)
from an included template, using the data in ``vars.yml``.

You can create and activate a virtual environment in your favorite way,
as long as it has the packages listed in ``requirements.txt``.

Two possible methods are described below.

Using Python's ``venv`` Directly
++++++++++++++++++++++++++++++++

.. code:: console

  $ python3 -m venv venv
  $ . ./venv/bin/activate
  $ python -m pip install -r requirements.txt

Using zpy
+++++++++

zpy_ is a set of helpers for managing Python venvs and packages, with Zsh and pip-tools_.

.. code:: console

  % envin

.. _ttf-iosevka-term-custom-git: https://aur.archlinux.org/packages/ttf-iosevka-term-custom-git
.. _Iosevka: https://github.com/be5invis/Iosevka/
.. _zpy: https://github.com/andydecleyre/zpy
.. _pip-tools: https://github.com/jazzband/pip-tools

.. |build-status| image:: https://github.com/AndydeCleyre/archbuilder_iosevka/workflows/Build%20and%20upload%20Arch%20Linux%20packages/badge.svg
   .. :alt: Build Status
   .. :target: https://github.com/AndydeCleyre/archbuilder_iosevka/actions
