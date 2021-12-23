(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(setq package-selected-packages '(which-key helm))
;; (when (cl-find-if-not #'package-installed-p package-selected-packages)
;;   (package-refresh-contents)
;;   (mapc #'package-install package-selected-packages))
;; (load-theme 'zenburn t)
(helm-mode)
;; (require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
;; (which-key-mode)
;; (add-hook 'prog-mode-hook #'lsp)
;; (setq gc-cons-threshold (* 100 1024 1024)
;;       read-process-output-max (* 1024 1024)
;;       company-idle-delay 0.0
;;       company-minimum-prefix-length 1
;;       create-lockfiles nil) ;; lock files will kill `npm start'
;; (with-eval-after-load 'lsp-mode
;;   (require 'dap-chrome)
;;   (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
;;   (yas-global-mode))

;; (setq lsp-server-install-dir "c:/lsp")

(require 'tramp)
(setq tramp-debug-buffer t)
(setq tramp-verbose 10)
(setq tramp-auto-save-directory "~/tramp-temp")

(add-to-list 'tramp-methods
             `("plinkw"
               (tramp-login-program        "plink")
               ;; ("%h") must be a single element, see `tramp-compute-multi-hops'.
               (tramp-login-args           (("-l" "%u") ("-P" "%p") ("-t")
                                            ("%h") ("\"")
                                            (,(format
                                               "env 'TERM=%s' 'PROMPT_COMMAND=' 'PS1=%s'"
                                               tramp-terminal-type
                                               "$"))
                                              ("/bin/sh") ("\"")))
               (tramp-remote-shell         "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe")
               (tramp-default-port         22))
             )

;; (when (string-equal system-type "windows-nt")
;;   (add-to-list 'tramp-methods
;;                `("sshw"
;;                  (tramp-login-program        "fakecygpty ssh")
;;                  ;; ("%h") must be a single element, see `tramp-compute-multi-hops'.
;;                  (tramp-login-args           (("-l" "%u" "-o \"StrictHostKeyChecking=no\"") ("-P" "%p") ("-t")
;;                                               ("%h") ("\"")
;;                                               (,(format
;;                                                  "env 'TERM=%s' 'PROMPT_COMMAND=' 'PS1=%s'"
;;                                                  tramp-terminal-type
;;                                                  "##"))
;;                                               ("/bin/sh") ("\"")))
;;                  (tramp-remote-shell         "/bin/sh")
;;                  (tramp-remote-shell-login   ("-l"))
;;                  (tramp-remote-shell-args    ("-c"))
;;                  (tramp-default-port         22))
;;                )

(setq tramp-default-method "plinkw")

;; (("smb"
;;   (tramp-remote-shell "")
;;   (tramp-tmpdir "/C$/Temp"))
;;  ("fcp"
;;   (tramp-login-program "fsh")
;;   (tramp-login-args
;;    (("%h")
;;     ("-l" "%u")
;;     ("sh" "-i")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-i")
;;    ("-c"))
;;   (tramp-copy-program "fcp")
;;   (tramp-copy-args
;;    (("-p" "%k")))
;;   (tramp-copy-keep-date t))
;;  ("psftp"
;;   (tramp-login-program "plink")
;;   (tramp-login-args
;;    (("-l" "%u")
;;     ("-P" "%p")
;;     ("-ssh")
;;     ("-t")
;;     ("%h")
;;     ("\"")
;;     ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
;;     ("/bin/sh")
;;     ("\"")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-copy-program "pscp")
;;   (tramp-copy-args
;;    (("-l" "%u")
;;     ("-P" "%p")
;;     ("-sftp")
;;     ("-p" "%k")
;;     ("-q")
;;     ("-r")))
;;   (tramp-copy-keep-date t)
;;   (tramp-copy-recursive t))
;;  ("pscp"
;;   (tramp-login-program "plink")
;;   (tramp-login-args
;;    (("-l" "%u")
;;     ("-P" "%p")
;;     ("-ssh")
;;     ("-t")
;;     ("%h")
;;     ("\"")
;;     ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
;;     ("/bin/sh")
;;     ("\"")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-copy-program "pscp")
;;   (tramp-copy-args
;;    (("-l" "%u")
;;     ("-P" "%p")
;;     ("-scp")
;;     ("-p" "%k")
;;     ("-q")
;;     ("-r")))
;;   (tramp-copy-keep-date t)
;;   (tramp-copy-recursive t)
;;   (tramp-default-port 22))
;;  ("plinkx"
;;   (tramp-login-program "plink")
;;   (tramp-login-args
;;    (("-load")
;;     ("%h")
;;     ("-t")
;;     ("\"")
;;     ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
;;     ("/bin/sh")
;;     ("\"")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c")))
;;  ("plink"
;;   (tramp-login-program "plink")
;;   (tramp-login-args
;;    (("-l" "%u")
;;     ("-P" "%p")
;;     ("-ssh")
;;     ("-t")
;;     ("%h")
;;     ("\"")
;;     ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
;;     ("/bin/sh")
;;     ("\"")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-default-port 22))
;;  ("krlogin"
;;   (tramp-login-program "krlogin")
;;   (tramp-login-args
;;    (("%h")
;;     ("-l" "%u")
;;     ("-x")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c")))
;;  ("ksu"
;;   (tramp-login-program "ksu")
;;   (tramp-login-args
;;    (("%u")
;;     ("-q")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-connection-timeout 10))
;;  ("sudo"
;;   (tramp-login-program "sudo")
;;   (tramp-login-args
;;    (("-u" "%u")
;;     ("-s")
;;     ("-H")
;;     ("-p" "Password:")))
;;   (tramp-login-env
;;    (("SHELL")
;;     ("/bin/sh")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-connection-timeout 10))
;;  ("su"
;;   (tramp-login-program "su")
;;   (tramp-login-args
;;    (("-")
;;     ("%u")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-connection-timeout 10))
;;  ("nc"
;;   (tramp-login-program "telnet")
;;   (tramp-login-args
;;    (("%h")
;;     ("%p")
;;     ("2>/dev/null")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-copy-program "nc")
;;   (tramp-copy-args
;;    (("-w" "1")
;;     ("-v")
;;     ("%h")
;;     ("%r")))
;;   (tramp-remote-copy-program "nc")
;;   (tramp-remote-copy-args
;;    (("-l")
;;     ("-p" "%r")))
;;   (tramp-default-port 23))
;;  ("telnet"
;;   (tramp-login-program "telnet")
;;   (tramp-login-args
;;    (("%h")
;;     ("%p")
;;     ("2>/dev/null")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-default-port 23))
;;  ("sshx"
;;   (tramp-login-program "ssh")
;;   (tramp-login-args
;;    (("-l" "%u")
;;     ("-p" "%p")
;;     ("%c")
;;     ("-e" "none")
;;     ("-t" "-t")
;;     ("%h")
;;     ("/bin/sh")))
;;   (tramp-async-args
;;    (("-q")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-gw-args
;;    (("-o" "GlobalKnownHostsFile=/dev/null")
;;     ("-o" "UserKnownHostsFile=/dev/null")
;;     ("-o" "StrictHostKeyChecking=no")))
;;   (tramp-default-port 22))
;;  ("ssh"
;;   (tramp-login-program "ssh")
;;   (tramp-login-args
;;    (("-l" "%u")
;;     ("-p" "%p")
;;     ("%c")
;;     ("-e" "none")
;;     ("%h")))
;;   (tramp-async-args
;;    (("-q")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-gw-args
;;    (("-o" "GlobalKnownHostsFile=/dev/null")
;;     ("-o" "UserKnownHostsFile=/dev/null")
;;     ("-o" "StrictHostKeyChecking=no")))
;;   (tramp-default-port 22))
;;  ("remsh"
;;   (tramp-login-program "remsh")
;;   (tramp-login-args
;;    (("%h")
;;     ("-l" "%u")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c")))
;;  ("rsh"
;;   (tramp-login-program "rsh")
;;   (tramp-login-args
;;    (("%h")
;;     ("-l" "%u")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c")))
;;  ("rsync"
;;   (tramp-login-program "ssh")
;;   (tramp-login-args
;;    (("-l" "%u")
;;     ("-p" "%p")
;;     ("%c")
;;     ("-e" "none")
;;     ("%h")))
;;   (tramp-async-args
;;    (("-q")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-copy-program "rsync")
;;   (tramp-copy-args
;;    (("-t" "%k")
;;     ("-r")))
;;   (tramp-copy-env
;;    (("RSYNC_RSH")
;;     ("ssh" "%c")))
;;   (tramp-copy-keep-date t)
;;   (tramp-copy-keep-tmpfile t)
;;   (tramp-copy-recursive t))
;;  ("scpx"
;;   (tramp-login-program "ssh")
;;   (tramp-login-args
;;    (("-l" "%u")
;;     ("-p" "%p")
;;     ("%c")
;;     ("-e" "none")
;;     ("-t" "-t")
;;     ("%h")
;;     ("/bin/sh")))
;;   (tramp-async-args
;;    (("-q")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-copy-program "scp")
;;   (tramp-copy-args
;;    (("-P" "%p")
;;     ("-p" "%k")
;;     ("-q")
;;     ("-r")
;;     ("%c")))
;;   (tramp-copy-keep-date t)
;;   (tramp-copy-recursive t)
;;   (tramp-gw-args
;;    (("-o" "GlobalKnownHostsFile=/dev/null")
;;     ("-o" "UserKnownHostsFile=/dev/null")
;;     ("-o" "StrictHostKeyChecking=no")))
;;   (tramp-default-port 22))
;;  ("scp"
;;   (tramp-login-program "ssh")
;;   (tramp-login-args
;;    (("-l" "%u")
;;     ("-p" "%p")
;;     ("%c")
;;     ("-e" "none")
;;     ("%h")))
;;   (tramp-async-args
;;    (("-q")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-copy-program "scp")
;;   (tramp-copy-args
;;    (("-P" "%p")
;;     ("-p" "%k")
;;     ("-q")
;;     ("-r")
;;     ("%c")))
;;   (tramp-copy-keep-date t)
;;   (tramp-copy-recursive t)
;;   (tramp-gw-args
;;    (("-o" "GlobalKnownHostsFile=/dev/null")
;;     ("-o" "UserKnownHostsFile=/dev/null")
;;     ("-o" "StrictHostKeyChecking=no")))
;;   (tramp-default-port 22))
;;  ("remcp"
;;   (tramp-login-program "remsh")
;;   (tramp-login-args
;;    (("%h")
;;     ("-l" "%u")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-copy-program "rcp")
;;   (tramp-copy-args
;;    (("-p" "%k")))
;;   (tramp-copy-keep-date t))
;;  ("rcp"
;;   (tramp-login-program "rsh")
;;   (tramp-login-args
;;    (("%h")
;;     ("-l" "%u")))
;;   (tramp-remote-shell "/bin/sh")
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-copy-program "rcp")
;;   (tramp-copy-args
;;    (("-p" "%k")
;;     ("-r")))
;;   (tramp-copy-keep-date t)
;;   (tramp-copy-recursive t))
;;  ("synce")
;;  ("sftp")
;;  ("obex")
;;  ("davs")
;;  ("dav")
;;  ("ftp")
;;  ("adb"
;;   (tramp-tmpdir "/data/local/tmp")))
