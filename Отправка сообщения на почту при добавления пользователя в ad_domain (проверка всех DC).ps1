# Итерация по каждому контроллеру домена
foreach ($dc in $domainControllers) {
    # Выполнение команды на удаленном компьютере с помощью Invoke-Command
    Invoke-Command -ComputerName $dc -ScriptBlock {
        # Передача параметра в скриптблок
        param($username)
        # Получение времени 24 часа назад
        $time = (Get-Date) - (New-TimeSpan -Hour 24)
        # Получение всех событий из журнала безопасности с ID 4728, произошедших в течение последних 24 часов
        Get-WinEvent -FilterHashtable @{LogName="Security";ID=4728;StartTime=$Time}| Foreach {
            # Сохранение текущего события в переменной
            $event = $_
            # Конвертация XML из события в объект XML
            $xml = [xml]$event.ToXml()
            # Если участник группы изменился, то выполнить дальнейшие действия
            if ($xml.Event.EventData.Data | Where-Object { $_.Name -eq "MemberName" } | Select-Object -First 1 -ExpandProperty "#text" | Select-String -Pattern "^CN=([^,]+),.*" -AllMatches | Foreach-Object { $_.Matches } | Foreach-Object { $_.Groups[1].Value }) {
                # Получение времени события в формате день.месяц.год часы:минуты:секунды
                $time = Get-Date $event.TimeCreated -UFormat "%d.%m.%Y %H:%M:%S"
                # Определение типа действия (Добавлен/Неизвестно)
                if ($event.Message.Contains("Добавлен")) {
                    $type = "Добавлен"
                } else {
                    $type = "Неизвестно"
                }
                # Получение имени администратора, который произвел изменения в группе
                $adminUser = $xml.Event.EventData.Data | Where-Object { $_.Name -eq "SubjectUserName" } | Select-Object -First 1 -ExpandProperty "#text"
                # Получение имени участника группы
                $username = ($xml.Event.EventData.Data | Where-Object { $_.Name -eq "MemberName" } | Select-Object -First 1 -ExpandProperty "#text") -replace '^CN=([^,]+),.*', '$1'
                # Получение имени измененной группы
                $group = $xml.Event.EventData.Data | Where-Object { $_.Name -eq "TargetUserName" } | Select-Object -First 1 -ExpandProperty "#text"
                    # Если измененная группа - Администраторы домена, то отправить уведомление по электронной почте
                    if ($group -eq "Администраторы домена") 
                       {
                        $smtpServer = "mail.npo-pkrv.ru"
                        $to = "p.kuryshin@npo-pkrv.ru"
                        $from = "p.kuryshin@npo-pkrv.ru"
                        $subject = "Уведомление об изменении группы безопасности"
                        $body = "В группу Администраторы домена добавлен пользователь $username"
                        Send-MailMessage -SmtpServer $smtpServer -To $to -From $from -Subject $subject -Body $body -Encoding 'UTF8' -Priority High
                       }
                $output = "$env:COMPUTERNAME | $time | $type член группы безопасности. | Изменил: $adminUser | Имя учетной записи: $username | Группа: $group"
                Write-Output $output
                }
            }
        }
    }