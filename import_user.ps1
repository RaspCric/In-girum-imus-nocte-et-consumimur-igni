
$CSVFile = "C:\Users.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter "," -Encoding UTF8

Foreach($User in $CSVData){

    $UserPrenom = $User.firstname
    $UserNom = $User.name
    $id = $UserPrenom.substring(0,1) + $UserNom

    $UserLogin = $id
    $UserEmail = $id
    $UserMotDePasse = "dadfba16$"

    # VÃ©rifier la prÃ©sence de l'User dans l'AD
    if (Get-ADUser -Filter {SamAccountName -eq $UserLogin})
    {
        Write-Warning "L'identifiant $UserLogin existe déjà  dans l'AD"
    }
    else
    {
        New-ADUser -Name "$UserNom $UserPrenom" `
                    -DisplayName "$UserNom $UserPrenom" `
                    -GivenName $UserPrenom `
                    -Surname $UserNom `
                    -SamAccountName $UserLogin `
                    -UserPrincipalName "$UserLogin@pac.land" `
                    -EmailAddress $UserEmail `
                    -Path "OU=Usagers,DC=pac,DC=land" `
                    -AccountPassword(ConvertTo-SecureString $UserMotDePasse -AsPlainText -Force) `
                    -ChangePasswordAtLogon $false `
                    -Enabled $true

        Write-Output "Création de l'User : $UserLogin ($UserNom $UserPrenom)"
    }
}