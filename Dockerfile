# Build stage
FROM rust:1.69-buster as builder

WORKDIR /app

# accept the build argument 
ARG DATABASE_URL

COPY . .

RUN mkdir -p ~/.cargo
RUN echo '[net]\ngit-fetch-with-cli = true' > ~/.cargo/config

# Assegure-se que os certificados estão atualizados
RUN apt-get update && apt-get install -y ca-certificates && update-ca-certificates

RUN curl -v https://github.com


RUN cargo build --release

# Production stage
FROM debian:buster-slim

WORKDIR /usr/local/bin

COPY --from=builder /app/target/release/rust-crud-api .

CMD ["./rust-crud-api"]