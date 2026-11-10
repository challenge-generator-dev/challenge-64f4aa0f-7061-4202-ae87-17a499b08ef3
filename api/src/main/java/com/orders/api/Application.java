package com.orders.api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import java.net.InetAddress;
import java.util.Arrays;
import java.util.UUID;

@SpringBootApplication
@ConfigurationPropertiesScan
public class Application {

    private static final Logger logger = LoggerFactory.getLogger(Application.class);

    public static void main(String[] args) {
        try {
            SpringApplication app = new SpringApplication(Application.class);
            app.setAdditionalProfiles("default");
            var environment = app.run(args).getEnvironment();
            logApplicationStartup(environment);
        } catch (Exception e) {
            logger.error("La aplicación no pudo iniciar correctamente", e);
            System.exit(1);
        }
    }

    private static void logApplicationStartup(org.springframework.core.env.Environment environment) {
        String protocol = "http";
        String serverPort = environment.getProperty("server.port", "8080");
        String contextPath = environment.getProperty("server.servlet.context-path", "/");
        String hostAddress = "localhost";
        try {
            InetAddress inetAddress = InetAddress.getLocalHost();
            hostAddress = inetAddress.getHostAddress();
        } catch (Exception e) {
            logger.warn("No se pudo determinar la dirección del host", e);
        }
        logger.info("\n----------------------------------------------------------\n\t" +
                "Aplicación '{}' iniciada en {}\n\t" +
                "Perfiles activos: {}\n\t" +
                "URL externa: {}://{}:{}{}proxy/actuator/health\n\t" +
                "Documentación Swagger: {}://{}:{}{}proxy/swagger-ui.html\n" +
                "----------------------------------------------------------",
                environment.getProperty("spring.application.name", "orders-api"),
                environment.getProperty("spring.profiles.active", "default"),
                Arrays.toString(environment.getActiveProfiles()),
                protocol, hostAddress, serverPort, contextPath,
                protocol, hostAddress, serverPort, contextPath);
    }

    @Bean
    @Profile("!test")
    public ApplicationProperties applicationProperties() {
        return new ApplicationProperties();
    }

    @Bean
    @Profile("!test")
    public DataSourceConfiguration dataSourceConfiguration() {
        return new DataSourceConfiguration();
    }

    @Configuration
    @ConfigurationProperties(prefix = "application")
    public static class ApplicationProperties {
        private String name = "orders-api";
        private String version = "1.0.0";
        private String description = "Servicio de gestión de órdenes";

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getVersion() {
            return version;
        }

        public void setVersion(String version) {
            this.version = version;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }
    }

    @Configuration
    public static class DataSourceConfiguration {
        private static final Logger log = LoggerFactory.getLogger(DataSourceConfiguration.class);

        @Bean
        public String datasourceHealthCheck() {
            log.info("Configuración de datasource inicializada para verificación de salud");
            return "dataSourceHealthy";
        }
    }
}