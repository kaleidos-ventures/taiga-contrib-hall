Taiga contrib hall
===================

The Taiga plugin for hall integration.

Installation
------------

### Taiga Back

In your Taiga back python virtualenv install the pip package `taiga-contrib-hall` with:

```bash
  pip install taiga-contrib-hall
```

Modify your settings/local.py and include the line:

```python
  INSTALLED_APPS += ["taiga_contrib_hall"]
```

The run the migrations to generate the new need table:

```bash
  python manage.py migrate taiga_contrib_hall
```

### Taiga Front

Download in your `dist/js/` directory of Taiga front the `taiga-contrib-hall` compiled code:

```bash
  cd dist/js
  wget "https://raw.githubusercontent.com/taigaio/taiga-contrib-hall/stable/front/dist/hall.js"
```

Include in your dist/js/conf.json in the contribPlugins list the value `"/js/hall.js"`:

```json
...
    "contribPlugins": ["/js/hall.js"]
...
```
