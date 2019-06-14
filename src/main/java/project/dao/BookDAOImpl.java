package project.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.dto.BookSearch;
import project.entity.Author;
import project.entity.Book;

@Repository
public class BookDAOImpl implements BookDAO {

    private final SessionFactory sessionFactory;

    @Autowired
    public BookDAOImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Book> getBooks() {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Book> query = currentSession.createQuery("from Book", Book.class);
        return query.getResultList();
    }

    @Override
    public List<Book> getBooks(Set<Integer> ids) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Book> query = currentSession.createQuery("from Book where id in (:ids)", Book.class)
                .setParameterList("ids", ids);
        return query.getResultList();
    }

    @Override
    public List<Book> getBooks(String sort) {
        Session currentSession = sessionFactory.getCurrentSession();
        CriteriaBuilder builder = currentSession.getCriteriaBuilder();
        CriteriaQuery<Book> query = builder.createQuery(Book.class);
        Root<Book> book = query.from(Book.class);
        query.select(book).orderBy(builder.asc(book.get(sort)));
        return currentSession.createQuery(query).getResultList();
    }

    @Override
    public void saveBook(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(book);
    }

    @Override
    public Book getBook(int bookId) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Book> query = currentSession.createQuery("from Book where id=:id", Book.class)
                .setParameter("id", bookId);
        return query.getSingleResult();
    }

    @Override
    public void deleteBook(int bookId) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.createQuery("delete from Book where id=:id")
                .setParameter("id", bookId).executeUpdate();
    }

    @Override
    public List<Book> getBooks(BookSearch search, String sort) {
        Session currentSession = sessionFactory.getCurrentSession();
        CriteriaBuilder builder = currentSession.getCriteriaBuilder();
        CriteriaQuery<Book> query = builder.createQuery(Book.class);
        Root<Book> book = query.from(Book.class);
        query.select(book).where(getPredicates(builder, book, search));
        Optional.ofNullable(sort).ifPresent(s -> query.orderBy(builder.asc(book.get(s))));
        return currentSession.createQuery(query).getResultList();
    }

    private Predicate[] getPredicates(CriteriaBuilder cb, Root<Book> book, BookSearch search) {
        List<Predicate> predicates = new ArrayList<>();
        Optional.ofNullable(search.getTitle())
                .ifPresent(name -> predicates.add(cb.equal(book.get("name"), name)));
        Optional.ofNullable(search.getPublisher())
                .ifPresent(publisher -> predicates.add(cb.equal(book.get("publisher"), publisher)));
        Optional.ofNullable(search.getPrice())
                .ifPresent(price -> predicates.add(cb.lt(cb.abs(cb.diff(book.get("price"), price)), 0.001)));
        Optional.ofNullable(search.getCategory())
                .ifPresent(category -> predicates.add(cb.equal(book.get("category").get("name"), category)));
        Optional.ofNullable(search.getAuthor())
                .ifPresent(author -> {
                    Join<Book, Author> join = book.join("authors");
                    Expression<String> e = cb.concat(cb.concat(join.get("firstName"), " "), join.get("lastName"));
                    predicates.add(cb.equal(e, author));
                });
        return predicates.toArray(new Predicate[0]);
    }

}
