# Cómo probar el scaffold en tu Mac (paso a paso)

## Requisitos
- macOS con **Xcode 15+**
- iPhone en la misma LAN que la cámara
- Cámara OBSBOT Tail Air 2 encendida

## 1) Crear proyecto iOS en Xcode
1. Abre Xcode.
2. **File > New > Project > iOS App**.
3. Product Name: `ObsbotPTZ`.
4. Interface: **SwiftUI**.
5. Language: **Swift**.
6. Guarda el proyecto.

## 2) Copiar estos archivos al proyecto
Desde este repo, arrastra al target de Xcode:
- `ObsbotPTZ/ObsbotPTZ/App/ObsbotPTZApp.swift`
- `ObsbotPTZ/ObsbotPTZ/Models/CameraDevice.swift`
- `ObsbotPTZ/ObsbotPTZ/Models/PTZCommand.swift`
- `ObsbotPTZ/ObsbotPTZ/Services/VISCAService.swift`
- `ObsbotPTZ/ObsbotPTZ/ViewModels/CameraViewModel.swift`
- `ObsbotPTZ/ObsbotPTZ/Views/ContentView.swift`

Marca **Copy items if needed** y verifica que estén en el target `ObsbotPTZ`.

## 3) Ajustar permisos de red local (importante)
En el target de app:
1. Ve a **Info**.
2. Agrega la clave `Privacy - Local Network Usage Description`.
3. Valor sugerido: `La app necesita red local para controlar la cámara OBSBOT.`

> Sin esto, iOS puede bloquear descubrimiento/comunicación de red local.

## 4) Configurar parámetros de cámara
Abre `CameraDevice.swift` y confirma:
- IP: `192.168.1.9`
- RTSP: `rtsp://192.168.1.9/stream1`
- Codec: `H265`
- Puerto VISCA: `52381` (confirmado)

## 5) Ejecutar en dispositivo real (recomendado)
1. Conecta iPhone por cable o Wi‑Fi debugging.
2. Selecciona tu iPhone como run destination.
3. Presiona **Run**.
4. Acepta permisos de red local cuando iOS lo pida.

## 6) Prueba funcional básica
En la app:
1. Toca **Connect**.
2. Prueba flechas PTZ (↑ ↓ ← →) y luego **Stop**.
3. Prueba **Zoom + / Zoom - / Zoom Stop**.
4. Prueba `Preset 1..3`.

## Estado esperado hoy
- La UI funciona.
- El flujo de botones funciona.
- El transporte VISCA UDP ya envía comandos PTZ/Zoom/Preset.

## 7) Cómo validar en pruebas reales
Checklist de aceptación:
- PTZ responde en menos de ~200 ms en LAN.
- Stop detiene movimiento al soltar/tocar stop.
- Zoom continuo responde y se detiene correctamente.
- Presets recall funcionan en repetición.
- Reconexión tras pérdida de red.

## 8) Problemas comunes
1. **No conecta**
   - Verifica misma subred (ej. iPhone 192.168.1.x y cámara 192.168.1.x).
   - Revisa firewall/router.
2. **No hay video RTSP**
   - Verifica URL exacta y codec.
3. **Sin permisos**
   - Reinstala app y vuelve a aceptar Local Network.

## 9) Siguiente paso inmediato
Cuando quieras, en el próximo cambio implemento:
- soporte ACK/Completion y reintentos,
- comandos extendidos (tracking/exposición/WB),
- y logs de diagnóstico avanzados para depurar en campo.

## 10) Configuración VISCA confirmada
- Compatible with Sony VISCA over IP Protocol
- IPv4
- UDP
- Port 52381
