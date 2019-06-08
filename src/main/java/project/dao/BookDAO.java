package project.dao;

import java.util.List;

import project.dto.BookSearch;
import project.entity.Book;

public interface BookDAO {

    List<Book> getBooks();

    List<Book> getBooks(String sort);

    List<Book> getBooks(BookSearch search, String sort);

    void saveBook(Book book);

    Book getBook(int bookId);

    void deleteBook(int bookId);

}
