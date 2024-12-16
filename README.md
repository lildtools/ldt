# ldt

### Reference Documentation

* [Official Git Documentation](https://git-scm.com/doc)

### Additional Links

* [Git submodules](https://git-scm.com/docs/git-submodule)
* [Ignore files from Git](http://help.github.com/ignore-files)

---

## Development

### Prerequisites

* [Git](https://git-scm.com/download)

#### Submodules

##### Connect

```sh
git submodule add --name submoduleName -- https://gitlab.com/group/repository.git path/to/submodule/
```

##### Synchronize

```sh
git submodule sync --recursive
```

```sh
git submodule update --init --recursive
```
