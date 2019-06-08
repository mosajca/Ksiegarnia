package project.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.entity.Author;

@Repository
public class AuthorDAOImpl implements AuthorDAO {

    private final SessionFactory sessionFactory;

    @Autowired
    public AuthorDAOImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Author> getAuthors() {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Author> query = currentSession.createQuery("from Author", Author.class);
        return query.getResultList();
    }

    @Override
    public void saveAuthor(Author author) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(author);
    }

    @Override
    public Author getAuthor(int authorId) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Author> query = currentSession.createQuery("from Author where id=:id", Author.class)
                .setParameter("id", authorId);
        return query.getSingleResult();
    }

    @Override
    public void deleteAuthor(int authorId) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.createQuery("delete from Author where id=:id")
                .setParameter("id", authorId).executeUpdate();
    }

}
