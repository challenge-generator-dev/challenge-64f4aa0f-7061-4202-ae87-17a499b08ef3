package com.orders.api.infrastructure.web;

import com.orders.api.application.OrderService;
import com.orders.api.domain.Order;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<OrderResponse> createOrder(@Valid @RequestBody OrderRequest request) {
        logger.info("Recibida solicitud para crear orden con {} items", request.items().size());
        List<OrderService.OrderItemDto> itemDtos = request.items().stream()
            .map(item -> new OrderService.OrderItemDto(
                item.quantity(),
                item.price(),
                item.productId()))
            .toList();

        Order order = orderService.createOrder(itemDtos);
        OrderResponse response = toResponse(order);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponse> getOrder(@PathVariable UUID id) {
        logger.info("Consultando orden con ID: {}", id);
        return orderService.getOrder(id)
            .map(order -> ResponseEntity.ok(toResponse(order)))
            .orElse(ResponseEntity.notFound().build());
    }

    private OrderResponse toResponse(Order order) {
        List<OrderItemResponse> itemResponses = order.getItems().stream()
            .map(item -> new OrderItemResponse(
                item.getId(),
                item.getProductId(),
                item.getQuantity(),
                item.getPrice()))
            .toList();

        return new OrderResponse(
            order.getId(),
            order.getTotalAmount(),
            order.getStatus().name(),
            order.getCreatedAt(),
            order.getUpdatedAt(),
            itemResponses);
    }

    public record OrderRequest(
        @NotEmpty(message = "La orden debe contener al menos un item")
        List<OrderItemRequest> items) {}

    public record OrderItemRequest(
        @NotNull @Positive Integer quantity,
        @NotNull @Positive BigDecimal price,
        @NotBlank String productId) {}

    public record OrderResponse(
        UUID id,
        BigDecimal totalAmount,
        String status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        List<OrderItemResponse> items) {}

    public record OrderItemResponse(
        UUID id,
        String productId,
        Integer quantity,
        BigDecimal price) {}
}