# util-scripts

## install

```bash
git clone github.com/jyury11/util-scripts

cd util-scripts && make install
```

## example

### execute script

```bash
$ util hello
hello
```

### print script

```bash
$ util cat hello
#!/bin/bash
# print heloo
set -e

echo hello
```

### sercah script and execute script

```bash
util serach
```

## help

```bash
$ util help
util [ RootCommand | Command ]

RootCommand
  cat [ Command ]                cat script
  update                         update all script
  search                         serach script & exec script

Command
  print comannd help
    :
    :
```
