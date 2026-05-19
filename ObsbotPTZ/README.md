# ObsbotPTZ (starter scaffold)

iOS starter app (SwiftUI + MVVM) para controlar 1 cámara OBSBOT Tail Air 2 usando VISCA over IP.

## Configuración confirmada por el usuario
- Protocolo: Sony VISCA over IP compatible
- Internet Protocol: IPv4
- Transport Protocol: UDP
- VISCA Port: `52381`
- Camera IP: `192.168.1.9`
- RTSP URL: `rtsp://192.168.1.9/stream1`
- Codec: `H265`
- Red: DHCP, misma subred iPhone/cámara

## Estado actual
- ✅ Servicio VISCA UDP implementado para PTZ/Zoom/Preset (send bytes).
- ✅ UI base para conectar y enviar comandos.
- ⚠️ Falta confirmar comandos extendidos específicos de Tail Air 2 (tracking/exposición/WB) y feedback ACK/Completion.
