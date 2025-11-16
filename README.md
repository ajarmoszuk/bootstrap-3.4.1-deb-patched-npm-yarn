# bootstrap-3.4.1-deb-patched

**Patched Bootstrap 3.4.1** from Debian Bullseye (`twitter-bootstrap3_3.4.1+dfsg-2+deb11u2`)  
Drop-in replacement for `bootstrap` version 3.4.1 in Yarn/npm.

---

## Requirements

- **Docker** (Linux, macOS, Windows)

---

## Build & Pack

```bash
./build.sh
```

Outputs: `bootstrap-debian-3.4.1-debian-bullseye-patched.tgz`

---

## Install

```bash
yarn add file:./bootstrap-debian-3.4.1-debian-bullseye-patched.tgz
```

---

## Usage

```js
require('bootstrap-debian');
```

```css
@import 'bootstrap-debian/css/bootstrap.min.css';
```

---

## Fixed CVEs

| CVE | Description |
|-----|-------------|
| **CVE-2025-1647** | XSS in Popover/Tooltip via prototype pollution |
| **CVE-2024-6485** | XSS in Button via `data-loading-text` |
| **CVE-2019-8331** | XSS in Tooltip/Popover via `data-template` |
| **CVE-2018-20676** | XSS in Tooltip via `data-viewport` |
| **CVE-2018-20677** | XSS in Affix via `data-offset` |
| **CVE-2016-10735** | XSS in Tooltip/Popover via `title` attribute |

All patched via **Debian LTS** (DLA-4124-1, DLA-4204-1).
