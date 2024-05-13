FROM alpine:3.18
RUN apk update  && \
		apk add --no-cache nginx 
ADD ./conf.d/ /etc/nginx/http.d/
EXPOSE 443
EXPOSE 80
ADD ./index.html /usr/share/nginx/html/
# CMD ["BASH"]
CMD ["nginx", "-g", "daemon off;"]
