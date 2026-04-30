# Investigación inicial: App iOS para controlar cámaras OBSBOT Tail Air 2 PTZ

Fecha de verificación: 2026-04-30.

## Protocolos confirmados (fuentes oficiales y semioficiales)

1. **VISCA over IP**
   - OBSBOT publica una guía específica de VISCA over IP para la serie Tail y expone descargas de tablas de comandos (incluyendo Tail Air).
   - Es el protocolo más estándar para PTZ remoto en LAN.

2. **NDI (incl. control PTZ vía NDI Controller/Switcher en Tail Air)**
   - En FAQ oficial indican que Tail Air puede controlarse por NDI si el entorno/controlador lo soporta.
   - Relevante si quieres baja latencia en ecosistemas broadcast.

3. **RTSP (streaming de video)**
   - Oficialmente documentado para Tail Air. Se usa para transporte/consumo de video, no como protocolo principal de control PTZ fino.

4. **SRT (streaming)**
   - Oficial en Tail Air para streaming robusto por red inestable.
   - Importante: al activar SRT, hay limitaciones con otros modos según la guía oficial.

5. **Tail 2 (manual público de terceros que cita documentación oficial de OBSBOT)**
   - Referencia a configuración de “Control Protocol” dentro de Obsbot Start App.
   - Confirma VISCA over IP y también menciona Pelco-D/P para Tail 2.

## Qué significa esto para tu app iOS

- **Canal de control recomendado para empezar**: VISCA over IP.
- **Canal de video recomendado para preview inicial**: RTSP (más simple que NDI en iOS).
- **NDI**: considerar fase 2/3 por licencias, SDK y complejidad.
- **Tail 2 vs Tail Air**: validar modelo exacto y firmware porque el set de comandos puede variar.

## Lo que necesito de ti (paso a paso) para construirla contigo

1. **Confirmar hardware exacto**
   - ¿Es “Tail Air”, “Tail 2” o ambos?
   - ¿Cuántas cámaras controlarás simultáneamente?

2. **Confirmar versión de firmware por cámara**
   - En Obsbot Start/Center, comparte versión exacta.
   - Esto evita errores por comandos no soportados.

3. **Elegir alcance de la V1 (MVP)**
   - Recomendado: descubrimiento manual por IP + PTZ + zoom + presets + recall presets + preview RTSP.
   - Decide si también quieres tracking on/off, exposición, balance de blancos, etc.

4. **Conseguir documentación de comandos**
   - Descarga y compárteme los Excel/tablas oficiales VISCA de tu modelo (Tail Air/Tail 2).
   - Si usarás Pelco (Tail 2), comparte también esa tabla.

5. **Definir entorno de red real**
   - Misma LAN para iPhone y cámaras.
   - Rango IP típico, DHCP o estática, VLAN (si existe).
   - Esto impacta descubrimiento y latencia.

6. **Decidir método de conexión inicial**
   - V1 recomendada: ingreso manual de IP:puerto por cámara.
   - Fase 2: autodescubrimiento (si protocolo/servicio lo permite de forma fiable).

7. **Definir UX de control PTZ**
   - ¿Joystick virtual continuo o botones por pasos?
   - Velocidades (lenta/media/rápida) y curva de aceleración.
   - Límite de comandos por segundo (anti-saturación).

8. **Definir permisos y capacidades iOS**
   - Solo red local inicialmente (sin BLE/USB).
   - Confirmar versión mínima de iOS objetivo (recomiendo iOS 17+).

9. **Decidir stack técnico**
   - SwiftUI + arquitectura MVVM.
   - Control VISCA por sockets UDP/TCP (según tabla oficial de tu modelo).
   - Preview por AVPlayer/FFmpeg wrapper para RTSP (según codec real).

10. **Criterios de aceptación (QA)**
   - PTZ responde <200 ms en LAN.
   - Presets confiables en >95% de ejecuciones.
   - Recuperación automática tras pérdida de red.

11. **Material de prueba que necesito de ti**
   - 1 captura de pantalla por cámara de settings de protocolo.
   - 1 ejemplo funcional de comando (si ya lo probaste desde vMix/teclado PTZ).
   - 1 URL RTSP real por cámara (ocultando credenciales si aplica).

12. **Plan de ejecución conjunto**
   - Semana 1: conexión + PTZ básico + presets.
   - Semana 2: preview RTSP + reconexión + pulido UX.
   - Semana 3: funciones avanzadas + pruebas de campo.

## Siguiente acción recomendada para ti

Envíame en un solo mensaje:
- Modelo exacto de cámara(s).
- Firmware de cada una.
- Captura o texto de configuración de “Control Protocol”.
- Tabla VISCA oficial descargada.
- Qué funciones quieres en la V1 (lista priorizada).
