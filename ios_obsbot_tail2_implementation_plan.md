# Plan de implementación con tus respuestas (Tail Air 2)

Fecha: 2026-04-30

## 1) Resumen de tus respuestas confirmadas

- **Modelo**: OBSBOT Tail Air 2
- **Cantidad**: 2 cámaras
- **Firmware**: 7.2.12.2
- **MVP deseado**: sí a PTZ + zoom + presets/recall + preview RTSP + extras (tracking/exposición/WB)
- **Protocolo base**: VISCA over IP (enlace compartido)
- **UX PTZ**: joystick virtual continuo
- **Velocidad**: lenta/media/rápida + curva de aceleración
- **iOS**: red local, iOS 17+
- **Stack**: SwiftUI + MVVM

## 2) Información faltante crítica (bloqueante para arrancar código de red)

Necesito que completes estos 6 datos:

1. **IP de cada cámara** (ej. 192.168.1.41 y 192.168.1.42)
2. **Puerto VISCA over IP** activo en cada cámara
3. **RTSP URL real** por cámara
4. **Codec RTSP** real (H264 o H265)
5. **Tipo de red**: DHCP o IP fija
6. **Misma LAN/VLAN**: confirmar si iPhone y cámaras están en la misma subred

## 3) Congelación de alcance V1 (cerrado)

### Incluido en V1
1. Alta manual de 2 cámaras por IP/puerto.
2. Joystick PTZ continuo (pan/tilt + stop).
3. Zoom in/out continuo + stop.
4. Presets: guardar / llamar.
5. Preview RTSP de 1 cámara activa (switch entre 2).
6. Reconexión automática y estado por cámara.

### Pasa a V1.1
1. Tracking on/off.
2. Exposición avanzada.
3. Balance de blancos avanzado.
4. Preview simultáneo doble (si rendimiento lo permite).

## 4) Contrato técnico inicial (app)

## Entidades
- `CameraDevice`
  - `id`, `name`, `ip`, `viscaPort`, `rtspURL`, `codec`, `isConnected`
- `PTZSpeedProfile`
  - `slow`, `medium`, `fast`, `accelerationCurve`
- `Preset`
  - `cameraId`, `slot`, `name`

## Capas
- `Presentation` (SwiftUI Views)
- `ViewModel` (estado + comandos UI)
- `Domain` (casos de uso PTZ/Presets/Connection)
- `Data` (VISCA transport + RTSP session)

## 5) Secuencia de desarrollo propuesta

### Sprint 1 (2-3 días)
- Crear proyecto base iOS (SwiftUI).
- Pantalla de registro manual de 2 cámaras.
- Servicio de conexión y health state.

### Sprint 2 (3-4 días)
- Motor de comandos PTZ con joystick continuo.
- Mapeo de velocidades y aceleración.
- Stop confiable al levantar dedo.

### Sprint 3 (2-3 días)
- Presets save/recall.
- Preview RTSP de cámara activa.
- Manejo básico de errores de stream.

### Sprint 4 (2 días)
- QA con criterios de latencia y reconexión.
- Pulido de UX.

## 6) Criterios de aceptación (ajustados a tu caso)

1. Conectar y controlar **2 cámaras Tail Air 2** por IP manual.
2. PTZ y zoom con respuesta perceptiblemente fluida en LAN estable.
3. Presets funcionando de forma repetible.
4. Reconexión automática tras caída de red.
5. Preview RTSP funcional al menos en 1 cámara activa.

## 7) Lo que te pido ahora (formato corto)

Respóndeme con:

```txt
CAM1_IP=
CAM1_VISCA_PORT=
CAM1_RTSP_URL=
CAM1_CODEC=

CAM2_IP=
CAM2_VISCA_PORT=
CAM2_RTSP_URL=
CAM2_CODEC=

NETWORK_MODE=DHCP|STATIC
SAME_SUBNET=YES|NO
```

Cuando me pases eso, en el siguiente paso te doy **estructura exacta de carpetas + archivos Swift iniciales** para empezar el desarrollo inmediatamente.
