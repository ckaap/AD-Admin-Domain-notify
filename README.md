### Мы используем команду Get-ADDomainController для получения списка контроллеров домена, и затем итерируемся по каждому контроллеру с помощью цикла foreach. Внутри цикла мы используем команду Invoke-Command для выполнения скрипта на удаленном контроллере домена, передавая ему имя контроллера в качестве параметра -ComputerName.  
### Таким образом, скрипт будет выполнен на каждом контроллере домена в списке $domainControllers.
