(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(abbrev-file-name "~/.emacs.d/abbrevs.el")
 '(clean-buffer-list-kill-never-buffer-names
   (quote
    ("*scratch*" "*Messages*" "*server*" "*Group*" "*Org Agenda*" "todo.txt" "dfinity.txt" "habits.txt" "Bahai.txt" "OSS.txt" "diary" "notes.txt" "&bitlbee")))
 '(clean-buffer-list-kill-never-regexps
   (quote
    ("^ \\*Minibuf-.*\\*$" "^\\*Summary" "^\\*Article" "^#")))
 '(clean-buffer-list-kill-regexps (quote (".*")))
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-buffer-done-function (quote kill-buffer))
 '(custom-file "~/.emacs.d/settings.el")
 '(custom-raised-buttons nil)
 '(custom-safe-themes
   (quote
    ("f56eb33cd9f1e49c5df0080a3e8a292e83890a61a89bceeaa481a5f183e8e3ef" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(font-lock-support-mode (quote jit-lock-mode))
 '(font-lock-verbose nil)
 '(frame-title-format
   (quote
    (:eval
     (concat
      (if buffer-file-name default-directory "%b")
      "    "
      (number-to-string
       (cdr
        (assq
         (quote width)
         (frame-parameters))))
      "x"
      (number-to-string
       (cdr
        (assq
         (quote height)
         (frame-parameters))))))) t)
 '(global-auto-complete-mode t)
 '(global-auto-revert-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(global-undo-tree-mode t)
 '(grep-command "egrep -nH -e ")
 '(grep-find-command
   "find . -name '*' -type f -print0 | xargs -0 -P8 egrep -nH ")
 '(grep-save-buffers t)
 '(history-delete-duplicates t)
 '(history-length 200)
 '(ibuffer-default-display-maybe-show-predicates t)
 '(ibuffer-expert t)
 '(ibuffer-formats
   (quote
    ((mark modified read-only " "
           (name 16 -1)
           " "
           (size 6 -1 :right)
           " "
           (mode 16 16)
           " " filename)
     (mark " "
           (name 16 -1)
           " " filename))))
 '(ibuffer-maybe-show-regexps nil)
 '(ibuffer-saved-filter-groups
   (quote
    (("default"
      ("Commands"
       (or
        (mode . shell-mode)
        (mode . eshell-mode)
        (mode . term-mode)
        (mode . compilation-mode)))
      ("Haskell"
       (or
        (mode . haskell-mode)
        (mode . haskell-cabal-mode)
        (mode . literate-haskell-mode)))
      ("Go"
       (mode . go-mode))
      ("Nix"
       (mode . nix-mode))
      ("C++"
       (or
        (mode . c-mode)
        (mode . c++-mode)))
      ("Lisp"
       (mode . emacs-lisp-mode))
      ("Dired"
       (mode . dired-mode))
      ("Gnus"
       (or
        (mode . message-mode)
        (mode . mail-mode)
        (mode . gnus-group-mode)
        (mode . gnus-summary-mode)
        (mode . gnus-article-mode)
        (name . "^\\.newsrc-dribble")
        (name . "^\\*\\(sent\\|unsent\\|fetch\\)")
        (name . "^ \\*\\(nnimap\\|nntp\\|nnmail\\|gnus\\|server\\|mm\\*\\)")
        (name . "\\(Original Article\\|canonical address\\|extract address\\)")))
      ("Org"
       (or
        (name . "^\\*Calendar\\*$")
        (name . "^\\*Org Agenda")
        (name . "^ \\*Agenda")
        (name . "^diary$")
        (mode . org-mode)))
      ("Magit"
       (or
        (mode . magit-status-mode)
        (mode . magit-log-mode)
        (name . "^\\*magit")
        (name . "git-monitor")))
      ("Emacs"
       (or
        (name . "^\\*scratch\\*$")
        (name . "^\\*Messages\\*$")
        (name . "^\\*\\(Customize\\|Help\\)")
        (name . "\\*\\(Echo\\|Minibuf\\)")))))))
 '(ibuffer-show-empty-filter-groups nil)
 '(ibuffer-shrink-to-minimum-size t t)
 '(image-dired-dir "~/.emacs.d/data/image-dired/")
 '(indent-tabs-mode nil)
 '(inhibit-startup-echo-area-message "jstolle")
 '(inhibit-startup-screen t)
 '(initial-major-mode (quote fundamental-mode))
 '(initial-scratch-message "")
 '(initsplit-customizations-alist
   (quote
    (("\\`\\(gnus\\|nn\\|message\\|mail\\|mm-\\|smtp\\|send-mail\\|check-mail\\|spam\\|sc-\\)" "~/.emacs.d/gnus-settings.el" nil nil)
     ("\\`\\(org-\\|deft-\\|cfw:\\)" "~/.emacs.d/org-settings.el" nil nil))))
 '(kill-do-not-save-duplicates t)
 '(kill-ring-max 500)
 '(kill-whole-line t)
 '(line-number-mode t)
 '(load-prefer-newer t)
 '(menu-bar-mode nil)
 '(midnight-delay 18000)
 '(midnight-mode t)
 '(moccur-following-mode-toggle nil)
 '(modelinepos-column-limit 80)
 '(ns-alternate-modifier (quote alt))
 '(ns-command-modifier (quote meta))
 '(ns-function-modifier (quote hyper))
 '(ns-right-alternate-modifier (quote alt))
 '(package-selected-packages
   (quote
    (phi-search-mc phi-search yasnippet-snippets java-snippets ivy-yasnippet go-snippets aws-snippets auto-yasnippet terraform-mode yaml-mode zenburn-theme aggressive-indent free-keys focus ace-mc markdown-mode+ flycheck persistent-scratch avy-zap avy auto-complete js3-mode multiple-cursors helpful web-server markdown-preview-mode solarized-theme helm-describe-modes dash-docs helm-descbinds async-await helm-dash helm csv-mode change-inner expand-region diminish-buffer magithub magit-imerge magit-popup magit term-manager multi-term use-package org-link-minor-mode ghub+ f el-mock diminish deferred anaphora ace-jump-mode)))
 '(parens-require-spaces t)
 '(password-store-password-length 24)
 '(persistent-scratch-autosave-interval 30)
 '(persistent-scratch-backup-directory "~/.cache/emacs/backups")
 '(persistent-scratch-file-name "~/.emacs.d/data/persistent-scratch" t)
 '(persistent-scratch-save-file "/Users/josh/.emacs.d/data/persistent-scratch")
 '(recentf-auto-cleanup 60)
 '(recentf-exclude
   (quote
    ("~\\'" "\\`out\\'" "\\.log\\'" "^/[^/]*:" "\\.el\\.gz\\'")))
 '(recentf-max-saved-items 2000)
 '(recentf-save-file "~/.emacs.d/data/recentf")
 '(redisplay-dont-pause t t)
 '(same-window-buffer-names
   (quote
    ("*eshell*" "*shell*" "*mail*" "*inferior-lisp*" "*ielm*" "*scheme*")))
 '(save-abbrevs (quote silently))
 '(save-interprogram-paste-before-kill t)
 '(save-kill-file-name "~/.emacs.d/data/kill-ring-saved.el" t)
 '(save-place-file "~/.emacs.d/data/places")
 '(savehist-additional-variables
   (quote
    (tablist-named-filter file-name-history sr-history-registry kmacro-ring compile-history)))
 '(savehist-autosave-interval 60)
 '(savehist-file "~/.emacs.d/data/history")
 '(savehist-ignored-variables (quote (load-history flyspell-auto-correct-ring kill-ring)))
 '(scroll-bar-mode nil)
 '(sentence-end-double-space nil)
 '(show-paren-delay 0)
 '(ssl-certificate-verification-policy 1)
 '(switch-to-buffer-preserve-window-point t)
 '(tab-always-indent (quote complete))
 '(temp-buffer-resize-mode t nil (help))
 '(text-mode-hook
   (quote
    (turn-on-auto-fill
     (lambda nil
       (ignore-errors
         (diminish
          (quote auto-fill-function)))))))
 '(tls-checktrust t)
 '(tls-program
   (quote
    ("openssl s_client -connect %h:%p -no_ssl2 -ign_eof -CApath /etc/postfix/certs -cert ~/Messages/me.pem")))
 '(tool-bar-mode nil)
 '(tramp-default-method "ssh")
 '(trash-directory "~/.Trash")
 '(undo-limit 800000)
 '(undo-tree-history-directory-alist (quote ((".*" . "~/.cache/emacs/backups"))))
 '(undo-tree-mode-lighter "")
 '(undo-tree-visualizer-timestamps t)
 '(url-cache-directory "~/.emacs.d/data/url/cache")
 '(url-configuration-directory "~/.emacs.d/data/url/")
 '(use-package-enable-imenu-support t)
 '(user-full-name "Josh Tolle")
 '(user-initials "jst")
 '(user-mail-address "josh@jstolle.com")
 '(visible-bell t)
 '(w3m-cookie-accept-bad-cookies (quote ask))
 '(w3m-default-display-inline-images t)
 '(w3m-fill-column 100)
 '(w3m-use-cookies t)
 '(warning-minimum-log-level :error)
 '(window-divider-default-bottom-width 1)
 '(window-divider-default-places (quote bottom-only)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
