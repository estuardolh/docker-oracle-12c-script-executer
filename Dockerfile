FROM tekintian/oracle12c
COPY execute_sql.pl /stage/
LABEL maintainer="elh"
ENV DBT_VERSION 1.0
RUN apt --assume-yes update && apt --assume-yes install nano && mkdir /stage/scripts && chmod +x /stage/execute_sql.pl && ln -s /stage/execute_sql.pl execute && touch /stage/scripts/script_list.txt
VOLUME ["/stage/scripts"]
