package project.services;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.dao.BookDAO;
import project.dto.BookSearch;
import project.entity.Book;

@Service
public class BookServiceImpl implements BookService {

    private final BookDAO bookDAO;
    private final List<String> columns = Arrays.asList("name", "price");

    @Autowired
    public BookServiceImpl(BookDAO bookDAO) {
        this.bookDAO = bookDAO;
    }

    @Override
    @Transactional
    public List<Book> getBooks() {
        return bookDAO.getBooks();
    }

    @Override
    @Transactional
    public List<Book> getBooks(Set<Integer> ids) {
        if (ids.isEmpty()) {
            return Collections.emptyList();
        } else {
            return bookDAO.getBooks(ids);
        }
    }

    @Override
    @Transactional
    public List<Book> getBooks(String sort) {
        if (columns.contains(sort)) {
            return bookDAO.getBooks(null, sort);
        } else {
            return bookDAO.getBooks();
        }
    }

    @Override
    @Transactional
    public List<Book> getBooks(BookSearch search, String sort) {
        return bookDAO.getBooks(search, columns.contains(sort) ? sort : null);
    }

    @Override
    @Transactional
    public void saveBook(Book book) {
        bookDAO.saveBook(book);
    }

    @Override
    @Transactional
    public Book getBook(int bookId) {
        return bookDAO.getBook(bookId);
    }

    @Override
    @Transactional
    public void deleteBook(int bookId) {
        bookDAO.deleteBook(bookId);
    }

}
