backend default {
.host = "127.0.0.1";
.port = "8080";
}

# Drop any cookies sent to Wordpress.
# except when previewing
sub vcl_recv {
    if ( !(req.url ~ "(wp-login|wp-admin|preview=true)") ) {
        unset req.http.cookie;
    }
}

# Drop any cookies Wordpress tries to send back to the client.
# except when previewing
sub vcl_fetch {
    if ( !(req.url ~ "(wp-login|wp-admin|preview=true)") ) {
        unset beresp.http.set-cookie;
    }
}