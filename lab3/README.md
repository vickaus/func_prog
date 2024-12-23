<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Функціональний і імперативний підходи до роботи зі списками"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студентка</b>: Ус Вікторія Олександрівна, КВ-12</p>
<p align="right"><b>Рік</b>: 2024</p>

### Загальне завдання  
Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і
імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і
конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного
списку. Не допускається використання: деструктивних операцій, циклів, функцій
вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Також реалізована функція не має
бути функціоналом (тобто приймати на вхід функції в якості аргументів).
2. Імперативний варіант реалізації має базуватись на використанні циклів і
деструктивних функцій (псевдофункцій). Не допускається використання функцій
вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Тим не менш, оригінальний список
цей варіант реалізації також не має змінювати, тому перед виконанням
деструктивних змін варто застосувати функцію copy-list (в разі необхідності).
Також реалізована функція не має бути функціоналом (тобто приймати на вхід
функції в якості аргументів).

Алгоритм, який необхідно реалізувати, задається варіантом (п. 3.1.1). Зміст і шаблон
звіту наведені в п. 3.2.

Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
мають бути оформленні у вигляді модульних тестів (наприклад, як наведено у п. 2.3).

### Варіант 6 (22)

<p align="center">
    <img src="lab3.png" alt="lab3">
</p>

### Лістинг першої функції insertion_sort_1
```lisp

(defun insertion_sort_1 (lst)
  (labels ((insert (x sorted)
             (cond ((null sorted) (list x)) 		 ; Якщо список порожній, просто додаємо елемент
                   ((<= x (car sorted)) (cons x sorted)) ; Якщо X менше або рівне першому елементу, вставляємо на початок
                   (t (cons (car sorted) (insert x (cdr sorted))))))) ; Інакше вставляємо елемент в решту списку
    (if (null lst)
        nil 	; Якщо список порожній, повертаємо порожній список
        (insert (car lst) (insertion_sort_1 (cdr lst)))))) ; Вставляємо перший елемент у відсортовану частину решти списку
```

### Тестові набори для першої функції
```lisp
(defun start_check_1 ()
(check_1 "test 1" '(8 3 2 6 7 5 1)'(1 2 3 5 6 7 8))
(check_1 "test 2" '() NIL)
(check_1 "test 3" '(9 1 9 2 8 2 2 3) '(1 2 2 2 3 8 9 9)))
```

### Результат тестування
```lisp
passed test 1
passed test 2
passed test 3
```

### Лістинг другої функції insertion_sort_2
```lisp
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
```

### Тестові набори для другої функції
```lisp
(defun start_check_2 ()
(check_2 "test 1" '(9 9 4 5 7 2) '(2 4 5 7 9 9))
(check_2 "test 2" '(5 4 3 2 1) '(1 2 3 4 5))
(check_2 "test 3" '() NIL))
```

### Тестування
```lisp
passed test 1
passed test 2
passed test 3
```
