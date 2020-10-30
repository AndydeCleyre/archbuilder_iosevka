Personal Builder for the Iosevka Term Font
==========================================

This repo has a GitHub Workflow which can build the
ttf-iosevka-term-custom-git_ package from the AUR, for the incredible
Iosevka_ font.

The built package can be installed on Arch Linux with ``sudo pacman -U``,
or you can simply extract the fonts with your favorite archive tool for use on
any system.

If you want to use it to have GitHub build your custom configuration:

#. Fork this repo on GitHub
#. Clone your fork, with submodules, and enter the repo folder
#. Copy the example configuration to the repo root as ``private-build-plans.toml``
#. Edit that to your liking, and commit it
#. Tag the commit with any name starting with ``r<number>``, and push the tag

.. code:: console

  $ git clone --recursive <your-github-fork>
  $ cd archbuilder_ttf-iosevka-term-custom-git
  $ cp ttf-iosevka-term-custom-git/private-build-plans.toml.example private-build-plans.toml
  $ $EDITOR private-build-plans.toml
  $ git add private-build-plans.toml
  $ git commit private-build-plans.toml -m "much better now"
  $ git tag r123-awesome-build-label
  $ git push --tags

You can watch the build process in your ``Actions`` tab, and after ~30 minutes
find the built font in your ``Releases``.

The AUR PKGBUILD is included here as a git submodule,
so if you want to fetch an update for that:

.. code:: console

  $ cd ttf-iosevka-term-custom-git
  $ git checkout master
  $ git pull
  $ cd ..
  $ git commit ttf-iosevka-term-custom-git -m "pull newer pkg submodule"

.. _ttf-iosevka-term-custom-git: https://aur.archlinux.org/packages/ttf-iosevka-term-custom-git
.. _Iosevka: https://github.com/be5invis/Iosevka/
