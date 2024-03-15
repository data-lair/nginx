worker_processes auto;

events {
    worker_connections 1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    sendfile        on;
    keepalive_timeout  65;
    access_log /dev/stdout;
    error_log /dev/stdout debug;

    server {
        
        listen 80
        listen [::]:80

        server_name dev.data-lair.com www.dev.data-lair.com;

        return 302 https://$server_name$request_uri;
    }

    server {
        client_max_body_size 100M;
        server_name dev.data-lair.com www.dev.data-lair.com;

        listen 443 ssl http2 dev.data-lair.com;
        listen [::]:443 ssl http2 dev.data-lair.com;
        
        ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
        ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
        include snippets/self-signed.conf;
        include snippets/ssl-params.conf;

        root   /usr/share/nginx/html;
        index  index.html index.htm;

        location / {
            try_files $uri $uri/ =404;
        }
        
    }

    
}