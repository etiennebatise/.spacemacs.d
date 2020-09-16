(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation nil
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers '(octave
                                       nginx
                                       (typescript :variables
                                                   typescript-backend 'lsp
                                                   typescript-fmt-tool 'prettier
                                                   typescript-linter 'eslint
                                                   )
                                       (javascript :variables node-add-modules-path t)
                                       lsp
                                       php
                                       elm
                                       sql
                                       csv
                                       ruby
                                       python
                                       docker
                                       haskell
                                       c-c++
                                       html
                                       emacs-lisp
                                       git
                                       markdown
                                       org
                                       ansible
                                       rust
                                       pdf-tools
                                       neotree
                                       theming
                                       gnus
                                       (haskell :variables haskell-enable-hindent-style "fundamental")
                                       auto-completion (haskell :variables
                                                                haskell-completion-backend 'dante)
                                       (auto-completion :variables
                                                        auto-completion-return-key-behavior 'complete
                                                        auto-completion-tab-key-behavior 'cycle
                                                        auto-completion-complete-with-key-sequence nil
                                                        auto-completion-complete-with-key-sequence-delay 0.1
                                                        auto-completion-private-snippets-directory nil)
                                       (shell :variables
                                              shell-default-shell 'eshell
                                              shell-default-position 'bottom
                                              shell-default-height 40)
                                       (osx :variables
                                            osx-command-as       'hyper
                                            osx-option-as        'none
                                            osx-control-as       'control
                                            osx-function-as      nil
                                            osx-right-command-as 'left
                                            osx-right-option-as  'left
                                            osx-right-control-as 'left
                                            osx-swap-option-and-command nil)

                                       (keyboard-layout :variables kl-layout 'bepo)
                                       )
   dotspacemacs-additional-packages '(js2-mode
                                      pandoc-mode
                                      all-the-icons
                                      dracula-theme
                                      grayscale-theme
                                      pretty-mode
                                      groovy-mode
                                      evil-mc
                                      projectile-ripgrep
                                      fzf)
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(vi-tilde-fringe)
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Function that will be called before loading packages etc..."
  (init/vars)
  (init/proxy))

