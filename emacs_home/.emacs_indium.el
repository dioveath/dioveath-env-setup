
(message "To load indium only.")

(package-refresh-contents)
(unless (package-installed-p 'indium)
  (package-install 'indium))

