# Browser preview (UI mock)

Este preview permite visualizar y probar el flujo UI en navegador.

## Ejecutar localmente
```bash
cd ObsbotPTZ/web-preview
python3 -m http.server 8080
```

Luego abre:
- http://localhost:8080

## Importante
- Esta vista es **simulada**: no envía comandos VISCA reales ni abre RTSP.
- Sirve para validar UX/layout y navegación antes de seguir iterando la app iOS.
