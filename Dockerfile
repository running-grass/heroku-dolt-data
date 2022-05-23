# syntax=docker/dockerfile:1.3-labs
FROM ubuntu:20.04
WORKDIR /
RUN apt update &&     apt upgrade -y &&     apt install -y curl     && curl -L https://github.com/dolthub/dolt/releases/latest/download/install.sh | bash

ENV HOST="0.0.0.0"
ENV PORT=3306
ENV DOLT_ROOT_PATH="/.dolt"
ENV DATABASE_REMOTE="https://doltremoteapi.dolthub.com/running-grass/basic-data"
ENV DATABASE_NAME=basic-data
ENV DOLTHUB_USER=running-grass
ENV DOLTHUB_EMAIL=467195537@qq.com
ENV DATA_DIR="/dolthub-dbs/running-grass/$DATABASE_NAME"

EXPOSE 3306
VOLUME [ "/dolthub-dbs" ]

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

WORKDIR /dolthub-dbs/running-grass
CMD [ "dolt", "sql-server", "-l=trace", "--host=0.0.0.0", "--port=3306"]
