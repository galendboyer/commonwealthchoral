;; -----------------------------------------
;; Favorite Dired Directories (Custom History)
;; -----------------------------------------

(setq my-dired-favorite-dirs
      (list
       (concat "c:/GITHUB/OLIN/fileqry-multisheets")
       (concat "g:/Shared drives/Contact Management/github/20251210")
       (concat "g:/Shared drives/Contact Management/Data/Data_Files_2025_Dec10/Galen")))

(defun my-load-favorite-dired-history ()
  "Replace `file-name-history' with `my-dired-favorite-dirs' for Dired."
  (interactive)
  (setq file-name-history
        (mapcar #'expand-file-name my-dired-favorite-dirs))
  (message "Loaded favorite Dired directories into history."))
