package project.dao;

import java.util.List;

import project.entity.Author;

public interface AuthorDAO {

    List<Author> getAuthors();

    void saveAuthor(Author author);

    Author getAuthor(int authorId);

    void deleteAuthor(int authorId);

}
