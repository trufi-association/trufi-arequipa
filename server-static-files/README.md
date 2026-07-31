# server-static-files

Copia versionada de los archivos que nginx sirve en
`https://arequipabus.muniarequipa.gob.pe/static_files/`.

## Por qué existe esta carpeta

En septiembre de 2025 el servidor se migró al directorio `new-trufi-server` y el
contenido de `data/static_files/` no se copió. `privacy-policy.html` era la URL
declarada como política de privacidad en la ficha de Google Play, así que empezó
a devolver 404. Google avisó el 15 de septiembre de 2025 y, al no corregirse,
**removió la app de Google Play el 18 de octubre de 2025** por "Invalid Privacy
policy". La app estuvo fuera de la tienda hasta que se restauró el archivo el
31 de julio de 2026.

El archivo solo existía en el servidor, sin copia en el repo. Esta carpeta evita
que vuelva a pasar: si el servidor se migra o se reinstala, el contenido se
recupera desde acá.

## Dónde va en el servidor

El contenedor nginx (`new-trufi-server-nginx_single_server-1`) monta el
directorio del host en `/app/static_files/`:

    /root/new-trufi-server/data/static_files  ->  /app/static_files

y `nginx/conf.d/app.conf` lo publica con:

    location /static_files/ {
        alias /app/static_files/;
    }

Para restaurar:

    scp privacy-policy.html root@<servidor>:/root/new-trufi-server/data/static_files/

No hace falta reiniciar el contenedor: el mount es un bind directo al host.

## Después de cualquier migración, verificar

    curl -sI https://arequipabus.muniarequipa.gob.pe/static_files/privacy-policy.html

Debe responder `200`. Si responde `404`, la ficha de Play queda en violación de
la User Data policy y la app puede ser removida otra vez.

## Nota sobre notification.json

El servidor también solía servir `notification.json` (notificaciones dentro de
la app). Está deliberadamente ausente: la versión 1.3.0 publicada tiene un bug
en el manejo de notificaciones personalizadas, corregido en 1.3.1. Reactivarlo
solo cuando 1.3.1 esté publicada y adoptada.
