FROM elasticsearch:latest

RUN apt-get update

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

RUN plugin install mobz/elasticsearch-head

CMD ["/tmp/entrypoint.sh"]
