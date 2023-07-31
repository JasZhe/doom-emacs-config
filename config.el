(setq user-full-name "NAME"
      user-mail-address "EMAIL")

;;(add-hook 'window-setup-hook #'toggle-frame-maximized) ;; this doesn't play wery with amethyst
;;(set-frame-parameter nil 'alpha  '70)
(defun my/set-frame-alpha (&optional arg)
  (if
      (and arg (not (string-empty-p arg)))
      (set-frame-parameter nil 'alpha  (string-to-number arg))
    (set-frame-parameter nil 'alpha 90)))

(defun my/interactive-set-frame-alpha (&optional arg)
  (interactive "sFrame Alpha? ")
  (my/set-frame-alpha arg))

(evil-define-command my/evil-set-frame-alpha (&optional arg)
  (interactive "<a>")
  (my/set-frame-alpha arg))

(evil-ex-define-cmd "set-alpha" #'my/evil-set-frame-alpha)
(add-to-list 'default-frame-alist '(alpha . 90 ))
(setq frame-alpha-lower-limit 70)

(setq scroll-margin 8)

(setq custom-safe-themes
   '("b2779867957a4b9de84bcd33c5ded92e943c710c4c5c5b7fc874786eaf63ca5c" "d395c1793e0d64797d711c870571a0033174ca321ed48444efbe640bf692bf4f" "11873c4fbf465b956889adfa9182495db3bf214d9a70c0f858f07f6cc91cbd47" "f82e68d489e6c21c9552c4e8e35a03d126d9eba632a8e7b4f9329d1374b4a19c" "eb7cd622a0916358a6ef6305e661c6abfad4decb4a7c12e73d6df871b8a195f8" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "f5b6be56c9de9fd8bdd42e0c05fecb002dedb8f48a5f00e769370e4517dde0e8" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" default))

(load-theme 'solarized-gruvbox-light t)
(setq solarized-scale-org-headlines t)
(setq solarized-height-minus-1 0.9)
(setq solarized-height-plus-1 1.0)
(setq solarized-height-plus-2 1.1)
(setq solarized-height-plus-3 1.2)
(setq solarized-height-plus-4 1.3)

(setq doom-font (font-spec :family "Iosevka Custom" :size 16))
(setq doom-variable-pitch-font (font-spec :family "Iosevka Etoile" :size 16))
(setq! doom-unicode-font (font-spec :family "FiraCode Nerd Font"))

(setq display-line-numbers-type nil)
(if (string= (system-name) "Jasons-MacBook.local")
    (progn
      (+global-word-wrap-mode -1))
  (progn
    (+global-word-wrap-mode)))

(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice find-file (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))

(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-right (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-left (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-down (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-up (before other-window-now activate)
  (when buffer-file-name (save-buffer)))

(defadvice +workspace/cycle (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice +workspace/switch-to (before other-window-now activate)
  (when buffer-file-name (save-buffer)))

(defadvice other-frame (before other-frame-now activate)
  (when buffer-file-name (save-buffer)))

(global-evil-quickscope-mode +1)
;; don't cross lines, also won't cross visual lines
(setq evil-cross-lines nil)
(setq evil-quickscope-cross-lines nil)

(evil-snipe-mode +1)
(evil-snipe-override-mode -1)
(evil-snipe-override-local-mode -1)

(map! :after evil-snipe
      :map evil-quickscope-mode-map
      :m "t" nil
      :m "T" nil
      :m "f" #'evil-quickscope-find-char
      :m "F" #'evil-quickscope-find-char-backward
      :m "t" #'evil-snipe-f
      :m "T" #'evil-snipe-F
)

(defun prism-colors-solarized ()
  (interactive)
  (prism-set-colors :num 24
    :desaturations '(0) :lightens '(0)
    :colors (list 'all-the-icons-lblue 'font-lock-string-face 'font-lock-keyword-face 'ansi-color-magenta 'font-lock-builtin-face 'font-lock-type-face )
    :comments-fn (lambda (color)
                   (-->
                    (prism-blend color (face-attribute 'font-lock-comment-face :foreground) 0.40)))
    :strings-fn (lambda (color)
                  (--> color
                       (color-desaturate-name it 25)
                       (prism-blend it (face-attribute 'default :background) 0.70)))
  )
)
(after! prism (prism-colors-solarized))
(map! :after prism
      :leader "pmm" #'prism-mode)
(map! :after prism
      :leader "pmw" #'prism-whitespace-mode)

(when (not (string= (system-name) "Jasons-MacBook.local"))
  (progn
    ;;(fset 'rainbow-delimiters-mode #'prism-mode)
    (add-hook 'emacs-lisp-mode-hook 'prism-mode)
    (add-hook 'go-mode-hook 'prism-mode)
    (add-hook 'json-mode-hook 'prism-mode)
    (add-hook 'terraform-mode-hook 'prism-mode)
    (add-hook 'web-mode-hook 'prism-whitespace-mode)

    (add-hook 'python-mode-hook 'prism-whitespace-mode)))

(after! git-gutter-fringe
  ;; I think this fixes the gutter disappearing issue: https://github.com/doomemacs/doomemacs/issues/4369
  (setq-default left-margin-width 1)
  (set-window-buffer nil (current-buffer))

  ;; standardize default fringe width
  ;; (if (fboundp 'fringe-mode) (fringe-mode '(8 . 8)))
  ;; thin fringe bitmaps
  (define-fringe-bitmap 'git-gutter-fr:added [#b111111] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [#b111111] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [#b111111] nil nil '(center repeated))
)

(evil-ex-define-cmd "mm" 'view-echo-area-messages)

(use-package zoom
  :config
  (setq zoom-size '(0.618 . 0.618)
        zoom-ignored-major-modes '(dired-mode vterm-mode help-mode helpful-mode rxt-help-mode help-mode-menu org-mode)
        zoom-ignored-buffer-names '("*doom:scratch*" "*info*" "*helpful variable: argv*")
        zoom-ignored-buffer-name-regexps '("^\\*calc" "\\*helpful variable: .*\\*")
        zoom-ignore-predicates (list (lambda () (< (count-lines (point-min) (point-max)) 20)))))

(evil-ex-define-cmd "zm" 'zoom-mode)
(define-key evil-normal-state-map (kbd "SPC zm") 'zoom-mode)

(plist-put +popup-defaults :select t)
;; workaround popup rule for Messages buffer and stuff so that :select t makes it so zoom doesn't break
(set-popup-rule! "^\\*\\(?:[Cc]ompil\\(?:ation\\|e-Log\\)\\|Messages\\)" :side 'bottom :size 0.3 :width 40 :height 0.3 :vslot -2 :quit t :select t :autosave t :parameters '((transient . t) (no-other-window . t)))

(setq git-gutter:update-interval 1)

(setq ispell-program-name (concat (getenv "HOMEBREW_PREFIX") "/bin/aspell"))

(use-package! peek
  :config
  (progn
    (setq peek-overlay-distance 1)
    (map! :leader "vp" #'peek-overlay-dwim)))

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(setq visual-line-fringe-indicators '(nil nil))

(setq avy-timeout-seconds 0.4)

(when (not (string= (system-name) "Jasons-MacBook.local"))
    (progn
        (setq highlight-indent-guides-auto-character-face-perc 35)
        (setq highlight-indent-guides-auto-top-character-face-perc 70)
        (setq highlight-indent-guides-method 'bitmap)
        (setq highlight-indent-guides-responsive 'top)
        (add-hook! 'prog-mode-hook (if (not (bound-and-true-p indent-tabs-mode)) (indent-bars-mode) (highlight-indent-guides-mode)))
        (add-hook! 'html-mode-hook (if (not (bound-and-true-p indent-tabs-mode)) (indent-bars-mode)))
    )
)

(eval-after-load "lookup"
  (lambda ()
    (defun +lookup-project-search-backend-fn (identifier)
      "Conducts a simple project text search for IDENTIFIER.

  Uses and requires `+ivy-file-search', `+helm-file-search', or `+vertico-file-search'.
  Will return nil if neither is available. These require ripgrep to be installed."
      (when identifier
        (let ((query (rxt-quote-pcre identifier)))
          (ignore-errors
            (cond ((modulep! :completion ivy)
                   (+ivy-file-search :query query)
                   t)
                  ((modulep! :completion helm)
                   (+helm-file-search :query query)
                   t)
                  ((modulep! :completion vertico)
                   (+vertico-file-search :query query)
                   t)
                  )
            )
          )
        )
      )
    )
  )

(defun my/reference-lookup (identifier)
  (+default/search-project-for-symbol-at-point identifier (projectile-project-root)))

(require 'citre)
(require 'citre-config)
(setq-default citre-enable-xref-integration t)

(require 'tramp)

(define-key evil-normal-state-map (kbd "SPC eat") 'eat-project)
(setq eat-enable-yank-to-terminal t)

(defun send-forward-word-to-eat ()
  (interactive)
  (eat-self-input 1 ?\M-f)
)

(defun send-backward-word-to-eat ()
  (interactive)
  (eat-self-input 1 ?\M-b)
)

;; There's no point in being in insert mode in eat terminal
;; for semi char mode at least
(map!
 :mode eat-mode
 :map eat-semi-char-mode-map
 :e "C-w k" #'windmove-up
 :e "C-w C-k" #'windmove-up

 :e "C-w j" #'windmove-down
 :e "C-w C-j" #'windmove-down

 :e "C-w l" #'windmove-right
 :e "C-w C-l" #'windmove-right

 :e "C-w h" #'windmove-left
 :e "C-w C-h" #'windmove-left

 :e "C-w C-q" #'evil-quit
 :e "C-w q" #'evil-quit

 :e "<ESC><ESC>" #'evil-force-normal-state
)

(map!
 :mode eat-mode
 :map (eat-semi-char-mode-map eat-char-mode-map)
 :i "M-<right>" #'send-forward-word-to-eat
 :i "M-<left>" #'send-backward-word-to-eat

 :n "s-v" #'eat-yank
 :v "s-v" #'eat-yank
 :i "s-v" #'eat-yank
 :e "s-v" #'eat-yank

 :n "p" #'eat-yank
 :v "p" #'eat-yank

 :m "C-S-p" #'eat-yank-from-kill-ring
)

(evil-set-initial-state 'eat-mode 'normal)
(evil-set-initial-state 'vterm-mode 'normal)

(add-hook 'prog-mode-hook #'topsy-mode)
(add-hook 'magit-section-mode-hook #'topsy-mode)

(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

(add-to-list 'auto-mode-alist '("\\.tf\\'" . terraform-mode))

(setq web-mode-engines-alist '(("go" . "\\.gohtml\\'")))
(add-to-list 'auto-mode-alist '("\\.gohtml\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.restclient\\'" . restclient-mode))

(setq whitespace-global-modes '(not go-mode))

(require 'exec-path-from-shell)
(setq exec-path-from-shell-arguments '("-l"))
(defun go-update-env ()
  "sets go related environment variables to match the project's version specified by goenv"
  (interactive)
  (if (directory-files (projectile-project-root) :MATCH ".go-version")
      (progn
        (dolist (var '("GOMODCACHE" "GOPATH" "GOROOT" "GOTOOLDIR" "GOVERSION"))
          (add-to-list 'exec-path-from-shell-variables var))
        (exec-path-from-shell-initialize)
        (go-mode))
    (message "warning: no .go-version file found in project root"))
)

(defun go--beginning-of-defun ()
  "Return the line moved to by `beginning-of-defun'."
  (when (> (window-start) 1)
    (save-excursion
      (goto-char (window-start))
      ;;^[[:blank]]* match blank at the beginning (so no comments)
      ;;want to match both struct/interfaces and functions definitions
      ;;pretty printing to get rid of escapes: (type .* (struct | interface).|func .*(.*).*){$
      ;; match type struct or type interface or func something () with { at the end
      (re-search-backward "^[[:blank:]]*\\(type .* \\(struct\\|interface\\).\\|func .*[(].*[)].*\\){$" nil t 1)
      (font-lock-ensure (point) (point-at-eol))
      (buffer-substring (point) (point-at-eol)))))

(after! topsy (add-to-list 'topsy-mode-functions '(go-mode . go--beginning-of-defun)))

(setq js-indent-level 4)

(defun lsp-keybinds-and-stuff ()
  (define-key evil-normal-state-map (kbd "SPC lx") 'lsp-treemacs-errors-list)
  (define-key evil-normal-state-map (kbd "SPC fm") 'lsp-format-buffer)
  (define-key evil-normal-state-map (kbd "gp") 'lsp-ui-doc-glance)
  (evil-ex-define-cmd "fmt" 'lsp-format-buffer)
  (define-key evil-motion-state-map (kbd "C-]") '+lookup/references)
)
(add-hook 'lsp-mode-hook 'lsp-keybinds-and-stuff)
(setq lsp-ui-doc-show-with-mouse nil)
(setq lsp-ui-peek-always-show nil)

(setq lsp-enable-file-watchers nil)

(define-key evil-normal-state-map (kbd "SPC ll") 'lsp-avy-lens)

(defun magit-mappings ()
  (define-key magit-hunk-section-map (kbd "RET") 'magit-diff-visit-file-other-window)
  (define-key magit-hunk-section-map (kbd "<S-return>") 'magit-diff-visit-worktree-file)
  (define-key magit-hunk-section-map (kbd "<C-return>") 'magit-diff-visit-worktree-file-other-window)

  (define-key magit-file-section-map (kbd "RET") 'magit-diff-visit-file-other-window)
  (define-key magit-file-section-map (kbd "<S-return>") 'magit-diff-visit-worktree-file)
  (define-key magit-file-section-map (kbd "<C-return>") 'magit-diff-visit-worktree-file-other-window)
)

(with-eval-after-load "magit" (magit-mappings))
(add-hook 'git-gutter:update-hooks 'magit-after-revert-hook)
(add-hook 'git-gutter:update-hooks 'magit-not-reverted-hook)

(map! :after magit
      :map magit-mode-map
      :n "l" #'evil-forward-char
      :n "C-l" #'magit-log

      :n "h" #'evil-backward-char
      :n "C-h" #'magit-dispatch

      :n "^" #'evil-first-non-blank
      :n "w" #'evil-forward-word-begin

      :n "b" #'evil-backward-word-begin
      :n "C-b" #'magit-branch
)

(setq company-idle-delay 0.5)
(add-hook! 'prog-mode-hook (setq company-idle-delay (if (string= (system-name) "Jasons-MacBook.local") nil 0.3)))
(add-hook! 'org-mode-hook (setq company-idle-delay nil)) ;; company is kind of annoying in org-mode
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

(after! org
    (add-to-list 'org-capture-templates '("w" "Workout Item" entry (file+headline "~/orgmode/roam/iCloudOrg/workout-tracking.org" "Workout")
    "* %U
    :PROPERTIES:
    :WEIGHT:
    :REPS:
    :VISIBILITY: folded
    :END:
    "))

    (add-to-list 'org-capture-templates '("W" "Workout Day" entry (file+headline "~/orgmode/roam/iCloudOrg/workout-tracking.org" "Workout")
    "* %u
    :PROPERTIES:
    :COLUMNS: %20ITEM %WEIGHT{max} %REPS{max}
    :VISIBILITY: folded
    :END:
    "))
)

(defun my/org-insert-time-stamp-with-seconds ()
  (interactive)
  (insert (format-time-string "[%Y-%m-%d %a %H:%M:%S]" (current-time)))
)
(map! :after evil-org
      :map org-mode-map
      :ni "C-c m t s" #'my/org-insert-time-stamp-with-seconds
)

(map! :after evil-org
      :map org-mode-map
      :ni "C-c C-u" #'outline-up-heading
)

(setq org-hide-emphasis-markers t)
(setq org-superstar-headline-bullets-list '("🚀" "✿" "✐" "✦" "✸"))
(setq org-startup-indented t)

(after! org-modern-indent
  (set-face-attribute 'org-modern-bracket-line nil :inherit 'font-lock-comment-face)
)
(add-hook 'org-mode-hook 'org-modern-indent-mode)

(after! org
  (setq org-ellipsis "  ⤵")
  (setq org-cycle-separator-lines -1)
  (setq org-tags-column 0)
)

(after! org
  (setq org-image-actual-width '(300))
)

(map! :after evil-org
      :map org-mode-map
      :n "C-c t s" #'org-table-shrink
      :n "C-c t e" #'org-table-expand
)

;; must be set BEFORE org loads so don't put this in an after! org block
(setq org-directory "~/orgmode/")

(map! :after evil-org
      :map emacs-lisp-mode-map
      :n "C-c C-v C-o" #'org-babel-tangle-jump-to-org
      :n "C-c C-v o" #'org-babel-tangle-jump-to-org
)

(after! org
  (org-babel-do-load-languages
   'org-babel-load-languages
   (append org-babel-load-languages '((protobuf-mode . t)))))

(let* ((plantuml_path (expand-file-name "~/orgmode/plantuml.jar")))
  (setq org-plantuml-jar-path plantuml_path)
  (setq plantuml-jar-path plantuml_path)
  (if (file-exists-p plantuml_path)
    nil
    (plantuml-download-jar)
  )
)
(setq plantuml-default-exec-mode 'jar)

;; I believe this sets the smart parens to match the major mode of the src block
;; which is why we needed to change "elisp-mode" to "emacs-lisp-mode"
(defun sp-in-src-block-p (_id _action _context)
  (when (org-in-src-block-p)
    (let* ((el (org-element-at-point))
            (lang (org-element-property :language el))
            (mode (intern (concat (if (string= lang "elisp") "emacs-lisp" lang) "-mode"))))
      (memq mode sp-lisp-modes))))

(after! smartparens
  (require 'smartparens-config)
  (sp-local-pair 'org-mode "\\[" "\\]")
  ;;(sp-local-pair 'org-mode "$" "$")
  (sp-local-pair 'org-mode "'" "'" :unless '(:add sp-in-src-block-p))
  (sp-local-pair 'org-mode "=" "=" :actions '(rem))
  (sp-local-pair 'org-mode "\\left(" "\\right)" :trigger "\\l(" :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (sp-local-pair 'org-mode "\\left[" "\\right]" :trigger "\\l[" :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (sp-local-pair 'org-mode "\\left\\{" "\\right\\}" :trigger "\\l{" :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (sp-local-pair 'org-mode "\\left|" "\\right|" :trigger "\\l|" :post-handlers '(sp-latex-insert-spaces-inside-pair))
)

(use-package! org-habit
  :after org
  :config
  (setq org-habit-following-days 7
        org-habit-preceding-days 35
        org-habit-show-habits t
        org-habit-show-habits-only-for-today nil))

(add-hook 'org-mode-hook 'org-edna-mode)

(setq alert-default-style 'osx-notifier)
(after! org-yaap
  (setq org-yaap-daily-alert 12)
  (setq org-yaap-alert_before 5)
  (setq org-yaap-overdue-alerts nil)
  (setq org-yaap-persistent-click t)
  (setq org-yaap-persistent-clock t)
)
(define-advice notifications-notify
    (:override (&rest params) using-alert)
  (alert (string-trim (replace-regexp-in-string "[^[:ascii:]]+" "" (plist-get params :body)))
         :title (plist-get params :title)))
(add-hook 'org-mode-hook 'org-yaap-mode)

(map! :after evil-org
      :map evil-org-mode-map
      :i [return] #'+default/newline
      :i "RET" #'+default/newline)

(add-hook 'org-mode-hook 'org-sticky-header-mode)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(after! org (setq org-roam-directory "~/orgmode/roam/") (setq org-roam-index-file "~/orgmode/roam/index.org"))
(map! :after evil-org
      :map evil-org-mode-map
      :n "C-c n n" #'org-roam-buffer-toggle
      :n "C-c n f" #'org-roam-node-find
      :n "C-c n r" #'org-roam-node-random
      :n "C-c n i" #'org-roam-node-insert
      :n "C-c n o" #'org-id-get-create
      :n "C-c n t" #'org-roam-tag-add
      :n "C-c n a" #'org-roam-alias-add
      :n "C-c n l" #'org-roam-buffer-toggle)

(defun my/org-roam-node-read--to-candidate (node template)
    "Return a minibuffer completion candidate given NODE.
  TEMPLATE is the processed template used to format the entry."
    (let ((candidate-main (org-roam-node--format-entry
                           template
                           node
                           (1- (frame-width)))))
      (cons (propertize candidate-main 'node node) node)))

(advice-add 'org-roam-node-read--to-candidate :override #'my/org-roam-node-read--to-candidate)

(after! org
  (setq org-roam-dailies-directory "daily/")

  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
          "* %?"
          :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))
)

(setq org-agenda-files
  (list (expand-file-name "AGENDA_FILE.org")))

(after! org
  (setq org-agenda-prefix-format
    '((agenda . " %i %16:c %?-12t% s")
      (todo . " %i %-12:c")
      (tags . " %i %-12:c")
      (search . " %i %-12:c")))
)

(after! org
  (setq org-agenda-todo-ignore-scheduled 'all)
)

(after! org
  (setq org-agenda-current-time-string "← now ─────────")
  (setq org-agenda-current-time-string "󰇥 󰇥 󰇥 〰〰〰〰〰〰")
)

(after! org
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)
)

(map! :after evil-org-agenda
      :map evil-org-agenda-mode-map
      :m "[" nil
      :m "]" nil
      :m "[a" #'org-agenda-earlier
      :m "]a" #'org-agenda-later
      :m "[F" #'+evil/previous-frame
      :m "]F" #'+evil/next-frame
)

(use-package! health-template)

(map! :after evil
      :m "^" nil
      :m "^" #'doom/backward-to-bol-or-indent
)

(setq doom-modeline-modal-icon nil)

(after! vertico
  (define-key evil-normal-state-map (kbd "SPC F") 'projectile-find-file)
  (define-key evil-normal-state-map (kbd "SPC G") '+vertico/project-search)
  (define-key evil-visual-state-map (kbd "SPC G") '+vertico/project-search)

  (define-key vertico-map (kbd "C-d") 'vertico-scroll-up)
  (define-key vertico-map (kbd "C-u") 'vertico-scroll-down)
  (define-key vertico-map (kbd "C-w C-w") 'previous-window-any-frame)

  (define-key vertico-map (kbd "C-S-n") 'vertico-next-group)
  (define-key vertico-map (kbd "C-S-p") 'vertico-previous-group)

  (define-key evil-normal-state-map (kbd "C-S-p") 'consult-yank-from-kill-ring)
  (define-key evil-insert-state-map (kbd "C-S-p") 'consult-yank-from-kill-ring)
)

(define-key evil-normal-state-map (kbd "C-t") 'pop-global-mark)
(better-jumper-mode +1)
(define-key evil-motion-state-map (kbd "<C-o>") 'better-jumper-jump-backward)
(define-key evil-motion-state-map (kbd "<C-i>") 'better-jumper-jump-forward)
(setq-default evil-escape-key-sequence "kj")

(evil-define-command evil-ex-ranger (path)
  (interactive "<a>")
  (if
      (= (length (window-list)) 1)
      (if path (ranger-find-file (expand-file-name path)) (ranger))
      (dired (expand-file-name path)))
)
(evil-ex-define-cmd "e" #'evil-ex-ranger)
(setq ranger-show-hidden t)

(evil-ex-define-cmd "q" 'kill-this-buffer)
(evil-ex-define-cmd "quit" 'evil-quit)

(global-subword-mode)
(add-hook! 'prog-mode-hook (modify-syntax-entry ?_ "-"))
(add-hook! 'org-mode-hook (modify-syntax-entry ?_ "-"))

(defun skip-dash-forward (n &rest foo)
  (when (or (eq (char-after (point)) ?-) (eq (char-after (point)) ?_))
    (forward-char)))

(defun skip-dash-forward-end (n &rest foo)
  (if (or (eq (char-after (point)) ?-) (eq (char-after (point)) ?_))
      (forward-char)))

(defun skip-dash-backward (n &rest foo)
  (when (or (eq (char-before (point)) ?-) (eq (char-before (point)) ?_))
    (backward-char)))

(advice-add 'evil-forward-word-begin :after #'skip-dash-forward)
(advice-add 'evil-forward-word-end :after #'skip-dash-forward-end)
(advice-add 'evil-backward-word-begin :before #'skip-dash-backward)

(define-key evil-normal-state-map (kbd "C-c p [") #'+workspace/swap-left)
(define-key evil-normal-state-map (kbd "C-c p ]") #'+workspace/swap-right)

(evil-define-command my-workspace-switch-next (&optional count)
  (interactive "<c>")
  (if count (+workspace/switch-to (- count 1)) (+workspace/cycle +1))
)

(evil-define-command my-workspace-switch-prev (&optional count)
  (interactive "<c>")
  (if count (+workspace/switch-to (- count 1)) (+workspace/cycle -1))
)

(define-key evil-normal-state-map (kbd "gt") 'my-workspace-switch-next)
(define-key evil-normal-state-map (kbd "gT") 'my-workspace-switch-prev)

(map! :after hideshow
      :mode prog-mode
      :n "zC" nil
      :n "zO" nil
      :n "zo" nil
      :n "zc" nil
      :n "za" nil
      :n "zC" #'hs-hide-all
      :n "zO" #'hs-show-all
      :n "zo" #'hs-show-block
      :n "zc" #'hs-hide-block
      :n "za" #'hs-toggle-hiding
)

(map! :after flycheck
      :mode flycheck-mode
      :n "[e" nil
      :n "]e" nil
      :n "[e" #'flycheck-previous-error
      :n "]e" #'flycheck-next-error
)
