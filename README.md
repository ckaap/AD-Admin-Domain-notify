## Script Description

This PowerShell script is designed to monitor changes in the "Administrators" group on domain controllers. The script performs the following tasks:

1. Retrieves a list of all domain controllers using the `Get-ADDomainController` command.
2. On each domain controller, it runs a command using `Invoke-Command` to search for security log events with ID 4728, indicating changes in group membership.
3. If an event related to adding a user to the "Administrators" group is found, it sends an email notification.
4. The notification contains information about the time of the change, the name of the administrator who made the change, the name of the added user, and the name of the modified group.
5. The script outputs information about each such event to the console in the format: `Computer Name | Time | Action Type | Modified by: Admin Name | Account Name: User Name | Group: Group Name`.

### Usage

1. Configure the `$smtpServer`, `$from`, `$to`, `$subject`, `$body`, and `$cred` variables for email notifications.
2. Run the script via PowerShell on a machine with administrative rights.
3. The script will automatically monitor changes in the "Administrators" group on all domain controllers and send notifications if changes are detected.

### Requirements

- PowerShell 5.0 or higher.
- Administrative rights on all domain controllers.
- Access to security logs on domain controllers.
- Configured SMTP server for sending email notifications.

### Notes

The script monitors events with ID 4728, which indicate the addition of a user to a security group. If the "Administrators" group is modified, this event will be logged, and a notification will be sent.


## Описание скрипта

Этот PowerShell скрипт предназначен для мониторинга изменений в группе "Администраторы" на контроллерах домена. Скрипт выполняет следующие задачи:

1. Получает список всех контроллеров домена с помощью команды `Get-ADDomainController`.
2. На каждом контроллере домена выполняет команду с использованием `Invoke-Command`, чтобы найти события с ID 4728 из журнала безопасности, которые указывают на изменения в членстве группы.
3. Если найдено событие, связанное с добавлением пользователя в группу "Администраторы", отправляет уведомление по электронной почте.
4. В уведомлении содержится информация о времени изменения, имени администратора, который произвел изменение, имени добавленного пользователя и имени измененной группы.
5. Скрипт выводит на консоль информацию о каждом таком событии в формате: `Имя компьютера | Время | Тип действия | Изменил: Имя администратора | Имя учетной записи: Имя пользователя | Группа: Имя группы`.

### Использование

1. Настройте переменные `$smtpServer`, `$from`, `$to`, `$subject`, `$body`, и `$cred` для отправки уведомлений по электронной почте.
2. Запустите скрипт через PowerShell на компьютере с правами администратора.
3. Скрипт будет автоматически отслеживать изменения в группе "Администраторы" на всех контроллерах домена и отправлять уведомления, если будут обнаружены изменения.

### Требования

- PowerShell 5.0 или выше.
- Права администратора на всех контроллерах домена.
- Доступ к журналам безопасности на контроллерах домена.
- Настроенный SMTP-сервер для отправки email-уведомлений.

### Примечания

Скрипт отслеживает события с ID 4728, которые указывают на добавление пользователя в группу безопасности. Если группа "Администраторы" подвергается изменениям, это событие будет зафиксировано и отправлено уведомление.
