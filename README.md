Auto run Nextclade/align bump via:

```bash
gh workflow run -R corneliusroemer/bioconda-recipes 16061415
gh run view  -R corneliusroemer/bioconda-recipes -w
git fetch --all
git checkout update/nextalign-2.2.0
gh pr create
git checkout update/nextalign-2.2.0
gh pr create
```

Click on 

![](https://raw.githubusercontent.com/bioconda/bioconda-recipes/master/logo/bioconda_monochrome_small.png
 "Bioconda")

# The bioconda channel

[![Gitter](https://badges.gitter.im/bioconda/bioconda-recipes.svg)](https://gitter.im/bioconda/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

[Conda](http://anaconda.org) is a platform- and language-independent package
manager that sports easy distribution, installation and version management of
software.  The [bioconda channel](https://anaconda.org/bioconda) is a Conda
channel providing bioinformatics related packages for **Linux** and **Mac OS**.
This repository hosts the corresponding recipes.

## User guide

Please visit https://bioconda.github.io for details. 

## Developer guide

Please visit the new docs at https://bioconda.github.io/contributor/index.html for details.

