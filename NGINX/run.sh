#!/bin/bash
exec nginx -g "daemon off;\
    error_log /var/log/nginx/error.log notice;"