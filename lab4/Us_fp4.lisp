;; Пункт 1

(defun insertion-sort-1 (lst &key (key #'identity) (test #'<=))
  (labels ((insert (x sorted)
    (if (null sorted) 
        (list x) 	; Якщо список порожній, просто додаємо елемент
      (let* ((head (car sorted))
	     (head-key (funcall key head))
	     (x-key (funcall key x)))
        (if (funcall test x-key head-key) 
            (cons x sorted) ; Якщо X менше або рівне першому елементу, вставляємо на початок
            (cons head (insert x (cdr sorted)))))))) ; Інакше вставляємо елемент в решту списку
    (if (null lst)
        nil 	; Якщо список порожній, повертаємо порожній список
      (insert (car lst) (insertion-sort-1 (cdr lst) :key key :test test))))) ; Вставляємо перший елемент у відсортовану частину решти списку

(defun check-1 (name input-1 expected &key (key #'identity) (test #'<=))
  (format t "~:[FAILED~;passed~] ~a~%"
    (equal (insertion-sort-1 input-1 :key key :test test) expected) name))

(defun start-check-1 ()
  (check-1 "test 1" '(8 3 2 6 7 5 1) '(1 2 3 5 6 7 8))
  (check-1 "test 2" '() NIL)
  (check-1 "test 3" '(9 1 9 2 8 2 2 3) '(1 2 2 2 3 8 9 9))
  (check-1 "test 4" '(-9 1 -2 8 5 -3) '(1 -2 -3 5 8 -9) :key #'abs)
  (check-1 "test 5" '(-9 1 9 -2 8 5 -3) '(9 8 5 1 -2 -3 -9) :test #'>))

(start-check-1)

;; Пункт 2

(defun duplicate-elements-reducer (n &key (duplicate-p (constantly t)))
  (let ((duplicate-p-value (or duplicate-p (constantly t))))	; створюємо змінну, у якій буде зберігатися значення ключового параметра
    (lambda (accumulator step-element)		; визначаємо анонімну функцію, яка буде використовуватися у reduce
      (let ((lst (if (funcall duplicate-p-value step-element)	; якщо даний елемент потрібно дублювати
                     (make-list n :initial-element step-element) ; дублюємо необхідну к-сть разів
                     (list step-element))))    ; якщо ні, то просто додаємо його до акумулятора
        (append accumulator lst))))) 

(defun start-duplicate-elements-reducer (input-1 n &key (duplicate-p nil))  
  (reduce (duplicate-elements-reducer n :duplicate-p duplicate-p) input-1 :from-end nil :initial-value nil))  ; чітко визначені значення ключових параметрів :from-end та :initial-value

(defun check-2 (name input-1 n expected &key (duplicate-p (constantly t)))
  (format t "~:[FAILED~;passed~] ~a~%"
    (equal (start-duplicate-elements-reducer input-1 n :duplicate-p duplicate-p) expected) name))

(defun start-check-2 ()
  (check-2 "test 1" '(1 2 3) 2 '(1 1 2 2 3 3))
  (check-2 "test 2" '(1 2 3) 3 '(1 2 2 2 3) :duplicate-p #'evenp)
  (check-2 "test 3" '(1 2 3) 2 '(1 1 2 3 3) :duplicate-p #'oddp)
  (check-2 "test 4" '(1 2 3) 0  nil)
  (check-2 "test 5" '(3) 3 '(3 3 3))
  (check-2 "test 6" '() 4 nil))

(start-check-2)
