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

---

The build page will be stored in `${{ github.workspace }}/build/html`.

For output usage, please refer to [Sphinx Publisher](sphinx-publisher), which will publish to Github Pages.


  [sphinx-publisher]: https://github.com/Kjuly/sphinx-publisher
