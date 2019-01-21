;;;; griffin-lisp.lisp

(in-package #:griffin-lisp)

(defun parse-yaml-file (filename)
  (let ((path (uiop:ensure-pathname filename)))
    (yaml:parse path)))

;; (woo:run
;;  (lambda (env)
;;    (break env)
;;    '(200 (:content-type "text/plain") "Request received."))
;;  :port 10081)

;; (defun quit-all-processes ()
;;   (woo.syscall::kill (woo.syscall::getpid) woo::quit))

(defun griffin-request-handler (env)
  (declare (ignorable env))
  (let* ((headers (getf env :headers))
	 (user-agent (gethash "user-agent" headers))
	 (ua-scanner (cl-ppcre::create-scanner "firefox|chrome|chromium|gecko"
					       :case-insensitive-mode t)))
    (unless (cl-ppcre::all-matches ua-scanner user-agent)
      (break "Request ~a" env))
   '(200 (:content-type "text/plain")
     ("Response from Clack...?"))))

(defparameter *griffin-http-client* nil)

(defun start-http-client (&key
			    (port 10080)
			    (server :woo))
  (when (and *griffin-http-client*
	     (sb-thread::thread-%alive-p
	      (clack.handler::handler-acceptor
	       *griffin-http-client*)))
    (clack:stop *griffin-http-client*))
  (setf *griffin-http-client*
	(clack:clackup
	 'griffin-request-handler
	 :port port
	 :server server)))

