FROM distribution/distribution:3.0.0

COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.9.1 /lambda-adapter /opt/extensions/lambda-adapter

ENV AWS_LWA_PORT=5000 \
    AWS_LWA_READINESS_CHECK_PORT=5001 \
    AWS_LWA_READINESS_CHECK_PATH=/debug/health

COPY config.yml .htpasswd /etc/distribution/
