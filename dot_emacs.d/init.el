;;; init.el --- 最小Emacs設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; パッケージ導入を行わず、復旧時や短時間編集に必要な最小設定だけを管理します。

;;; Code:

;; 日本語とUTF-8を既定にする。
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

;; 起動時の余計な表示を抑える。
(setq initial-scratch-message nil)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)

;; cache配下へbackupとautosaveを集約する。
(setq make-backup-files t)
(setq backup-directory-alist '((".*" . "~/.cache/emacs/backup")))
(setq auto-save-default t)
(setq auto-save-file-name-transforms
      '(("\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'" "~/.cache/emacs/autosave/\\2" t)))
(setq auto-save-list-file-prefix "~/.cache/emacs/auto-save-list")

;; 基本的な編集体験だけを揃える。
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq ring-bell-function 'ignore)
(setq frame-title-format "%f")
(setq scroll-conservatively 35)
(setq scroll-margin 5)
(setq scroll-step 1)
(setq next-screen-context-lines 5)
(setq scroll-preserve-screen-position t)
(defalias 'yes-or-no-p 'y-or-n-p)

;; 端末でも邪魔になりやすいUIを消す。
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; 標準機能だけで位置情報と括弧対応を見やすくする。
(line-number-mode t)
(column-number-mode t)
(if (fboundp 'global-display-line-numbers-mode)
    (global-display-line-numbers-mode t)
  (global-linum-mode t))
(blink-cursor-mode 0)
(show-paren-mode t)
(setq show-paren-style 'mixed)
(transient-mark-mode t)
(setq kill-whole-line t)

;;; init.el ends here
