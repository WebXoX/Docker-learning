FROM alpine:3.18.5
RUN apk update  && \
		apk add --no-cache nginx 
ADD ./conf.d/ /etc/nginx/http.d/
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
