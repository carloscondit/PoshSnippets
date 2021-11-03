#Добавляем в переменную результат выполнения установки 
$MsiExitCode = (Start-Process msiexec -ArgumentList "/i 'путь к msi' /quiet /log 'путь к логу' -Wait -PassThru").ExitCode

#В итоге получишь код выхода после установки, если 0, то всё оке, если 1603, то курим логи
#Можно добавить ключ /norestart если есть шанс что установка захочет ребута. В этом случае если код выхода будет 3010, то нужен ребут после установки
#Все коды выхода - https://docs.microsoft.com/ru-ru/windows/win32/msi/error-codes

#Условия проверки каталога в параметр расширенной функции
[Parameter(Position = 1, HelpMessage = "Укажите имя каталога")]
[ValidateScript({
        #это условие выдаст ошибку в случае, если проверка каталога не пройдет
        If ((Test-Path -path $_ -PathType Container) -AND ((Get-Item -path $_).psprovider.name -eq 'Filesystem')) {
            return $True
        }
        else {
            Throw "The specified Path value $_ is not a valid folder or not a file system location."
            return $False
        }
    })]
[string]$Path = "."
