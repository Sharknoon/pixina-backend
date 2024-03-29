FROM gradle as build-stage
WORKDIR /app
COPY ./ .
RUN gradle installDist

FROM amazoncorretto:21 as production-stage
EXPOSE 8080:8080
RUN mkdir /app
COPY --from=build-stage /app/build/install/pixina-backend /app
WORKDIR /app/bin
VOLUME /app/bin/data
CMD ["./pixina-backend"]