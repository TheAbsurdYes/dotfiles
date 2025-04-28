(setq gc-cons-threshold #x40000000)

(setq read-process-output-max (* 1024 1024 4))

(setenv "LSP_USE_PLISTS" "true")
(setq max-lisp-eval-depth 10000)

(setq explicit-shell-file-name "/bin/zsh")                                                                                                                                    
(setq shell-file-name "zsh")                                                                                                                                                  
(setq explicit-bash.exe-args '("--noediting" "--login" "-ic"))                                                                                                                 
(setq shell-command-switch "-ic")                                                                                                                                              
(setenv "SHELL" shell-file-name)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(defcustom ek-use-nerd-fonts nil
  "Configuration for using Nerd Fonts Symbols."
  :type 'boolean
  :group 'appearance)

(use-package emacs
  :ensure nil
  :custom
  (create-lockfiles nil)
  (global-auto-revert-non-file-buffers t)
  (inhibit-startup-screen t)
  (pixel-scroll-precision-mode t)
  (pixel-scroll-precision-use-momentum nil)
  (ring-bell-function 'ignore)
  (truncate-lines t)
  (make-backup-files nil)
  (display-line-numbers-type 'relative)

  (use-dialog-box nil)
  (use-short-answers t)
  (global-auto-revert-non-file-buffers t)
  (delete-by-moving-to-trash t)
  (load-prefer-newer t)
  (treesit-font-lock-level 4)
  (switch-to-buffer-obey-display-actions t)

  (tab-always-indent 'complete)
  (tab-width 4)

  (warning-minimum-level :emergency)

  :hook
  (prog-mode . display-line-numbers-mode)

  :config
  (add-to-list `default-frame-alist `(font . "Iosevka-20"))

  (setq custom-file (expand-file-name ".emacs.custom.el" user-emacs-directory))
  (setq backup-directory-alist '(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))

  (make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

  (setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
	auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

  (when (eq system-type 'darwin)
    (setq mac-option-key-is-meta nil
	  mac-command-key-is-meta t
	  mac-command-modifier 'meta
	  mac-option-modifier 'none))

  (load custom-file 'noerror 'nomessage)

  ;; avoid leaving a gap between the frame and the screen
  (setq-default frame-resize-pixelwise t)

  (savehist-mode 1)            ;; Enable saving of command history.
  (save-place-mode 1)          ;; Enable saving the place in files for easier return.
  (winner-mode 1)              ;; Enable winner mode to easily undo window configuration changes.
  (file-name-shadow-mode 1)    ;; Enable shadowing of filenames for clarity.

  (toggle-frame-maximized)
  :init
  (menu-bar-mode 0)
  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (file-name-shadow-mode 1)
  (electric-pair-mode))

(use-package async
  :ensure t
  :after dired
  :init
  (dired-async-mode 1))

(use-package files
  :config
  (defun make-directory-maybe (filename &optional wildcards)
    "Create parent directory if not exists while visiting file."
    (unless (file-exists-p filename)
      (let ((dir (file-name-directory filename)))
	(unless (file-exists-p dir)
	  (make-directory dir t)))))

  (advice-add 'find-file :before #'make-directory-maybe))

(use-package eldoc
  :defer 10
  :init
  (setq eldoc-echo-area-use-multiline-p nil)

  (setopt eldoc-documentation-strategy #'eldoc-documentation-compose)
  (global-eldoc-mode t))

(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))

(use-package treesit-auto
  :ensure t
  :after emacs
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode t))

;; Magit: best Git client to ever exist
(use-package magit
  :ensure t
  :defer t)

;; Langs
(use-package php-ts-mode
  :mode "\\.php\\'"
  :config)

(use-package rust-ts-mode
  :mode "\\.rs\\'")

(use-package lua-ts-mode
  :mode "\\.lua\\'")

(use-package python-ts-mode
  :mode "\\.py\\'")

(use-package dotenv-mode
  :ensure t
  :mode "\\.env\\..*\\'")

(use-package vue-ts-mode
  :mode "\\.vue\\'"
  :hook (vue-ts-mode . sgml-electric-tag-pair-mode)
  :bind (:map vue-ts-mode-map
	      ("C-c C-t" . vue-ts-mode-element-transpose)
	      ("C-c C-w" . vue-ts-mode-attributes-toggle-wrap)
	      ("C-c C-o" . vue-ts-mode-element-match)
	      ("C-c C-f" . sgml-skip-tag-forward)
	      ("C-c C-n" . sgml-skip-tag-forward)
	      ("C-c C-b" . sgml-skip-tag-backward)
	      ("C-c C-p" . sgml-skip-tag-backward)
	      :repeat-map sgml-skip-tag
	      ("f"   .  sgml-skip-tag-forward)
	      ("C-f" .  sgml-skip-tag-forward)
	      ("b"   .  sgml-skip-tag-backward)
	      ("C-b" .  sgml-skip-tag-backward))
  :init
  (unless (package-installed-p 'vue-ts-mode)
    (package-vc-install "https://github.com/theschmocker/vue-ts-mode"))
  (with-eval-after-load 'treesit
    (push '(vue "https://github.com/ikatyang/tree-sitter-vue")
	  treesit-language-source-alist))
  :config
  (setopt vue-ts-mode-indent-offset 2)
  (setq-default vue-ts-mode-indent-offset 2))

;; UNDO TREE
;; The `undo-tree' package provides an advanced and visual way to
;; manage undo history. It allows you to navigate and visualize your
;; undo history as a tree structure, making it easier to manage
;; changes in your buffers.
(use-package undo-tree
  :defer t
  :ensure t
  :hook
  (after-init . global-undo-tree-mode)
  :init
  (setq undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t
        ;; Increase undo limits to avoid losing history due to Emacs' garbage collection.
        ;; These values can be adjusted based on your needs.
        ;; 10X bump of the undo limits to avoid issues with premature
        ;; Emacs GC which truncates the undo history very aggressively.
        undo-limit 800000                     ;; Limit for undo entries.
        undo-strong-limit 12000000            ;; Strong limit for undo entries.
        undo-outer-limit 120000000)           ;; Outer limit for undo entries.
  :config
  ;; Set the directory where `undo-tree' will save its history files.
  ;; This keeps undo history across sessions, stored in a cache directory.
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/.cache/undo"))))

(use-package evil
  :ensure t
  :defer t
  :hook
  (after-init . evil-mode)
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  (setq evil-want-Y-yank-to-eol t) ; consistent with D
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-move-cursor-back nil)
  (setq evil-search-module 'isearch)
  :config
  (evil-set-undo-system 'undo-tree)

  ;; (defun my-center-line (&rest _)
  ;;   (evil-scroll-line-to-center nil))

  ;; (advice-add 'evil-scroll-down :after #'my-center-line)
  ;; (advice-add 'evil-scroll-up :after #'my-center-line)
  ;; (advice-add 'evil-jump-backward :after #'my-center-line)
  ;; (advice-add 'evil-jump-forward :after #'my-center-line)

  (evil-define-key 'normal 'global (kbd "gl") #'evil-end-of-line)
  (evil-define-key 'normal 'global (kbd "gh") #'evil-beginning-of-line)

  (evil-define-key 'normal 'global (kbd "C-r") 'query-replace)
  (evil-define-key 'normal 'global (kbd "U") 'evil-redo)

  ;; Set the leader key to space for easier access to custom commands. (setq evil-want-leader t)
  (setq evil-leader/in-all-states t)  ;; Make the leader key available in all states.
  (setq evil-want-fine-undo t)        ;; Evil uses finer grain undoing steps

  ;; Define the leader key as Space
  (evil-set-leader 'normal (kbd "SPC")) 
  (evil-set-leader 'visual (kbd "SPC")) 

  ;; Dired commands for file management
  (evil-define-key 'normal 'global (kbd "<leader> d") 'dired)
  (evil-define-key 'normal 'global (kbd "<leader> j") 'dired-jump)
  (evil-define-key 'normal 'global (kbd "<leader> f") 'find-file)

  (evil-define-key 'normal 'global (kbd "<leader> t") 'vterm)
  (evil-define-key 'normal 'global (kbd "<leader> c c") 'compile)
  (evil-define-key 'normal 'global (kbd "<leader> r r") 'recompile)

  (evil-define-key 'normal 'global (kbd "<leader> k")   'kill-current-buffer) ;; Kill current buffer
  (evil-define-key 'normal 'global (kbd "<leader> b d") 'kill-current-buffer) ;; Kill current buffer
  (evil-define-key 'normal 'global (kbd "<leader> b k") 'kill-current-buffer) ;; Kill current buffer
  (evil-define-key 'normal 'global (kbd "<leader> b x") 'kill-current-buffer) ;; Kill current buffer
  (evil-define-key 'normal 'global (kbd "<leader> b s") 'save-buffer) ;; Save buffer
  (evil-define-key 'normal 'global (kbd "<leader> b b") 'consult-buffer) ;; Save buffer

  (evil-define-key 'normal 'global (kbd "<leader>SPC") 'consult-buffer) ;; Consult buffer

  ;; Keybindings for searching and finding files.
  (evil-define-key 'normal 'global (kbd "<leader> s f") 'consult-fd)
  (evil-define-key 'normal 'global (kbd "<leader> s g") 'consult-grep)
  (evil-define-key 'normal 'global (kbd "<leader> s G") 'consult-git-grep)
  (evil-define-key 'normal 'global (kbd "<leader> s r") 'consult-ripgrep)
  (evil-define-key 'normal 'global (kbd "<leader> s h") 'consult-info)
  (evil-define-key 'normal 'global (kbd "<leader> s i") 'consult-imenu)
  (evil-define-key 'normal 'global (kbd "<leader> s s") 'consult-lsp-symbols)
  (evil-define-key 'normal 'global (kbd "<leader> s /") 'consult-lsp-file-symbols)
  (evil-define-key 'normal 'global (kbd "<leader> /") 'consult-line)

  ;; Flymake navigation
  (evil-define-key 'normal 'global (kbd "<leader> x x") 'consult-flymake);; Gives you something like `trouble.nvim'
  (evil-define-key 'normal 'global (kbd "] d") 'flymake-goto-next-error) ;; Go to next Flymake error
  (evil-define-key 'normal 'global (kbd "[ d") 'flymake-goto-prev-error) ;; Go to previous Flymake error

  ;; Project management keybindings
  (evil-define-key 'normal 'global (kbd "<leader> p b") 'consult-project-buffer) ;; Consult project buffer
  (evil-define-key 'normal 'global (kbd "<leader> p p") 'project-switch-project) ;; Switch project
  (evil-define-key 'normal 'global (kbd "<leader> p f") 'project-find-file) ;; Find file in project
  (evil-define-key 'normal 'global (kbd "<leader> p g") 'project-find-regexp) ;; Find regexp in project
  (evil-define-key 'normal 'global (kbd "<leader> p k") 'project-kill-buffers) ;; Kill project buffers
  (evil-define-key 'normal 'global (kbd "<leader> p c") 'project-compile) ;; Kill project buffers
  (evil-define-key 'normal 'global (kbd "<leader> p r") 'project-recompile) ;; Kill project buffers
  (evil-define-key 'normal 'global (kbd "<leader> p d") 'project-dired) ;; Dired for project
  (evil-define-key 'normal 'global (kbd "<leader> p a") 'project-async-shell-command) ;; Shell command for a project
  (evil-define-key 'normal 'global (kbd "<leader> p s") 'project-shell-command) ;; Shell command for a project

  ;; Help keybindings
  (evil-define-key 'normal 'global (kbd "<leader> h m") 'describe-mode) ;; Describe current mode
  (evil-define-key 'normal 'global (kbd "<leader> h f") 'describe-function) ;; Describe function
  (evil-define-key 'normal 'global (kbd "<leader> h v") 'describe-variable) ;; Describe variable
  (evil-define-key 'normal 'global (kbd "<leader> h k") 'describe-key) ;; Describe key

  ;; Embark actions for contextual commands
  (evil-define-key 'normal 'global (kbd "<leader> .") 'embark-act)

  ;; Undo tree visualization
  (evil-define-key 'normal 'global (kbd "<leader> u") 'undo-tree-visualize)

  ;; LSP commands keybindings
  (evil-define-key 'normal lsp-mode-map
    ;; (kbd "gd") 'lsp-find-definition                ;; evil-collection already provides gd
    (kbd "gr") 'lsp-find-references                   ;; Finds LSP references
    (kbd "<leader> c a") 'lsp-execute-code-action     ;; Execute code actions
    (kbd "<leader> r n") 'lsp-rename                  ;; Rename symbol
    (kbd "gI") 'lsp-find-implementation               ;; Find implementation
    (kbd "<leader> l f") 'lsp-format-buffer)          ;; Format buffer via lsp

  (defun ek/lsp-describe-and-jump ()
	"Show hover documentation and jump to *lsp-help* buffer."
	(interactive)
	(lsp-describe-thing-at-point)
	(let ((help-buffer "*lsp-help*"))
      (when (get-buffer help-buffer)
		(switch-to-buffer-other-window help-buffer))))

  ;; Open hover documentation
  (evil-define-key 'normal 'global (kbd "K") 'ek/lsp-describe-and-jump)

  (evil-define-key 'normal 'global (kbd "gcc")
    (lambda ()
      (interactive)
      (if (not (use-region-p))
	  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))))

  (evil-define-key 'visual 'global (kbd "gc")
    (lambda ()
      (interactive)
      (if (use-region-p)
		  (comment-or-uncomment-region (region-beginning) (region-end)))))

  (defun append-semicolon-end-of-line ()
	"Append a semicolon at the end of the current line."
	(interactive)
	(end-of-line)
	(insert ";"))

  (defun append-comma-end-of-line ()
	"Append a comma at the end of the current line."
	(interactive)
	(end-of-line)
	(insert ","))

  (evil-define-key 'normal 'global (kbd "; ;") #'append-semicolon-end-of-line)
  (evil-define-key 'normal 'global (kbd ", ,") #'append-comma-end-of-line)

  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-find-file),
  (evil-define-key 'normal dired-mode-map (kbd "SPC") nil))

(use-package evil-collection
  :defer t
  :ensure t
  :custom
  (evil-collection-want-find-usages-bindings t)
  (evil-collection-key-blacklist '("SPC"))
  :hook
  (evil-mode . evil-collection-init))

(use-package evil-surround
  :after evil
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; (use-package evil-multiedit
;;   :ensure t
;;   :config
;;   (evil-define-key 'normal 'global
;;     (kbd "C->")   #'evil-multiedit-match-symbol-and-next
;;     (kbd "C-<")   #'evil-multiedit-match-symbol-and-prev)
;;   (evil-define-key 'visual 'global
;;     "R"           #'evil-multiedit-match-all
;;     (kbd "C->")   #'evil-multiedit-match-and-next
;;     (kbd "C-<")   #'evil-multiedit-match-and-prev)
;;   (evil-define-key '(visual normal) 'global
;;     (kbd "C-M-d") #'evil-multiedit-restore)

;;   (with-eval-after-load 'evil-multiedit
;;     (evil-define-key 'multiedit 'global
;;       (kbd "C->")   #'evil-multiedit-match-and-next
;;       (kbd "C-<") #'evil-multiedit-match-and-prev
;;       (kbd "RET")   #'evil-multiedit-toggle-or-restrict-region)
;;     (evil-define-key '(multiedit multiedit-insert) 'global
;;       (kbd "C-n")   #'evil-multiedit-next
;;       (kbd "C-p")   #'evil-multiedit-prev)))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package expand-region
  :ensure t
  :bind
  ("C-=" . er/expand-region)
  ("C--" . er/contract-region))

(use-package tab-jump-out
  :disabled t
  :ensure t
  :config
  (defun my-toggle-tab-jump-out-mode ()
	"Disable `tab-jump-out-mode` when completion menu is open, enable it otherwise."
	(if completion-in-region-mode
		(tab-jump-out-mode -1)
	  (tab-jump-out-mode 1))

	(if completion-preview-active-mode
		(tab-jump-out-mode -1)
	  (tab-jump-out-mode 1)))

  ;; Add the function to `post-command-hook`
  (add-hook 'post-command-hook #'my-toggle-tab-jump-out-mode)

  (tab-jump-out-global-mode))

(use-package popper
  :ensure t ; or :straight t
  :bind (("C-`"   . popper-toggle)
	 ("M-`"   . popper-cycle)
	 ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
	'(
	  "\\*Messages\\*"
	  "\\*Warnings\\*"
	  "\\*Backtrace\\*"
	  "\\*xref\\*"
	  "^\\*vterm.*\\*$"  vterm-mode  ;vterm as a popup
	  "^\\*eat.*\\*$"  eat-mode  ;eat as a popup
	  "Output\\*$"
	  "\\*Async Shell Command\\*"
	  "\\*eldoc\\*"
	  "\\*devdocs\\*"
	  "\\*lsp-help\\*"
	  help-mode
	  compilation-mode
	  ))
  (popper-mode +1)
  (popper-echo-mode +1))

(use-package vterm
  :ensure t)

(use-package pulsar
  :defer t
  :ensure t
  :hook
  (after-init . pulsar-global-mode)
  :config
  (setq pulsar-pulse t)
  (setq pulsar-delay 0.025)
  (setq pulsar-iterations 10)
  (setq pulsar-face 'evil-ex-lazy-highlight)

  ;; (add-to-list 'pulsar-pulse-functions 'evil-scroll-down)
  ;; (add-to-list 'pulsar-pulse-functions 'flymake-goto-next-error)
  ;; (add-to-list 'pulsar-pulse-functions 'flymake-goto-prev-error)
  (add-to-list 'pulsar-pulse-functions 'evil-yank)
  (add-to-list 'pulsar-pulse-functions 'evil-yank-line)
  (add-to-list 'pulsar-pulse-functions 'evil-delete)
  (add-to-list 'pulsar-pulse-functions 'evil-delete-line)
  ;; (add-to-list 'pulsar-pulse-functions 'evil-jump-item)
  ;; (add-to-list 'pulsar-pulse-functions 'diff-hl-next-hunk)
  ;; (add-to-list 'pulsar-pulse-functions 'diff-hl-previous-hunk)
  )

;;; DOOM MODELINE
;; The `doom-modeline' package provides a sleek, modern mode-line that is visually appealing
;; and functional. It integrates well with various Emacs features, enhancing the overall user
;; experience by displaying relevant information in a compact format.
(use-package doom-modeline
  :ensure t
  :defer t
  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)  ;; Set the buffer file name style to just the buffer name (without path).
  (doom-modeline-project-detection 'project)           ;; Enable project detection for displaying the project name.
  (doom-modeline-buffer-name t)                        ;; Show the buffer name in the mode line.
  (doom-modeline-vcs-max-length 25)                    ;; Limit the version control system (VCS) branch name length to 25 characters.
  :config
  (if ek-use-nerd-fonts                                ;; Check if nerd fonts are being used.
      (setq doom-modeline-icon t)                      ;; Enable icons in the mode line if nerd fonts are used.
    (setq doom-modeline-icon nil))                     ;; Disable icons if nerd fonts are not being used.
  (setq doom-modeline-modal nil)
  :hook
  (after-init . doom-modeline-mode))

;;; DIRED
;; In Emacs, the `dired' package provides a powerful and built-in file manager
;; that allows you to navigate and manipulate files and directories directly
;; within the editor. If you're familiar with `oil.nvim', you'll find that
;; `dired' offers similar functionality natively in Emacs, making file
;; management seamless without needing external plugins.
(use-package dired
  :ensure nil                                                ;; This is built-in, no need to fetch it.
  :custom
  (setq delete-by-moving-to-trash t)
  (dired-listing-switches "-lah --group-directories-first")  ;; Display files in a human-readable format and group directories first.
  (dired-dwim-target t)                                      ;; Enable "do what I mean" for target directories.
  (dired-kill-when-opening-new-dired-buffer t)               ;; Close the previous buffer when opening a new `dired' instance.
  :config
  (when (eq system-type 'darwin)
    (let ((gls (executable-find "gls")))                     ;; Use GNU ls on macOS if available.
      (when gls
		(setq insert-directory-program gls))))

  (evil-collection-define-key )
  )

;; (use-package dirvish
;;   :ensure t
;;   :config
;;   (dirvish-override-dired-mode))

;;; NERD ICONS Dired
;; The `nerd-icons-dired' package integrates nerd icons into the Dired mode,
;; providing visual icons for files and directories. This enhances the Dired
;; interface by making it easier to identify file types at a glance.
(use-package nerd-icons-dired
  :if ek-use-nerd-fonts                   ;; Load the package only if the user has configured to use nerd fonts.
  :ensure t                               ;; Ensure the package is installed.
  :defer t                                ;; Load the package only when needed to improve startup time.
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package so-long
  :ensure t
  :config
  (global-so-long-mode 1)
  (add-hook 'so-long-mode-hook
			(lambda ()
			  (when auto-revert-mode
				(auto-revert-mode -1)))))

(use-package rainbow-mode 
  :ensure t 
  :commands (rainbow-mode)
  :hook
  (prog-mode . rainbow-mode))

(use-package rainbow-delimiters
  :defer t
  :ensure t
  :commands (rainbow-delimiters-mode)
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :custom
  (vertico-count 10)                    ;; Number of candidates to display in the completion list.
  (vertico-resize nil)                  ;; Disable resizing of the vertico minibuffer.
  (vertico-cycle nil)                   ;; Do not cycle through candidates when reaching the end of the list.
  :config
  ;; Customize the display of the current candidate in the completion list.
  ;; This will prefix the current candidate with “» ” to make it stand out.
  ;; Reference: https://github.com/minad/vertico/wiki#prefix-current-candidate-with-arrow
  (advice-add #'vertico--format-candidate :around
	      (lambda (orig cand prefix suffix index _start)
		(setq cand (funcall orig cand prefix suffix index _start))
		(concat
		 (if (= vertico--index index)
		     (propertize "» " 'face '(:foreground "#80adf0" :weight bold))
		   "  ")
		 cand))))

(use-package marginalia
  :after vertico
  :ensure t
  ;; :custom
  ;; (marginalia-annotators
  ;;  '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :config
  (marginalia-mode))

(use-package consult
  :ensure t
  :defer t
  :after vertico
  :bind (
	 ("C-x b"       . consult-buffer)
	 ("C-x C-b"     . consult-buffer)
	 ("C-x C-k C-k" . consult-kmacro)
	 ("M-y"         . consult-yank-pop)
	 ("M-g g"       . consult-goto-line)
	 ("M-g M-g"     . consult-goto-line)
	 ("M-g f"       . consult-flymake)
	 ("M-g i"       . consult-imenu)
	 ("M-s l"       . consult-line)
	 ("M-s L"       . consult-line-multi)
	 ("M-s u"       . consult-focus-lines)
	 ("M-s g"       . consult-ripgrep)
	 ("M-s M-g"     . consult-ripgrep)
	 ("M-s f"       . consult-find)
	 ("M-s M-f"     . consult-fd)
	 ("C-x C-SPC"   . consult-global-mark)
	 ("C-x M-:"     . consult-complex-command)
	 ("C-c n"       . consult-org-agenda)
	 ("M-X"         . consult-mode-command)
	 :map minibuffer-local-map
	 ("M-r" . consult-history)
	 :map Info-mode-map
	 ("M-g i" . consult-info)
	 ;; :map org-mode-map
	 ("M-g i"  . consult-org-heading)
	 )
  :init
  ;; Enhance register preview with thin lines and no mode line.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult for xref locations with a preview feature.
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  (setq consult-preview-key nil)
  :custom
  (completion-in-region-function #'consult-completion-in-region)
  :config
  (recentf-mode t))

;;; EMBARK
;; Embark provides a powerful contextual action menu for Emacs, allowing 
;; you to perform various operations on completion candidates and other items. 
;; It extends the capabilities of completion frameworks by offering direct 
;; actions on the candidates.
;; Just `<leader> .' over any text, explore it :)
(use-package embark
  :ensure t
  :defer t
  :bind ("C-." . embark-act))

;; Helpful for editing consult-grep
(use-package wgrep
  :ensure t
  :after embark)

;;; EMBARK-CONSULT
;; Embark-Consult provides a bridge between Embark and Consult, ensuring 
;; that Consult commands, like previews, are available when using Embark.
(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode)) ;; Enable preview in Embark collect mode.

(use-package consult-lsp
  :ensure t)

(use-package autorevert
  :ensure nil
  :defer 1
  :init (global-auto-revert-mode t))

(use-package completion-preview
  ;; :disabled
  :hook (prog-mode . completion-preview-mode)
  :custom
  (completion-preview-minimum-symbol-length 2))

(use-package corfu
  :disabled
  :ensure t
  ;; Optional customizations
  :custom
  (corfu-cycle t)                 ; Allows cycling through candidates
  (corfu-auto t)                  ; Enable auto completion
  (corfu-auto-prefix 1)
  (corfu-auto-delay 0.0)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-preview-current 'insert) ; insert previewed candidate
  (corfu-preselect 'prompt)
  (corfu-on-exact-match nil)      ; Don't auto expand tempel snippets
  ;; Optionally use TAB for cycling, default is `corfu-complete'.
  ;; :bind (:map corfu-map
  ;; 	      ("M-SPC"      . corfu-insert-separator)
  ;; 	      ("TAB"        . corfu-next)
  ;; 	      ("<tab>"      . corfu-next)
  ;; 	      ([tab]        . Corfu-next)
  ;; 	      ("S-TAB"      . corfu-previous)
  ;; 	      ([backtab]    . corfu-previous)
  ;; 	      ("S-<return>" . corfu-insert)
  ;; 	      ("RET"        . corfu-insert))

  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-indexed-mode)
  (corfu-popupinfo-mode)  ; Popup completion info
  :config
  (defun my-corfu-insert-parentheses (&rest _)
	"Insert parentheses if the completed item is a function or method."
	(when (and (eq major-mode 'php-ts-mode)
			   (looking-back "\\_<[A-Za-z0-9_]+\\_>" (line-beginning-position)))
	  (insert "()")
	  (backward-char)))

  ;; Add `my-corfu-insert-parentheses` as a post-completion hook for corfu
  (add-hook 'corfu-completion-hook #'my-corfu-insert-parentheses)
  )

(use-package orderless
  :ensure t
  :defer t
  :after vertico
  :commands (orderless)
  :custom
  (completion-styles '(orderless flex))
  (completion-category-defaults nil)      
  (completion-ignore-case t)
  (completion-category-overrides '((file (styles partial-completion)))) ;; Clear default category settings.
)

(use-package cape
  :ensure t
  :defer 10
  :init
  (add-to-list 'completion-at-point-functions 'cape-file)
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (defun my/add-shell-completion ()
    (interactive)
    (add-to-list 'completion-at-point-functions 'cape-history)
    (add-to-list 'completion-at-point-functions 'pcomplete-completions-at-point))
  (add-hook 'shell-mode-hook #'my/add-shell-completion nil t)
  (add-hook 'vterm-mode-hook #'my/add-shell-completion nil t)

  :config
  ;; Make capfs composable
  ;; (advice-add #'eglot-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add #'lsp-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add #'comint-completion-at-point :around #'cape-wrap-nonexclusive)

  ;; Silence then pcomplete capf, no errors or messages!
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)

  ;; Ensure that pcomplete does not write to the buffer
  ;; and behaves as a pure `completion-at-point-function'.
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify))

(use-package devdocs
  :ensure t
  :bind ("M-s d" . devdocs-lookup))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

;;; LSP
;; Emacs comes with an integrated LSP client called `eglot', which offers basic LSP functionality. 
;; However, `eglot' has limitations, such as not supporting multiple language servers 
;; simultaneously within the same buffer (e.g., handling both TypeScript, Tailwind and ESLint
;; LSPs together in a React project). For this reason, the more mature and capable 
;; `lsp-mode' is included as a third-party package, providing advanced IDE-like features 
;; and better support for multiple language servers and configurations.
;;
;; NOTE: To install or reinstall an LSP server, use `M-x install-server RET`.
;;       As with other editors, LSP configurations can become complex. You may need to
;;       install or reinstall the server for your project due to version management quirks
;;       (e.g., asdf or nvm) or other issues.
;;       Fortunately, `lsp-mode` has a great resource site:
;;       https://emacs-lsp.github.io/lsp-mode/
(use-package lsp-mode
  :ensure t
  :defer t
  :hook (;; Replace XXX-mode with concrete major mode (e.g. python-mode)
         (bash-ts-mode . lsp)                           ;; Enable LSP for Bash
         (typescript-ts-mode . lsp)                     ;; Enable LSP for TypeScript
         (tsx-ts-mode . lsp)                            ;; Enable LSP for TSX
         (jsx-ts-mode . lsp)                            ;; Enable LSP for JSX
         (js-mode . lsp)                                ;; Enable LSP for JavaScript
         (js-ts-mode . lsp)                             ;; Enable LSP for JavaScript (TS mode)
         (php-mode . lsp)                               ;; Enable LSP for Php
         (php-ts-mode . lsp)                            ;; Enable LSP for Php (TS mode)
         (lua-mode . lsp)                               ;; Enable LSP for Php
         (lua-ts-mode . lsp)                            ;; Enable LSP for Php (TS mode)
         (vue-ts-mode . lsp)                            ;; Enable LSP for Vue (TS mode)
         (python-mode . lsp)                            ;; Enable LSP for Vue (TS mode)
         (python-ts-mode . lsp)                            ;; Enable LSP for Vue (TS mode)
         (lsp-mode . lsp-enable-which-key-integration)) ;; Integrate with Which Key
  :commands lsp
  :custom
  (lsp-keymap-prefix "C-c l")                           ;; Set the prefix for LSP commands.
  (lsp-inlay-hint-enable t)                             ;; Enable inlay hints.
  ;; (lsp-completion-provider :none)                       ;; Disable the default completion provider.
  (lsp-session-file (locate-user-emacs-file ".lsp-session")) ;; Specify session file location.
  (lsp-log-io nil)                                      ;; Disable IO logging for speed.
  (lsp-idle-delay 0)                                    ;; Set the delay for LSP to 0 (debouncing).
  (lsp-keep-workspace-alive nil)                        ;; Disable keeping the workspace alive.
  ;; Core settings
  (lsp-enable-xref t)                                   ;; Enable cross-references.
  (lsp-auto-configure t)                                ;; Automatically configure LSP.
  (lsp-enable-links nil)                                ;; Disable links.
  (lsp-eldoc-enable-hover t)                            ;; Enable ElDoc hover.
  (lsp-enable-file-watchers nil)                        ;; Disable file watchers.
  (lsp-enable-folding nil)                              ;; Disable folding.
  (lsp-enable-imenu t)                                  ;; Enable Imenu support.
  (lsp-enable-indentation t)                            ;; Disable indentation.
  (lsp-enable-on-type-formatting nil)                   ;; Disable on-type formatting.
  (lsp-enable-suggest-server-download t)                ;; Enable server download suggestion.
  (lsp-enable-symbol-highlighting nil)                    ;; Enable symbol highlighting.
  (lsp-enable-text-document-color nil)                  ;; Disable text document color.
  ;; Modeline settings
  (lsp-modeline-code-actions-enable nil)                ;; Keep modeline clean.
  (lsp-modeline-diagnostics-enable nil)                 ;; Use `flymake' instead.
  (lsp-modeline-workspace-status-enable t)              ;; Display "LSP" in the modeline when enabled.
  (lsp-signature-doc-lines 1)                           ;; Limit echo area to one line.
  (lsp-eldoc-render-all nil)                            ;; Render all ElDoc messages.
  ;; Completion settings
  (lsp-completion-enable t)                             ;; Enable completion.
  (lsp-completion-enable-additional-text-edit t)        ;; Enable additional text edits for completions.
  (lsp-enable-snippet t)                                ;; Disable snippets
  (lsp-completion-show-kind t)                          ;; Show kind in completions.
  ;; Lens settings
  (lsp-lens-enable t)                                   ;; Enable lens support.
  ;; Headerline settings
  (lsp-headerline-breadcrumb-mode nil)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-headerline-breadcrumb-enable-symbol-numbers t)   ;; Enable symbol numbers in the headerline.
  (lsp-headerline-arrow "▶")                           ;; Set arrow for headerline.
  (lsp-headerline-breadcrumb-enable-diagnostics nil)    ;; Disable diagnostics in headerline.
  (lsp-headerline-breadcrumb-icons-enable nil)          ;; Disable icons in breadcrumb.
  ;; Semantic settings
  (lsp-semantic-tokens-enable nil)                      ;; Disable semantic tokens.

  ;; Custom for 
  (lsp-volar-take-over-mode nil)
  :preface
  (defun lsp-booster--advice-json-parse (old-fn &rest args)
	"Try to parse bytecode instead of json."
	(or
	 (when (equal (following-char) ?#)
	   (let ((bytecode (read (current-buffer))))
		 (when (byte-code-function-p bytecode)
		   (funcall bytecode))))
	 (apply old-fn args)))
  (advice-add (if (progn (require 'json)
						 (fboundp 'json-parse-buffer))
				  'json-parse-buffer
				'json-read)
			  :around
			  #'lsp-booster--advice-json-parse)

  (defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
	"Prepend emacs-lsp-booster command to lsp CMD."
	(let ((orig-result (funcall old-fn cmd test?)))
	  (if (and (not test?)                             ;; for check lsp-server-present?
			   (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
			   lsp-use-plists
			   (not (functionp 'json-rpc-connection))  ;; native json-rpc
			   (executable-find "emacs-lsp-booster"))
		  (progn
			(when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
			  (setcar orig-result command-from-exec-path))
			(message "Using emacs-lsp-booster for %s!" orig-result)
			(cons "emacs-lsp-booster" orig-result))
		orig-result)))
  :init
  (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command))

(use-package tempel
  :ensure t
  :hook ((prog-mode . tempel-setup-capf)
         (text-mode . tempel-setup-capf))
  :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
         ("M-*" . tempel-insert)
         :map tempel-map
         ([remap keyboard-escape-quit] . tempel-done)
         ("TAB" . tempel-next)
         ("<backtab>" . tempel-previous))
  :config
  (defun tempel-include (elt)
    "Support i as a way to import another template"
    (when (eq (car-safe elt) 'i)
      (if-let (template (alist-get (cadr elt) (tempel--templates)))
          (cons 'l template)
        (message "Template %s not found" (cadr elt))
        nil)))

  (add-to-list 'tempel-user-elements #'tempel-include)

  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-complete
                      completion-at-point-functions))))

(use-package tempel-collection
  :ensure t
  :config
  :after tempel)

(use-package compile
  :defer t
  :config
  (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
  (setopt compilation-scroll-output t)
  (setopt compilation-ask-about-save nil))

(use-package golden-ratio
  :ensure t
  :hook (after-init . golden-ratio-mode)
  :custom
  (golden-ratio-exclude-modes '(occur-mode)))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package dired-aux
  :config
  (add-to-list 'dired-compress-file-alist '("\\.rar\\'" . "tar -xf %i")))

;;; EAT AND ESHELL
(use-package eat
  :ensure t
  :custom
  (eat-term-name "xterm")
  :hook (eat-exec . (lambda (_) (eat-line-mode)))
  :config
  (eat-eshell-mode)                     ; use Eat to handle term codes in program output
  (eat-eshell-visual-command-mode))   

(use-package dumb-jump
  :ensure t)

(use-package psysh
  :ensure t)

(use-package org
  :defer t)

;;; LSP Additional Servers
;; You can extend `lsp-mode' by integrating additional language servers for specific 
;; technologies. For example, `lsp-tailwindcss' provides support for Tailwind CSS 
;; classes within your HTML files. By using various LSP packages, you can connect 
;; multiple LSP servers simultaneously, enhancing your coding experience across 
;; different languages and frameworks.
(use-package lsp-tailwindcss
  :ensure t
  :defer t
  :after lsp-mode
  :custom
  (lsp-tailwindcss-server-path "/Users/apostoladrian/Library/Application Support/Herd/config/nvm/versions/node/v21.7.3/lib/node_modules/@tailwindcss/language-server/bin/tailwindcss-language-server")
  :config
  (add-to-list 'lsp-tailwindcss-major-modes 'vue-ts-mode)
  :init
  (setq lsp-tailwindcss-add-on-mode t))

(use-package emmet-mode
  :ensure t
  :bind
  ("C-j" . emmet-expand-line)
  (:map emmet-mode-keymap
		("TAB" . emmet-next-edit-point)
		("<backtab>" . emmet-prev-edit-point))
  :config
    (defun my/emmet-expand-capf ()
    (let ((bounds (bounds-of-thing-at-point 'symbol))
          (tap (thing-at-point 'symbol)))
      (list (car bounds) (cdr bounds)
            ;; Just return the symbol at point to so completion will be possible
            ;; TODO Determine if there is a less hacky option
            (lambda (string pred action) (list (thing-at-point 'symbol)))
            ;; Annotate with what emmet expands to
            ;; TODO find a way for this to show since right now
            ;; corfu doesn't display this on a single completion
            :annotation-function (lambda (str) (emmet-transform str))
            ;; Don't try to complete with emmet if there is no possible
            ;; expansion
            :predicate (not (string= (emmet-transform tap)
                                     tap))
            ;; Expand Emmet Template On Match
            :exit-function (lambda (str status)
                             (when (eql status 'finished)
			       (emmet-expand-line nil)))
            ;; Allow for other completions to follow
            :exlcusive 'no)))

  (defun emmet-setup-capf ()
    (setq-local completion-at-point-functions
                (add-to-list 'completion-at-point-functions
                             'my/emmet-expand-capf
                             t)))

  (add-hook 'emmet-mode-hook 'emmet-setup-capf))

(use-package sql
  :config
  (setq sql-connection-alist
		'((movie-recommender (sql-product 'mysql)
					 (sql-port 3306)
					 (sql-server "localhost")
					 (sql-user "sail")
					 (sql-password "password")
					 (sql-database "movie_recommender"))))
  )
