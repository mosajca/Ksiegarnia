package project.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.entity.Order;

@Repository
public class OrderDAOImpl implements OrderDAO {

    private final SessionFactory sessionFactory;

    @Autowired
    public OrderDAOImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Order> getOrders() {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Order> query = currentSession.createQuery("select distinct o from Order o left join fetch o.books " +
                "order by o.creationTimestamp desc", Order.class);
        return query.getResultList();
    }

    @Override
    public List<Order> getOrders(String username) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Order> query = currentSession.createQuery("select distinct o from Order o left join fetch o.books " +
                "where o.user.username=:username order by o.creationTimestamp desc", Order.class)
                .setParameter("username", username);
        return query.getResultList();
    }

    @Override
    public void saveOrder(Order order) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.save(order);
    }

    @Override
    public void completeOrder(int orderId) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.createQuery("update Order set status='zrealizowane' where id=:id")
                .setParameter("id", orderId)
                .executeUpdate();
    }

}
