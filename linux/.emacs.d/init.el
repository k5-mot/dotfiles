;;;
;;; package読み込み
;;;
(require 'package)
;; package-archivesを上書き
(setq package-archives
  '(
    ("melpa" . "https://melpa.org/packages/")
    ;("melpa-stable" . "https://stable.melpa.org/packages/")
    ("org" . "https://orgmode.org/elpa/")
    ("gnu" . "https://elpa.gnu.org/packages/")
  )
)
;; RSA署名有効化
(setq package-check-signature 'allow-unsigned)
;(setq package-check-signature nil)
;; 初期化
(package-initialize)
;; パッケージ情報の更新
;(package-refresh-contents)
;; インストールするパッケージ
(defvar my/favorite-packages
  '(
		;; for RSA
		gnu-elpa-keyring-update
    ;; for auto-complete
    auto-complete fuzzy popup pos-tip

  ))
;; my/favorite-packagesからインストールしていないパッケージをインストール
(dolist (package my/favorite-packages)
  (unless (package-installed-p package)
    (package-install package)))

;;;
;;; General
;;;
;; UTF-8の設定
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;; *.~ バックアップファイルを作らない
(setq make-backup-files nil)
;; .#* バックアップファイルを作らない
(setq auto-save-default nil)
;; 括弧の対応関係をハイライト表示
(show-paren-mode nil)
;; スタートアップ画面を表示しないようにする
(setq inhibit-startup-message t)
;; 背景を透過させる
;(set-frame-parameter nil 'alpha '(90 70))
;; ツールバーを表示しないようにする（Official Emacs の場合は 0）
(tool-bar-mode 0)
;; ツールバーを表示しないようにする（Official Emacs の場合は 0）
;; ウィンドウ（フレーム）のサイズ設定する
(setq default-frame-alist '((width . 100) (height . 60)))
;; 時間も表示
(display-time)
;; emacs テーマ選択
;;(load-theme 'manoj-dark t)
;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)
;; メニューバーを非表示
(if (not window-system) (menu-bar-mode 0))
;; 現在ポイントがある関数名をモードラインに表示
(which-function-mode 1)
;; 対応する括弧をハイライト
(show-paren-mode 1)
;; リージョンのハイライト
(transient-mark-mode 1)
;; current directory 表示
(let ((ls (member 'mode-line-buffer-identification mode-line-format)))
  (setcdr ls (cons '(:eval (concat " (" (abbreviate-file-name default-directory) ")")) (cdr ls))))
;; エラー音をならなくする
(setq ring-bell-function 'ignore)
;; タブインデントのサイズ
(setq default-tab-width 2)
;; タイトルにフルパス表示
(setq frame-title-format "%f")
;; scratch の初期メッセージ消去
(setq initial-scratch-message "")
;; スクロールは 1 行ごと
(setq mouse-wheel-scroll-amount '(5                ; 通常時 
																	((shift) . 1)    ; SHIFT
																	((control) . 20) ; CTRL
																	))
;; スクロールの加速をやめる
(setq mouse-wheel-progressive-speed nil)
;; スクロールのステップ量
(setq scroll-conservatively 1)
;; スクロールのマージン
(setq scroll-margin 10)
;;
(setq next-screen-context-lines 10)
(setq scroll-preserve-screen-position t)
;; 大文字・小文字を区別しない
(setq case-fold-search t)
;; dark-mode
(set-face-background 'default "#303030")
(set-face-foreground 'default "#ffffff")
;; set normal window
(setq-default truncate-lines t)
(setq-default truncate-partial-width-windows t)
;; delete welcome screen
(setq initial-scratch-message t)
(setq initial-scratch-message nil)
;; 入力の設定
(setq default-input-method "japanese-egg-anthy")
;; 日本語切り替え
(global-set-key "\C-o" 'toggle-input-method)
;; フォントの設定
(add-to-list 'default-frame-alist '(font . "Ricty Diminished Discord-14"))

;;;
;;; package用設定
;;;
;; savaplace (カーソル位置の保存)
(require 'saveplace)
(save-place-mode 1)
;; 左側に行番号表示をする
(require 'linum)
(global-linum-mode t)
(setq linum-format "%3d|")
;; line number を分かりやすくする
(set-face-attribute 'linum nil
  :foreground "#a9a9a9"
  :background "#404040"
  :height 0.9)
;; auto-complete用
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ
(setq ac-delay 0.05)
(setq ac-auto-show-menu 0.05)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (gnu-elpa-keyring-update auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
