Personal Builder for the Iosevka Font
=====================================

|build status|

This repo has a GitHub Workflow which can build Arch Linux
packages for the incredible Iosevka_ font.

The built package can be installed on Arch Linux with ``sudo pacman -U``,
or you can simply extract the fonts with your favorite archive tool for use on
any system.

To run the included scripts, you'll need ``python3-venv``.

.. contents::
   :depth: 1

How to Use
----------

If you want to have GitHub build your custom configuration,
fork this repo on GitHub, then:

- get a local copy:

  .. code:: console

     $ git clone <your-github-fork>
     $ cd archbuilder_iosevka

- configure your font (see the `character variants`_), either by editing ``vars.yml``:

  .. code:: console

     $ $EDITOR vars.yml

  or by `Using the Customizer Site`_.

- generate your new workflow:

  .. code:: console

     $ ./mk/buildpkg.yml.sh

- commit, tag, and push:

  .. code:: console

     $ git commit -am "whatever change message you want"
     $ git tag whatever-label-you-want
     $ git push && git push --tags

You can watch the build process in your ``Actions`` tab,
or using GitHub's CLI_:

.. code:: console

   $ gh run watch

After anywhere from 30-120+ minutes you can
get the built font from your ``Releases`` page, or:

.. code:: console

   $ gh release download -p '*'

Using the Customizer Site
-------------------------

There is now `an official web app`_ for configuring a build visually.

To use a configuration thus generated with this builder:

- in the customizer, leave the default Family Name ("Iosevka Custom")
- save the generated configuration as ``templates/private-build-plans.toml.wz``
- in ``vars.yml``'s ``build`` list, ensure the only uncommented item is ``ttf-iosevka-custom-git``,
  with either an editor:

  .. code:: console

     $ $EDITOR vars.yml

  or yamlpath's ``yaml-merge``:

  .. code:: console

     $ yaml-merge -A right -w vars.yml vars.yml <<<'{"build": ["ttf-iosevka-custom-git"]}'


.. _Iosevka: https://github.com/be5invis/Iosevka/
.. _character variants: https://github.com/be5invis/Iosevka/blob/main/doc/custom-build.md
.. _an official web app: https://typeof.net/Iosevka/customizer
.. _CLI: https://github.com/cli/cli

.. |build status| image:: https://github.com/AndydeCleyre/archbuilder_iosevka/workflows/Build%20and%20upload%20Arch%20Linux%20packages/badge.svg
   :alt: Build Status
   :target: https://github.com/AndydeCleyre/archbuilder_iosevka/actions
