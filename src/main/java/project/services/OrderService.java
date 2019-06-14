package project.services;

import java.util.List;

import project.entity.Order;

public interface OrderService {

    List<Order> getOrders();

    List<Order> getOrders(String username);

    void saveOrder(Order order);

    void completeOrder(int orderId);

}
