FROM debezium/connect:2.3

ADD --chmod=644 https://packages.confluent.io/maven/io/confluent/kafka-connect-avro-converter/7.4.0/kafka-connect-avro-converter-7.4.0.jar /kafka/libs/
ADD --chmod=644 https://packages.confluent.io/maven/io/confluent/kafka-connect-avro-data/7.4.0/kafka-connect-avro-data-7.4.0.jar /kafka/libs/
ADD --chmod=644 https://packages.confluent.io/maven/io/confluent/kafka-avro-serializer/7.4.0/kafka-avro-serializer-7.4.0.jar /kafka/libs/
ADD --chmod=644 https://packages.confluent.io/maven/io/confluent/kafka-schema-serializer/7.4.0/kafka-schema-serializer-7.4.0.jar /kafka/libs/
ADD --chmod=644 https://packages.confluent.io/maven/io/confluent/kafka-schema-registry-client/7.4.0/kafka-schema-registry-client-7.4.0.jar /kafka/libs/
ADD --chmod=644 https://packages.confluent.io/maven/io/confluent/kafka-schema-registry/7.4.0/kafka-schema-registry-7.4.0.jar /kafka/libs/
ADD --chmod=644 https://packages.confluent.io/maven/io/confluent/common-config/7.4.0/common-config-7.4.0.jar /kafka/libs/
ADD --chmod=644 https://packages.confluent.io/maven/io/confluent/common-utils/7.4.0/common-utils-7.4.0.jar /kafka/libs/
ADD --chmod=644 https://packages.confluent.io/maven/io/confluent/kafka-schema-converter/7.4.0/kafka-schema-converter-7.4.0.jar /kafka/libs/
ADD --chmod=644 https://repo1.maven.org/maven2/com/google/guava/guava/32.1.0-jre/guava-32.1.0-jre.jar /kafka/libs/
ADD --chmod=644 https://repo1.maven.org/maven2/org/apache/avro/avro/1.11.2/avro-1.11.2.jar /kafka/libs/
ADD --chmod=644 https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar /kafka/libs/

RUN cd /kafka/libs/ && sha1sum -c - <<EOF
    559f3a223abdcc527a4ecc6bf5fe0a4dc3d02a06 kafka-connect-avro-converter-7.4.0.jar
    9b4af20d38ed1becde31e67dfff25491245c695f kafka-connect-avro-data-7.4.0.jar
    7c2568542ef20c611740761e7b56d47eda7e6d7b kafka-avro-serializer-7.4.0.jar
    1118cfa5dd2f0a19f47e6fc3ea0ef46b42e1c21a kafka-schema-serializer-7.4.0.jar
    780543cc2da84265d8cd49829ca185df7e000413 kafka-schema-registry-client-7.4.0.jar
    2aae2925829bc23ab1c2fd45e0c56e71c776798c kafka-schema-registry-7.4.0.jar
    ab0aacdd178aa0149e7316b82a69ce54a7c5a9d6 kafka-schema-converter-7.4.0.jar
    9d122ca9ebafca98ed216705611458e68903c16d common-config-7.4.0.jar
    0d85ea27eb918aa11d5f82189532503552840ade common-utils-7.4.0.jar
    54a136da267b1f1b840771b7200628daa12e63ea guava-32.1.0-jre.jar
    97e62e8be2b37e849f1bdb5a4f08121d47cc9806 avro-1.11.2.jar
    1dcf1de382a0bf95a3d8b0849546c88bac1292c9 failureaccess-1.0.1.jar
EOF

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
