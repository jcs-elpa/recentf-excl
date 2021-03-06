[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![JCS-ELPA](https://raw.githubusercontent.com/jcs-emacs/badges/master/elpa/v/recentf-excl.svg)](https://jcs-emacs.github.io/jcs-elpa/#/recentf-excl)

# recentf-excl
> Exclude commands for recent files

[![CI](https://github.com/jcs-elpa/recentf-excl/actions/workflows/test.yml/badge.svg)](https://github.com/jcs-elpa/recentf-excl/actions/workflows/test.yml)

## 🔧 Usage

First set the commands you don't want `recnetf` to track:

```elisp
(setq recentf-excl-commands '(ediff-find-file))
```

Then enable the minor mode:

```elisp
(recentf-excl 1)
```

## Contribute

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Elisp styleguide](https://img.shields.io/badge/elisp-style%20guide-purple)](https://github.com/bbatsov/emacs-lisp-style-guide)
[![Donate on paypal](https://img.shields.io/badge/paypal-donate-1?logo=paypal&color=blue)](https://www.paypal.me/jcs090218)

If you would like to contribute to this project, you may either
clone or make pull requests to this repository. Or you can
clone the project and establish your branch of this tool.
Any methods are welcome!
