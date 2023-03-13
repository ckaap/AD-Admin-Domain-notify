# Скрипт для поиска внесения изменений в группу Администраторов домена  
### Ищет ключевые события в журналах всех DC, и, если находит, отправляет письмо на указанную почту.
Мы используем команду Get-ADDomainController для получения списка контроллеров домена, и затем итерируемся по каждому контроллеру с помощью цикла foreach. Внутри цикла мы используем команду Invoke-Command для выполнения скрипта на удаленном контроллере домена, передавая ему имя контроллера в качестве параметра -ComputerName.  
Таким образом, скрипт будет выполнен на каждом контроллере домена в списке $domainControllers.

## Необходимо для DC включить расширенную политику аудита событий  
Computer Configuration -> Windows Settings -> Security Settings -> Advanced Audit Configuration -> Account Management -> Audit Security Group Management.  
При добавлении пользователя в группу Active Directory в журнале Security появляется событие EventId 4728
