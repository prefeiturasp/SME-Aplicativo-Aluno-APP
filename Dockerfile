FROM alevato/android-flutter:android-29

ARG GOOGLE_SERVICES_JSON
ARG JKS_KEY_FILE
ARG JKS_KEY_PROPERTIES

ENV GOOGLE_SERVICES_JSON=${GOOGLE_SERVICES_JSON}
ENV JKS_KEY_FILE=${JKS_KEY_FILE}
ENV JKS_KEY_PROPERTIES=${JKS_KEY_PROPERTIES}

# Cópia dos arquivos de assinatura
RUN echo ${GOOGLE_SERVICES_JSON} > /src/android/app/google-services.json
RUN echo ${JKS_KEY_FILE} > /home/developer/key.jks
RUN echo ${JKS_KEY_PROPERTIES} > /src/android/key.properties

# Build da APK
WORKDIR /src
RUN flutter pub get \
    && flutter packages pub run build_runner build --delete-conflicting-outputs \
    && flutter build appbundle
