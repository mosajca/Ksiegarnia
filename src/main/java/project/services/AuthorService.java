package project.services;

import java.util.List;

import project.entity.Author;

public interface AuthorService {

    List<Author> getAuthors();

    void saveAuthor(Author author);

    Author getAuthor(int authorId);

    void deleteAuthor(int authorId);

}
