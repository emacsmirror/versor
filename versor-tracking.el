;;;; versor-tracking.el -- tracking ordinary cursor, or using mouse, for versor
;;; Time-stamp: <2006-04-28 18:51:32 jcgs>

;;  This program is free software; you can redistribute it and/or modify it
;;  under the terms of the GNU General Public License as published by the
;;  Free Software Foundation; either version 2 of the License, or (at your
;;  option) any later version.

;;  This program is distributed in the hope that it will be useful, but
;;  WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;  General Public License for more details.

;;  You should have received a copy of the GNU General Public License along
;;  with this program; if not, write to the Free Software Foundation, Inc.,
;;  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

(provide 'versor-tracking)

(defun versor-select-around-point (where)
  "Move the selection to surround WHERE (point, interactively)."
  (interactive "d")
  (goto-char where)
  (let* ((item (versor-invent-item))
	 (start (car item))
	 (end (cdr item)))
    (versor-set-current-item start end)
    (if (< (point) start)
	(goto-char start)
      (if (> (point) end)
	  (goto-char end)))))

(defun versor-mouse-action (event)
  (interactive "e")
  (mouse-minibuffer-check event)
  ;; Use event-end in case called from mouse-drag-region.
  ;; If EVENT is a click, event-end and event-start give same value.
  (let ((posn (event-start event)))
    (if (not (windowp (posn-window posn)))
	(error "Cursor not in text area of window"))
    (select-window (posn-window posn))
    (let ((where (posn-point posn)))
      (when (numberp where)
	(versor-select-around-point where)))))

(global-set-key [mouse-1]	'versor-mouse-action)
;; (global-set-key [down-mouse-1]	'versor-mouse-action)
;; (global-set-key [up-mouse-1]	'versor-mouse-action)

;;; end of versor-tracking.el