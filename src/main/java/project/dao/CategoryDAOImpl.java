package project.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.entity.Category;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

    private final SessionFactory sessionFactory;

    @Autowired
    public CategoryDAOImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Category> getCategories() {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Category> query = currentSession.createQuery("from Category", Category.class);
        return query.getResultList();
    }

    @Override
    public void saveCategory(Category category) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(category);
    }

    @Override
    public Category getCategory(int categoryId) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Category> query = currentSession.createQuery("from Category where id=:id", Category.class)
                .setParameter("id", categoryId);
        return query.getSingleResult();
    }

    @Override
    public void deleteCategory(int categoryId) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.createQuery("update Book set category=null where category.id=:id")
                .setParameter("id", categoryId).executeUpdate();
        currentSession.createQuery("delete from Category where id=:id")
                .setParameter("id", categoryId).executeUpdate();
    }

}
