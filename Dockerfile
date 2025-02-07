FROM aglover/java8-pier

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get -y install nginx --no-install-recommends

WORKDIR /usr/local/mirthconnect

ADD templates/mirthconnect/mirthconnect-install-wrapper.sh /usr/local/mirthconnect/mirthconnect-install-wrapper.sh

RUN wget http://downloads.mirthcorp.com/connect/3.8.0.b2464/mirthconnect-3.8.0.b2464-unix.sh \
 && chmod +x mirthconnect-3.8.0.b2464-unix.sh \
 && chmod +x mirthconnect-install-wrapper.sh \
 && ./mirthconnect-install-wrapper.sh

ADD templates/etc /etc
ADD templates/mirthconnect /usr/local/mirthconnect
ADD templates/mirthconnect/conf /usr/local/mirthconnect/conf

EXPOSE 3000

CMD ./mirthconnect-wrapper.sh
