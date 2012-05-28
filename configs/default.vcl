backend default {
.host = "127.0.0.1";
.port = "8080";
}
# Drop any cookies sent to Wordpress.
sub vcl_recv {
    if (!(req.url ~ "wp-(login|admin)")) {
        unset req.http.cookie;
    }
}

# Drop any cookies Wordpress tries to send back to the client.
sub vcl_fetch {
    if (!(req.url ~ "wp-(login|admin)")) {
        unset beresp.http.set-cookie;
    }
}