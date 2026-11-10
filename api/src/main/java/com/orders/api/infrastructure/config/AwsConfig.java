package com.orders.api.infrastructure.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

@Configuration
@Profile("!test")
public class AwsConfig {

    private static final Logger logger = LoggerFactory.getLogger(AwsConfig.class);

    @Value("${AWS_ACCESS_KEY_ID:}")
    private String accessKeyId;

    @Value("${AWS_SECRET_ACCESS_KEY:}")
    private String secretAccessKey;

    @Value("${AWS_REGION:us-east-1}")
    private String region;

    @Value("${AWS_SQS_ENDPOINT:}")
    private String sqsEndpoint;

    @Value("${AWS_DYNAMODB_ENDPOINT:}")
    private String dynamoDbEndpoint;

    @Bean
    public AmazonSQS amazonSQS() {
        logger.info("Configurando cliente SQS para la región: {}", region);

        BasicAWSCredentials credentials = new BasicAWSCredentials(accessKeyId, secretAccessKey);
        AmazonSQSClientBuilder builder = AmazonSQSClientBuilder.standard()
            .withRegion(region)
            .withCredentials(new AWSStaticCredentialsProvider(credentials));

        if (sqsEndpoint != null && !sqsEndpoint.isBlank()) {
            logger.info("Usando endpoint personalizado para SQS: {}", sqsEndpoint);
            builder.withEndpointConfiguration(
                new AwsClientBuilder.EndpointConfiguration(sqsEndpoint, region));
        }

        return builder.build();
    }

    @Bean
    public AmazonDynamoDB amazonDynamoDB() {
        logger.info("Configurando cliente DynamoDB para la región: {}", region);

        BasicAWSCredentials credentials = new BasicAWSCredentials(accessKeyId, secretAccessKey);
        AmazonDynamoDBClientBuilder builder = AmazonDynamoDBClientBuilder.standard()
            .withRegion(region)
            .withCredentials(new AWSStaticCredentialsProvider(credentials));

        if (dynamoDbEndpoint != null && !dynamoDbEndpoint.isBlank()) {
            logger.info("Usando endpoint personalizado para DynamoDB: {}", dynamoDbEndpoint);
            builder.withEndpointConfiguration(
                new AwsClientBuilder.EndpointConfiguration(dynamoDbEndpoint, region));
        }

        return builder.build();
    }
}