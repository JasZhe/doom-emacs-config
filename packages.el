(package! eat :recipe (:host codeberg :repo "akib/emacs-eat" :files ("*.el" ("term" "term/*.el") "*.texi"
               "*.ti" ("terminfo/e" "terminfo/e/*")
               ("terminfo/65" "terminfo/65/*")
               ("integration" "integration/*")
               (:exclude ".dir-locals.el" "*-tests.el"))) :pin "f01afd6c24289f0f3b3b0409baae7c266adfd43b")

(package! exec-path-from-shell :pin "ddd24dc823de9a94435b4d8ea7569161657f31e2")

(package! protobuf-mode :recipe (:host github :repo "protocolbuffers/protobuf" :files ("editors/protobuf-mode.el")) :pin "d73406a0077d7e9d8800abebc6e32f2af0e602cc")

(package! citre :pin "4626ada80fabea6b62935567acc1cb8dad607016")

(package! solarized-theme :pin "0f0b1129cf51c85904f9e015da4fcca5f5f7a4ce")
(package! modus-themes :pin "7661b78509c86bb8f4faf8f9cf605dfbb29c18a2")

;; needed for org-roam-ui
(unpin! org-roam)
;; fucking sick graph visualization of org-roam
(package! org-roam-ui :pin "5ac74960231db0bf7783c2ba7a19a60f582e91ab")

;; todo functions
(package! org-edna :pin "de6454949045453e0fa025e605b445c3ca05c62a")

;; using org as a restclient
(if (string= (system-name) "Jasons-MacBook.local") (package! verb :pin "4bc23d78a723c6b184a949507b3061c8da8e831c"))

;; make headers stick to top of window if it leaves the screen
(package! org-sticky-header :pin "697875935b04b25c8229b9155a1ea0cab3ebe629")
(package! org-super-agenda :pin "f4f528985397c833c870967884b013cf91a1da4a")

(package! org-modern-indent :recipe (:host github :repo "jdtsmith/org-modern-indent") :pin "85f95d093d9b2d8fb9e4a705529eac4e2a888e87")

(package! alert :pin "c762380ff71c429faf47552a83605b2578656380")
(package! org-yaap :recipe (:host gitlab :repo "tygrdev/org-yaap") :pin "bab336dc62ca0ec953b1c3644db9bda7c7a9506b")

(when (not (string= (system-name) "MBP-20143438.local")) (package! ob-ledger :recipe (:local-repo "lisp/ob-ledger")))

(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))

;; scope colors
(package! prism :pin "169b49afa91e69d35b8756df49ed3ca06f418d35")
;; fast af search
(package! ripgrep :pin "b6bd5beb0c11348f1afd9486cbb451d0d2e3c45a")
;; better mark navigation like C-o and C-i for vim
(package! better-jumper :pin "47622213783ece37d5337dc28d33b530540fc319")
;; sticky breadcrumb like header for func declaration if the declaration leaves the screen
(package! topsy :pin "86d4234e4a0e9d2f5bf0f1114ea9893da48e77d1")
;; makes f F navigation easier
(package! evil-quickscope :pin "37a20e4c56c6058abf186ad4013c155e695e876f")

;; better window focusing
(package! zoom :pin "2104abb074682db79b9ff3a748e8e2e760a4d8cf")

;; handy feature to snip a section from another buffer (or current buffer) and peek it in the current buffer
(package! peek :recipe (:type git :host sourcehut :repo "meow_king/peek") :pin "c7d86147ea3fced6c394a9a58467872133da5cba")

;; partial horizontal scroll
(package! phscroll :recipe (:host github :repo "misohena/phscroll" :files ("*.el")) :pin "16aa0f1b85ce14364e01d7c40d6f1fe28700c14c")

;; health
(package! health-template :recipe (:host gitlab :repo "dto/health-template" :files ("*.el")) :pin "d9e25fb65f5587b3a7d5c64f0c9f773d37ead23b")

;; better indent bars
(when IS-MAC (package! indent-bars :recipe (:host github :repo "jdtsmith/indent-bars" :files ("*.el"))  :pin "4dc2b9e329cf7497a3f02939e0cff816c7295f8b"))

;; other indent package
(package! highlight-indent-guides :pin "cf352c85cd15dd18aa096ba9d9ab9b7ab493e8f6")

;; epub reader
(when (not (string= (system-name) "MBP-20143438.local")) (package! nov :pin "58c35e677e11f5c04a702b42ac753c80c8955089"))

(when (string= (system-name) "MBP-20143438.local")
  (progn
    (package! gnuplot :disable t)
    (package! gnuplot-mode :disable t)))
