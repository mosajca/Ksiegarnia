package project.entity;

import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "zamowienia")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "cena")
    private float price;

    @Column(name = "status")
    private String status;

    @CreationTimestamp
    @Column(name = "data_i_czas")
    private OffsetDateTime creationTimestamp;

    @ManyToOne
    @JoinColumn(name = "uzytkownik_id")
    private User user;

    @ManyToMany
    @JoinTable(
            name = "zamowienia_to_ksiazki",
            joinColumns = @JoinColumn(name = "zamowienie_id"),
            inverseJoinColumns = @JoinColumn(name = "ksiazka_id")
    )
    private Set<Book> books;

    public Order() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public OffsetDateTime getCreationTimestamp() {
        return creationTimestamp;
    }

    public void setCreationTimestamp(OffsetDateTime creationTimestamp) {
        this.creationTimestamp = creationTimestamp;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Set<Book> getBooks() {
        return books;
    }

    public void setBooks(Set<Book> books) {
        this.books = books;
        price = books.stream().map(Book::getPrice).reduce(0.0f, Float::sum);
    }

    public void addBook(Book book) {
        if (books == null) {
            books = new HashSet<>();
        }
        books.add(book);
        book.addOrder(this);
        price += book.getPrice();
    }

    public void removeBook(Book book) {
        if (books != null && books.remove(book)) {
            book.removeOrder(this);
            price -= book.getPrice();
        }
    }

    public String booksToString() {
        return Optional.ofNullable(books)
                .map(b -> b.toString().replaceAll("^\\[", "").replaceAll("]$", ""))
                .orElse("");
    }

    public String timestampToString() {
        return Optional.ofNullable(creationTimestamp)
                .map(t -> t.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")))
                .orElse("");
    }

}
