# sphinx-builder
Github Action to build Sphinx source files as static pages.

## Configurations

| Input | Default | Description
| --- | --- | ---
| source_root | docs/source | Root directory of source to build.
| build_root | docs/build | Root directory for build output.
| default_lang | en | The default language, which will be placed under the build directory, no subdirectory will be created.
| lang_mappings | '' | Newline-separated list of folder & language mappings to build (refer to [Multiple languages](#multiple-languages). If you don't provide one, will use Makefile's SOURCEDIR & BUILDDIR to determine.

## Usage

### One language only

```yaml
jobs:
  build:
    name: Build MkDocs Pages
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Build Pages
        uses: Kjuly/sphinx-builder@main
```

Folder structure:
```sh
/docs
    /source
    /build
```

### Multiple languages

```yaml
uses: Kjuly/sphinx-builder@main
with:
  default_lang: en
  lang_mappings: |-
    en:en
    zh-Hans:zh_CN
```

Folder structure:
```sh
/docs
    /source
        /en
        /zh-Hans
    /build
```

## Share & Override Config File

You can provide `_conf.py` to share and override `conf.py`. Below is a sample folder structure:

```sh
/source
    _conf.py  # Shared base config file.

    /en
        _conf.py  # Override config file for "en".
        conf.py   # The final generated config file for "en", which will be updated for each build process.
        ...       #   You don't need to provide it manually.

    /zh-Hans
        conf.py   # No "_conf.py" provided at the same level, will use "conf.py" as it was.
        ...
/build
```

---

The build page will be stored in `${{ github.workspace }}/build/html`.

For output usage, please refer to [Sphinx Publisher](sphinx-publisher), which will publish to Github Pages.


  [sphinx-publisher]: https://github.com/Kjuly/sphinx-publisher
