# App iOS para controlar cámaras OBSBOT Tail (Tail Air / Tail 2)

Fecha de actualización: 2026-04-30.

## 1) Protocolos y decisión técnica para V1

### Control PTZ
- **VISCA over IP** (recomendado para V1): estándar de facto en cámaras PTZ IP.
- **Pelco-D/P** (relevante sobre todo para Tail 2): útil cuando tu flujo usa controladores legacy.

### Video/preview
- **RTSP** (recomendado para V1): suficiente para preview y validación de framing.
- **NDI** (fase posterior): ideal para producción broadcast, pero añade complejidad/licenciamiento/SDK.
- **SRT**: útil para transporte robusto, más orientado a contribución que a control.

## 2) Arquitectura objetivo de la app

### Stack sugerido
- **SwiftUI** para UI.
- **MVVM** para separar lógica de red/control.
- **Network module** para sockets de control.
- **Video module** para preview RTSP.

### Módulos mínimos
1. **Camera Registry**
   - Alta/edición/eliminación de cámaras.
   - Persistencia local (nombre, IP, puerto, protocolo).
2. **PTZ Control Engine**
   - Pan/Tilt continuo + Stop.
   - Zoom in/out + Stop.
   - Velocidad configurable.
3. **Preset Manager**
   - Guardar/llamar presets.
4. **RTSP Preview**
   - Vista por cámara.
5. **Connection Health**
   - Ping lógico, reconexión y estados.

## 3) MVP cerrado (lo que sí haremos primero)

- Conexión manual por IP:puerto.
- Control PTZ básico (pan/tilt/zoom/focus básico si aplica).
- Presets (save/recall).
- Preview RTSP por cámara.
- Manejo de desconexión y reconexión.

## 4) Lo que necesito de ti para construirla (checklist exacto)

Copia y rellena este bloque:

```txt
[CAMERAS]
- Modelos exactos:
- Cantidad de cámaras:
- Firmware por cámara:

[NETWORK]
- iPhone y cámaras están en la misma LAN: (sí/no)
- DHCP o IP fija:
- Rango de red (ej. 192.168.1.x):
- VLAN / redes separadas: (sí/no + detalle)

[CONTROL]
- Protocolo habilitado en cámara: (VISCA IP / Pelco / otro)
- Puerto de control:
- ¿Autenticación habilitada?:

[VIDEO]
- RTSP URL real por cámara (puedes ocultar password):
- Codec esperado (H264/H265):
- Resolución/FPS objetivo:

[MVP]
- Funciones obligatorias V1 (ordenadas):
- Funciones deseables V1.1:
```

## 5) Definiciones funcionales (para evitar ambigüedades)

- **Latencia objetivo PTZ**: <= 200 ms en LAN estable.
- **Frecuencia de comandos**: 15–30 Hz con anti-flood.
- **Timeout de comando**: 300–500 ms.
- **Reconexión**: backoff exponencial (1s, 2s, 4s, 8s, máx 15s).
- **Presets**: éxito >= 95% en pruebas repetidas.

## 6) Riesgos técnicos y mitigación

1. **Diferencias Tail Air vs Tail 2 por firmware**
   - Mitigación: matriz de compatibilidad por modelo/firmware y feature flags.
2. **RTSP en iOS con variación de codecs**
   - Mitigación: validar codec real antes de cerrar player.
3. **Saturación por comandos continuos PTZ**
   - Mitigación: throttling y coalescing de comandos.

## 7) Plan de ejecución (3 iteraciones)

### Iteración 1 (base funcional)
- Modelo de cámaras + conexión manual + PTZ básico + stop confiable.

### Iteración 2 (operación real)
- Presets + preview RTSP + reconexión automática + estados de salud.

### Iteración 3 (pulido y campo)
- Ajustes de UX PTZ, perfiles de velocidad, pruebas multi-cámara, hardening.

## 8) Entregables que te daré después de que me compartas el checklist

1. Diseño técnico (diagramas simples + contratos de módulos).
2. Estructura de proyecto Xcode lista.
3. Implementación inicial de motor PTZ.
4. Pantallas SwiftUI MVP.
5. Plan de pruebas funcionales en campo.

## 9) Siguiente paso inmediato

Respóndeme con el bloque del **checklist exacto** (sección 4). Con eso te entrego en el siguiente turno:
- arquitectura concreta,
- estructura de carpetas,
- y primera tanda de código para iniciar la app iOS.
