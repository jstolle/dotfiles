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
 '(doom-modeline-buffer-file-name-style 'truncate-upto-project)
 '(doom-modeline-python-executable "python")
 '(doom-modeline-icon t)
 '(doom-modeline-major-mode-icon t)
 '(doom-modeline-major-mode-color-icon nil)
 '(doom-modeline-minor-modes nil)
 '(doom-modeline-persp-name t)
 '(doom-modeline-lsp t)
 '(doom-modeline-github nil)
 '(doom-modeline-version t)
 '(doom-themes-enable-bold t)
 '(doom-themes-enable-italic t)
 '(doom-theme-name "doom-one")
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
 '(git-commit-mode-hook
   (quote
    (turn-on-auto-fill flyspell-mode git-commit-save-message)) t)
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
 '(ibuffer-use-other-window t)
 '(icicle-Completions-text-scale-decrease 0)
 '(icicle-apropos-cycle-next-keys (quote ([next] [(control 110)])))
 '(icicle-apropos-cycle-previous-keys (quote ([prior] [(control 112)])))
 '(icicle-incremental-completion nil)
 '(icicle-max-candidates 100)
 '(image-dired-dir "~/.emacs.d/data/image-dired/" t)
 '(imagemagick-render-type 1)
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
 '(next-line-add-newlines nil)
 '(ns-alternate-modifier (quote alt))
 '(ns-command-modifier (quote meta))
 '(ns-function-modifier (quote hyper))
 '(ns-right-alternate-modifier (quote alt))
 '(ovpn-mode-base-directory "~/.config/openvpn")
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("MELPA" . "https://melpa.org/packages/")
     ("Marmalade" . "https://marmalade-repo.org/packages/"))))
 '(parens-require-spaces t)
 '(password-store-password-length 24)
 '(persistent-scratch-autosave-interval 30)
 '(persistent-scratch-backup-directory "~/.cache/emacs/backups")
 '(persistent-scratch-file-name "~/.emacs.d/data/persistent-scratch" t)
 '(persistent-scratch-save-file "/Users/jstolle/.emacs.d/data/persistent-scratch")
 '(powerline-default-separator (quote arrow))
 '(powerline-image-apple-rgb t)
 '(pp^L-^L-string "                                            ")
 '(projectile-cache-file "~/.emacs.d/data/projectile.cache")
 '(projectile-completion-system (quote ivy))
 '(projectile-enable-caching t)
 '(projectile-file-exists-local-cache-expire 300)
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "dist" "\\`/nix/.+" ".*/\\..*")))
 '(projectile-globally-ignored-files (quote ("TAGS" "GPATH" "GRTAGS" "GTAGS" "ID")))
 '(projectile-ignored-project-function
   (lambda
     (path)
     (string-match "\\(:?\\`/\\(:?nix\\|tmp\\)\\|/\\.nix-profile\\)" path)))
 '(projectile-keymap-prefix "p")
 '(projectile-known-projects-file "~/.emacs.d/data/projectile-bookmarks.eld")
 '(projectile-other-file-alist
   (quote
    (("cpp" "h" "hpp" "ipp")
     ("ipp" "h" "hpp" "cpp")
     ("hpp" "h" "ipp" "cpp" "cc")
     ("cxx" "h" "hxx" "ixx")
     ("ixx" "h" "hxx" "cxx")
     ("hxx" "h" "ixx" "cxx")
     ("c" "h")
     ("m" "h")
     ("mm" "h")
     ("h" "c" "cc" "cpp" "ipp" "hpp" "cxx" "ixx" "hxx" "m" "mm")
     ("cc" "h" "hh" "hpp")
     ("hh" "cc")
     ("vert" "frag")
     ("frag" "vert")
     (nil "lock" "gpg")
     ("lock" "")
     ("gpg" "")
     ("mli" "ml")
     ("ml" "mli")
     ("hs-boot" "hs")
     ("hs" "hs-boot")
     ("nix" "exp")
     ("exp" "nix")
     ("go"))))
 '(projectile-project-search-path (quote ("~/src")))
 '(projectile-sort-order (quote recentf))
 '(recentf-auto-cleanup 60)
 '(recentf-exclude
   (quote
    ("~\\'" "\\`out\\'" "\\.log\\'" "^/[^/]*:" "\\.el\\.gz\\'")))
 '(recentf-max-saved-items 2000)
 '(recentf-save-file "~/.emacs.d/data/recentf")
 '(redisplay-dont-pause t t)
 '(regex-tool-backend (quote perl))
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
 '(smex-history-length 20)
 '(smex-save-file "~/.emacs.d/data/smex-items")
 '(sp-highlight-pair-overlay nil)
 '(sql-sqlite-program "sqlite3")
 '(ssl-certificate-verification-policy 1)
 '(svn-status-hide-unmodified t)
 '(switch-to-buffer-preserve-window-point t)
 '(tab-always-indent (quote complete))
 '(tags-apropos-verbose t)
 '(tags-case-fold-search nil)
 '(tail-max-size 25)
 '(tail-volatile nil)
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
 '(url-irc-function (quote url-irc-erc))
 '(use-package-enable-imenu-support t)
 '(user-full-name "Josh Tolle")
 '(user-initials "jst")
 '(user-mail-address "josh@jstolle.com")
 '(vc-command-messages t)
 '(vc-follow-symlinks t)
 '(vc-git-diff-switches (quote ("-w" "-U3")))
 '(vc-handled-backends (quote (GIT SVN CVS Bzr Hg)))
 '(vc-make-backup-files t)
 '(version-control t)
 '(visible-bell t)
 '(w3m-cookie-accept-bad-cookies (quote ask))
 '(w3m-default-display-inline-images t)
 '(w3m-fill-column 100)
 '(w3m-use-cookies t)
 '(warning-minimum-log-level :error)
 '(wdired-use-dired-vertical-movement (quote sometimes))
 '(wgrep-auto-save-buffer t)
 '(wgrep-enable-key "")
 '(whitespace-auto-cleanup t t)
 '(whitespace-line-column 80)
 '(whitespace-rescan-timer-time nil t)
 '(whitespace-silent t t)
 '(whitespace-style (quote (face trailing lines-tail space-before-tab)))
 '(window-divider-default-bottom-width 1)
 '(window-divider-default-places (quote bottom-only))
 '(workgroups-mode nil)
 '(x-stretch-cursor t)
 '(yas-installed-snippets-dir "~/.emacs.d/site-lisp/yasnippet-snippets/snippets/" t)
 '(yas-prompt-functions
   (quote
    (yas-ido-prompt yas-completing-prompt yas-no-prompt)))
 '(yas-snippet-dirs (quote ("/Users/jostol01/.emacs.d/snippets")))
 '(yas-triggers-in-field t)
 '(yas-wrap-around-region t)
 '(zencoding-indentation 2)
 '(zencoding-preview-default nil)
 '(zoom-size (quote size-callback)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
