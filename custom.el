(put 'customize-variable 'disabled nil)
(put 'customize-face 'disabled nil)
(put 'customize-group 'disabled nil)
(put 'list-timers 'disabled nil)
(custom-set-variables
 '(safe-local-variable-values
   '((eval if
      (string=
       (system-name)
       "Jasons-MacBook.local")
      (verb-mode))
     (eval add-hook 'after-save-hook
      (lambda nil
        (org-babel-tangle))
      nil t)
     (eval progn
      (defun file-symlink-p
          (FILENAME)
        nil)) ;; for .dir-locals in orgmode, which makes it so we don't expand symlinks, so projectile stays in orgmode project
     (eval add-hook 'after-save-hook
      (lambda nil
        (if
            (y-or-n-p "Tangle?")
            (org-babel-tangle)))
      nil t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(+workspace-tab-selected-face ((t (:inherit all-the-icons-pink :underline t))))
 '(org-ellipsis ((t (:inherit variable-pitch :foreground "#a89984"))))
 '(dired-header ((t (:inherit default :background "unspecified" :foreground "unspecified"))))
 ;; '(highlight ((t (:background "LightYellow1")))) ;;only needed for solarized-light if i want highlighting to pop
)
