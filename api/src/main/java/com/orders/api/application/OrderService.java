package com.orders.api.application;

import com.orders.api.domain.Order;
import com.orders.api.domain.OrderItem;
import com.orders.api.domain.OrderRepository;
import com.orders.api.domain.Order.OrderStatus;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderService {

    private static final Logger logger = LoggerFactory.getLogger(OrderService.class);
    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    @Transactional
    public Order createOrder(List<OrderItemDto> items) {
        logger.info("Creando nueva orden con {} items", items.size());

        BigDecimal totalAmount = items.stream()
            .map(item -> item.price().multiply(BigDecimal.valueOf(item.quantity())))
            .reduce(BigDecimal.ZERO, BigDecimal::add);

        Order order = new Order(totalAmount, new ArrayList<>());

        for (OrderItemDto itemDto : items) {
            OrderItem item = new OrderItem(
                itemDto.quantity(),
                itemDto.price(),
                itemDto.productId()
            );
            order.addItem(item);
        }

        Order savedOrder = orderRepository.save(order);
        logger.info("Orden creada exitosamente con ID: {}", savedOrder.getId());
        return savedOrder;
    }

    @Transactional(readOnly = true)
    public Optional<Order> getOrder(UUID id) {
        logger.info("Consultando orden con ID: {}", id);
        return orderRepository.findById(id);
    }

    @Transactional
    public void cancelOrder(UUID id) {
        logger.info("Cancelando orden con ID: {}", id);
        Optional<Order> orderOpt = orderRepository.findById(id);
        if (orderOpt.isEmpty()) {
            throw new IllegalArgumentException("Orden no encontrada: " + id);
        }
        Order order = orderOpt.get();
        order.setStatus(OrderStatus.CANCELLED);
        orderRepository.save(order);
        logger.info("Orden cancelada exitosamente");
    }

    public record OrderItemDto(Integer quantity, BigDecimal price, String productId) {}
}