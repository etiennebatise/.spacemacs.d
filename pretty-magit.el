(require 'dash)
(require 'helm)  ; for leader-prompts only
;; (require 'evil)  ; Remove evil-insert at end if not using evil

(provide 'pretty-magit)

;;; Pretty-magit

(setq pretty-magit-alist nil)
(setq pretty-magit-prompt nil)

;;;###autoload
(defmacro pretty-magit (WORD ICON PROPS &optional NO-PROMPT?)
  "Replace sanitized WORD with ICON, PROPS and by default add to prompts."
  `(progn
     (add-to-list 'pretty-magit-alist
                  (list (rx bow (group ,WORD (eval (if ,NO-PROMPT? "" ":"))))
                        ,ICON ',PROPS))
     (unless ,NO-PROMPT?
       (add-to-list 'pretty-magit-prompt (concat ,WORD ": ")))))

(pretty-magit "feat"    ? (:foreground "slate gray" :height 1.2))
(pretty-magit "add"     ? (:foreground "#375E97" :height 1.2))
(pretty-magit "fix"     ? (:foreground "#FB6542" :height 1.2))
(pretty-magit "refact"  ? (:foreground "#FFBB00" :height 1.2))
(pretty-magit "docs"    ? (:foreground "#3F681C" :height 1.2))
(pretty-magit "master"  ? (:height 1.2) t)
(pretty-magit "origin"  ? (:height 1.2) t)

;;;###autoload
(defun add-magit-faces ()
  "Add face properties and compose symbols for buffer from pretty-magit."
  (interactive)
  (with-silent-modifications
    (--each pretty-magit-alist
      (-let (((rgx icon props) it))
        (save-excursion
          (goto-char (point-min))
          (while (search-forward-regexp rgx nil t)
            (compose-region
             (match-beginning 1) (match-end 1) icon)
            (when props
              (add-face-text-property
               (match-beginning 1) (match-end 1) props))))))))

;;; Leader Prompts

(setq use-magit-commit-prompt-p nil)
(defun use-magit-commit-prompt (&rest args)
  (setq use-magit-commit-prompt-p t))

;;;###autoload
(defun magit-commit-prompt ()
  "Magit prompt and insert commit header with faces."

  (interactive)
  (when use-magit-commit-prompt-p
    (setq use-magit-commit-prompt-p nil)
    (insert (helm :sources (helm-build-sync-source "Commit Type "
                             :candidates pretty-magit-prompt)
                  :buffer "*magit cmt prompt*"))
    (add-magit-faces)
    (evil-insert 1)))

;;; Hooks

(remove-hook 'git-commit-setup-hook 'with-editor-usage-message)
(add-hook 'git-commit-setup-hook 'magit-commit-prompt)

(advice-add 'magit-status :after 'add-magit-faces)
(advice-add 'magit-refresh-buffer :after 'add-magit-faces)
(advice-add 'magit-commit :after 'use-magit-commit-prompt)
