;;; init.el --- My init.el  -*- lexical-binding: t; -*-

;;; Commentary:

;; My init.el.

;;; Code:
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))
 (leaf leaf-keywords
    :ensure t

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

 
;; coding UFT8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)



;;カラーテーマ
  
  



;;line number の表示
(require 'linum)
(global-linum-mode 1)



;;カッコの自動挿入
(electric-pair-mode 1)

;; line number を分かりやすくする
(set-face-attribute 'linum nil
            :foreground "#a9a9a9"
            :background "#404040"
            :height 0.9)


;; 対応する括弧をハイライト
(show-paren-mode 1)

;; リージョンのハイライト
(transient-mark-mode 1)
;; current directory 表示
(let ((ls (member 'mode-line-buffer-identification
                mode-line-format)))
  (setcdr ls
    (cons '(:eval (concat " ("
          (abbreviate-file-name default-directory)
      ")"))
        (cdr ls))))


;; *.~  バックアップファイルを作らない
(setq make-backup-files nil)
;; .#*  バックアップファイルを作らない
(setq auto-save-default nil)

;; 大文字・小文字を区別しない
(setq case-fold-search t)




;; neotree

(leaf neotree
  :ensure t
  :init
 
  :config
  (setq neo-smart-open t)
 
  (setq neo-create-file-auto-open t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (bind-key [f8] 'neotree-toggle)
  (bind-key "RET" 'neotree-enter-hide )
  (bind-key "a" 'neotree-hidden-file-toggle )
  (bind-key "<left>" 'neotree-select-up-node )
  (bind-key "<right>" 'neotree-change-root ))


;; Change neotree's font size
;; Tips from https://github.com/jaypei/emacs-neotree/issues/218
(defun neotree-text-scale ()
  "Text scale for neotree."
  (interactive)
  (text-scale-adjust 0)
  (text-scale-decrease 1)
  (message nil))
(add-hook 'neo-after-create-hook
      (lambda (_)
        (call-interactively 'neotree-text-scale)))


(leaf flycheck
  :ensure t
  :init (global-flycheck-mode))






;; スタートアップメッセージを表示させない
(setq inhibit-startup-message 1)
;; ターミナルで起動したときにメニューを表示しない
(if (setq window-system 'x)
    (menu-bar-mode 1) (menu-bar-mode 0))
(menu-bar-mode nil)

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

(leaf dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(leaf avy :ensure t
  :config
  (bind-key "M-g M-f" 'avy-goto-line)
  (bind-key "M-g M-d" 'avy-goto-word-0)
  (bind-key "C-:" 'avy-goto-char))


  (provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(bind-key avy doom-modeline dashboard tree-sitter flycheck neotree company leaf-keywords leaf)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 ;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
