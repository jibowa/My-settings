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
                                                                                        
;; coding UFT8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)



;;カラーテーマ
  
     (leaf doom-themes
    :when window-system
    :ensure t
    :custom
    (doom-themes-enable-italic t)
    (doom-themes-enable-bold t)
    :custom-face
    (doom-modeline-bar ((t (:background "#6272a4"))))
    :config
    (load-theme 'doom-dracula t)
    
    (doom-themes-org-config))
   



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
;;(let ((ls (member 'mode-line-buffer-identification
;;                mode-line-format)))
;;  (setcdr ls
;;    (cons '(:eval (concat " ("
;;          (abbreviate-file-name default-directory)
;;      ")"))
;;        (cdr ls))))


;; *.~  バックアップファイルを作らない
(setq make-backup-files nil)
;; .#*  バックアップファイルを作らない
(setq auto-save-default nil)

;; 大文字・小文字を区別しない
(setq case-fold-search t)
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(avy doom-modeline dashboard tree-sitter-langs tree-sitter flycheck use-package package-utils rainbow-mode company neotree))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ricty Diminished" :foundry "outline" :slant normal :weight normal :height 109 :width normal))))
 '(doom-modeline-bar ((t (:background "#6272a4")))))


;;Company-mode
(leaf company :ensure t
:hook
(after-init-hook . global-company-mode)
:custom
(setq company-idle-delay 0.3)
(setq company-minimum-prefix-length 1))


;; 候補に番号を付け、
;; M-1やM-2などM-をつけて押すことで候補選択をショートカットできる
(setq company-show-quick-access t)

;; 候補の一番下でさらに下に行こうとすると一番上に戻る
(setq company-selection-wrap-around t)

;; ツールチップ上の候補を右揃え
(setq company-tooltip-align-annotations t)




;; neotree

(leaf neotree
  :ensure t
  :init
 
  :config
  (setq neo-smart-open t)
 
  (setq neo-create-file-auto-open t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (bind-key [f8] 'neotree-toggle)
  (bind-key "RET" 'neotree-enter-hide neotree-mode-map)
  (bind-key "a" 'neotree-hidden-file-toggle neotree-mode-map)
  (bind-key "<left>" 'neotree-select-up-node neotree-mode-map)
  (bind-key "<right>" 'neotree-change-root neotree-mode-map))


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

;;(require 'tree-sitter-langs)
;;(require 'tree-sitter)

;;(global-tree-sitter-mode)
;;(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(leaf tree-sitter :ensure t 
 :init
 (global-tree-sitter-mode)
 :hook
 (tree-sitter-after-on-hook . tree-sitter-hl-mode)
 :config
 (leaf tree-sitter-langs :ensure t))

(leaf dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(leaf doom-modeline
  :when window-system
  :ensure t
  :custom
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  
  :hook
  (after-init . doom-modeline-mode))

(leaf avy :ensure t
  :config
  (bind-key "M-g M-f" 'avy-goto-line)
  (bind-key "M-g M-d" 'avy-goto-word-0)
  (bind-key "C-:" 'avy-goto-char))
  
;;; init.el ends here
