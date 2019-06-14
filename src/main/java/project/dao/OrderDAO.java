package project.dao;

import java.util.List;

import project.entity.Order;

public interface OrderDAO {

    List<Order> getOrders();

    List<Order> getOrders(String username);

    void saveOrder(Order order);

    void completeOrder(int orderId);

}
