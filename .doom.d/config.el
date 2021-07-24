;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Tamir Azrab"
      user-mail-address "tamirazrab@gmail.com")


;defauls settings
(setq confirm-kill-emacs nil) ; kill emacs without asking for confirmation

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 tab-width 4                                                         ; Set width for tabs
 uniquify-buffer-name-style 'forward      ; Uniquify buffer names
 window-combination-resize t                    ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                                           ; Stretch cursor to the glyph width

(setq undo-limit 80000000                          ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                             ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                                    ; Nobody likes to loose work, I certainly don't
      inhibit-compacting-font-caches t)      ; When there are lots of glyphs, keep them in memory

(delete-selection-mode 1)                             ; Replace selection when inserting text
(display-time-mode 1)                                   ; Enable time in the mode-line
(global-subword-mode 1)                           ; Iterate through CamelCase words
(setq-default line-spacing 0.5)                                   ; seems like a nice line spacing balance.


; Open emacs in full window by-default

(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))                           ; On laptops it's nice to know how much power you have
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
(setq treemacs-position 'right)
;; font string. You generally only need these two:
 (setq doom-font (font-spec :family "MonoLisa" :size 15 ))
(custom-set-faces! '(font-lock-keyword-face :slant italic))
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Line numbers are pretty slow all around. The performance boost of
;; disabling them outweighs the utility of always keeping them on.
(setq display-line-numbers-type 'relative)


(setq frame-title-format
    '(""
      (:eval
       (if (s-contains-p org-roam-directory (or buffer-file-name ""))
           (replace-regexp-in-string ".*/[0-9]*-?" "🢔 " buffer-file-name)
         "%b"))
      (:eval
       (let ((project-name (projectile-project-name)))
         (unless (string= "-" project-name)
           (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(use-package super-save
  :ensure t
  :config
  (super-save-mode +1))
(setq auto-save-default nil)
(setq super-save-auto-save-when-idle t)

;(map! "<C-l>" #'forward-evil-space)



;(map! "<C-h>" #'move-to-left-margin)
(evil-define-key 'insert global-map (kbd "C-h") 'evil-backward-char )
(evil-define-key 'insert global-map (kbd "C-l") 'evil-forward-char )
(evil-define-key 'insert global-map (kbd "C-k") 'evil-previous-line)
(evil-define-key 'insert global-map (kbd "C-j") 'evil-next-line )
(map! )

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

(require 'treemacs-all-the-icons)
(treemacs-load-theme "all-the-icons")
