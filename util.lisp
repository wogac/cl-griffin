(in-package #:griffin-lisp)

(defun hash-to-alist (hash)
  "Convert hash map recursively to alist."
  (typecase hash
    (hash-table
     (loop for k being the hash-keys in hash using (hash-value v)
	collect (cons k (hash-to-alist v))))
    (list
     (loop for el in hash collect (hash-to-alist el)))
    (t hash)))

