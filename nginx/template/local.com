server {
        listen {{vhost_http_port}};
        listen [::]:{{vhost_http_port}};
        listen {{vhost_https_port}} ssl http2;
        listen [::]:{{vhost_https_port}} ssl http2;

        include ssl/self-signed.conf;
        include ssl/ssl-params.conf;  

        root /var/www/{{vhost_domain_name}}/html;
        index index.html index.htm index.nginx-debian.html;

        server_name {{vhost_domain_name}} www.{{vhost_domain_name}};

       
        location / {
                try_files $uri $uri/ =404;

        }
        #we can use http2_push to push extra items in first connection.
        location /index.html {

                        http2_push /style.css
                        http2_push /favicon.png


        }
        location ~* \.(css|js|jpg|png)$ {
                access_log off;

                add_header Cache-Control public;
                add_header Pragma public;
                add_header Vary Accept-Encoding;
                expires 1h;

        }
}