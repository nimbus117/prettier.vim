Format the current buffer using [prettier](https://prettier.io/).

```vim
:Prettier
```
By default the whole buffer is formatted.

Optionally a range and parser argument can be supplied.

The following will format line 10 to line 20 in the current buffer using the
html parser.

```vim
:10,20Prettier html
```

Use tab completion to see all the available parsers.
