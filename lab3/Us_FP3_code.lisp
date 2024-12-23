;; Пункт 1

(defun insertion_sort_1 (lst)
  (labels ((insert (x sorted)
             (cond ((null sorted) (list x)) 		 ; Якщо список порожній, просто додаємо елемент
                   ((<= x (car sorted)) (cons x sorted)) ; Якщо X менше або рівне першому елементу, вставляємо на початок
                   (t (cons (car sorted) (insert x (cdr sorted))))))) ; Інакше вставляємо елемент в решту списку
    (if (null lst)
        nil 	; Якщо список порожній, повертаємо порожній список
        (insert (car lst) (insertion_sort_1 (cdr lst)))))) ; Вставляємо перший елемент у відсортовану частину решти списку

(defun check_1 (name input_1 expected)
(format t "~:[FAILED~;passed~] ~a~%"
(equal (insertion_sort_1 input_1) expected) name))

(defun start_check_1 ()
(check_1 "test 1" '(8 3 2 6 7 5 1)'(1 2 3 5 6 7 8))
(check_1 "test 2" '() NIL)
(check_1 "test 3" '(9 1 9 2 8 2 2 3) '(1 2 2 2 3 8 9 9)))

(start_check_1)


;; Пункт 2

(defun insertion_sort_2 (lst)
  (let ((result (copy-list lst))) 		; Копіюємо список, щоб не змінювати оригінал
    (loop for i from 1 below (length result) do ; Проходимо по кожному елементу, починаючи з другого
          (let ((current (nth i result))) 	; Поточний елемент
            (loop for j from 0 below i do 	
                  (when (<= current (nth j result)) 	 ; Шукаємо місце вставки зліва направо
                    (loop for k from i downto (+ j 1) do ; Зсуваємо елементи вправо
                          (setf (nth k result) (nth (- k 1) result))) ; Вставляємо поточний елемент
                    (setf (nth j result) current)
                    (return))))) 			 ; Вихід з внутрішнього циклу, якщо вставка завершена
    result))


(defun check_2 (name input_1 expected)
(format t "~:[FAILED~;passed~] ~a~%"
(equal (insertion_sort_2 input_1) expected) name))

(defun start_check_2 ()
(check_2 "test 1" '(9 9 4 5 7 2) '(2 4 5 7 9 9))
(check_2 "test 2" '(5 4 3 2 1) '(1 2 3 4 5))
(check_2 "test 3" '() NIL))

(start_check_2)


