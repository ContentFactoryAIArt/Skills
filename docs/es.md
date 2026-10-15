# Empieza con ContentFactory

Crea videos, imágenes, narraciones, música y composiciones editables con ContentFactory y tu agente de IA. Las instrucciones de la habilidad están en inglés; puedes conversar y crear contenido en español.

## Empieza en cuatro pasos

1. Instala Python 3.11 o posterior y la versión actual de Codex CLI. Elige una carpeta de proyecto que ya exista.
2. [Descarga el ZIP de este repositorio](https://github.com/ContentFactoryAIArt/Skills/archive/refs/heads/main.zip) y extráelo, o ejecuta:

   ```sh
   git clone https://github.com/ContentFactoryAIArt/Skills.git
   cd Skills
   ```

3. Desde la carpeta del repositorio extraído o clonado, ejecuta el asistente e indica la ruta de tu proyecto existente:

   ```powershell
   python scripts/connect.py --workspace "C:\Projects\MyVideo"
   ```

   En macOS o Linux, usa `python3` y una ruta existente como `~/projects/my-video`. Inicia sesión en ContentFactory desde el navegador y elige proyectos, permisos y duración del acceso.

4. Abre o recarga ese proyecto en Codex y escribe:

   > Usa $contentfactory-video para crear un video de producto de 30 segundos en español. Trabaja en mi proyecto seleccionado y muestra el plan y el coste previsto antes de cualquier operación de pago.

## Otros clientes MCP

Si tu cliente admite MCP remoto Streamable HTTP con OAuth, añade `https://content-factory.art/mcp` como un único servidor y autorízalo en el navegador. Después instala la carpeta completa `skills/contentfactory-video` mediante la función de habilidades del cliente.

## ¿Problemas de conexión?

Si el asistente indica que el endpoint unificado no está disponible, hace falta la versión correspondiente del servidor de ContentFactory. `--install-only` prepara la habilidad, pero para crear contenido se necesita una conexión activa. No vuelvas a iniciar sesión si la conexión actual funciona.

Consulta la [guía detallada en inglés](en.md) para solucionar problemas.

## Fotos, video y 3D con Claude Code

ContentFactory es un editor gratuito de fotos, video y 3D en el navegador. Tu propio agente también puede crear videos completos. La generación y el análisis con IA pueden tener un coste.

Instala la versión actual de Claude Code CLI. Esta alternativa instala el skill y configura una sola conexión MCP. Completa el acceso en el navegador y usa /contentfactory-video. Se requiere una autorización de ContentFactory por cliente; las conexiones existentes se reutilizan.

```powershell
python scripts/connect.py --client claude --workspace "C:\Projects\MyVideo"
```
