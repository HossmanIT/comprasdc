# Rutas de los scripts Python
$transferScript = "C:\FastAPI\comprasdc\transfercdc.py"
$syncScript = "C:\FastAPI\comprasdc\sync_scriptcdc.py"
$logFile = "C:\Logs\comprasdc.log"
$transferOut = "C:\Logs\transfer_salidacdc.log"
$transferErr = "C:\Logs\transfer_errorcdc.log"
$syncOut = "C:\Logs\sync_salidacdc.log"
$syncErr = "C:\Logs\sync_errorcdc.log"

# Ruta completa a python.exe (ajusta si usas entorno virtual)
$pythonPath = "python.exe"

# Función para escribir logs
function Write-Log {
    param ([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -FilePath $logFile -Append
    Write-Host "$timestamp - $message"
}

# Iniciar registro
Write-Log "==== Inicio de la ejecucion automatica ===="

# 1. Ejecutar transfercdc.py
try {
    Write-Log "Ejecutando transfercdc.py..."
    $transferProcess = Start-Process -FilePath $pythonPath `
        -ArgumentList $transferScript `
        -RedirectStandardOutput $transferOut `
        -RedirectStandardError $transferErr `
        -Wait -PassThru -NoNewWindow

    if ($transferProcess.ExitCode -eq 0) {
        Write-Log "transfercdc.py se ejecuto correctamente (ExitCode: 0)."
    } else {
        Write-Log "ERROR: transfercdc.py fallo (ExitCode: $($transferProcess.ExitCode))."
        exit 1
    }
} catch {
    Write-Log "ERROR al ejecutar transfercdc.py: $_"
    exit 1
}

# 2. Esperar 60 segundos antes de ejecutar sync_scriptcdc.py
Write-Log "Esperando 60 segundos antes de ejecutar sync_scriptcdc.py..."
Start-Sleep -Seconds 60

# 3. Ejecutar sync_scriptcdc.py
try {
    Write-Log "Ejecutando sync_scriptcdc.py..."
    $syncProcess = Start-Process -FilePath $pythonPath `
        -ArgumentList $syncScript `
        -RedirectStandardOutput $syncOut `
        -RedirectStandardError $syncErr `
        -Wait -PassThru -NoNewWindow

    if ($syncProcess.ExitCode -eq 0) {
        Write-Log "sync_scriptcdc.py se ejecuto correctamente (ExitCode: 0)."
    } else {
        Write-Log "ERROR: sync_scriptcdc.py fallo (ExitCode: $($syncProcess.ExitCode))."
        exit 1
    }
} catch {
    Write-Log "ERROR al ejecutar sync_scriptcdc.py: $_"
    exit 1
}

Write-Log "==== Ejecucion completada ===="