(defun dotspacemacs/user-init ()
  "Avoid custom-vars to be set in init.el file"
  (push '("melpa-stable" . "stable.melpa.org/packages/") configuration-layer-elpa-archives)
  (push '(ensime . "melpa-stable") package-pinned-packages)
  (setq custom-file "~/.spacemacs.d/custom.el")
  (if (not (file-exists-p custom-file))
      (write-region "" nil custom-file)
    (load-file custom-file)))

(defun dotspacemacs/user-config ()
  "Custom user configuration, doing all the displaying stuff after package are loaded."
  ;; (user-config/pretty)
  (user-config/icons)
  (user-config/editing)
  (user-config/csharp)
  (user-config/java)
  (user-config/javascript)
  (user-config/ruby)
  (user-config/layout)
  (user-config/magit)
  (user-config/apex))

(defun init/vars ()
  "General variable configurations."
  (setq-default
   dotspacemacs-elpa-https nil
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner '999
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-colorize-cursor-according-to-state nil
   dotspacemacs-default-font '("Fira Code"
                               :size 14)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ nil
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Olympe"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.6
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)
   dotspacemacs-smooth-scrolling nil
   dotspacemacs-line-numbers nil
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server t
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup t
   dotspacemacs-themes '(grayscale)))

(defun init/proxy ()
  "Load the proxy configuration if defined."
  (when (file-exists-p "~/.spacemacs.d/proxy.el")
    (load-file "~/.spacemacs.d/proxy.el")))

(defun user-config/icons ()
  (setq neo-theme 'icons))

(defun user-config/csharp ()
  (setq-default omnisharp-server-executable-path "~/omnisharp/run"))

(defun user-config/java ()
  (setq eclim-eclipse-dirs '("~/eclipse")
        eclim-executable "~/eclipse/eclim"
        eclimd-executable "~/eclipse/eclimd"
        eclimd-wait-for-process t))

(defun user-config/javascript ()
  (setq-default js-indent-level 2)
  (setq-default js2-basic-offset 2)
  (setq-default javascript-backend 'lsp)
  )

(defun user-config/ruby ()
  (setq ruby-insert-encoding-magic-comment nil))

(defun user-config/magit ()
  (load-file "~/.spacemacs.d/magit-gerrit.el"))

(defun user-config/layout ()
  ;; Patched to allow everything but .DS_Store
  ;; Tips from https://github.com/syl20bnr/spacemacs/issues/2751
  (with-eval-after-load 'neotree
    (defun neo-util--walk-dir (path)
      "Return the subdirectories and subfiles of the PATH."
      (let* ((full-path (neo-path--file-truename path)))
        (condition-case nil
            (directory-files
             path 'full "^\\([^.]\\|\\.[^D.][^S]\\).*")
          ('file-error
           (message "Walk directory %S failed." path)
           nil)))))
  (setq evil-insert-state-cursor '((bar . 4) "white")
        evil-normal-state-cursor '(box "white")
        evil-replace-state-cursor '(hollow "white")
        evil-visual-state-cursor '(box "red")
        evil-iedit-state-cursor '(box "gold")
        evil-lisp-state-cursor '(box "deep pink")))

(defun my-save-if-bufferfilename ()
  (if (buffer-file-name)
      (progn
        (save-buffer))
    ()))

(defun user-config/editing ()
  ;; Pandoc mode for markdown
  (add-hook 'markdown-mode-hook 'pandoc-mode)
  ;; Save on exiting insert mode
  (add-hook 'evil-insert-state-exit-hook 'my-save-if-bufferfilename)
  ;; Remap for bépo
  (evil-define-key 'git-rebase-mode 'git-rebase-mode-map
    "S" 'git-rebase-move-line-up
    "T" 'git-rebase-move-line-down)

  ;; Golden ratio for the current window
  (evil-leader/set-key "gr" 'golden-ratio)

  ;; Haskell dante / Purescript psc
  (evil-leader/set-key-for-mode 'haskell-mode
    "x" 'xref-find-definitions
    "a" 'dante-type-at
    "z" 'dante-info)
  (evil-leader/set-key-for-mode 'purescript-mode
    "a" 'psc-ide-show-type)

  (add-hook 'haskell-mode-hook 'abbrev-mode)
  (add-hook 'dante-mode-hook 'flycheck-mode)
  (add-hook 'dante-mode-hook '(lambda() (flycheck-add-next-checker
                                         'haskell-dante
                                         '(warning . haskell-hlint))))

  ;; Line numbers
  (when (not (version< emacs-version "26"))
    (setq display-line-numbers-type 'absolute)
    (custom-set-faces '(line-number ((t (:foreground "dim gray")))))
    (custom-set-faces '(line-number-current-line ((t (:background "dim gray" :foreground "white")))))
    (add-hook 'prog-mode-hook 'display-line-numbers-mode)
    (add-hook 'org-mode-hook 'display-line-numbers-mode)
    (add-hook 'yaml-mode-hook 'display-line-numbers-mode))

  ;; Auto complete disabled in eshell
  (spacemacs|disable-company eshell-mode)
  (spacemacs|disable-company erc-mode)

  ;; Cursor
  (global-evil-mc-mode t)
  ;; (blink-cursor-mode t)

  ;; Bindings
  (define-key evil-normal-state-map (kbd "t") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "s") 'evil-previous-visual-line)

  ;; Search with ripgrep
  (evil-leader/set-key "/" 'spacemacs/helm-project-do-ag)
  (setq helm-ag-base-command "rg -S --no-heading")

  (spacemacs/set-leader-keys "off" 'fzf)

  ;; Vim like window navigation
  (spacemacs/set-leader-keys "wc" 'evil-window-left)
  (spacemacs/set-leader-keys "wt" 'evil-window-down)
  (spacemacs/set-leader-keys "ws" 'evil-window-up)
  (spacemacs/set-leader-keys "wr" 'evil-window-right)
  (spacemacs/set-leader-keys "wh" 'evil-window-split)
  )

(defun user-config/pretty ()
  (load-file "~/.spacemacs.d/pretty-fonts.el")
  (load-file "~/.spacemacs.d/pretty-eshell.el")
  (load-file "~/.spacemacs.d/pretty-magit.el")
  (require 'pretty-mode)
  (add-hook 'haskell-mode-hook 'turn-on-pretty-mode)
  (add-hook 'purescript-mode-hook 'turn-on-pretty-mode)
  ;; (pretty-deactivate-groups '(:equality :ordering :ordering-double :ordering-triple :arrows :arrows-twoheaded :punctuation :logic :nil))
;;   (pretty-activate-groups
;;    '(:arithmetic-nary :undefined :sqrt :greek :sets :quantifiers))
;;   (pretty-fonts-set-kwds
  '((pretty-fonts-fira-font prog-mode-hook org-mode-hook))
)

(defun user-config/apex ()
  (add-to-list 'load-path "~/.emacs.d/lisp/")
  (require 'apex-mode)
  )
