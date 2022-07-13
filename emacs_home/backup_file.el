;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; make-backup-file-name will store my
;;;; files in dated directories
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-backup-file-name (FILE)
  "Create a name full relative directory for the backup of give argument FILE."
  (let ((dirname (concat "backup/emacs/"
			 (format-time-string "%Y_%b_%d/"))))
    (if (not (file-exists-p dirname))
	(make-directory dirname t))
    (concat dirname
	    (concat (file-name-nondirectory (concat "~" FILE))
		    (format-time-string "@%I-%M-%S%-p")))))

(setq make-backup-files nil)

(defun make-backup-current-file ()
  "Interactive command to backup the current file.  Make a backup file for the current buffer."
(interactive)
(let ((filename (buffer-file-name))
      backupname)
  (if (not filename) (error "Current Buffer is not File!!")
    (progn
      (setq backupname (make-backup-file-name (concat "~" filename)))
      (while (file-exists-p backupname)
	(setq backupname (make-backup-file-name (concat "~" filename))))
      (copy-file filename
		 (concat (file-name-directory filename) backupname))))))


(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Rename file and current buffer
;;;; Credit - my-dot-emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun rename-file-and-buffer (new-name)
  "Rename both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
	(filename (buffer-file-name)))
    (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
      (if(get-buffer new-name)
	  (message "A buffer named '%s' already exists!" new-name)
	(progn (rename-file filename new-name 1)
	       (rename-buffer new-name)
	       (set-visited-file-name new-name)
	       (set-buffer-modified-p nil))))))
;; Casey: Never understood why Emacs doesn't have this function, either.
;; END OF CUSTOM THINGS
