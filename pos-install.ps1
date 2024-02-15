# Lista de aplicativos iniciais a serem instalados
#TODO perguntar se quer instsalar Steam
#TODO permitir executar esse script
#TODO tirar aquela tela pedido permissao de admin
#TODO remover apps desnecessarios
#TODO automatizar a configura��o da conta microsoft
#TODO perguntar se quer instalar driver nvidia 
#TALVEZ detectar o hardware e isntalar o driver nvidia, amd, intel caso seja necessario
#TODO invoke-webrequest n�o funcionou
#TODO adiciona alguma forma de copiar o .ssh e clona o repositorio bta-save para a pasta save
$aplicativos = @(
    "Microsoft.VisualStudio.Code",
    "Google.Chrome",
    "qBittorrent.qBittorrent",
    "Valve.Steam",
    "JetBrains.IntelliJIDEA.Ultimate",
    "JetBrains.CLion",
    "TechPowerUp.NVCleanstall",
    "Git.Git",
    "7zip.7zip",
    "PeterPawlowski.foobar2000",
    "KeePassXCTeam.KeePassXC",
    "Microsoft.WindowsTerminal",
    "Obsidian.Obsidian",
    "Notion.Notion",
    "Mozilla.Thunderbird",
    "PrismLauncher.PrismLauncher"
)

# Loop através da lista de aplicativos e instala cada um usando Winget
foreach ($app in $aplicativos) {
    Write-Host "Instalando $app ..."
    winget install $app -e
    if ($LASTEXITCODE -eq 0) {
        Write-Host "$app instalado com sucesso!"
    } else {
        Write-Host "Erro ao instalar $app. Código de erro: $LASTEXITCODE"
    }
}

# URL do instalador
$url = "https://drivers.amd.com/drivers/amd_chipset_software_6.01.25.342.exe"

# Local onde o instalador será baixado
$local_instalador = "$env:TEMP\amd_chipset_software_6.01.25.342.exe"

# Baixa o instalador
Write-Host "Baixando o instalador..."
Invoke-WebRequest -Uri $url -OutFile $local_instalador

# Verifica se o download foi bem-sucedido
if (Test-Path $local_instalador) {
    Write-Host "Instalador baixado com sucesso em: $local_instalador"
    
    # Instala o aplicativo
    Write-Host "Instalando o aplicativo..."
    Start-Process -FilePath $local_instalador -Wait
    
    # Verifica se a instalação foi concluída com êxito
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Aplicativo instalado com sucesso!"
    } else {
        Write-Host "Erro ao instalar o aplicativo. Código de erro: $LASTEXITCODE"
    }
} else {
    Write-Host "Erro ao baixar o instalador."
}

# Caminho para o executável do aplicativo
#$NVCleanstall = "C:\Program Files\NVCleanstall\NVCleanstall.exe"

# Executa o NVCleanstall
#Start-Process -FilePath $NVCleanstall

#Write-Host "Abrindo site da intel assistente"

#Start-Process "chrome.exe" -ArgumentList "https://www.intel.com.br/content/www/br/pt/support/intel-driver-support-assistant.html"