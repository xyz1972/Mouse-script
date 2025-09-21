; Инициализация переменной состояния
scrollMode := "vertical"  ; По умолчанию вертикальная прокрутка
active := true            ; Флаг активности скрипта

; Кнопка 1 (XButton1 - обычно боковая кнопка 4) - Горизонтальная прокрутка
XButton1::
    if (!active)
        return
    scrollMode := "horizontal"
    ToolTip, [HORIZONTAL] Use wheel to scroll horizontally
    SetTimer, RemoveToolTip, 1500
    return

; Кнопка 2 (XButton2 - обычно боковая кнопка 5) - Вертикальная прокрутка
XButton2::
    if (!active)
        return
    scrollMode := "vertical"
    ToolTip, [VERTICAL] Normal scroll mode
    SetTimer, RemoveToolTip, 1500
    return

; Убираем всплывающую подсказку
RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return

; Перехват событий колесика мыши
#If (scrollMode = "horizontal" && active)
    WheelUp:: 
        Send {WheelLeft}  ; Прокрутка влево
        return
        
    WheelDown:: 
        Send {WheelRight}  ; Прокрутка вправо
        return
#If

; Клавиша-выключатель (F12)
F12::
    active := !active
    if (active) {
        ToolTip, SCROLL MODE ENABLED
    } else {
        ToolTip, SCROLL MODE DISABLED
    }
    SetTimer, RemoveToolTip, 1000
    return

; Автоматический возврат в вертикальный режим при нажатии любой кнопки мыши
#If (scrollMode = "horizontal" && active)
    ~*LButton::
    ~*RButton::
    ~*MButton::
    ~*XButton1::
    ~*XButton2::
        scrollMode := "vertical"
        ToolTip, [AUTO-SWITCH] Vertical mode restored
        SetTimer, RemoveToolTip, 1000
        return
#If