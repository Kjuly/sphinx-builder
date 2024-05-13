# sphinx-builder
Github Action to build Sphinx source files as static pages.

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
> /src  
> /build

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
> /src  
> -- /en  
> -- /zh-Hans  
> /build  

## Share & Override Config File

You can provide `_conf.py` to share and override `conf.py`. Below is a sample folder structure:

```sh
/src  
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
